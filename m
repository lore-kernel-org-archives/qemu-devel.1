Received: from eggs.gnu.org ([2001:4830:134:3::10]:51429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsNRI-0001gL-BS
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 03:20:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsNRH-0005nE-9k
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 03:20:24 -0400
References: <20180820153020.21478-1-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <aec8f424-f2eb-b52b-d2ed-c1249cdf32a0@greensocs.com>
Date: Wed, 22 Aug 2018 09:19:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180820153020.21478-1-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N3tevn2M5jWscMpV88bE8XKIgUQ60Nvs7"
Subject: Re: [Qemu-devel] [PATCH v2 0/6] target/arm: Some pieces of support
 for 32-bit Hyp mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N3tevn2M5jWscMpV88bE8XKIgUQ60Nvs7
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <aec8f424-f2eb-b52b-d2ed-c1249cdf32a0@greensocs.com>
Subject: Re: [PATCH v2 0/6] target/arm: Some pieces of support for 32-bit Hyp
 mode
References: <20180820153020.21478-1-peter.maydell@linaro.org>
In-Reply-To: <20180820153020.21478-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/20/18 5:30 PM, Peter Maydell wrote:
> Now we have virtualization support in the GICv2 emulation,
> I thought I'd have a look at how much we were still missing
> for being able to enable EL2 support for AArch32.
> This set of patches fixes some minor missing pieces:
>  * AArch32 HACTLR2
>  * AArch32 HCR, HCR2
>  * support for taking exceptions to Hyp mode
>  * boot AArch32 kernels in Hyp mode where available
> and I threw in a trivial bugfix:
>  * Clear CPSR.IL and CPSR.J on 32-bit exception entry
> since it would otherwise have a conflict with the refactoring
> of exception entry.
>=20
> Changes v1->v2:
>  * some patches are now upstream
>  * v8-only registers no longer created for v7 CPUs
>  * split the "factor out exception-entry code" into
>    its own patch
>  * new patch: clear CPSR.IL and CPSR.J
>  * new patch: boot kernels in Hyp mode if possible
>=20
> (I still have the same "guest EL0 segv" issue as for v1
> if I actually enable the EL2 feature on Cortex-A15.)
>=20

Reviewed-By: Luc Michel <luc.michel@greensocs.com>

> thanks
> -- PMM
>=20
> Peter Maydell (6):
>   target/arm: Implement RAZ/WI HACTLR2
>   target/arm: Implement AArch32 HCR and HCR2
>   target/arm: Factor out code for taking an AArch32 exception
>   target/arm: Implement support for taking exceptions to Hyp mode
>   target/arm: Clear CPSR.IL and CPSR.J on 32-bit exception entry
>   hw/arm/boot: AArch32 kernels should be started in Hyp mode if
>     available
>=20
>  hw/arm/boot.c       |  11 +++
>  target/arm/helper.c | 212 ++++++++++++++++++++++++++++++++++++++------=

>  2 files changed, 196 insertions(+), 27 deletions(-)
>=20


--N3tevn2M5jWscMpV88bE8XKIgUQ60Nvs7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt9DpoACgkQd8knW3Qn
Tr7zkRAAgtr5gcdGbI5GShfRCuXnl4Kj7SCCWlZvGmaqLtnrWFyQZKpHqa/vL1c1
oh25kMcow4o96mtwZlO8Mt154MEQMp3NhhKHZegz2MxrebZ89rY2ro6Yt0DOUFcA
mXJARciOU94Zp93p0BUGGcndmrUF+rLBm1RYStrXCJv/Zz+2Fj0vvA6njzpSJiFO
7NkHCw4v5HbLWiIhKksrIL1Gles2ZzjgiwN2duTDwc0f/+Y8Wh9PFCkii7xDlL/b
FseNd4z0aomar5YcdfGmEpdAeB19ZyHOMWC/JygJjUgGDnn5q1T8ZYzLgykqdBo7
uVHODVCUIbmazohsGDP9rpfS26++PnKEas4hhmx8Q1Q+bDVE4vk/XEjS0esSO08p
BwLcm5jjcTMmgIYPO646qO/imcIuAxbq6eRWPn/kcBVhTW+SU0CUSMG3uYsf7gJX
RlG5Q4CkiQWkeBojINRCKUDwWlWfuD/tg1yscOmtgwDnL4a+EesUDnieA6HWuQ29
B2DGbJZGBZBcULzNl7IhWqZz5iIMmSW9v7QkVWk+P2wi1ZxVa7Qw2KwV7zhfSM+1
K5BFomYo5mC8rbrKd59BAmMDe/Gf88ICjeQxlCjd0KDAD2dgOF1lLG1rD7z0ufaC
ntSXqR/XQtDcjWecyXylpaFWu11CgoAtPZKJosJHeUoDHAs/MVA=
=rJ2C
-----END PGP SIGNATURE-----

--N3tevn2M5jWscMpV88bE8XKIgUQ60Nvs7--
