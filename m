Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619E2C34022
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 03:43:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 158ED20801
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 03:43:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="Y7OdAe+h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 158ED20801
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4GGK-0005WZ-6q
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 22:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43685)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasper.lowell@bt.com>) id 1j4GFg-00054z-2t
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 22:42:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasper.lowell@bt.com>) id 1j4GFc-0006fJ-Im
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 22:42:19 -0500
Received: from smtpe1.intersmtp.com ([62.239.224.235]:52413)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasper.lowell@bt.com>)
 id 1j4GFb-0006Y2-Dq
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 22:42:16 -0500
Received: from tpw09926dag07e.domain1.systemhost.net (10.9.202.34) by
 RDW083A011ED67.bt.com (10.187.98.37) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 19 Feb 2020 03:42:28 +0000
Received: from tpw09926dag07g.domain1.systemhost.net (10.9.202.42) by
 tpw09926dag07e.domain1.systemhost.net (10.9.202.34) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Wed, 19 Feb 2020 03:42:11 +0000
Received: from RDW083A011ED67.bt.com (10.187.98.37) by
 tpw09926dag07g.domain1.systemhost.net (10.9.202.42) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Wed, 19 Feb 2020 03:42:11
 +0000
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (104.47.20.51) by
 smtpe1.intersmtp.com (62.239.224.235) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Wed, 19 Feb 2020 03:42:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmsJjctDmANTfuqFKTaKtcNqVB9EJ2YGunbCnzlysi35WIuI+ORPFeBGx+Ay/dNUVQBL0uJvHJ4axxbirYYIZ6QFNYS7MlcOtoN5jUyCHP0F8el/PhtV6SX/pZHRIunHRW+nEMgAvsvDJlWu+wLWzBAZYKtNZwBlipLJutjSh8Ys3WwcmZMujeQIRVNTLGR8gwSaMJeaetiTzx6VhnJqHV1oBDI6QziMskcZMobeNIB7DhepVtUxuMZ0bxsIa5c+A1PpR00CoTylS7A0VlMT9YLGkh9eiODibsQke4eUVO/oztRewa1r7ak/j/pheb9qGpGEu5DDsoR6Scfdhw50tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QfeVjdUlraZ+zVvuyCJ/NSYR3yvJpgYYGwSBtOpdDk=;
 b=QYIw3veCeECb/au/+gHUlojOZQzuFg3HN04pvQN0uGnPnO8ExSMDU7+NQ8pTgsnnj/pThP2CozwbISqcm/XwlJH9gvJCyNMPvbgPKpmUGg6YD/mgmrNwyILzAC6Enr/7fpNphRDC1eVyy8iVhkIeeB2ykkwUBGBD+QePez20pAd9cz+BSZZzzl3DkFofrdyr5t4PQa83MqoDk9JuI31XM4nDEPMMENOQZr/y1Iz4VU9J0dwLarZVjoxbK1FEJ0xm46q+QNzT2LrIt9QbQsGKo9rPKRp+KE4BsrWe01e3t6RDdq1o5nrm+AcDA1mrwW4uK5Vaqta5zsZfKB6i5NqLCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/QfeVjdUlraZ+zVvuyCJ/NSYR3yvJpgYYGwSBtOpdDk=;
 b=Y7OdAe+hHpiGw+zhzZbcNqKoKxjLYOAfAmQaGUuopL/+0DpX/06Io9Ic4B5xqEoq8lLe5ekBpJU0S7n5fjp/WMtD+4E/SlMN1364OHW4i+xJ7S3iwarTkG0FZlTtQxcXLqeSlacQZ4uxRe3nSKt+FZBgWISDQupdNSLjA22yuf8=
Received: from LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM (20.176.154.209) by
 LO2P123MB2093.GBRP123.PROD.OUTLOOK.COM (20.176.155.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Wed, 19 Feb 2020 03:42:09 +0000
Received: from LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM
 ([fe80::41c0:c971:96e3:abf0]) by LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM
 ([fe80::41c0:c971:96e3:abf0%5]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 03:42:09 +0000
From: <jasper.lowell@bt.com>
To: <mark.cave-ayland@ilande.co.uk>, <qemu-devel@nongnu.org>
Subject: RE: Emulating Solaris 10 on SPARC64 sun4u
Thread-Topic: Emulating Solaris 10 on SPARC64 sun4u
Thread-Index: AdXb7aKPCyPc5BgLRMag+zXZgy3FKQDThhmAAeT9/3A=
Date: Wed, 19 Feb 2020 03:42:09 +0000
Message-ID: <LO2P123MB2271B1493AD1B4DC8DDCB97783100@LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM>
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <f0f00ecd-1989-9bc1-02e0-8a9b4819f051@ilande.co.uk>
In-Reply-To: <f0f00ecd-1989-9bc1-02e0-8a9b4819f051@ilande.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jasper.lowell@bt.com; 
x-originating-ip: [61.68.11.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7766f3fa-8e0f-41b4-7216-08d7b4edb2d7
x-ms-traffictypediagnostic: LO2P123MB2093:
x-microsoft-antispam-prvs: <LO2P123MB209307822664D5C0E6CA2E4583100@LO2P123MB2093.GBRP123.PROD.OUTLOOK.COM>
x-antispam-2: 1
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(136003)(376002)(346002)(39860400002)(189003)(199004)(54906003)(4326008)(2906002)(33656002)(53546011)(52536014)(5660300002)(71200400001)(110136005)(966005)(6506007)(55016002)(186003)(478600001)(26005)(316002)(81166006)(81156014)(8676002)(8936002)(9686003)(66946007)(76116006)(7696005)(86362001)(66446008)(64756008)(66476007)(66556008)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:LO2P123MB2093;
 H:LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bt.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ClOxP8HwXrhAGwoUo/E+iVxzZGEV4NHwaa3NJcq+3U6bMYQKf13TOY4xyq2Nhtd7qff2Pj0X7biw4K1UNfVJeiRFw4JCyOzr4YGq2lWKBuJvxZ7KtZ3QAD/f0juQBpWKVIcb7nbpktIPUEzVYW5oi1we8ZsdAa8JkXQH5kwdmXU0Au+nS5Ga21lmNZq9meqRGNYQX1v3GB91JIjlxwZLxjfbqzRlStMXRs6UZdFcmR07eLcMmM25s0ECWk2kbKip2O2CXyvdkNEJovmMHsxonzBGjJ1IMjMU1vA112Gmv0yNg6ZX4/6Qd6mh0Z2+JH+AW/nazuQu2kmvYANveoc+g84+gSem8HIom0w8gsxSTKz62KlweHxqXp+R55u+WdCNRRJaXYhph2tQtxl818f1MmHVslgVtPSjnL/gUCbPB1nx2pCluYxzSSudjh4eJePdveZz84uuRuOaebwS4yaEAQTDgkdiiHxw3qf3Kvg/8tyKoGZQvXICE/DH6tfjHJZtPuYjcZ0EkQgNCwLV6eV2eakeOG1vsj3925vsMqxDIfKIKxPXvaYVx7GBgadSWmT
x-ms-exchange-antispam-messagedata: AJDXrwBNVGphMQDNFSw3MlFn7rZ71USaiybYRq+0pH5lE2V0GD1QCoYSPSYceD9v9r9mmNdx/jUOPE4cjdTwiMl3KHNZ6BxMgUZsDmCm513gf/jwZ9szuYMoMeH1QGPXB0qmSTqMOi7E2xxWtJh/DQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 7766f3fa-8e0f-41b4-7216-08d7b4edb2d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 03:42:09.5777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0bEzTwaZ1TjYxXR5HdypdyFluheM38PLWZGHc4IRGotWw87RqjPIBbbr1kdj/Ddd7veYMEuNvvRVcSbADuR4AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB2093
X-OriginatorOrg: bt.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.235
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
Cc: jsnow@redhat.com, dgilbert@redhat.com, atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Excuse the delay. I believe the reason why I am unable to locate the error =
string "Interrupt not seen after set_features" in the OpenSolaris source co=
de is because it belongs to a proprietary driver that was not distributed w=
ith OpenSolaris. Rather than rely on source code I've had to debug this pro=
blem by observing Solaris 10's behaviour.

I previously linked https://docs.oracle.com/cd/E23824_01/html/821-1475/uata=
-7d.html that seems to indicate that this error is fatal.
Considering that the CMD646 IDE controller driver experiences a fatal error=
 during the bootstrapping of the system, I suspect that the file system on =
the CDROM might not be accessible.
I'm not sure if this is directly related to the unresponsive serial console=
 but I wouldn't be surprised.

When configuring devices, Solaris 10 uses the SET_FEATURE command on the CM=
D646 to set the transfer mode to MDMA mode.
From what I can tell, this is successful and the emulated IDE controller ra=
ises an interrupt acknowledging that the command was completed successfully=
. To determine whether or not this interrupt was successfully propagated to=
 Solaris 10, I made manual changes to ensure that the interrupt was not rai=
sed for this event at this specific time. This resulted in a new error from=
 Solaris 10 regarding "set_features".
- Solaris 10 appears to be able to see the interrupt from the completion of=
 the SET_FEATURE command.
- Solaris 10 appears to then perform two reads on the status register. From=
 what I understand, this has the side effect of clearing interrupts.
- Solaris 10 then writes to the device/head register.
- Solaris 10 then spins on ARTTIM23_INTR_CH1 expecting it to be set. When i=
t is not set, the operation times out and we are presented with the fatal e=
rror regarding set_features.

I am not intimately familiar with the workings of the CMD646 or the ATA spe=
cification so I can only speculate.
- If the interrupt that Solaris 10 expects is the one from the SET_FEATURE =
command, then Solaris 10 is not expecting reading from the status register =
to clear ARTTIM23_INTR_CH1.
- If the interrupt that Solaris 10 expects is not the one from the SET_FEAT=
URE command, then it must expect an interrupt to occur from writing to the =
device/head register.

I found it strange that Solaris 10 was spinning on ARTTIM23_INTR_CH1. Is it=
 possible that Solaris 10 is not expecting the values of ARTTIM23_INTR_CH1 =
and MRDMODE_INTR_CH1 to be synced? I made changes to disable the syncing an=
d the fatal error from Solaris 10 disappeared. Unfortunately, I can't tell =
whether or not this actually improved the emulation of Solaris 10 as the se=
rial console is still unresponsive.

If there is a bug in the Solaris 10 driver I would expect this error to be =
more widely referenced online. I suspect that the emulated CMD646 is not pe=
rfectly faithful to the hardware and this is causing problems for Solaris 1=
0.
I am not convinced that this problem is related to IRQ routing as Solaris 1=
0 appears to recognise interrupts when they happen (or don't). Because of t=
his, I don't think this error is related  to the DMA problem under MorphOS =
but I could be wrong.

Does anyone have any ideas that might explain why Solaris 10 insists that A=
RTTIM23_INTR_CH1 is set despite two previous reads of the status register?

Thanks,
Jasper Lowell.

-----Original Message-----
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>=20
Sent: Sunday, 9 February 2020 10:26 PM
To: Lowell,J,Jasper,VIM R <jasper.lowell@bt.com>; qemu-devel@nongnu.org
Cc: atar4qemu@gmail.com
Subject: Re: Emulating Solaris 10 on SPARC64 sun4u

On 05/02/2020 06:31, jasper.lowell@bt.com wrote:

> I'm currently working towards emulating Solaris 10 on sun4u.
>=20
> =A0
>=20
> The Solaris 10 ISO image I am attempting to boot is the one from the=20
> Oracle
>=20
> download page at
> https://www.oracle.com/solaris/solaris10/downloads/solaris10-get-jsp-down=
loads.html.
>=20
> Image: sol-10-u11-ga-sparc-dvd.iso
>=20
> MD5:=A0=A0 53e8b066f7f250ce2fd2cef063f8072b
>=20
> =A0
>=20
> I am using QEMU commit 7bd9d0a9e26c7a3c67c0f174f0009ba19969b158.
>=20
> =A0
>=20
> The command I am using to run QEMU is:
>=20
> ./qemu/sparc64-softmmu/qemu-system-sparc64 -bios=20
> ./openbios/obj-sparc64/openbios-builtin.elf -cdrom=20
> ./iso/solaris/sol-10-u11-ga-sparc-dvd.iso -boot d -nographic -m 3G
>=20
> =A0
>=20
> ```
>=20
> CPUs: 1 x SUNW,UltraSPARC-IIi
>=20
> UUID: 00000000-0000-0000-0000-000000000000
>=20
> Welcome to OpenBIOS v1.1 built on Feb 5 2020 19:15
>=20
> =A0 Type 'help' for detailed information
>=20
> Trying cdrom:f...
>=20
> Not a bootable ELF image
>=20
> Not a bootable a.out image
>=20
> =A0
>=20
> Loading FCode image...
>=20
> Loaded 7420 bytes
>=20
> entry point is 0x4000
>=20
> Evaluating FCode...
>=20
> Evaluating FCode...
>=20
> Ignoring failed claim for va 1000000 memsz af6d6!
>=20
> Ignoring failed claim for va 1402000 memsz 4dcc8!
>=20
> Ignoring failed claim for va 1800000 memsz 510c8!
>=20
> SunOS Release 5.10 Version Generic_147147-26 64-bit
>=20
> Copyright (c) 1983, 2013, Oracle and/or its affiliates. All rights reserv=
ed.
>=20
> could not find debugger-vocabulary-hook>threads:interpret: exception=20
> -13 caught
>=20
> interpret \ Copyright (c) 1995-1999 by Sun Microsystems, Inc.
>=20
> \ All rights reserved.
>=20
> \
>=20
> \ ident "@(#)data64.fth=A0 1.3=A0=A0=A0=A0 00/07/17 SMI"
>=20
> =A0
>=20
> hex
>=20
> =A0
>=20
> only forth also definitions
>=20
> vocabulary kdbg-words
>=20
> also kdbg-words definitions
>=20
> =A0
>=20
> defer p@
>=20
> defer p!
>=20
> ['] x@ is p@
>=20
> ['] x! is p!
>=20
> =A0
>=20
> 8 constant ptrsize
>=20
> =A0
>=20
> d# 32 constant nbitsminor
>=20
> h# ffffffff constant maxmin
>=20
> \
>=20
> \ Copyright 2008 Sun Microsystems, Inc.=A0 All rights reserved.
>=20
> \ Use is subject to license terms.
>=20
> \
>=20
> =A0
>=20
> \ #pragma ident=A0 "@(#)kdbg.fth=A0=A0=A0 1.20=A0=A0=A0 08/06/06 SMI"
>=20
> =A0
>=20
> h# 7ff constant v9bias
>=20
> h# unix-tte:interpret: exception -13 caught
>=20
> interpret ' unix-tte is va>tte-data failed with error ffffffffffffffed
>=20
> WARNING: consconfig: cannot find driver for screen device=20
> /pci@1fe,0/pci@1,1/QEMU,VGA@2
>=20
> Configuring devices.
>=20
> WARNING: Interrupt not seen after set_features
>=20
> Using RPC Bootparams for network configuration information.
>=20
> Attempting to configure interface hme0...
>=20
> WARNING: Power off requested from power button or SC, powering down the s=
ystem!
>=20
> Skipped interface hme0
>=20
> svc:/system/filesystem/local:default: WARNING: /usr/sbin/zfs mount -a=20
> failed: one or more file systems failed to mount
>=20
> Serial console, reverting to text install
>=20
> Beginning system identification...
>=20
> Searching for configuration file(s)...
>=20
> Search complete.
>=20
> Discovering additional network configuration...
>=20
> ```
>=20
> =A0
>=20
> The installation menu is shown after but the console is unresponsive.
>=20
> =A0
>=20
> After some debugging, it looks like the QEMU front-end is correctly=20
> filling
>=20
> the serial receive buffer with characters, and then starts dropping=20
> them once
>=20
> the number of characters in the buffer reach the interrupt level. The=20
> interrupt
>=20
> level happens to be 1 when booting Solaris 10. This looks like normal=20
> behaviour
>=20
> to me.
>=20
> =A0
>=20
> I started looking at why the serial receive buffer might not be=20
> consumed and
>=20
> considered that interrupts might not be being raised correctly. I ran=20
> with
>=20
> tracing and there were no interrupts for IRQ 0x2b like there are when=20
> using
>=20
> OpenBSD. When inspecting the registers of the serial device it looks=20
> like the
>=20
> Interrupt Enable Register is set to zero.
>=20
> =A0
>=20
> If Solaris 10 was using the device is polling mode, it should be=20
> reading the RBR
>=20
> or at least the LSR. When tracing serial_ioport_read and=20
> serial_ioport_write,
>=20
> once the menu is hit, I don't see any read or writes to the serial=20
> device
>=20
> registers despite me trying to send characters and use the menu.
>=20
> =A0
>=20
> The driver Solaris 10 is using for the device appears to be=20
> similar/same as
>=20
> /usr/src/uts/sun4/io/su_driver.c in the OpenSolaris code found at=20
> https://github.com/nxmirrors/onnv.
>=20
> =A0
>=20
> ```
>=20
> asy->asy_hwtype =3D ASY16550AF;
>=20
> OUTB(FIFOR, 0x00); /* clear fifo register */
>=20
> asy->asy_trig_level =3D 0x00; /* sets the fifo Threshold to 1 */
>=20
> =A0
>=20
> /* set/Enable FIFO */
>=20
> OUTB(FIFOR, FIFO_ON | FIFODMA | FIFOTXFLSH | FIFORXFLSH |
>=20
> (asy->asy_trig_level & 0xff));
>=20
> =A0
>=20
> if ((INB(ISR) & 0xc0) =3D=3D 0xc0)
>=20
> =A0=A0=A0 asy->asy_use_fifo =3D FIFO_ON; /* QEMU REACHES HERE. */
>=20
> else {
>=20
> =A0=A0=A0 asy->asy_hwtype =3D ASY8250;
>=20
> =A0=A0=A0 OUTB(FIFOR, 0x00); /* NO FIFOs */
>=20
> =A0=A0=A0 asy->asy_trig_level =3D 0;
>=20
> }
>=20
> ```
>=20
> =A0
>=20
> From what I can tell when tracing serial_ioport_write and=20
> serial_ioport_read,
>=20
> Solaris 10 correctly identifies the serial device and successfully attach=
es it.
>=20
> In the asyattach function (OpenSolaris driver), interrupts are=20
> disabled by zeroing the
>=20
> Interrupt Enable Register. From what I'm reading in OpenSolaris source=20
> code, interrupts
>=20
> are reenabled when the device is "opened". This seems like consistent=20
> and
>=20
> correct behaviour though I'm not sure why the device is not being=20
> opened to be
>=20
> used by the serial console.
>=20
> =A0
>=20
> Is this an issue anyone else has tried to debug?
>=20
> Are there any leads that I can follow up on for why the serial console=20
> becomes unresponsive
>=20
> on Solaris 10?

It has been a while since I've looked at booting Solaris >=3D 10 but certai=
nly the messages above about set_features and the frozen console suggest th=
at something is going amiss with interrupt routing, although since Linux an=
d NetBSD were fine the last time I ran my OpenBIOS release tests then Solar=
is must be doing something different here.

Note that the serial interrupts are routed from the ebus into sabre so the =
first thing to check would be that the end-to-end routing from device to CP=
U looks correct when using Solaris.


ATB,

Mark.

