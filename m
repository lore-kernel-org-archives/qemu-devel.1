Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCD3C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 20:01:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0640A20651
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 20:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0640A20651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40499 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLvQN-0003zw-1E
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 16:01:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hLvPK-0002ni-9B
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hLvPI-0001aQ-Ur
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:00:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:39008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hLvPI-0001Zq-Oq
	for qemu-devel@nongnu.org; Wed, 01 May 2019 16:00:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hLvPH-0001rj-4y
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 20:00:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 238412E806D
	for <qemu-devel@nongnu.org>; Wed,  1 May 2019 20:00:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 May 2019 19:48:14 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1809291@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Confirmed; importance=Undecided;
	assignee=f4bug@amsat.org; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: kcwang philmd pmaydell
X-Launchpad-Bug-Reporter: k.c. Wang (kcwang)
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
	=?utf-8?q?=29?=
References: <154532874183.18487.10011391612831676105.malonedeb@gac.canonical.com>
Message-Id: <155674009432.14336.4563620623907169400.malone@gac.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 56e94b4e9ce003c197f0babababb57bdab55f8a8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1809291] Re: ARM PL181 (mmc for Security Digital
 Card) not working in Ubuntu 18.10 (CMD 2,
 3 timeout). The SDC driver worked fine in Ubuntu 18.04 and earlier versions
 but not in Ubuntu 18.10
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1809291 <1809291@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501194814.sA0rdRJK86oH2LcPDnhLtMFQSHgGk__v9HwhktAiB2g@z>

I googled some code from comment #2 and got a hit for "u32 RCA =3D (u32)0x4=
5670000; // QEMU's hard-coded RCA". Then I found kcwang's book: https://lin=
k.springer.com/content/pdf/10.1007%2F978-3-319-51517-5.pdf and read:
"I am also grateful to Springer International Publishing AG for allowing me=
 to disclose the source code of this book to the public for free, which are=
 available at http://www.eecs.wsu.edu/~cs460/ARMhome for download". This li=
nk gives 404, however googling again "site:www.eecs.wsu.edu/~cs460" I found=
 https://www.eecs.wsu.edu/~cs460/samples/ which thankfully provides sdc.tgz=
 with the source files and binaries mentioned.

With the command provided in the bug description I could bisect to:

4e5cc6756586e967993187657dfcdde4e00288d9 is the first bad commit
commit 4e5cc6756586e967993187657dfcdde4e00288d9
Author: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Date:   Thu Feb 22 15:12:54 2018 +0000

    sdcard: simplify SD_SEND_OP_COND (ACMD41)
    =

    replace switch(single case) -> if()
    =

    Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
    Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
    Message-id: 20180215221325.7611-17-f4bug@amsat.org
    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


** Changed in: qemu
       Status: Incomplete =3D> Confirmed

** Summary changed:

- ARM PL181 (mmc for Security Digital Card) not working in Ubuntu 18.10 (CM=
D 2,3 timeout).  The SDC driver worked fine in Ubuntu 18.04 and earlier ver=
sions but not in Ubuntu 18.10
+ SD Card not working in Ubuntu 18.10 (CMD 2,3 timeout).  The device worked=
 fine in Ubuntu 18.04 and earlier versions but not in Ubuntu 18.10

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1809291

Title:
  SD Card not working in Ubuntu 18.10 (CMD 2,3 timeout).  The device
  worked fine in Ubuntu 18.04 and earlier versions but not in Ubuntu
  18.10

Status in QEMU:
  Confirmed

Bug description:
  ARM PL181 MMC card no longer working in qemu-system-arm in Ubuntu 18.10
  The MMC driver code worked fine in Ubuntu 15.10 to 18.04.
  The command to run qemu-system-arm is

      qemu-system-arm -M versatilepb -m 256M -sd sdimage -kernel t.bin
  -serial mon:stdio

  During SDC initialization, SDC commands 2, 3, 9, 13, 7, 16 all timeout, =

  which cause subsequent read/write commands 17/24 to fail also.

  Tried both ARM versatilepb and realview-pb-a8, realview-pbx-a9 boards:
  all the same.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1809291/+subscriptions

