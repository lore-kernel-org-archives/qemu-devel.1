Received: from eggs.gnu.org ([2001:4830:134:3::10]:59642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoXVU-0003f6-VN
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:44:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eoXVR-00014N-Tk
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:44:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34566 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eoXVR-00014H-PR
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 11:44:33 -0500
Date: Wed, 21 Feb 2018 16:44:31 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180221164431.GC21436@stefanha-x1.localdomain>
References: <20180124053957.29145-1-peterx@redhat.com>
	<20180124053957.29145-13-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="32u276st3Jlj2kUU"
Content-Disposition: inline
In-Reply-To: <20180124053957.29145-13-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 12/23] monitor: let suspend_cnt be
 thread safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--32u276st3Jlj2kUU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 24, 2018 at 01:39:46PM +0800, Peter Xu wrote:
> @@ -3996,7 +3996,7 @@ int monitor_suspend(Monitor *mon)
>  {
>      if (!mon->rs)
>          return -ENOTTY;

Does this mean that QMP monitors like -qmp unix:/tmp/foo,server,nowait
will not use suspend_cnt?

I thought the point was to use suspend_cnt for QMP monitors too.

--32u276st3Jlj2kUU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJajaHvAAoJEJykq7OBq3PIACUIAMjE4Aqf27TohlJUwXEqcOPo
/K4u/J0GzXv6WWEQKF4sCID3JoSS+WW+ost9k391LF1zKaMsxS7z48kQPQWGvsRS
UsWkSOGbRVn3dZcq6vd13I9Y1ds+8T3VehnUpU8lBiA2oLJuOhk+QG7N2M82pRI9
N8KaDwVY8ewJvrZo3vNeK/jMRDAivP1GkkkwO6tUgK0O7C9B1vZZ6sPUc+eaRyjv
5xhaYGIBCqMkdnhvciDoxTdjgCsVvkSv3lgFWbGzCn65x1muMBbUbR9NWwScPhue
+OEl2oA2vDA8uv19SUpBMApVG310l5IU4xapjOfxTqU6hSnhh81BmZ+uDNdTq6I=
=lm0M
-----END PGP SIGNATURE-----

--32u276st3Jlj2kUU--
