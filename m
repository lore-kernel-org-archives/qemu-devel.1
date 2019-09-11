Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F287C49ED6
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 17:27:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB332084F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 17:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=angelcompanygroup.onmicrosoft.com header.i=@angelcompanygroup.onmicrosoft.com header.b="ITVxKlQf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB332084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angelcompany.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54142 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i86P7-0004Yh-8r
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 13:27:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33210)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vincenzo.muolo@angelcompany.com>) id 1i850q-0000WU-7L
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:58:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vincenzo.muolo@angelcompany.com>) id 1i850l-0006ke-Rx
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:58:32 -0400
Received: from mail-ve1eur03on0623.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::623]:44870
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vincenzo.muolo@angelcompany.com>)
 id 1i850c-0006do-De; Wed, 11 Sep 2019 11:58:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfOG3BYVBfRo86WjHI+kbrjydCRKvSE5yPi6HeCtiaxozza2zlRWbSaetlISRHvojQnZtS4Y2n6vtwyozt6Ee2xztCGstyf+UjfjETR3spE/do3zRN6B8pIBG3XGbHaOeeM4qYo+Mjlqo9HFsdnwknHmIRQGe/x6pESk5U8X7QzUTLWenzsIGOQz8SYL/rf62M1e9zmSbQl1njlbvXV02DZ0Mly1g8m2wEOfnB8qmKTbdh+tsZ75EEP3XXOOv8j32iqKBpZ+vWWczZn0B1wc14FP/w/VJqkQmkMcCoaPtSkSN+tdOYlFCh68NXb0NCIbfwNX8kvNzm4KJOjnyRVDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQLeF8B4zSlUyz3EYx0AhtETesLsRmNk1sbUoh0UGFo=;
 b=TnIHX/64hguMdgNPGalPWkUoIAV9fyB7zrqNl0fYBOBd/GPTPSoUZBSFlWB54laW9kylDBxSJiUfqEMzHblBPnaS09PNh1BTgLA2HSKPHmMGeIfNvnZdmpmWedV4ZMnMEfMzocIzVlfaMD/G0KmSmo1iLscKrk0+dL2BnjRpe3dVGWyUlDSCr+gwEA6+xmSKy9TNvjcr9O4BP1TYfzzV4m9NdBzaatcyCqcVzdDkAa+A225U8gTRq3FmdjdPTCOHDQxp8m51FJ5jPNCbI7V+ycuWLgZKvs6rgc6le1yP6M3ZLNDjtpx7xbKlLPJQaI4UeGKxIL57wf53JFWLj7D4UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=angelcompany.com; dmarc=pass action=none
 header.from=angelcompany.com; dkim=pass header.d=angelcompany.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=angelcompanygroup.onmicrosoft.com;
 s=selector1-angelcompanygroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OQLeF8B4zSlUyz3EYx0AhtETesLsRmNk1sbUoh0UGFo=;
 b=ITVxKlQfZ1YLKOBbklkk/TLe/OY0STaF1uqbWCuSXNL9WZBy4nTuUWWaZNAi+lMt0UZpsH8PecCqYiA4vZpZY8vD9UK/W1lnzUzyzbdlcpe18bbjf7mbW1yhSWDf5Oi+kFCMjlViVLTGyOvwQA2IzcQmaSaFIDeJUdB0eeXwUrM=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB3647.eurprd08.prod.outlook.com (20.177.61.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2199.21; Wed, 11 Sep 2019 15:58:14 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::5542:8398:f1bd:f8c7%6]) with mapi id 15.20.2199.027; Wed, 11 Sep 2019
 15:58:14 +0000
From: "Muolo Vincenzo (S.I.)" <vincenzo.muolo@angelcompany.com>
To: "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Thread-Topic: issue related to boot aix 7.1 when I try to use qemu ppc64  
Thread-Index: AdVouUhNGC1ZBUZSS1GZyGskmH5Zbw==
Date: Wed, 11 Sep 2019 15:58:14 +0000
Message-ID: <VI1PR08MB439957EF8E072A9A2A96B58DE5B10@VI1PR08MB4399.eurprd08.prod.outlook.com>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vincenzo.muolo@angelcompany.com; 
x-originating-ip: [93.63.158.101]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 561b87c9-9040-4f27-2bdb-08d736d0dac5
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3647; 
x-ms-traffictypediagnostic: VI1PR08MB3647:
x-microsoft-antispam-prvs: <VI1PR08MB36471F2718E41383DA991579E5B10@VI1PR08MB3647.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0157DEB61B
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39840400004)(136003)(396003)(366004)(189003)(199004)(54164003)(71190400001)(14454004)(71200400001)(66476007)(64756008)(66946007)(66446008)(66556008)(76116006)(478600001)(33656002)(52536014)(316002)(86362001)(15188155005)(8676002)(8936002)(2906002)(54906003)(81166006)(81156014)(2351001)(7736002)(2501003)(1730700003)(16799955002)(256004)(790700001)(6116002)(3846002)(19627235002)(66066001)(5660300002)(74316002)(6506007)(966005)(6916009)(6306002)(102836004)(26005)(486006)(7696005)(55016002)(186003)(9686003)(5640700003)(54896002)(25786009)(99286004)(476003)(6436002)(53936002)(4326008)(460985005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:VI1PR08MB3647;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: angelcompany.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: O2BpDgmpE6KsBDFzo5JEgVCtP//cQN1dpMnvvSLJ1BhWv7WhQeWOONLVCAALhxxgvdqY0QXRsDaGCVp1I+WP1zyefpUQA/FzF83NhxzrkfSOJhchByPXnw1UL/K1PXLATJfFkOgIQPfIPtW6wq6j4c4xwBKY/fqlxYBIpH8U34aIQgk6vTBlwMUcPMdEQLTuiTyC8e3IRwFOWNfS429Jq2rLWeBigTL1bDfsYdMkueHXCrLwcCoAOtb2Xuxe2A/vYhk920Rt3gabFZ4ovnCEXSoo7ockocSMyIqI2x5SS43bTeCxNv8Pv05Zz14aPBPeHPM7ubpQE5oLG0CcTCTItA6kB7yOG0gc7aprIN5/SPs22O+75Ke4TG7j+LVJpDsMdRWULh9DlH4lFY6ZHKfDkwe97wyGVL8fG2gS4qAnSq8=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: angelcompany.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 561b87c9-9040-4f27-2bdb-08d736d0dac5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2019 15:58:14.6737 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c187ee01-4e4e-40c8-b342-f82c8d699421
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbh/M+x/oUfs3ec6EUJBjzl8cdqs/Cu3Z2aQ+FZ9rhT3BNK0H1VzoiSIDuDGULfMQ9SS0Ixr6yvM72H6nEfWJfl5qVmga1DNPLjASQt+UAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3647
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe09::623
X-Mailman-Approved-At: Wed, 11 Sep 2019 13:26:22 -0400
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: [Qemu-devel] issue related to boot aix 7.1 when I try to use qemu
 ppc64
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

Hi to all

I try to use ( into VM debian 10  running into VMWARE virtualization enviro=
nment ) qemu ppc64  version to simulate an AIX 7.1 TL04  OS


root@vkvm-acmm:/AIX# qemu-system-ppc64  -version
QEMU emulator version 3.1.0 (Debian 1:3.1+dfsg-8+deb10u2)
Copyright (c) 2003-2018 Fabrice Bellard and the QEMU Project developers


I run the following commands into my linux DEB but after few time i have to=
 following issue ( trap  interrupt kernel see to end .. ):

qemu-system-ppc64 -cpu POWER8 -machine pseries -m 4096 -serial stdio -drive=
 file=3Ddisk.img,if=3Dnone,id=3Ddrive-virtio-disk0 -device virtio-scsi-pci,=
id=3Dscsi -device scsi-hd,drive=3Ddrive-virtio-disk0 -cdrom aix.iso -prom-e=
nv "boot-command=3Ddev / 0 0 s\" ibm,aix-diagnostics\" property boot cdrom:=
\ppc\chrp\bootfile.exe -s verbose" -net nic -net tap -display vnc=3D:1
W: /etc/qemu-ifup: no bridge for guest interface found


SLOF **********************************************************************
QEMU Starting
Build Date =3D Dec 28 2018 13:55:34
FW Version =3D buildd@ release 20180702
Press "s" to enter Open Firmware.

Populating /vdevice methods
Populating /vdevice/vty@71000000
Populating /vdevice/nvram@71000001
Populating /vdevice/l-lan@71000002
Populating /vdevice/v-scsi@71000003
       SCSI: Looking for devices
          8200000000000000 CD-ROM   : "QEMU     QEMU CD-ROM      2.5+"
Populating /pci@800000020000000
                     00 0000 (D) : 1234 1111    qemu vga
                     00 0800 (D) : 1033 0194    serial bus [ usb-xhci ]
                     00 1000 (D) : 1af4 1004    virtio [ scsi ]
Populating /pci@800000020000000/scsi@2
       SCSI: Looking for devices
          100000000000000 DISK     : "QEMU     QEMU HARDDISK    2.5+"
Installing QEMU fb



Scanning USB
  XHCI: Initializing
    USB Keyboard
    USB mouse
No console specified using screen & keyboard

  Welcome to Open Firmware

  Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
  This program and the accompanying materials are made available
  under the terms of the BSD License available at
  http://www.opensource.org/licenses/bsd-license.php


Trying to load: -s verbose from: /vdevice/v-scsi@71000003/disk@820000000000=
0000:\ppc\chrp\bootfile.exe ...   Successfully loaded
AIX
StarLED{814}

AIX Version 7.1
exec(/etc/init){1,0}

INIT: EXECUTING /sbin/rc.boot 1
exec(/usr/bin/sh,-c,/sbin/rc.boot 1){1179684,1}
exec(/sbin/rc.boot,/sbin/rc.boot,1){1179684,1}
+ PHASE=3D1
+ + bootinfo -p
exec(/usr/sbin/bootinfo,-p){1245222,1179684}
PLATFORM=3Dchrp
+ [ ! -x /usr/lib/boot/bin/bootinfo_chrp ]
+ [ 1 -eq 1 ]
+ 1> /usr/lib/libc.a
+ init -c unlink /usr/lib/boot/bin/!(*_chrp)
exec(/etc/init,-c,unlink /usr/lib/boot/bin/!(*_chrp)){1245224,1179684}
+ chramfs -t
exec(/usr/sbin/chramfs,-t){1245226,1179684}
+ init -c unlink /usr/sbin/chramfs
+ 1> /dev/null
exec(/etc/init,-c,unlink /usr/sbin/chramfs){1245228,1179684}
+ + bootinfo -t
exec(/usr/sbin/bootinfo,-t){1245230,1179684}
BOOTYPE=3D3
+ [ 0 -ne 0 ]
+ [ -z 3 ]
+ unset pdev_to_ldev undolt native_netboot_cfg
+ unset disknet_odm_init config_ATM
+ /usr/lib/methods/showled 0x510 DEV CFG 1 START
exec(/usr/lib/methods/showled,0x510,DEV CFG 1 START){1245232,1179684}
+ cfgmgr -f -v
exec(/usr/sbin/cfgmgr,-f,-v){1245234,1179684}
cfgmgr is running in phase 1
----------------
Time: 0 LEDS: 0x538
Invoking top level program -- "/etc/methods/defsys"
exec(/bin/sh,-c,/etc/methods/defsys ){1310760,1245234}
exec(/etc/methods/defsys){1310760,1245234}
exec(/bin/sh,-c,/usr/lib/methods/define_rspc -n -c sys -s node -t chrp){137=
6298,1310760}
exec(/usr/lib/methods/define_rspc,-n,-c,sys,-s,node,-t,chrp){1376298,131076=
0}
Time: 0 LEDS: 0x539
Return code =3D 0
***** stdout *****
sys0

***** stderr *****
MS 1376298 1310760 /usr/lib/methods/define_rspc -n -c sys -s node -t chrp
M4 1376298 Defining device: uniquetype=3Dsys/node/chrp parent=3D connection=
=3D
M4 1376298 ..define_dvc()
M4 1376298 ..generate_name()
M4 1376298 Generated name: sys0
M4 1376298 ..create_cudv()
M4 1376298 Adding new CuDv
M4 1376298 Defined device sys0

----------------
Attempting to configure device 'sys0'
Time: 0 LEDS: 0x811
Invoking /usr/lib/methods/cfgsys_chrp -1 -l sys0
exec(/bin/sh,-c,/usr/lib/methods/cfgsys_chrp -1 -l sys0){1310762,1245234}
Number of running methods: 1
exec(/usr/lib/methods/cfgsys_chrp,-1,-l,sys0){1310762,1245234}
LED{A20}
Illegal Trap Instruction Interrupt in Kernel
05911ACC            tweqi    r0,0                r0=3D0
KDB(0)>

So how can I to proceed ? I must to try to use an different  kernel AIX ( 7=
.2 ? ) or it's possibile to fix this one ?

I'll  available to take a dump and so on ....

Awaiting an feedback

Thanks to all

Vincenzo

