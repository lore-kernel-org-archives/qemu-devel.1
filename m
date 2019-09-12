Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811E0C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:09:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DEAF2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 14:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=angelcompanygroup.onmicrosoft.com header.i=@angelcompanygroup.onmicrosoft.com header.b="j1ijkyuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DEAF2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angelcompany.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8Pmp-0001VM-IZ
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 10:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vincenzo.muolo@angelcompany.com>) id 1i8PS6-00046G-U8
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vincenzo.muolo@angelcompany.com>) id 1i8PS5-0001z2-3t
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:48:02 -0400
Received: from mail-eopbgr30046.outbound.protection.outlook.com
 ([40.107.3.46]:49734 helo=EUR03-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vincenzo.muolo@angelcompany.com>)
 id 1i8PS0-0001vq-TI; Thu, 12 Sep 2019 09:47:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m38/vn2I7q+e070OBdfBUTFy1hpvpYqwmrffGB6ItgXXaEabmJHxoB34zPbeVKPnbmKogJdxDNCRfmdBzqDc5qvtIdCybaoyVqwEwvFeQ9ejyRrOpfAF2Y0lGWrVwgEgkizYxZq581/nwMQAeFoNZsC25SYL/ZzAJ4/bBq3aHgnTCyOcR4/Swn9PN2Rx+xw4UXnVUOF1yD1bq0/ERiLWKDM8t7LygCwboRivCessa/rtlnVp4fVQxP2lXprN/FNz8RTxi3Vyv15Gc+iI5AhNXbXfRRK7q/Z+jydyjj8ZaEarPsIaKz4SX/aqZ8vik6EKcGJ6ZF8YotVAk3QdZY9LjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yL59H+WxlVlBSVFVeanQKoRmWhSVLXBWzZQHFvefHE=;
 b=FvH/NhmSzW/0aJzCZ9SF1bdJ0dAnAvxhfNZU48+CP/WkCvlpd8DzWxWLdzIWf0mB+tOEB3ZVjeDCOF2326bGbo7FwlLKM29HT3SfPdJMpELzFWNx9bRdcMrBVTnSC3xdVXFGJNsEtNvBo0zOQeHLpJJr3O6BehJdjsnjcTmaEgGmmzCOXBmIvYnUgl8bPW/EBMrLdkeN2AS2BgYPmpW4YbWHsRHY3i8HZFLX/Ep0SwFmB1K614MDNZh0rYxzfY4axKKWjxG3ACvQogafC7ZCeKwOTjPVHp07S1cTgBMFlouqIhh5pg7sWdYFpuCBT06t9smo9y6OLMCWxqwVi1cB6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=angelcompany.com; dmarc=pass action=none
 header.from=angelcompany.com; dkim=pass header.d=angelcompany.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=angelcompanygroup.onmicrosoft.com;
 s=selector1-angelcompanygroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yL59H+WxlVlBSVFVeanQKoRmWhSVLXBWzZQHFvefHE=;
 b=j1ijkyuPQC4oG5LjzvEOX1KlOF5aXStiXUc2HQjgJGXkjBS09IQ7YRgqjmwyqg5RcjhfuY62EF2ksLkRaAhuVkZgQsZgZ+2svaQCus/ykX3+L0m5yW56Hplshq7Xa52hBLNERMvkbXqGOoqNrRrhMA9GhwUpthExB87Sbj2IZb4=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB2878.eurprd08.prod.outlook.com (10.170.239.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.22; Thu, 12 Sep 2019 13:47:53 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7%6]) with mapi id 15.20.2263.016; Thu, 12 Sep 2019
 13:47:53 +0000
From: "Muolo Vincenzo (S.I.)" <vincenzo.muolo@angelcompany.com>
To: "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Thread-Topic: issue related to boot aix 7.1 when I try to use qemu ppc64
Thread-Index: AdVouUhNGC1ZBUZSS1GZyGskmH5ZbwARMKGAABwQzSA=
Date: Thu, 12 Sep 2019 13:47:53 +0000
Message-ID: <VI1PR08MB4399E7ADF4DA20EA65CCA74DE5B00@VI1PR08MB4399.eurprd08.prod.outlook.com>
References: <VI1PR08MB439957EF8E072A9A2A96B58DE5B10@VI1PR08MB4399.eurprd08.prod.outlook.com>
 <20190912000719.GF13785@umbus.fritz.box>
In-Reply-To: <20190912000719.GF13785@umbus.fritz.box>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vincenzo.muolo@angelcompany.com; 
x-originating-ip: [93.63.158.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8812d63f-2172-4242-200c-08d73787cf9d
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB2878; 
x-ms-traffictypediagnostic: VI1PR08MB2878:
x-ms-exchange-purlcount: 2
x-microsoft-antispam-prvs: <VI1PR08MB287885D694A35372BA8E9624E5B00@VI1PR08MB2878.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 01583E185C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39840400004)(376002)(136003)(396003)(346002)(51874003)(54164003)(189003)(199004)(15188155005)(2906002)(66066001)(6306002)(55016002)(6916009)(9686003)(5640700003)(33656002)(966005)(14454004)(478600001)(99286004)(81166006)(86362001)(256004)(6436002)(102836004)(66946007)(64756008)(2501003)(6116002)(11346002)(54906003)(2351001)(305945005)(486006)(66556008)(66446008)(76176011)(66476007)(26005)(3846002)(446003)(186003)(16799955002)(8676002)(7736002)(71190400001)(71200400001)(25786009)(476003)(316002)(7696005)(1730700003)(76116006)(81156014)(4326008)(8936002)(52536014)(6506007)(74316002)(5660300002)(53936002)(460985005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR08MB2878;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: angelcompany.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FTHbEd9EdW/7F5aJ9MVRF/ioWS4vKzhnKOX68znm9R2CMgH9IhEFlKSiLYXqM5Ofb5La1Ey1MunUSwKkDKZ8VC8/1QjF6zjB2sgfO5oaJ2O6dUbfHsL9wWoO4ZSFJq2wAMt+6IK0egh4aXI5O05dpgexJJhQ26Z3C96slUzYJ/uRuDFNsZeXs9W3enlh2wSb++jeqd7r9Os2rDlpqlTOakulwPFlM8Kwi9TE/7qRYg95Q4SMhmNm9haWrhDbXMG/Nx3nl5Ep+rXW6vfFbRnugpOKFF/PvgH8dgtCfErF7DH7iP/XP3VX1kYE6aI8hd9d2rylR0C9n1wjWyhc0U7VXjk6DIy+Ei5fRC5iyBUzofmrbk6PqyzRYO0te0ZCrnGS4YY/dOb6n4NTV3Wamou7P7QNbYMePB46KO5jHeQffMo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: angelcompany.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8812d63f-2172-4242-200c-08d73787cf9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2019 13:47:53.8838 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c187ee01-4e4e-40c8-b342-f82c8d699421
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: reA1NYtqswmS67JG43izIBXl5tBvRW9lFPGIiVOiRGCMxbPVjm4wy+B/8ld8dSSZNcySF2oZabZolXq7MGIq/h6LDIx3Y9GERv5av1HlpJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB2878
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.3.46
Subject: [Qemu-devel] R: issue related to boot aix 7.1 when I try to use
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

Hi David Thanks also for for answer=20

Now I try to install the qemu (4.1) into DEB Server  ( qemu_4.1-1+b1_ppc64.=
deb   )  however I had the following error :

apt install /home/vmuolo/qemu_4.1-1+b1_ppc64.deb
dpkg: error in processing the archive /home/vmuolo/qemu_4.1-1+b1_ppc64.deb =
(--unpack):

  the package architecture (ppc64) does not match that of the system (amd64=
)

Now this means that the "old" package qemu  ppc is valid only for 32 bits o=
r no (?)

Again  if I try to install this package into our DEB Server ( amd64) second=
 your opinion  how can  to proceed ?=20

For i.e. must I download the latest source files and try to compile the " n=
ew"  qemu ?  This can be an right approach or no ?

Have you some further  suggestion to give me so I  can to go ahead ?

Thanks in advance=20

Vincenzo


root@vkvm-acmm:/home/vmuolo# ls
Documenti  Immagini  Musica    qemu_4.1-1+b1_ppc64.deb  Scrivania
ftp        Modelli   Pubblici  Scaricati                Video
root@vkvm-acmm:/home/vmuolo# dpkg --print-architecture
amd64
root@vkvm-acmm:/home/vmuolo# apt install /home/vmuolo/qemu_4.1-1+b1_ppc64.d=
eb
Lettura elenco dei pacchetti... Fatto
Generazione albero delle dipendenze
Lettura informazioni sullo stato... Fatto
Nota, viene selezionato "qemu:ppc64" al posto di "/home/vmuolo/qemu_4.1-1+b=
1_ppc64.deb"
I seguenti pacchetti saranno RIMOSSI:
  qemu
I seguenti pacchetti NUOVI saranno installati:
  qemu:ppc64
0 aggiornati, 1 installati, 1 da rimuovere e 0 non aggiornati.
=C8 necessario scaricare 0 B/70,1 kB di archivi.
Dopo quest'operazione, verranno occupati 2.048 B di spazio su disco.
Continuare? [S/n] s
Scaricamento di:1 /home/vmuolo/qemu_4.1-1+b1_ppc64.deb qemu ppc64 1:4.1-1+b=
1 [70,1 kB]
dpkg: errore nell'elaborare l'archivio /home/vmuolo/qemu_4.1-1+b1_ppc64.deb=
 (--unpack):
 l'architettura del pacchetto (ppc64) non corrisponde a quella del sistema =
(amd64)
Si sono verificati degli errori nell'elaborazione:
 /home/vmuolo/qemu_4.1-1+b1_ppc64.deb
E: Sub-process /usr/bin/dpkg returned an error code (1)
root@vkvm-acmm:/home/vmuolo#


-----Messaggio originale-----
Da: david@gibson.dropbear.id.au <david@gibson.dropbear.id.au>=20
Inviato: gioved=EC 12 settembre 2019 02:07
A: Muolo Vincenzo (S.I.) <vincenzo.muolo@angelcompany.com>
Cc: qemu-ppc@nongnu.org; qemu-devel@nongnu.org
Oggetto: Re: issue related to boot aix 7.1 when I try to use qemu ppc64

On Wed, Sep 11, 2019 at 03:58:14PM +0000, Muolo Vincenzo (S.I.) wrote:
> Hi to all
>=20
> I try to use ( into VM debian 10  running into VMWARE virtualization=20
> environment ) qemu ppc64  version to simulate an AIX 7.1 TL04  OS
>=20
>=20
> root@vkvm-acmm:/AIX# qemu-system-ppc64  -version QEMU emulator version=20
> 3.1.0 (Debian 1:3.1+dfsg-8+deb10u2) Copyright (c) 2003-2018 Fabrice=20
> Bellard and the QEMU Project developers
>=20
>=20
> I run the following commands into my linux DEB but after few time i have =
to following issue ( trap  interrupt kernel see to end .. ):
>=20
> qemu-system-ppc64 -cpu POWER8 -machine pseries -m 4096 -serial stdio=20
> -drive file=3Ddisk.img,if=3Dnone,id=3Ddrive-virtio-disk0 -device=20
> virtio-scsi-pci,id=3Dscsi -device scsi-hd,drive=3Ddrive-virtio-disk0=20
> -cdrom aix.iso -prom-env "boot-command=3Ddev / 0 0 s\"=20
> ibm,aix-diagnostics\" property boot cdrom:\ppc\chrp\bootfile.exe -s=20
> verbose" -net nic -net tap -display vnc=3D:1
> W: /etc/qemu-ifup: no bridge for guest interface found

Running AIX under qemu really isn't tested or supported as yet.  We're just=
 starting to look at this these days, but you'd want to get the very latest=
 upstream qemu (4.1) and even then there could well be remaining problems.

>=20
>=20
> SLOF=20
> **********************************************************************
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
> exec(/usr/bin/sh,-c,/sbin/rc.boot 1){1179684,1}=20
> exec(/sbin/rc.boot,/sbin/rc.boot,1){1179684,1}
> + PHASE=3D1
> + + bootinfo -p
> exec(/usr/sbin/bootinfo,-p){1245222,1179684}
> PLATFORM=3Dchrp
> + [ ! -x /usr/lib/boot/bin/bootinfo_chrp ] [ 1 -eq 1 ]
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
> + unset pdev_to_ldev undolt native_netboot_cfg unset disknet_odm_init=20
> + config_ATM /usr/lib/methods/showled 0x510 DEV CFG 1 START
> exec(/usr/lib/methods/showled,0x510,DEV CFG 1 START){1245232,1179684}
> + cfgmgr -f -v
> exec(/usr/sbin/cfgmgr,-f,-v){1245234,1179684}
> cfgmgr is running in phase 1
> ----------------
> Time: 0 LEDS: 0x538
> Invoking top level program -- "/etc/methods/defsys"
> exec(/bin/sh,-c,/etc/methods/defsys ){1310760,1245234}=20
> exec(/etc/methods/defsys){1310760,1245234}
> exec(/bin/sh,-c,/usr/lib/methods/define_rspc -n -c sys -s node -t=20
> chrp){1376298,1310760}=20
> exec(/usr/lib/methods/define_rspc,-n,-c,sys,-s,node,-t,chrp){1376298,1
> 310760}
> Time: 0 LEDS: 0x539
> Return code =3D 0
> ***** stdout *****
> sys0
>=20
> ***** stderr *****
> MS 1376298 1310760 /usr/lib/methods/define_rspc -n -c sys -s node -t=20
> chrp
> M4 1376298 Defining device: uniquetype=3Dsys/node/chrp parent=3D=20
> connection=3D
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
> Invoking /usr/lib/methods/cfgsys_chrp -1 -l sys0=20
> exec(/bin/sh,-c,/usr/lib/methods/cfgsys_chrp -1 -l=20
> sys0){1310762,1245234} Number of running methods: 1=20
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

