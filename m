Received: from eggs.gnu.org ([2001:4830:134:3::10]:54571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYwWl-0000Gy-2E
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:13:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eYwWj-0005dn-T2
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:13:27 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d7f23db3-6669-76fe-661e-a5b506cfbeaf@amsat.org>
Date: Tue, 9 Jan 2018 13:13:15 -0300
MIME-Version: 1.0
In-Reply-To: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="kwNFjJuA79QvxwnyXiYVvuS3HyHpn6nB1"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 0/4] Reset SD cards attached to
 legacy-API controllers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kwNFjJuA79QvxwnyXiYVvuS3HyHpn6nB1
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, patches@linaro.org
Message-ID: <d7f23db3-6669-76fe-661e-a5b506cfbeaf@amsat.org>
Subject: Re: [Qemu-arm] [PATCH 0/4] Reset SD cards attached to legacy-API
 controllers
References: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1515506513-31961-1-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 01/09/2018 11:01 AM, Peter Maydell wrote:
> It turns out that we don't reset the SD card model if it's
> attached to a legacy-API controller. For new-style controllers
> where the SD card object is attached to an SD_BUS, the generic
> qbus infrastructure takes care of ensuring that the card's
> DeviceState::reset method gets called. But for the legacy
> API where the card is created by calling sd_init(), the card
> object has no SD_BUS to plug into, and so the reset function
> must be called manually.
>=20
> This mostly had no ill effects because a guest OS will typically
> perform an SD reset command as part of its device driver init
> sequence. However it does mean that migration won't work, because
> it's in sd_reset() that we set up the wpgrps_size field, and
> without that the migration struct on reload won't match.
>=20
> This patchset fixes up the four legacy controllers to call
> reset on the SD card device in their controller reset functions.
> The first 3 are cc:stable as migration bugfixes.
>=20
> This fixes https://bugs.launchpad.net/qemu/+bug/1739378
>=20
> Philippe: this probably clashes slightly with your sdcard
> patchsets (and where you've updated devices to the new APIs
> it becomes irrelevant), but I think we should apply these
> first so we can have a simple patch to backport to the stable
> tree.

Sure, it makes sens.

I didn't test migrating a card (but have a "sdcard migration qtest"
entry in my TODO).

this series:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

>=20
> Notes:
>  * OMAP doesn't migrate anyway, so isn't cc:stable
>  * for vexpress-a15, you also need "-machine secure=3Doff":
>    a config with trustzone emulation enabled doesn't
>    successfully migrate (haven't yet debugged why)
>=20
> thanks
> -- PMM
>=20
> Peter Maydell (4):
>   hw/sd/pl181: Reset SD card on controller reset
>   hw/sd/milkymist-memcard: Reset SD card on controller reset
>   hw/sd/ssi-sd: Reset SD card on controller reset
>   hw/sd/omap_mmc: Reset SD card on controller reset
>=20
>  hw/sd/milkymist-memcard.c |  4 ++++
>  hw/sd/omap_mmc.c          | 14 ++++++++++----
>  hw/sd/pl181.c             |  4 ++++
>  hw/sd/ssi-sd.c            | 24 +++++++++++++++++++++++-
>  4 files changed, 41 insertions(+), 5 deletions(-)
>=20


--kwNFjJuA79QvxwnyXiYVvuS3HyHpn6nB1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpU6hsACgkQ4+MsLN6t
wN7p0RAAkY/dGWPp9YaVY9VDI33T4TBJDGuPL77XWjt3+CuceNrim8ecP7FqrRir
voknNtES38Zw2jTGVZtEqfRp+x3tus0ZvU+PJ/GT9XMf0qkFrasEJ0bAuj3C6qL1
Uc6g7QYwQvwHcdZxEY1tiNGcRJ6IU1cIQSYf32RJQ0sPhWyZn2xilqLYy4H6xmGF
PDU0OvEkel7Iq2Qk1cj8+4MtjGqy5pcqkalUto64izi2t74kDhrTfWjvBbTjT6Jv
GhVgdBmM4VyJMZP2F+E6FGxcicGAISW5gnL+/urBX/Gj/kiJfhNY+u18fYYzEUsW
mnuwmIVoo3IAtQp41rrtyvjbCq5rNoM9ApsfrkuX2Gn8Wxe4YGUcjaEQUyErzRP3
ymqINaP2gXcxFYmSOKzx7vBzThuYiQ0SR88uR0n+XdWLTjEtvh/efY40ZYbqi9U4
5TaXUSHcyaMX62iwgU3Y7MdyIrmGM7/TDzcK4Fg+UHPJVOryZSxog16tO/LjPKD9
VoYXEXd32XxOz/M/EyRRrbUnAWnalyb8QPF0KQvdnNeg/g0c1EvXdQuENMFwgi9j
8E5O0KpgeMxfJqBZeusbDOaSFj2yzdizDTx2Dx5b/dXs+Dzj7i79lCiv5XGR0wKo
DoH29u+iqN0IUqOn0vxiMp+dfODY4hqe0IssMOPoF8Bv14rmvgA=
=cNBO
-----END PGP SIGNATURE-----

--kwNFjJuA79QvxwnyXiYVvuS3HyHpn6nB1--
