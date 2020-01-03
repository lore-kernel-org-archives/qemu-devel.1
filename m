Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC37C3276C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 00:21:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 850C721D56
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 00:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ZO0VUyr8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 850C721D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inAi9-0000qf-LB
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 19:21:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1inAhS-0000A8-54
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 19:20:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1inAhQ-0003Zx-Gr
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 19:20:21 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:56707 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1inAhP-0003KY-Gz; Thu, 02 Jan 2020 19:20:20 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47plsn6qpZz9sRR; Fri,  3 Jan 2020 11:20:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1578010813;
 bh=3OpOumVrA3aljsTxgSXtFXrZmPAKKeYRsnSwHYyzEpE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ZO0VUyr83eGiJSfE+eqnpj6pqGKYrJfzR0nPzB/mmXasHNd4OSVEjYoizHQzAzlRh
 dPO6EOmpO4osrm86w7uU1WPBgTfmrYq0CnvY+LSFUD1g89zddf1YD3StfqzeZd9kLw
 ioiZXnWl2ykQgayPEt93TZEhTabsg6lO8zFdslTM=
Date: Fri, 3 Jan 2020 11:20:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: [PATCH v7 6/6] docs: tpm: Add example command line for ppc64 and
 tpm-spapr
Message-ID: <20200103002004.GN2098@umbus>
References: <20191219140605.3243321-1-stefanb@linux.vnet.ibm.com>
 <20191219140605.3243321-7-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="+mr2ctTDD1GjnQwB"
Content-Disposition: inline
In-Reply-To: <20191219140605.3243321-7-stefanb@linux.vnet.ibm.com>
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
Cc: marcandre.lureau@redhat.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--+mr2ctTDD1GjnQwB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2019 at 09:06:05AM -0500, Stefan Berger wrote:
> Add an example to the TPM docs for how to add a TPM SPAPR
> device model to a QEMU VM emulating a pSeries machine.
>=20
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

I don't see any advantage to splitting this out - it can be merged
into 3/6.

> ---
>  docs/specs/tpm.txt | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>=20
> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> index 9c8cca042d..9c3e67d8a7 100644
> --- a/docs/specs/tpm.txt
> +++ b/docs/specs/tpm.txt
> @@ -34,6 +34,12 @@ The CRB interface makes a memory mapped IO region in t=
he area 0xfed40000 -
>  QEMU files related to TPM CRB interface:
>   - hw/tpm/tpm_crb.c
> =20
> +
> +pSeries (ppc64) machines offer a tpm-spapr device model.
> +
> +QEMU files related to the SPAPR interface:
> + - hw/tpm/tpm_spapr.c
> +
>  =3D fw_cfg interface =3D
> =20
>  The bios/firmware may read the "etc/tpm/config" fw_cfg entry for
> @@ -281,7 +287,7 @@ swtpm socket --tpmstate dir=3D/tmp/mytpm1 \
>    --log level=3D20
> =20
>  Command line to start QEMU with the TPM emulator device communicating wi=
th
> -the swtpm:
> +the swtpm (x86):
> =20
>  qemu-system-x86_64 -display sdl -accel kvm \
>    -m 1024 -boot d -bios bios-256k.bin -boot menu=3Don \
> @@ -289,6 +295,18 @@ qemu-system-x86_64 -display sdl -accel kvm \
>    -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
>    -device tpm-tis,tpmdev=3Dtpm0 test.img
> =20
> +In case a pSeries machine is emulated, use the following command line:
> +
> +qemu-system-ppc64 -display sdl -machine pseries,accel=3Dkvm \
> +  -m 1024 -bios slof.bin -boot menu=3Don \
> +  -nodefaults -device VGA -device pci-ohci -device usb-kbd \
> +  -chardev socket,id=3Dchrtpm,path=3D/tmp/mytpm1/swtpm-sock \
> +  -tpmdev emulator,id=3Dtpm0,chardev=3Dchrtpm \
> +  -device tpm-spapr,tpmdev=3Dtpm0 \
> +  -device spapr-vscsi,id=3Dscsi0,reg=3D0x00002000 \
> +  -device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x3,drive=3Ddrive=
-virtio-disk0,id=3Dvirtio-disk0 \
> +  -drive file=3Dtest.img,format=3Draw,if=3Dnone,id=3Ddrive-virtio-disk0
> +
> =20
>  In case SeaBIOS is used as firmware, it should show the TPM menu item
>  after entering the menu with 'ESC'.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+mr2ctTDD1GjnQwB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4OiLQACgkQbDjKyiDZ
s5IETA//TzXU/tuovc6TbOYLGJ5WxexKCVtdiKe5Fzez8xxbBT5ZUZYX64mayqqO
pEDLG2W1R5qkUJ6ULV9JCwYKRi6QKr1jYowm6MZ/ZmBxW8CWX/UUxTEtc6yBZb1H
+yuRti6iXNXlwFNBVHep1CjzZklkXoMfVWUrxXtGACWx1tkUJRKarfZggW+ZWH+t
TbIlhhnmNOOzaZEbpMxxQM34L2k1O4Ppmy0MkLw5w/IZT13sL0AxB+FfyyBmLljk
86wkgW3AY9nEvZWbAruPXvO0Ld8qQB33253opE6A6c0lnBcVhVHO9JCFYwA6Gzob
Q/ywO5R6bcm2imb/2rcXH8OoTtlJiJPlBHFMBXyygJQgflQcAIfuwWiBvCbbIOF+
rgZ/8fuCRPArRpbKb3Rxbze17lBL0LxgIp2gefMvnPgf18Yy3PlowiUZiTQnBhLh
FuvIwtcO+10ofJ/zyT3cS1U3j8p7nTmOYrQotnIygSFR5Ddsn8Dbiq+nkm19+q+J
zHm7kDzmcOml9b+gciavXT1nct+jTHdJN9t9z2FZ7F/UVPA7U0dj9cy4fZmV0Mg3
+wxfSaZ35TAh+LWrhpYMCGAl775lwsDInA2j3pRcXhslNkk5Gs3s6eIZA+pvmB+W
hASIbF2b2TEyc7UNs8nFXvFQN358/mO8y4J4OyZmgjt7TXDj/vw=
=5NgP
-----END PGP SIGNATURE-----

--+mr2ctTDD1GjnQwB--

