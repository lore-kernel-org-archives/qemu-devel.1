Received: from eggs.gnu.org ([2001:4830:134:3::10]:47952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQqX1-0004o1-Sn
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:44:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQqWy-0007O5-Sy
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:44:31 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:40468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fQqWy-0007N1-M6
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 04:44:28 -0400
Received: by mail-wm0-x241.google.com with SMTP id n5-v6so17139164wmc.5
	for <qemu-devel@nongnu.org>; Thu, 07 Jun 2018 01:44:28 -0700 (PDT)
Date: Thu, 7 Jun 2018 09:44:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180607084425.GA19032@stefanha-x1.localdomain>
References: <1527028012-21888-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <1527028012-21888-1-git-send-email-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH 0/5] trace-mem fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 22, 2018 at 06:26:47PM -0400, Emilio G. Cota wrote:
> This series fixes a few issues that I found while testing
> the tracing of guest memory accesses in TCG. Please review!
>=20
> You can fetch these patches from:
>   https://github.com/cota/qemu/commits/trace-mem

Doesn't look like anyone else is going to review this.

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGPBpAAoJEJykq7OBq3PI9PMIAIAR8ahGY7yJrpAgFIQlucDy
AzgNKZ/4Xzt42eitXH0IG2fIuxjoEKsuRgloOojzoNe0eWbxWxZI1wHu/+xEg4DB
QN59ChxgOW4w65amxQ+stNbUiRLO0jn7TiIV83MNLmYEGrD4f5vCCN5f1n329JQ6
oKsXd4eYmbnEz83B9wPVpyBseWupMnGxMuIeDQ2XAY4s2y9JXCF7rGWef62trlP4
7Xri/FalAhp5fcpATYUj6S6ycoCuIi9tXVZVmPWfZhNuWQ7de+3vCZPmPavJZHF8
LxHhR09Cp/uGMyMDrUXAPcjBLlbsJM8+leButpKwURB1+NJAtWAlK/mgj2X7S+w=
=wlp7
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
