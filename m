Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F69FC04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4862320578
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 14:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4862320578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCP6W-0005nH-CN
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 10:14:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35847)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iCP3b-000369-DL
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iCP3a-0004io-2J
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:11:15 -0400
Received: from indium.canonical.com ([91.189.90.7]:50766)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iCP3Z-0004iW-TI
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 10:11:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iCP3X-0007ja-VV
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 14:11:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id ECC052E80C7
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2019 14:11:11 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Sep 2019 13:57:02 -0000
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: pmaydell robert-hu
X-Launchpad-Bug-Reporter: Robert Hu (robert-hu)
X-Launchpad-Bug-Modifier: Peter Maydell (pmaydell)
References: <20170426091517.1328.12576.malonedeb@gac.canonical.com>
Message-Id: <156924702293.4429.12415362038035121399.malone@chaenomeles.canonical.com>
Subject: =?utf-8?q?=5BBug_1686350=5D_Re=3A_=5BKVM=5D_The_qemu_=E2=80=98-cpu?=
 =?utf-8?q?=E2=80=99_option_not_have_skylake_server_cpu_model?=
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19048";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 294daa34899cc373667fd14086ba0cc395b67d4b
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
Reply-To: Bug 1686350 <1686350@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Skylake-Server cpu type was added for either QEMU 3.0 or 3.1, so
this bug is fix-released.


** Changed in: qemu
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1686350

Title:
  [KVM] The qemu =E2=80=98-cpu=E2=80=99 option not have skylake server cpu =
model

Status in QEMU:
  Fix Released

Bug description:
  Environment:
  -------------------
  KVM commit/branch: bd17117b/next
  Qemu commit/branch: cd1ea508/master
  Host OS: RHEL7.3 ia32e
  Host Kernel:4.11.0-rc3
  Bug detailed description:
  ----------------------------------
  In latest qemu commit the qemu still not have skylake server cpu model
  Reproduce steps:
  -------------------------
  [root@skl-2s2 ~]# qemu-system-x86_64 -cpu help
  Available CPUs:
  x86 486
  x86 Broadwell-noTSX Intel Core Processor (Broadwell, no TSX)
  x86 Broadwell Intel Core Processor (Broadwell)
  x86 Conroe Intel Celeron_4x0 (Conroe/Merom Class Core 2)
  x86 Haswell-noTSX Intel Core Processor (Haswell, no TSX)
  x86 Haswell Intel Core Processor (Haswell)
  x86 IvyBridge Intel Xeon E3-12xx v2 (Ivy Bridge)
  x86 Nehalem Intel Core i7 9xx (Nehalem Class Core i7)
  x86 Opteron_G1 AMD Opteron 240 (Gen 1 Class Opteron)
  x86 Opteron_G2 AMD Opteron 22xx (Gen 2 Class Opteron)
  x86 Opteron_G3 AMD Opteron 23xx (Gen 3 Class Opteron)
  x86 Opteron_G4 AMD Opteron 62xx class CPU
  x86 Opteron_G5 AMD Opteron 63xx class CPU
  x86 Penryn Intel Core 2 Duo P9xxx (Penryn Class Core 2)
  x86 SandyBridge Intel Xeon E312xx (Sandy Bridge)
  x86 Skylake-Client Intel Core Processor (Skylake)
  x86 Westmere Westmere E56xx/L56xx/X56xx (Nehalem-C)
  x86 athlon QEMU Virtual CPU version 2.5+
  x86 core2duo Intel(R) Core(TM)2 Duo CPU T7700 @ 2.40GHz
  x86 coreduo Genuine Intel(R) CPU T2600 @ 2.16GHz
  x86 kvm32 Common 32-bit KVM processor
  x86 kvm64 Common KVM processor
  x86 n270 Intel(R) Atom(TM) CPU N270 @ 1.60GHz
  x86 pentium
  x86 pentium2
  x86 pentium3
  x86 phenom AMD Phenom(tm) 9550 Quad-Core Processor
  x86 qemu32 QEMU Virtual CPU version 2.5+
  x86 qemu64 QEMU Virtual CPU version 2.5+
  x86 base base CPU model type with no features enabled
  x86 host KVM processor with all supported host features (only available i=
n KVM mode)
  x86 max Enables all features supported by the accelerator in the current =
host

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1686350/+subscriptions

