Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF2D0C47409
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C267217BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="a/+YcYl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C267217BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKs7-0004AW-No
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46452)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasper.lowell@bt.com>) id 1izEEE-0002VJ-41
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 01:32:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasper.lowell@bt.com>) id 1izEEB-0004uf-Cc
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 01:32:01 -0500
Received: from smtpe1.intersmtp.com ([62.239.224.237]:42761)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasper.lowell@bt.com>)
 id 1izEEA-0004Us-Bd
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 01:31:59 -0500
Received: from tpw09926dag11h.domain1.systemhost.net (10.9.212.35) by
 RDW083A010ED66.bt.com (10.187.98.36) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 5 Feb 2020 06:30:32 +0000
Received: from tpw09926dag08f.domain1.systemhost.net (10.9.202.39) by
 tpw09926dag11h.domain1.systemhost.net (10.9.212.35) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 5 Feb 2020 06:31:53 +0000
Received: from RDW083A009ED65.bt.com (10.187.98.35) by
 tpw09926dag08f.domain1.systemhost.net (10.9.202.39) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Wed, 5 Feb 2020 06:31:52
 +0000
Received: from GBR01-LO2-obe.outbound.protection.outlook.com (104.47.21.57) by
 smtpe1.intersmtp.com (62.239.224.236) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 5 Feb 2020 06:25:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iysOBxVLQ/MmuWvzhfSyOnXvYlFaLLegfdB+PhvY+SaWpoup36QPEwVGGffEyHjOzXNz7QhCXwx0pQ4cInjO/M7N2CAy4+HfuEG8qRuAsZta7j+OzbXDH+p9o1RugPJAYhle8F0+w9k8wkUyFn1Pb8iXdIfVqpnDFg6ybpdR2umTz3SyRdNqHIo1/O+KmTqakKJqJxKy/+T/JGmcnnGRWvKjkc7yNojxTVA5slOfmop7MrApjotDdYtOe7WEdqaH7kMw32BZ/M3Oevb3Nqasm2kqTi3O58UJjwIU1o1J26TtV3Q7tVKTnNwMG+93Do/pxC9090gwZq31rwblgM2gwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpNWOIB5LrCn1oO18+FAPxdJ/sMgPQt45DyVRSJKlcc=;
 b=L0Nl+bugBBMx9zPcRWFAOS+/2FRcrxnFslnHqig4IAXqZJPLy/g+wN6VRoSDS6Y/y16YbpamiaV6ihNvhZKVEKN1SFdcNZWMbMYiWudiUgXGDGleyIFwNhWocKgMaGC6CVUxQ8sIBtMwiZotSGAEwukCLruMOMuGtxykI6PohsoD3qITwgPFoUF11c2pLcwEODIpbPUZCY3bSTfgwPgQXJL9bX7kSNjQUk37xmRDNuq/cibzdQlwkJxlvwQs1PLtEtpKe7UUnuu92vbNPHK1yAT8JZ5a000w32sTmgW6q9kEzn5V2cnfcfiv9w/LZlG1FOLRfqJYc2eZ5Ar55Hb/tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vpNWOIB5LrCn1oO18+FAPxdJ/sMgPQt45DyVRSJKlcc=;
 b=a/+YcYl+TCT/oC0X8JvZ3Yb2Rju2x8nnmtNQ2et8O5nQgp61hzjgsf2vDLbV26Fs5lql0hgwoi9vkhYu+q7x/4POB0W7FGv5qgyN0yc1ugBhAlBnLrw0bl8BCE7PvEdb5Q0a/Fikq/wl+3JHOeiTHECdMEZfjqndgl9YqATgl08=
Received: from CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM (20.179.109.212) by
 CWXP123MB2389.GBRP123.PROD.OUTLOOK.COM (20.179.110.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.29; Wed, 5 Feb 2020 06:31:51 +0000
Received: from CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e475:38a3:109b:b884]) by CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e475:38a3:109b:b884%5]) with mapi id 15.20.2707.020; Wed, 5 Feb 2020
 06:31:51 +0000
From: <jasper.lowell@bt.com>
To: <qemu-devel@nongnu.org>
Subject: Emulating Solaris 10 on SPARC64 sun4u
Thread-Topic: Emulating Solaris 10 on SPARC64 sun4u
Thread-Index: AdXb7aKPCyPc5BgLRMag+zXZgy3FKQ==
Date: Wed, 5 Feb 2020 06:31:51 +0000
Message-ID: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jasper.lowell@bt.com; 
x-originating-ip: [61.14.34.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0f33059c-e003-4648-c131-08d7aa0515dc
x-ms-traffictypediagnostic: CWXP123MB2389:
x-microsoft-antispam-prvs: <CWXP123MB23893B0C3CDF298A0761B3B983020@CWXP123MB2389.GBRP123.PROD.OUTLOOK.COM>
x-antispam-2: 1
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(39860400002)(136003)(199004)(189003)(33656002)(7696005)(66946007)(71200400001)(5660300002)(2906002)(76116006)(4326008)(64756008)(54906003)(66476007)(66556008)(52536014)(478600001)(66446008)(6506007)(81166006)(8676002)(186003)(81156014)(26005)(6916009)(316002)(9686003)(966005)(86362001)(8936002)(55016002)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CWXP123MB2389;
 H:CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bt.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cfTZ9uQFfkv342E0frT84hQ/Qwp92GPgeEs7W7IHtGkBLL4eHDsIYOWVE4h7cyiBCku7BbN5wkm+6beoQMYNRbAB6r6G2wX6Uj1Xvp6pFdyAWEyqWJBf9CrqZ1dH4C71N3VGelGdvE8ldwjWF3IJjmEwa0WbB5ihBRQY9IaEtlh2gWYnFUkHPEBG9d5WFk0zc0xQEgXr5LfYJyDB6BeS8UnVRx1sFCdPkxHq35D9czSU0Mt5LIEmkTX82g5IM9Hf/+y4+ZvNAY6Hj/DEBCUIVm0vRHD8MTnalTmtS4G41IJXggucsNcf9eOSqWBiRi1FCaZdJ6TMeHWD/ZxrWa8W5qHbJH0pWm5ermAJFDbrNRoWmmG92tEBGUIMTxtIb05nySBsYkokdssuuutMc44yyyPi55Ayo3/wdRj0W45vZ3uLbETAhvn6S4jfwE8DnUDt/9KNsbAtNF2YL5hO4QfxCQo4Zhk6NNVy44vQmTDqZ6hOuHmtoVy8gHikLjriU5ig8Li79qycBYh8YCoCAFpuEznu7tJs/3zKSl0cI4CFv/fx3/+B9oF6l4Pf3OlxOA5m
x-ms-exchange-antispam-messagedata: 2B288idR6MYPeNYqVlhX+EZ7+J2XAl3NvpZadrhmWDT7AGeww+vKtogNg2a/dP7tMou1PFwe7sF2PuMpdkPlZi/iEiRk+5+K0f+Yq+JCZfsoYS6SnI5yZ2Sgxy8l8i0AgGnNhlfJdVceBB//4ymsEQ==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_CWXP123MB2262B6F3159B7AA7AB010F4183020CWXP123MB2262GBRP_"
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f33059c-e003-4648-c131-08d7aa0515dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 06:31:51.2952 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MAkMQf7F5o5EvpnTxw0C2GeeEYtGyvfvte+1+ArAUbpxy2SMdpD+mFZN0m7EVIvvk+3uNNwGFYO64rLp7FVTAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB2389
X-OriginatorOrg: bt.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.237
X-Mailman-Approved-At: Wed, 05 Feb 2020 08:35:33 -0500
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
Cc: mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_CWXP123MB2262B6F3159B7AA7AB010F4183020CWXP123MB2262GBRP_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm currently working towards emulating Solaris 10 on sun4u.

The Solaris 10 ISO image I am attempting to boot is the one from the Oracle
download page at https://www.oracle.com/solaris/solaris10/downloads/solaris=
10-get-jsp-downloads.html.
Image: sol-10-u11-ga-sparc-dvd.iso
MD5:   53e8b066f7f250ce2fd2cef063f8072b

I am using QEMU commit 7bd9d0a9e26c7a3c67c0f174f0009ba19969b158.

The command I am using to run QEMU is:
./qemu/sparc64-softmmu/qemu-system-sparc64 -bios ./openbios/obj-sparc64/ope=
nbios-builtin.elf -cdrom ./iso/solaris/sol-10-u11-ga-sparc-dvd.iso -boot d =
-nographic -m 3G

```
CPUs: 1 x SUNW,UltraSPARC-IIi
UUID: 00000000-0000-0000-0000-000000000000
Welcome to OpenBIOS v1.1 built on Feb 5 2020 19:15
  Type 'help' for detailed information
Trying cdrom:f...
Not a bootable ELF image
Not a bootable a.out image

Loading FCode image...
Loaded 7420 bytes
entry point is 0x4000
Evaluating FCode...
Evaluating FCode...
Ignoring failed claim for va 1000000 memsz af6d6!
Ignoring failed claim for va 1402000 memsz 4dcc8!
Ignoring failed claim for va 1800000 memsz 510c8!
SunOS Release 5.10 Version Generic_147147-26 64-bit
Copyright (c) 1983, 2013, Oracle and/or its affiliates. All rights reserved=
.
could not find debugger-vocabulary-hook>threads:interpret: exception -13 ca=
ught
interpret \ Copyright (c) 1995-1999 by Sun Microsystems, Inc.
\ All rights reserved.
\
\ ident "@(#)data64.fth  1.3     00/07/17 SMI"

hex

only forth also definitions
vocabulary kdbg-words
also kdbg-words definitions

defer p@
defer p!
['] x@ is p@
['] x! is p!

8 constant ptrsize

d# 32 constant nbitsminor
h# ffffffff constant maxmin
\
\ Copyright 2008 Sun Microsystems, Inc.  All rights reserved.
\ Use is subject to license terms.
\

\ #pragma ident  "@(#)kdbg.fth    1.20    08/06/06 SMI"

h# 7ff constant v9bias
h# unix-tte:interpret: exception -13 caught
interpret ' unix-tte is va>tte-data failed with error ffffffffffffffed
WARNING: consconfig: cannot find driver for screen device /pci@1fe,0/pci@1,=
1/QEMU,VGA@2
Configuring devices.
WARNING: Interrupt not seen after set_features
Using RPC Bootparams for network configuration information.
Attempting to configure interface hme0...
WARNING: Power off requested from power button or SC, powering down the sys=
tem!
Skipped interface hme0
svc:/system/filesystem/local:default: WARNING: /usr/sbin/zfs mount -a faile=
d: one or more file systems failed to mount
Serial console, reverting to text install
Beginning system identification...
Searching for configuration file(s)...
Search complete.
Discovering additional network configuration...
```

The installation menu is shown after but the console is unresponsive.

After some debugging, it looks like the QEMU front-end is correctly filling
the serial receive buffer with characters, and then starts dropping them on=
ce
the number of characters in the buffer reach the interrupt level. The inter=
rupt
level happens to be 1 when booting Solaris 10. This looks like normal behav=
iour
to me.

I started looking at why the serial receive buffer might not be consumed an=
d
considered that interrupts might not be being raised correctly. I ran with
tracing and there were no interrupts for IRQ 0x2b like there are when using
OpenBSD. When inspecting the registers of the serial device it looks like t=
he
Interrupt Enable Register is set to zero.

If Solaris 10 was using the device is polling mode, it should be reading th=
e RBR
or at least the LSR. When tracing serial_ioport_read and serial_ioport_writ=
e,
once the menu is hit, I don't see any read or writes to the serial device
registers despite me trying to send characters and use the menu.

The driver Solaris 10 is using for the device appears to be similar/same as
/usr/src/uts/sun4/io/su_driver.c in the OpenSolaris code found at https://g=
ithub.com/nxmirrors/onnv.

```
asy->asy_hwtype =3D ASY16550AF;
OUTB(FIFOR, 0x00); /* clear fifo register */
asy->asy_trig_level =3D 0x00; /* sets the fifo Threshold to 1 */

/* set/Enable FIFO */
OUTB(FIFOR, FIFO_ON | FIFODMA | FIFOTXFLSH | FIFORXFLSH |
(asy->asy_trig_level & 0xff));

if ((INB(ISR) & 0xc0) =3D=3D 0xc0)
    asy->asy_use_fifo =3D FIFO_ON; /* QEMU REACHES HERE. */
else {
    asy->asy_hwtype =3D ASY8250;
    OUTB(FIFOR, 0x00); /* NO FIFOs */
    asy->asy_trig_level =3D 0;
}
```

From what I can tell when tracing serial_ioport_write and serial_ioport_rea=
d,
Solaris 10 correctly identifies the serial device and successfully attaches=
 it.
In the asyattach function (OpenSolaris driver), interrupts are disabled by =
zeroing the
Interrupt Enable Register. From what I'm reading in OpenSolaris source code=
, interrupts
are reenabled when the device is "opened". This seems like consistent and
correct behaviour though I'm not sure why the device is not being opened to=
 be
used by the serial console.

Is this an issue anyone else has tried to debug?
Are there any leads that I can follow up on for why the serial console beco=
mes unresponsive
on Solaris 10?

Thanks,
Lowell.

--_000_CWXP123MB2262B6F3159B7AA7AB010F4183020CWXP123MB2262GBRP_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Consolas;
	panose-1:2 11 6 9 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
pre
	{mso-style-priority:99;
	mso-style-link:"HTML Preformatted Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:10.0pt;
	font-family:"Courier New";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
span.HTMLPreformattedChar
	{mso-style-name:"HTML Preformatted Char";
	mso-style-priority:99;
	mso-style-link:"HTML Preformatted";
	font-family:"Courier New";
	mso-fareast-language:EN-AU;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;
	mso-fareast-language:EN-US;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-AU" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">I'm currently working towards emul=
ating Solaris 10 on sun4u.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">The Solaris 10 ISO image I am atte=
mpting to boot is the one from the Oracle<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">download page at https://www.oracl=
e.com/solaris/solaris10/downloads/solaris10-get-jsp-downloads.html.<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Image: sol-10-u11-ga-sparc-dvd.iso=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">MD5:&nbsp;&nbsp; 53e8b066f7f250ce2=
fd2cef063f8072b<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">I am using QEMU commit 7bd9d0a9e26=
c7a3c67c0f174f0009ba19969b158.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">The command I am using to run QEMU=
 is:<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">./qemu/sparc64-softmmu/qemu-system=
-sparc64 -bios ./openbios/obj-sparc64/openbios-builtin.elf -cdrom ./iso/sol=
aris/sol-10-u11-ga-sparc-dvd.iso -boot
 d -nographic -m 3G<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">```<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">CPUs: 1 x SUNW,UltraSPARC-IIi<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">UUID: 00000000-0000-0000-0000-0000=
00000000<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Welcome to OpenBIOS v1.1 built on =
Feb 5 2020 19:15<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">&nbsp; Type 'help' for detailed in=
formation<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Trying cdrom:f...<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Not a bootable ELF image<o:p></o:p=
></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Not a bootable a.out image<o:p></o=
:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Loading FCode image...<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Loaded 7420 bytes<o:p></o:p></span=
></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">entry point is 0x4000<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Evaluating FCode...<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Evaluating FCode...<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Ignoring failed claim for va 10000=
00 memsz af6d6!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Ignoring failed claim for va 14020=
00 memsz 4dcc8!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Ignoring failed claim for va 18000=
00 memsz 510c8!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">SunOS Release 5.10 Version Generic=
_147147-26 64-bit<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Copyright (c) 1983, 2013, Oracle a=
nd/or its affiliates. All rights reserved.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">could not find debugger-vocabulary=
-hook&gt;threads:interpret: exception -13 caught<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">interpret \ Copyright (c) 1995-199=
9 by Sun Microsystems, Inc.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">\ All rights reserved.<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">\<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">\ ident &quot;@(#)data64.fth&nbsp;=
 1.3&nbsp;&nbsp;&nbsp;&nbsp; 00/07/17 SMI&quot;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">hex<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">only forth also definitions<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">vocabulary kdbg-words<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">also kdbg-words definitions<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">defer p@<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">defer p!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">['] x@ is p@<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">['] x! is p!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">8 constant ptrsize<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">d# 32 constant nbitsminor<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">h# ffffffff constant maxmin<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">\<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">\ Copyright 2008 Sun Microsystems,=
 Inc.&nbsp; All rights reserved.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">\ Use is subject to license terms.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">\<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">\ #pragma ident&nbsp; &quot;@(#)kd=
bg.fth&nbsp;&nbsp;&nbsp; 1.20&nbsp;&nbsp;&nbsp; 08/06/06 SMI&quot;<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">h# 7ff constant v9bias<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">h# unix-tte:interpret: exception -=
13 caught<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">interpret ' unix-tte is va&gt;tte-=
data failed with error ffffffffffffffed<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">WARNING: consconfig: cannot find d=
river for screen device /pci@1fe,0/pci@1,1/QEMU,VGA@2<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Configuring devices.<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">WARNING: Interrupt not seen after =
set_features<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Using RPC Bootparams for network c=
onfiguration information.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Attempting to configure interface =
hme0...<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">WARNING: Power off requested from =
power button or SC, powering down the system!<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Skipped interface hme0<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">svc:/system/filesystem/local:defau=
lt: WARNING: /usr/sbin/zfs mount -a failed: one or more file systems failed=
 to mount<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Serial console, reverting to text =
install<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Beginning system identification...=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Searching for configuration file(s=
)...<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Search complete.<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Discovering additional network con=
figuration...<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">```<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">The installation menu is shown aft=
er but the console is unresponsive.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">After some debugging, it looks lik=
e the QEMU front-end is correctly filling<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">the serial receive buffer with cha=
racters, and then starts dropping them once<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">the number of characters in the bu=
ffer reach the interrupt level. The interrupt<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">level happens to be 1 when booting=
 Solaris 10. This looks like normal behaviour<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">to me.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">I started looking at why the seria=
l receive buffer might not be consumed and<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">considered that interrupts might n=
ot be being raised correctly. I ran with<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">tracing and there were no interrup=
ts for IRQ 0x2b like there are when using<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">OpenBSD. When inspecting the regis=
ters of the serial device it looks like the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Interrupt Enable Register is set t=
o zero.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">If Solaris 10 was using the device=
 is polling mode, it should be reading the RBR<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">or at least the LSR. When tracing =
serial_ioport_read and serial_ioport_write,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">once the menu is hit, I don't see =
any read or writes to the serial device<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">registers despite me trying to sen=
d characters and use the menu.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">The driver Solaris 10 is using for=
 the device appears to be similar/same as<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">/usr/src/uts/sun4/io/su_driver.c i=
n the OpenSolaris code found at https://github.com/nxmirrors/onnv.<o:p></o:=
p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">```<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">asy-&gt;asy_hwtype =3D ASY16550AF;=
<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">OUTB(FIFOR, 0x00); /* clear fifo r=
egister */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">asy-&gt;asy_trig_level =3D 0x00; /=
* sets the fifo Threshold to 1 */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">/* set/Enable FIFO */<o:p></o:p></=
span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">OUTB(FIFOR, FIFO_ON | FIFODMA | FI=
FOTXFLSH | FIFORXFLSH |<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">(asy-&gt;asy_trig_level &amp; 0xff=
));<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">if ((INB(ISR) &amp; 0xc0) =3D=3D 0=
xc0)<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">&nbsp;&nbsp;&nbsp; asy-&gt;asy_use=
_fifo =3D FIFO_ON; /* QEMU REACHES HERE. */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">else {<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">&nbsp;&nbsp;&nbsp; asy-&gt;asy_hwt=
ype =3D ASY8250;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">&nbsp;&nbsp;&nbsp; OUTB(FIFOR, 0x0=
0); /* NO FIFOs */<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">&nbsp;&nbsp;&nbsp; asy-&gt;asy_tri=
g_level =3D 0;<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">}<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">```<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">From what I can tell when tracing =
serial_ioport_write and serial_ioport_read,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Solaris 10 correctly identifies th=
e serial device and successfully attaches it.<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">In the asyattach function (OpenSol=
aris driver), interrupts are disabled by zeroing the<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Interrupt Enable Register. From wh=
at I'm reading in OpenSolaris source code, interrupts<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">are reenabled when the device is &=
quot;opened&quot;. This seems like consistent and<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">correct behaviour though I'm not s=
ure why the device is not being opened to be<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">used by the serial console.<o:p></=
o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Is this an issue anyone else has t=
ried to debug?<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Are there any leads that I can fol=
low up on for why the serial console becomes unresponsive<o:p></o:p></span>=
</p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">on Solaris 10?<o:p></o:p></span></=
p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:Consolas=
;color:black;mso-fareast-language:EN-AU">Lowell.<o:p></o:p></span></p>
</div>
</body>
</html>

--_000_CWXP123MB2262B6F3159B7AA7AB010F4183020CWXP123MB2262GBRP_--

