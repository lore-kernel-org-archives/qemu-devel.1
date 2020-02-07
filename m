Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B79FDC2D0B1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 05:44:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 815B6222C2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 05:44:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bt.com header.i=@bt.com header.b="qOosGtFB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 815B6222C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izwRH-0005nO-Oy
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 00:44:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasper.lowell@bt.com>) id 1izwQh-0005MS-2z
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 00:43:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasper.lowell@bt.com>) id 1izwQf-0003Kr-9B
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 00:43:50 -0500
Received: from smtpe1.intersmtp.com ([62.239.224.234]:8404)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasper.lowell@bt.com>)
 id 1izwQe-0003Gs-Kj
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 00:43:49 -0500
Received: from tpw09926dag05e.domain1.systemhost.net (10.9.202.20) by
 RDW083A012ED68.bt.com (10.187.98.38) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Fri, 7 Feb 2020 05:41:23 +0000
Received: from tpw09926dag12f.domain1.systemhost.net (10.9.212.20) by
 tpw09926dag05e.domain1.systemhost.net (10.9.202.20) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4; Fri, 7 Feb 2020 05:43:44 +0000
Received: from RDW083A011ED67.bt.com (10.187.98.37) by
 tpw09926dag12f.domain1.systemhost.net (10.9.212.20) with Microsoft SMTP
 Server (TLS) id 15.0.1395.4 via Frontend Transport; Fri, 7 Feb 2020 05:43:44
 +0000
Received: from GBR01-CWL-obe.outbound.protection.outlook.com (104.47.20.56) by
 smtpe1.intersmtp.com (62.239.224.235) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Fri, 7 Feb 2020 05:52:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eh7cvDrqNfnvu9upJfRH/z+Qfgp2Kcq3JK76BmhdH2NBrBpaaBvPpb9ipwPB3a+whJOo4sf1tK/8yj5tsblr+tnIb2VGVypTIS6CSqw9H5gMNPB91qx4CklIbYidCPHnuNlGP6o5+yE3vrdCRLX+0s6RZIL4NkQgCj+H3CeoM6sH8lmcnOjT5uT7c4d80bwLJ5SZcvOpT/2PIXIrLpJGI5Dfbjc50l5w3rtDaAtkWYnZHrlzUdc0kxZ9I2YbO2v+e2sXo3PLKCo8Hsi4BPlf9TV1iCbtVScoZzMMfLgCzS8egSdjIojk2wjRanzzWPRIJK/BXUr9Ch9EGPOOlIa1TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rOlIWgrB+pMEjKqmK0Lev1taOpW6mMKF6Ah7+yBdi8=;
 b=GsElcV3ao8kI2p1Iqj+E7ZWiPRO9i1QUwQTANbLFV/cBxvnt0iTZYAsytYa8nNWK1YDgEXYw36pgFD1ugx0y75J+gqHm26uHN4GY64MVeV/4+8xh4faRSy2yARb27L7kCthAJd+G1o+ePP04/U65pNDTBVeTZfvJxuMEqVxgTtSq5kqQE84FZdK2QTJtWiN5otQwG1jeAsHD547TwNY6QIapd4etigtheP4et4yLGj5Nrp7n0pm12kP04kRfHvFNhziPgklPQ8AoWa8+osIY5Sx5mguwua1ut/AnMiSOFHYUDz/q9ywRtfE88nDNZBKPEi4hHwBV3BY3he0pMnjcZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bt.com; dmarc=pass action=none header.from=bt.com; dkim=pass
 header.d=bt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bt.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rOlIWgrB+pMEjKqmK0Lev1taOpW6mMKF6Ah7+yBdi8=;
 b=qOosGtFBC1zy39TIfioSzG1LOfnLVZg3x/k/IPw0vLia5wdvXzRM0aanrIOnEXij64DN88w2TDVQt+wm6Cd79TPddnE6+fRjCAHGdMnUR9OY4XYOyfQLBoGxDGGI4on2cbAx+ahENW5PYAhF6zVKqHUsE2zDPHGiZhoN5PAiWlk=
Received: from LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM (20.176.154.209) by
 LO2P123MB1726.GBRP123.PROD.OUTLOOK.COM (20.176.157.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Fri, 7 Feb 2020 05:43:43 +0000
Received: from LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM
 ([fe80::41c0:c971:96e3:abf0]) by LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM
 ([fe80::41c0:c971:96e3:abf0%5]) with mapi id 15.20.2707.023; Fri, 7 Feb 2020
 05:43:43 +0000
From: <jasper.lowell@bt.com>
To: <dgilbert@redhat.com>
Subject: RE: Emulating Solaris 10 on SPARC64 sun4u
Thread-Topic: Emulating Solaris 10 on SPARC64 sun4u
Thread-Index: AdXb7aKPCyPc5BgLRMag+zXZgy3FKQAXLygAAEt1BYA=
Date: Fri, 7 Feb 2020 05:43:42 +0000
Message-ID: <LO2P123MB22710F9D590E023381119FAB831C0@LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM>
References: <CWXP123MB2262B6F3159B7AA7AB010F4183020@CWXP123MB2262.GBRP123.PROD.OUTLOOK.COM>
 <20200205173326.GA3256@work-vm>
In-Reply-To: <20200205173326.GA3256@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=jasper.lowell@bt.com; 
x-originating-ip: [61.68.11.94]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fde4133b-c5ea-4d16-76f4-08d7ab90b158
x-ms-traffictypediagnostic: LO2P123MB1726:
x-microsoft-antispam-prvs: <LO2P123MB172611364FABA4F6A66FF215831C0@LO2P123MB1726.GBRP123.PROD.OUTLOOK.COM>
x-antispam-2: 1
x-ms-oob-tlc-oobclassifiers: OLM:2331;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(199004)(189003)(2906002)(9686003)(55016002)(66446008)(64756008)(66556008)(66476007)(66946007)(5660300002)(316002)(52536014)(478600001)(71200400001)(966005)(8936002)(33656002)(186003)(26005)(8676002)(53546011)(6506007)(81156014)(81166006)(76116006)(4326008)(6916009)(7696005)(54906003)(86362001)(32563001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:LO2P123MB1726;
 H:LO2P123MB2271.GBRP123.PROD.OUTLOOK.COM; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bt.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jk7Zc1SUmC9l7H9n1w3UNUdrwB9xnneE15tIfUfzMWOqE4QkT+X4hh8h2wJFk+ipRCKOmDvxnZfxn4gPW3z85lxKvnb3q6Ej17gbZ/1w7SVG7R9ffKbLVj1C+JGQEP5Y3qYSrm2xtfTUT8lfjMkOU7qNHmNpnEV9KBC9EW2YevFbrrD4U40/gO3e68OrQAGIyL4dTCGXiHdRCqJa6KToqc/8+6/MEG4pNTLLssg7Gw5qiGcB5CABiX5ZhukJPHnenMi19/kDBuFlz0MyU05Q+L8hbTDfpembEBkRt+WAzKMK31G0HRTGtG212GoA62K9quMxojai/+lDQMK+2Hejyf38KUlDgnsy8L4fQnm5FEUqPERWG18JkjICu0XrcKxR+w31gJlIspXzAN+B+NgNlcWFcfCQBY5CL+OYYVfUA+VjgOAba7EhVioNOxsINIl/F0Fm0UuoelQFaGH93ZIspe3hXLP2RRt4YCWXGe7ntfF3maZwvq9/7SNw7+azM7WcXbRKcXsgpD2X26gCYA6bSqRN3kN//mvbMFDvyeIb8QKtovO4yBzkGnTkJ6Ph09je
x-ms-exchange-antispam-messagedata: YYG+Cho66iaiQ5Sqy02qsyYpLq6frfOZEGPU55r/VvnGFsl74GNksimdf9gIlTSIYobPYXoEZX0PPeuX/AxcgYYPkZcteLo8mM1LUjt/ZkU7FXI3LOTR5DzV0lEj4/eocrQmSFxOGaiy848/ovydSQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fde4133b-c5ea-4d16-76f4-08d7ab90b158
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 05:43:43.2111 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7f35688-9c00-4d5e-ba41-29f146377ab0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8gK9deGXH2ManxPzbjWjqRP9dm13fSuBLwmnI+n6uGqNzgMeLusvpDSJqIKm0ymJZNhWYTn5t5QgIO/eHMiTng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P123MB1726
X-OriginatorOrg: bt.com
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 62.239.224.234
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
Cc: mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org, atar4qemu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I haven't figured out where that is coming from.
The error doesn't look like it's in the OpenSolaris source code so I don't =
have any context behind it.
The error does show up here: https://docs.oracle.com/cd/E23824_01/html/821-=
1475/uata-7d.html so it might be related to the IDE controller.
The behaviour of Solaris 10 does make me think there is a problem with inte=
rrupts but OpenBSD works just fine on this architecture.

I've also tried using kmdb (Solaris kernel debugger) by running using `boot=
 cdrom -kvd` at the OpenBIOS prompt.
I thought this might help diagnose the problem.
After the kernel debugger prompt occurs and I type `::cont` to continue, th=
e system hangs completely.

Thanks,
Lowell.

-----Original Message-----
From: Dr. David Alan Gilbert <dgilbert@redhat.com>=20
Sent: Thursday, 6 February 2020 4:33 AM
To: Lowell,J,Jasper,VIM R <jasper.lowell@bt.com>
Cc: qemu-devel@nongnu.org; mark.cave-ayland@ilande.co.uk; atar4qemu@gmail.c=
om
Subject: Re: Emulating Solaris 10 on SPARC64 sun4u

* jasper.lowell@bt.com (jasper.lowell@bt.com) wrote:
> I'm currently working towards emulating Solaris 10 on sun4u.
>=20
> The Solaris 10 ISO image I am attempting to boot is the one from the=20
> Oracle download page at https://www.oracle.com/solaris/solaris10/download=
s/solaris10-get-jsp-downloads.html.
> Image: sol-10-u11-ga-sparc-dvd.iso
> MD5:   53e8b066f7f250ce2fd2cef063f8072b
>=20
> I am using QEMU commit 7bd9d0a9e26c7a3c67c0f174f0009ba19969b158.
>=20
> The command I am using to run QEMU is:
> ./qemu/sparc64-softmmu/qemu-system-sparc64 -bios=20
> ./openbios/obj-sparc64/openbios-builtin.elf -cdrom=20
> ./iso/solaris/sol-10-u11-ga-sparc-dvd.iso -boot d -nographic -m 3G
>=20
> ```
> CPUs: 1 x SUNW,UltraSPARC-IIi
> UUID: 00000000-0000-0000-0000-000000000000
> Welcome to OpenBIOS v1.1 built on Feb 5 2020 19:15
>   Type 'help' for detailed information Trying cdrom:f...
> Not a bootable ELF image
> Not a bootable a.out image
>=20
> Loading FCode image...
> Loaded 7420 bytes
> entry point is 0x4000
> Evaluating FCode...
> Evaluating FCode...
> Ignoring failed claim for va 1000000 memsz af6d6!
> Ignoring failed claim for va 1402000 memsz 4dcc8!
> Ignoring failed claim for va 1800000 memsz 510c8!
> SunOS Release 5.10 Version Generic_147147-26 64-bit Copyright (c)=20
> 1983, 2013, Oracle and/or its affiliates. All rights reserved.
> could not find debugger-vocabulary-hook>threads:interpret: exception=20
> -13 caught interpret \ Copyright (c) 1995-1999 by Sun Microsystems, Inc.
> \ All rights reserved.
> \
> \ ident "@(#)data64.fth  1.3     00/07/17 SMI"
>=20
> hex
>=20
> only forth also definitions
> vocabulary kdbg-words
> also kdbg-words definitions
>=20
> defer p@
> defer p!
> ['] x@ is p@
> ['] x! is p!
>=20
> 8 constant ptrsize
>=20
> d# 32 constant nbitsminor
> h# ffffffff constant maxmin
> \
> \ Copyright 2008 Sun Microsystems, Inc.  All rights reserved.
> \ Use is subject to license terms.
> \
>=20
> \ #pragma ident  "@(#)kdbg.fth    1.20    08/06/06 SMI"
>=20
> h# 7ff constant v9bias
> h# unix-tte:interpret: exception -13 caught interpret ' unix-tte is=20
> va>tte-data failed with error ffffffffffffffed
> WARNING: consconfig: cannot find driver for screen device=20
> /pci@1fe,0/pci@1,1/QEMU,VGA@2 Configuring devices.
> WARNING: Interrupt not seen after set_features

GIven that your problem below is looking like an interrupt related problem,=
 have you figured out where that's coming from?

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


