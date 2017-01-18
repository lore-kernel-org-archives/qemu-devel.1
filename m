Received: from eggs.gnu.org ([2001:4830:134:3::10]:36696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTsg8-00017j-Mb
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:01:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTsg4-0006JA-S4
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:01:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33460)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTsg4-0006Iy-MU
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 11:01:36 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BF99F9E606
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 16:01:36 +0000 (UTC)
Date: Wed, 18 Jan 2017 16:01:34 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118160134.GQ30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-17-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sBcizk6cgRZY6rnJ"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-17-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/16] block: document fields protected by
 AioContext lock
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


--sBcizk6cgRZY6rnJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 13, 2017 at 02:17:31PM +0100, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/block/block_int.h      | 64 +++++++++++++++++++++++++-----------------
>  include/sysemu/block-backend.h | 14 ++++++---
>  2 files changed, 49 insertions(+), 29 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--sBcizk6cgRZY6rnJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf5FeAAoJEJykq7OBq3PISNQIAJjd/WSpiRHaRYuqRl5fp3zy
6muZR+vi1HiklNKzSS/RsCgzieGQj/Tc7Wu272dPkfsDIHFSJ+shWfu9jgzwr/w+
IeOnd0QQTTtT4g+w6tH6U+Ada6a5bi7G6y5NSlGBBjyqaX6IpvwFsmXcQ1gQlvxh
P+vk/zPVMSCgnTqoPoTAFRtavCnaS9EIRjSCOLK6qXihAikdt72MUOv/JBvSAIVX
KCXmAfzFLcQuReUv4mbbsx8Zw12yajUfavJgvr+rEcz3UstNgcCL0ewGJyxcUWP/
ROESu0+lfTzJpu1Hhuc2r4hKskcJwxx9bGRwbXecqvTrDHRLiRDrURa2IldL+ig=
=M1j8
-----END PGP SIGNATURE-----

--sBcizk6cgRZY6rnJ--
