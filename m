Received: from eggs.gnu.org ([2001:4830:134:3::10]:47181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1eF6wj-0005fx-HO
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 18:18:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@redhat.com>) id 1eF6wg-0002Rq-Dk
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 18:18:17 -0500
Date: Thu, 16 Nov 2017 10:18:04 +1100
From: David Gibson <dgibson@redhat.com>
Message-ID: <20171116101804.5e24336f@umbus.fritz.box>
In-Reply-To: <8360a4ac-421d-1150-5e4c-cac5e2f7bdb3@redhat.com>
References: <1510658424-16527-1-git-send-email-thuth@redhat.com>
	<20171115103345.7582aa37@umbus.fritz.box>
	<8360a4ac-421d-1150-5e4c-cac5e2f7bdb3@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/XgRxF+urcBCCsnIFF/7Cb0s";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11] hw/net/vmxnet3: Fix code to
 work on big endian hosts, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, f4bug@amsat.org

--Sig_/XgRxF+urcBCCsnIFF/7Cb0s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Nov 2017 07:59:31 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 15.11.2017 00:33, David Gibson wrote:
>  [...] =20
>  [...] =20
> [...]
>  [...] =20
>  [...] =20
> [...]
>  [...] =20
>  [...] =20
>=20
> David, I agree with all of your comments - I had similar thoughts when I
> was working with the code. However, as you already indicated, to address
> all of this, we would need to rewrite most parts of this device. That's
> out of my scope here - I wanted to keep the changes as minimal as
> possible, so that there is a chance that we can get the endianness
> problem still fixed for 2.11. So do you think that the patch is OK for
> this? ... otherwise, I think I'll rather send a patch that removes the
> vmxnet3 from the pxe-tester again - then it won't be tested anymore and
> we won't get anymore endianness test failures.

Yeah, good point.  Getting a fix in place is more important than
making the existing stuff more elegant.

Reviewed-by: David Gibson <dgibson@redhat.com>

--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/XgRxF+urcBCCsnIFF/7Cb0s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloMyywACgkQbDjKyiDZ
s5KWFg//SyPg3lUNyqBGMfXPiCFDg/HdJj/WqVq+J3Hs620H83wbrWRY4r3iMcA5
n32t3n+jTAiynItpdlZ2kFVhsbENfu8P2Hj+aY26X1/cHFsrcTdS9bB9ws4TfWWs
vNRpntnruxvi9ro9nhMu/lzmxc8plYM7r1k6VSkGSY5kKMZfKiHkpm5rOoOVWRCI
hXmvSm94aNafa9BgoaX2HYxIY7L6lPBtL1GmoStsmpCgkpGPeAfEaDvsoR9ICcly
XAesZSPNuzIPKgsOuRL6VZjA18PZ4K6c9Ysy/oz7UYGw1Cq5D5OZhlTeQ0cyit2j
baOOUpLo8LjbgoNKn6fOYmAg5DmA6PzweN4Q7zOc/g++u3R8IHEgKFVNvlMOO+Yk
T/ziZY57dT7FmuH2q+iAX9OK/kjKDxGpU8/7GVozjxiHXIZEgh+ivpRsd4JUdGfm
0rIqRjwj4W87u2wKV3dCHDgdklHo8oPLiISbTBZ1keiNgE6rZiYVp6t2W4+sjKp3
1cx+jc8Kqsvj0L5zae1nUQ7D2qyM2pmxfSsrSDhxYacZIeX0C3qvIJC/uv2SJ0D7
1sP24/l1cvNrd7Jjq7LupyVeH4OVSImWMWbE7dURoshci06tS7PXD03s25i98/XJ
aDAdqPlGIm0MyqOYRlILUPSej/eyhryFxRQrPZAhrGaGO8gZcpw=
=amoI
-----END PGP SIGNATURE-----

--Sig_/XgRxF+urcBCCsnIFF/7Cb0s--
