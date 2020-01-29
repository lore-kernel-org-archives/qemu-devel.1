Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B126AC33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 02:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 826882073A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 02:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="BFS/vI6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 826882073A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwcrb-0007O0-Ol
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 21:13:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iwcqu-0006Sj-0E
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 21:13:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iwcqs-0001VX-Gu
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 21:13:11 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:55029 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iwcqr-0001UN-GB; Tue, 28 Jan 2020 21:13:10 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 486n7y09rKz9s29; Wed, 29 Jan 2020 13:13:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1580263982;
 bh=XsMs44Cr5r66n+Ny8jtd2qRFfy6y/YHNoOqeSPhWLTQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BFS/vI6HUEaiXQv362Cp5y/NyxI0lqc+mOo5dJ+Sa/SuRnhWr+NCEnTmsX+up+vgl
 NkDdORKCyt9TniOIZBN86cGPQ0eMDOySUZTvXy6RRgNpfkZBhS+ATHmKKlEzLBQGeJ
 +MOCNLFaRR3iGkwKsfh1XJDL4cuN3I45+qNVMuYw=
Date: Wed, 29 Jan 2020 13:08:02 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 0/6] Add vTPM emulator support for ppc64 platform
Message-ID: <20200129020802.GV42099@umbus.fritz.box>
References: <20200121152935.649898-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5M2fOMh7RWu7idz2"
Content-Disposition: inline
In-Reply-To: <20200121152935.649898-1-stefanb@linux.ibm.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--5M2fOMh7RWu7idz2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2020 at 10:29:29AM -0500, Stefan Berger wrote:
>=20
> The following series of patches adds vTPM emulator support for the
> ppc64 platform (pSeries).=20
>=20
> It can be tested as follows with swtpm/libtpms:
>=20
> mkdir /tmp/mytpm1
> swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
>   --ctrl type=3Dunixio,path=3D/tmp/mytpm1/swtpm-sock \
>   --log level=3D20
>=20
> If TPM 2 is desired, add --tpm2 as parameter to the above.
>=20
> In another terminal start QEMU:
>=20
> sudo ./ppc64-softmmu/qemu-system-ppc64 -display sdl \
> 	-machine pseries,accel=3Dkvm \
> 	-m 1024 -bios slof.bin -boot menu=3Don \
> 	-nodefaults -device VGA -device pci-ohci -device usb-kbd \
> 	-chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> 	-tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> 	-device tpm-spapr,tpmdev=3Dtpm0 \
> 	-device spapr-vscsi,id=3Dscsi0,reg=3D0x00002000 \
> 	-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x3,drive=3Ddrive-v=
irtio-disk0,id=3Dvirtio-disk0 \
> 	-drive file=3Dtest.img,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0
>=20
> Links:
>  - libtpms: https://github.com/stefanberger/libtpms/wiki
>  - swtpm: https://github.com/stefanberger/swtpm/wiki

Applied to ppc-for-5.0, thanks.

>=20
> Changes:
>  v8->v9:
>   - Allocating buffer now so we can use VMSTATE_VBUFFER_UINT32 for the re=
gular
>     buffer (no more suspend buffer)
>=20
>  v7->v8:
>   - Folded documentation patch into 3rd patch
>   - Added Marc-Andr=E9's patch to end of series
>=20
>  v6->v7:
>   - Implemented get_dt_compatible() and using it
>   - Moved tpm_this_show_buffer to tpm_util.c
>=20
>  v5->v6:
>   - adjusted names of structures and simplified
>   - only transmitting min. necessary bytes to pass to VM after resume
>   - addressed other issues pointed out by D. Gibson
>=20
>  v4->v5:
>   - use runstate_check(RUN_STATE_FINISH_MIGRATE) to check whether devices
>     are suspending; ditch 3 patches in this series that tried to do simil=
ar
>=20
>  v3->v4:
>   - addressed comments to v3
>   - reworked suspend/resume support that requires extensions to backends
>=20
>  v2->v3:
>   - patch 1: a TPM 2 is identified by IBM,vtpm20 in the compatible node
>   - patch 1: convert to tracing to display Tx and Rx buffers
>   - added documentation patch
>   - added patch to enable TPM device as part of pSeries
>=20
>  v1->v2:
>   - followed Cedric Le Goater's suggestions to patch 1
>   - send appropriate CRQ error responses if DMA read or write fails
>   - renamed tpm_spapr_got_payload to tpm_spapr_process_cmd and
>     pass endianess-adjusted data pointer from CRQ to it
>=20
> Regards,
>     Stefan
>=20
>=20
> Marc-Andr=E9 Lureau (1):
>   docs/specs/tpm: reST-ify TPM documentation
>=20
> Stefan Berger (5):
>   tpm: Move tpm_tis_show_buffer to tpm_util.c
>   spapr: Implement get_dt_compatible() callback
>   tpm_spapr: Support TPM for ppc64 using CRQ based interface
>   tpm_spapr: Support suspend and resume
>   hw/ppc/Kconfig: Enable TPM_SPAPR as part of PSERIES config
>=20
>  docs/specs/index.rst       |   1 +
>  docs/specs/tpm.rst         | 503 +++++++++++++++++++++++++++++++++++++
>  docs/specs/tpm.txt         | 427 -------------------------------
>  hw/ppc/Kconfig             |   1 +
>  hw/ppc/spapr_vio.c         |  11 +-
>  hw/tpm/Kconfig             |   6 +
>  hw/tpm/Makefile.objs       |   1 +
>  hw/tpm/tpm_spapr.c         | 429 +++++++++++++++++++++++++++++++
>  hw/tpm/tpm_tis.c           |  32 +--
>  hw/tpm/tpm_util.c          |  25 ++
>  hw/tpm/tpm_util.h          |   3 +
>  hw/tpm/trace-events        |  16 +-
>  include/hw/ppc/spapr_vio.h |   1 +
>  include/sysemu/tpm.h       |   3 +
>  qapi/tpm.json              |   6 +-
>  15 files changed, 1004 insertions(+), 461 deletions(-)
>  create mode 100644 docs/specs/tpm.rst
>  delete mode 100644 docs/specs/tpm.txt
>  create mode 100644 hw/tpm/tpm_spapr.c
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5M2fOMh7RWu7idz2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4w6QIACgkQbDjKyiDZ
s5IDPRAAnvIKA10zAC7L9idvMJ+PiJxpxDPhDD6pgVc1c8ZPTxBFTxH/+zxbJ5C7
kFsOxBAMdWUkmsdqBxSiXe7/xFM6k41hBbJO7U7aDQhb/NzYh3WtvCpBnoFweWNH
pBrE5paIgdnDaQ383e5ztlAUfxuUDyipnALTyGUli7Htqml2ig2qs42DvHHfI8x5
LnwFDmsEk/0V3szHdRbEYa0JlBZ479sJ1qT8Cy0sTV+7pZ87obDhxzJJrxQ1+cB5
vxirUOHKbzAribRl+EdssPrD3I5wlV+Y0Bop4TIzjw7KduNj5CYfYN3yIFEJF2Gf
/B7EAxBlzuhtyd1LmILn3wcxA1wBgiWuP4h7u2671E+E5H2Vyps4B6EavIRaHS7S
keAgUS85YXolE6/Ccs/uyPL8ccqjcSEmtHGCEr4CA2TtLHKKE3j914rMl/nwLmk0
bNa5NLI3KZoxrP1Irw83iZlvgt0F4bpbl2GSrZSafHbjLhU08YNwWwhZGLruddVQ
C9OWehZEvSFQIeUKO2DIgcyX/Nfq1oo89wvXNDRGAnX5A0211ljnAAJumj7CCs8x
7dzfLJKqpjis3H9Z7m7nsitsrxOo83CvKI2rPgZvtQna2LlOaxuvQnh4oi98qfaV
rh8kl89/+QZxvQ1fEmeoBcNLF941h9rFIbeUQ4nMbqY/8N1v3y4=
=NOYs
-----END PGP SIGNATURE-----

--5M2fOMh7RWu7idz2--

