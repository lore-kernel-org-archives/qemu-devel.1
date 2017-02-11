Received: from eggs.gnu.org ([2001:4830:134:3::10]:55214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cchZI-0004ig-I5
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 18:59:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cchZH-0006rQ-Hh
	for qemu-devel@nongnu.org; Sat, 11 Feb 2017 18:59:04 -0500
References: <1486744104-15590-1-git-send-email-peter.maydell@linaro.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6693f54a-77ed-fd63-d865-756839e7ecd2@redhat.com>
Date: Sun, 12 Feb 2017 00:58:51 +0100
MIME-Version: 1.0
In-Reply-To: <1486744104-15590-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Rl8CqhrVBRRSb0jeh9jWDWNE2JPgtSOS1"
Subject: Re: [Qemu-devel] [PATCH 0/2] qemu-img: fix coverity nits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Rl8CqhrVBRRSb0jeh9jWDWNE2JPgtSOS1
From: Max Reitz <mreitz@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <6693f54a-77ed-fd63-d865-756839e7ecd2@redhat.com>
Subject: Re: [PATCH 0/2] qemu-img: fix coverity nits
References: <1486744104-15590-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486744104-15590-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 10.02.2017 17:28, Peter Maydell wrote:
> Coverity points out a couple of nits in qemu-img:
>  * misuse of strtoul()
>  * variable set but not used
>=20
> These patches fix the issues.
>=20
> Peter Maydell (2):
>   qemu-img: Use qemu_strtoul() rather than raw strtoul()
>   qemu-img: Avoid setting ret to unused value in img_convert()
>=20
>  qemu-img.c | 40 ++++++++++++++++++++--------------------
>  1 file changed, 20 insertions(+), 20 deletions(-)

Thanks, applied to my block tree:

https://github.com/XanClic/qemu/commits/block

Max


--Rl8CqhrVBRRSb0jeh9jWDWNE2JPgtSOS1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlifpTwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ALBIH/RcqE0ZHXNgtY8TrUIhL9SGlanBvZaCF
9IsTL1L2I3Om1RqQmXoXsnWXaZKrgyeNT4PMBO88BGCugspoDWuwBncixaiVANb1
+gLUz27JBn/0N1H7b+F306OFPx8R6I+U0uL5LIyytXrBpJz//HyW3OCIborbmAxJ
Lo57Roc3Won/tvKP+RPnnbfMXdXQuzpjZSLYTtXDCuFAR51jVRiYa3CtdgesUXhI
XSRgdX059D6WpBLQrOk/JhSM0iHr/7+IIlWBETEhZTRveYdn2LpQVROuk5F75XJY
xltuCiasl+7GI/9d53Xcp7fGqjxvzcqc6yOEwfH4iHJr8VZL4NivDuI=
=padt
-----END PGP SIGNATURE-----

--Rl8CqhrVBRRSb0jeh9jWDWNE2JPgtSOS1--
