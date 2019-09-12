Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295BBC49ED6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 00:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E266920872
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 00:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="k3J12dlC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E266920872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8CqH-00070Y-1z
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 20:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1i8CmP-000239-Bi
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 20:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1i8CmN-0006A4-L0
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 20:16:09 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:34595)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1i8CmM-000697-7f; Wed, 11 Sep 2019 20:16:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 46TK756lDNz9sNF; Thu, 12 Sep 2019 10:16:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1568247361;
 bh=1uzSIh6+kDEBjNJfos2dP5SeXlbGeiqqNljcg5smoQQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k3J12dlCUQzyp1nFl5WQw+1QeUCYU7CaXuACHEU5xp7fsW+WDaMNmP9Frto7Zn1fj
 w8Is+XjxtS7kn1sMZRjzdXGnRPT5raVDlShoby3ZKwgMI7IVpE4kHmkf/a6nBnXKBY
 s+7xc/gqE762E4VXTnBhgW2VIxGXMOgqQTzkl7Zo=
Date: Thu, 12 Sep 2019 10:07:19 +1000
From: "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
To: "Muolo Vincenzo (S.I.)" <vincenzo.muolo@angelcompany.com>
Message-ID: <20190912000719.GF13785@umbus.fritz.box>
References: <VI1PR08MB439957EF8E072A9A2A96B58DE5B10@VI1PR08MB4399.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rWhLK7VZz0iBluhq"
Content-Disposition: inline
In-Reply-To: <VI1PR08MB439957EF8E072A9A2A96B58DE5B10@VI1PR08MB4399.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] issue related to boot aix 7.1 when I try to use
 qemu ppc64
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
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--rWhLK7VZz0iBluhq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2019 at 03:58:14PM +0000, Muolo Vincenzo (S.I.) wrote:
> Hi to all
>=20
> I try to use ( into VM debian 10  running into VMWARE virtualization envi=
ronment ) qemu ppc64  version to simulate an AIX 7.1 TL04  OS
>=20
>=20
> root@vkvm-acmm:/AIX# qemu-system-ppc64  -version
> QEMU emulator version 3.1.0 (Debian 1:3.1+dfsg-8+deb10u2)
> Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers
>=20
>=20
> I run the following commands into my linux DEB but after few time i have =
to following issue ( trap  interrupt kernel see to end .. ):
>=20
> qemu-system-ppc64 -cpu POWER8 -machine pseries -m 4096 -serial stdio -dri=
ve file=3Ddisk.img,if=3Dnone,id=3Ddrive-virtio-disk0 -device virtio-scsi-pc=
i,id=3Dscsi -device scsi-hd,drive=3Ddrive-virtio-disk0 -cdrom aix.iso -prom=
-env "boot-command=3Ddev / 0 0 s\" ibm,aix-diagnostics\" property boot cdro=
m:\ppc\chrp\bootfile.exe -s verbose" -net nic -net tap -display vnc=3D:1
> W: /etc/qemu-ifup: no bridge for guest interface found

Running AIX under qemu really isn't tested or supported as yet.  We're
just starting to look at this these days, but you'd want to get the
very latest upstream qemu (4.1) and even then there could well be
remaining problems.

>=20
>=20
> SLOF ********************************************************************=
**
> QEMU Starting
> Build Date =3D Dec 28 2018 13:55:34
> FW Version =3D buildd@ release 20180702
> Press "s" to enter Open Firmware.
>=20
> Populating /vdevice methods
> Populating /vdevice/vty@71000000
> Populating /vdevice/nvram@71000001
> Populating /vdevice/l-lan@71000002
> Populating /vdevice/v-scsi@71000003
>        SCSI: Looking for devices
>           8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
> Populating /pci@800000020000000
>                      00 0000 (D) : 1234 1111    qemu vga
>                      00 0800 (D) : 1033 0194    serial bus [ usb-xhci ]
>                      00 1000 (D) : 1af4 1004    virtio [ scsi ]
> Populating /pci@800000020000000/scsi@2
>        SCSI: Looking for devices
>           100000000000000 DISK     : "QEMU     QEMU HARDDISK    2.5+"
> Installing QEMU fb
>=20
>=20
>=20
> Scanning USB
>   XHCI: Initializing
>     USB Keyboard
>     USB mouse
> No console specified using screen & keyboard
>=20
>   Welcome to Open Firmware
>=20
>   Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
>   This program and the accompanying materials are made available
>   under the terms of the BSD License available at
>   http://www.opensource.org/licenses/bsd-license.php
>=20
>=20
> Trying to load: -s verbose from: /vdevice/v-scsi@71000003/disk@8200000000=
000000:\ppc\chrp\bootfile.exe ...   Successfully loaded
> AIX
> StarLED{814}
>=20
> AIX Version 7.1
> exec(/etc/init){1,0}
>=20
> INIT: EXECUTING /sbin/rc.boot 1
> exec(/usr/bin/sh,-c,/sbin/rc.boot 1){1179684,1}
> exec(/sbin/rc.boot,/sbin/rc.boot,1){1179684,1}
> + PHASE=3D1
> + + bootinfo -p
> exec(/usr/sbin/bootinfo,-p){1245222,1179684}
> PLATFORM=3Dchrp
> + [ ! -x /usr/lib/boot/bin/bootinfo_chrp ]
> + [ 1 -eq 1 ]
> + 1> /usr/lib/libc.a
> + init -c unlink /usr/lib/boot/bin/!(*_chrp)
> exec(/etc/init,-c,unlink /usr/lib/boot/bin/!(*_chrp)){1245224,1179684}
> + chramfs -t
> exec(/usr/sbin/chramfs,-t){1245226,1179684}
> + init -c unlink /usr/sbin/chramfs
> + 1> /dev/null
> exec(/etc/init,-c,unlink /usr/sbin/chramfs){1245228,1179684}
> + + bootinfo -t
> exec(/usr/sbin/bootinfo,-t){1245230,1179684}
> BOOTYPE=3D3
> + [ 0 -ne 0 ]
> + [ -z 3 ]
> + unset pdev_to_ldev undolt native_netboot_cfg
> + unset disknet_odm_init config_ATM
> + /usr/lib/methods/showled 0x510 DEV CFG 1 START
> exec(/usr/lib/methods/showled,0x510,DEV CFG 1 START){1245232,1179684}
> + cfgmgr -f -v
> exec(/usr/sbin/cfgmgr,-f,-v){1245234,1179684}
> cfgmgr is running in phase 1
> ----------------
> Time: 0 LEDS: 0x538
> Invoking top level program -- "/etc/methods/defsys"
> exec(/bin/sh,-c,/etc/methods/defsys ){1310760,1245234}
> exec(/etc/methods/defsys){1310760,1245234}
> exec(/bin/sh,-c,/usr/lib/methods/define_rspc -n -c sys -s node -t chrp){1=
376298,1310760}
> exec(/usr/lib/methods/define_rspc,-n,-c,sys,-s,node,-t,chrp){1376298,1310=
760}
> Time: 0 LEDS: 0x539
> Return code =3D 0
> ***** stdout *****
> sys0
>=20
> ***** stderr *****
> MS 1376298 1310760 /usr/lib/methods/define_rspc -n -c sys -s node -t chrp
> M4 1376298 Defining device: uniquetype=3Dsys/node/chrp parent=3D connecti=
on=3D
> M4 1376298 ..define_dvc()
> M4 1376298 ..generate_name()
> M4 1376298 Generated name: sys0
> M4 1376298 ..create_cudv()
> M4 1376298 Adding new CuDv
> M4 1376298 Defined device sys0
>=20
> ----------------
> Attempting to configure device 'sys0'
> Time: 0 LEDS: 0x811
> Invoking /usr/lib/methods/cfgsys_chrp -1 -l sys0
> exec(/bin/sh,-c,/usr/lib/methods/cfgsys_chrp -1 -l sys0){1310762,1245234}
> Number of running methods: 1
> exec(/usr/lib/methods/cfgsys_chrp,-1,-l,sys0){1310762,1245234}
> LED{A20}
> Illegal Trap Instruction Interrupt in Kernel
> 05911ACC            tweqi    r0,0                r0=3D0
> KDB(0)>
>=20
> So how can I to proceed ? I must to try to use an different  kernel AIX (=
 7.2 ? ) or it's possibile to fix this one ?
>=20
> I'll  available to take a dump and so on ....
>=20
> Awaiting an feedback
>=20
> Thanks to all
>=20
> Vincenzo
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rWhLK7VZz0iBluhq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl15jDQACgkQbDjKyiDZ
s5KzWw/8DV9/XIT3BncV10BE8P8/3Gcy0J5lU7G4Sx3uPBrHIERezWQydp0JSmtj
P/G3gpprAiC+DFxr+jhGY3+I8hEKLN+UaLMSyIkdpM+8d/W39qUBK10aoIaQWk0v
cZFO11+QMP/Gu5bC/7AcJFvnRgVF1V/JIgIdyiStjw9WyxgSm5ZN5fjFK4gWkkAI
t/RAdYKjcAXZrceE5jvQIQePGlI7xW88zVafBoddpCWenoe5/7g+6BDabvLNjMHv
NmjlIoEJuWfMqfY6bgRikqyHJOYUiRaECBI5tRnMVQKRqHxTBfFQZ6O3kcXJRdaU
udKBsioOTAQccB1rNrZLPPkhNrBoB+wzjtKBPrb1ZstO90iq5E+EFbk4vxCqCwck
U1OYMn3LPqQRf/0bWN19jMy69vbknnYMkWGTfN1tSXAsDzPS494h020AUOC6h7rs
oygyg/9dxts2bXz2dZcu5s0ZQD+o4f0ilYpmnOitNALZAgYpxu1ZiykIUGEs9yfL
at1rdN1ODOuwOYjSmK5jhKxvY8l6x1jmkp4h/ct2Hdvh5o91FYkvVKVNqRiju/Nf
w4w5n7QzmjOkaTNUoD8VBqWSzxVhpdGVhqkLbuBMxf/rXEUT3UZ315M0J12SwNvQ
53pUX1B6/9Ki2pdfTj1iBCFAk6tmu4SQ+39P26TrGpNFLzrMsa0=
=53WK
-----END PGP SIGNATURE-----

--rWhLK7VZz0iBluhq--

