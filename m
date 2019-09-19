Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7370DC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49B7A2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 17:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49B7A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iB0Nc-0000Pp-8k
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 13:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50270)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iB073-0000Cl-Vw
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iB072-0000us-BX
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:21:01 -0400
Received: from indium.canonical.com ([91.189.90.7]:41850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iB072-0000uF-5Z
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 13:21:00 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iB06z-0002Qu-52
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 17:20:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id AF10B2E80D2
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 17:20:55 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Sep 2019 17:14:04 -0000
From: Cleber Rosa <cleber.gnu@gmail.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
 assignee=philmd@redhat.com; 
X-Launchpad-Bug-Tags: mips pflash
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: cleber-gnu philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Cleber Rosa (cleber-gnu)
References: <156110193683.18432.8339006487274258755.malonedeb@chaenomeles.canonical.com>
Message-Id: <156891324474.32435.6642214766509415320.malone@wampee.canonical.com>
Subject: [Bug 1833661] Re: Linux kernel oops on Malta board while accessing
 pflash
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: a16eb0b7a4ebf9296cc0170be6ec47a767a651ed
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1833661 <1833661@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When running
tests/acceptance/linux_ssh_mips_malta.py:LinuxSSH.test_mips_malta64el_kerne=
l3_2_0,
I'm getting in roughly 8% of executions:

2019-09-18 22:37:43,665 linux_ssh_mips_m L0065 DEBUG| Intel/Sharp Extended =
Query Table at 0x0031
2019-09-18 22:37:43,668 linux_ssh_mips_m L0065 DEBUG| Using buffer write me=
thod
2019-09-18 22:37:45,722 linux_ssh_mips_m L0065 DEBUG| Searching for RedBoot=
 partition table in physmap-flash.0 at offset 0x1003f0000
2019-09-18 22:37:46,287 linux_ssh_mips_m L0065 DEBUG| ESC[?25lESC[?1cESC7Cr=
eating 3 MTD partitions on "physmap-flash.0":
2019-09-18 22:37:46,287 linux_ssh_mips_m L0065 DEBUG| 0x000000000000-0x0000=
00100000 : "YAMON"
2019-09-18 22:37:46,314 linux_ssh_mips_m L0065 DEBUG| 0x000000100000-0x0000=
003e0000 : "User FS"
2019-09-18 22:37:46,319 linux_ssh_mips_m L0065 DEBUG| 0x0000003e0000-0x0000=
00400000 : "Board Config"
2019-09-18 22:37:47,260 linux_ssh_mips_m L0065 DEBUG| ESC[1G[ESC[32m ok ESC=
[39;49mCPU 0 Unable to handle kernel paging request at virtual address =

0000000000000028, epc =3D=3D ffffffffc00ed234, ra =3D=3D ffffffffc00ed210
2019-09-18 22:37:47,262 linux_ssh_mips_m L0065 DEBUG| Oops[#1]:


And when running tests/acceptance/linux_ssh_mips_malta.py:LinuxSSH.test_mip=
s_malta32eb_kernel3_2_0:

2019-09-19 00:02:47,151 linux_ssh_mips_m L0065 DEBUG| Searching for RedBoot=
 partition table in physmap-flash.0 at offset 0x3f0000
2019-09-19 00:02:47,154 linux_ssh_mips_m L0065 DEBUG| No RedBoot partition =
table detected in physmap-flash.0
2019-09-19 00:02:47,847 linux_ssh_mips_m L0065 DEBUG| Creating 3 MTD partit=
ions on "physmap-flash.0":
2019-09-19 00:02:47,850 linux_ssh_mips_m L0065 DEBUG| 0x000000000000-0x0000=
00100000 : "YAMON"
2019-09-19 00:02:47,875 linux_ssh_mips_m L0065 DEBUG| 0x000000100000-0x0000=
003e0000 : "User FS"
2019-09-19 00:02:47,875 linux_ssh_mips_m L0065 DEBUG| 0x0000003e0000-0x0000=
00400000 : "Board Config"
2019-09-19 00:02:48,792 linux_ssh_mips_m L0065 DEBUG| ESC[?25lESC[?1cESC7CP=
U 0 Unable to handle kernel paging request at virtual address 00000014,
 epc =3D=3D c0205278, ra =3D=3D c0205254
2019-09-19 00:02:48,794 linux_ssh_mips_m L0065 DEBUG| Oops[#1]:

** Changed in: qemu
       Status: New =3D> Confirmed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1833661

Title:
  Linux kernel oops on Malta board while accessing pflash

Status in QEMU:
  Confirmed

Bug description:
  commit 33d609990621dea6c7d056c86f707b8811320ac1

  While running tests/acceptance/linux_ssh_mips_malta.py, the big-endian
  tests fail:

    physmap-flash.0: Found 1 x32 devices at 0x0 in 32-bit bank. Manufacture=
r ID 0x000000 Chip ID 0x000000
    Intel/Sharp Extended Query Table at 0x0031
    Using buffer write method
    Searching for RedBoot partition table in physmap-flash.0 at offset 0x10=
03f0000
    Creating 3 MTD partitions on "physmap-flash.0":
    0x000000000000-0x000000100000 : "YAMON"
    0x000000100000-0x0000003e0000 : "User FS"
    0x0000003e0000-0x000000400000 : "Board Config"
    CPU 0 Unable to handle kernel paging request at virtual address 00000014

  The 64-bit test fails with:

    CPU 0 Unable to handle kernel paging request at virtual address
  0000000000000028

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1833661/+subscriptions

