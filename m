Received: from eggs.gnu.org ([2001:4830:134:3::10]:50675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fD5wH-0008QC-85
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:21:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fD5wD-0007UL-7A
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:21:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58910 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fD5wD-0007TC-1c
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 06:21:41 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E35AB406C78D
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 10:21:36 +0000 (UTC)
Date: Mon, 30 Apr 2018 11:21:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180430102126.GE4002@stefanha-x1.localdomain>
References: <20180418090239.13090-1-peterx@redhat.com>
	<20180418090239.13090-4-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Content-Disposition: inline
In-Reply-To: <20180418090239.13090-4-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] monitor: add lock to protect
 mon_fdsets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 18, 2018 at 05:02:39PM +0800, Peter Xu wrote:
> Similar to previous patch, but introduce a new global big lock for
> mon_fdsets.  Take it where needed.

Looks like monitor_fdset_get_fd() is missing.

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa5u4mAAoJEJykq7OBq3PIof0H/1hKmnLnbTk2b/F+b+RqSYv1
UoCsh0/raZYbMojKgXrX9cCn/EDcEPxONufyI6IgJdQst/cq21dSh5Hcg+GviUKx
4wmEUCjXi5MgAdhy6sXPP8H5xXqaK/4KjuxYREciTwoAq7+1xbqDiLstbgzMFdKu
u62NjRiw6/7uHVO8kUFm8hr+9Nsgxr5TgUJDk5i2uj9UK8N31xfHQ7UklhB8k36V
avrtxJ/pd1yip6buYIypqB17zGtZT7GDYbmMwtqBOympw6G5WWlww3pBd1fi6y2Q
g3IMA9lyA8bKTjWLeBBbmZk8brgFaffjbiu0/05kUcZkUDI0cPPJ9vjBJWF5oUQ=
=A8b3
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
