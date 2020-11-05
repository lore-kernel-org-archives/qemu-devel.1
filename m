Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7326C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C42A920729
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 12:12:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C42A920729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kae8H-0004Tt-Je
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 07:12:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kae76-0003Lj-Ia
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:11:36 -0500
Received: from indium.canonical.com ([91.189.90.7]:51086)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kae73-0006mo-JQ
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 07:11:36 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kae70-00076j-ML
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 12:11:30 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 6EA6C2E8030
 for <qemu-devel@nongnu.org>; Thu,  5 Nov 2020 12:11:30 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2020 12:02:58 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1781463@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=Davidof130@gmail.com; 
X-Launchpad-Bug-Tags: abs amiko emulation firmware qemu receiver
 satelitereceiver stb
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd screamfox th-huth
X-Launchpad-Bug-Reporter: David Martins (screamfox)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
References: <153142289132.32266.13097437819271021346.malonedeb@wampee.canonical.com>
Message-Id: <160457777841.28706.6993772495009554856.malone@chaenomeles.canonical.com>
Subject: [Bug 1781463] Re: qemu don't start *.abs firmware files
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 07a7fe159b95cb3e261a67adb82d421e868e2b26
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 04:11:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1781463 <1781463@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Comment #1 from Thomas is correct, this MIPS machine is not modelled.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1781463

Title:
  qemu don't start *.abs firmware files

Status in QEMU:
  Invalid

Bug description:
  Hello Devs,

  I'm here to report this bug/issue because i'm using Win64 Qemu but i
  can't start a *.abs firmware at normally this firmware is based in
  Linux Kernel and this type of firmware is made for STB Receivers,

  So this is all information i provide to get support.

  Files extracted by ( binwalk -e )

  =

  Terminal output:

  # binwalk -e AMIKO_HD8150_2.4.43_emu.abs

  DECIMAL       HEXADECIMAL     DESCRIPTION

  -------------------------------------------------------------------------=
-------
  196736        0x30080         LZMA compressed data, properties: 0x6C, dic=
tionary size: 8388608 bytes, uncompressed size: 11883876 bytes
  3866752       0x3B0080        LZMA compressed data, properties: 0x6C, dic=
tionary size: 8388608 bytes, uncompressed size: 3255512 bytes
  5636224       0x560080        LZMA compressed data, properties: 0x6C, dic=
tionary size: 8388608 bytes, uncompressed size: 87904 bytes

  =

  Files extracted with ALI TOOLS or Ali FirmwareDecriptor.

  Windows files output:

  Software used: Ali Main Code Decrypter 8.9

  Files unpacked:

  bootloader
  MemCfg
  maincode(AV)
  seecode
  default_lang
  cipluskey
  countryband
  logo_user
  logo_menu
  logo_radio
  logo_boot
  patch
  defaultdb(PRC)
  userdb(64+64)

  =

  Terminal OUTPUT:

  # hexdump -C

  part of file

  =

  00b51a30  00 00 00 00 4c 69 62 63  6f 72 65 20 76 65 72 73  |....Libcore =
vers|
  00b51a40  69 6f 6e 20 31 33 2e 31  36 2e 30 40 53 44 4b 34  |ion 13.16.0@=
SDK4|
  00b51a50  2e 30 66 61 2e 31 33 2e  31 36 5f 32 30 31 36 31  |.0fa.13.16_2=
0161|
  00b51a60  30 31 39 28 67 63 63 20  76 65 72 73 69 6f 6e 20  |019(gcc vers=
ion |
  00b51a70  33 2e 34 2e 34 20 6d 69  70 73 73 64 65 2d 36 2e  |3.4.4 mipssd=
e-6.|
  00b51a80  30 36 2e 30 31 2d 32 30  30 37 30 34 32 30 29 28  |06.01-200704=
20)(|
  00b51a90  41 64 6d 69 6e 69 73 74  72 61 74 6f 72 40 20 46  |Administrato=
r@ F|
  00b51aa0  72 69 2c 20 4a 75 6c 20  32 38 2c 20 32 30 31 37  |ri, Jul 28, =
2017|
  00b51ab0  20 31 32 3a 35 33 3a 32  38 20 41 4d 29 0a 00 00  | 12:53:28 AM=
)...|
  00b51ac0  44 4d 58 5f 53 33 36 30  31 5f 30 00 00 a1 03 18  |DMX_S3601_0.=
....|

  =

  When I use readelf it says files isn't an ELF file, so i can't run it lik=
e a kernel (Bootloader,Maincode, and etc. )

  so this is the cmd output when i use qemu Win64 (I don't whant to use
  linux to do the emulation about this *.abs extension firmware so
  please help me for win64 version from Qemu)

  CMD OUTPUT:

   C:\Program Files\qemu>qemu-system-mips.exe -machine mips -cpu
  mips32r6-generic -drive
  file=3DC:\30080.bin,index=3D0,media=3Ddisk,format=3Draw

  qemu-system-mips.exe: warning: could not load MIPS bios
  'mips_bios.bin'

  I also tried a lot of diferents qemu-system... and a lot of diferent
  configs like -machine -cpu -kernel -driver root=3D -PFLASH and etc...
  and nothing hapenned

  How can i reproduce this issue ? =

  Reply:. =


  Donwload *.abs firmware in amikoreceiver.com (only *.abs) and download
  AliDekompressor in http://www.satedu.cba.pl/

  Direct tools:

  FirmwareDecrypter_v8.9.zip :

  http://www.satedu.cba.pl/index.php?action=3Ddownloadfile&filename=3DFirmw=
areDecrypter_v8.9.zip&directory=3DTest%20Folder&

  Ali__tools_Console_v4.0__CRC_FIXER.rar :

  http://www.satedu.cba.pl/index.php?action=3Ddownloadfile&filename=3DAli__=
tools_Console_v4.0__CRC_FIXER.rar&directory=3DTest%20Folder&

  =

  so if Qemu can explain how can i fix this issue this can be highly helpfu=
ll.

  With my best regards,
  David Martins =

  Screamfox

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1781463/+subscriptions

