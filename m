Received: from eggs.gnu.org ([2001:4830:134:3::10]:57142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRMHY-0001Iz-Le
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:01:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRMHY-0003oS-15
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:01:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36106)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRMHX-0003o9-S6
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:01:51 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE6E27F7B1
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 17:01:51 +0000 (UTC)
Date: Wed, 11 Jan 2017 17:01:45 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170111170145.GF9269@stefanha-x1.localdomain>
References: <20170104132625.28059-1-pbonzini@redhat.com>
	<20170104132625.28059-8-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
In-Reply-To: <20170104132625.28059-8-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/10] aio-posix: remove walking_handlers,
 protecting AioHandler list with list_lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 04, 2017 at 02:26:22PM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  aio-posix.c | 65 ++++++++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 39 insertions(+), 26 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYdmT5AAoJEJykq7OBq3PICJkH/05gA/Oj9vfoXcN6FWYxwpi5
DaTDEXXRqQbcnuf+dLPJTAoO+M7C5nK9KkgnUFuP/Sl4p5fx0wmwOdWmLFuSWMxb
xpgrbOP17jOFr1LOEZgEfQShf4jUktfj4F+tIEVaNzXl6vOZsa5D9nTx/3+LeXfm
ezt4Itzsb7j5WF9kNVD9jG4aj0egiwwACafDfqfK7kDtDvjTMkMPE5Xy1zbCe7hx
vGB4SldxhjZQspTghrGvBgZvpJE4Y2hx30xFtFv1rdU/+7YS3aJB88C5FJKjtMvy
Uw3OSY6K91A7XgumGgs7/shbh27xBrwAIw+LsGc1V/9QhxkzfGWslc9M+3MoLuo=
=mVfZ
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
