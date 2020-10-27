Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7EFC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 21:42:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10FE2206DB
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 21:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10FE2206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52418 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXWjs-00016B-VP
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 17:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kXWiA-0000B2-SS
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 17:40:58 -0400
Received: from indium.canonical.com ([91.189.90.7]:43024)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kXWi8-0006n7-LR
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 17:40:58 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kXWi5-0005Uv-Bt
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 21:40:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 514AC2E8030
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 21:40:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2020 21:30:39 -0000
From: Alistair Francis <1898883@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Invalid; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: alistair2323 azuk bmeng-cn rth
X-Launchpad-Bug-Reporter: Azuk 443 (azuk)
X-Launchpad-Bug-Modifier: Alistair Francis (alistair2323)
References: <160208094339.8985.13177411264868514958.malonedeb@wampee.canonical.com>
Message-Id: <160383423995.15500.3356063756276601276.malone@wampee.canonical.com>
Subject: [Bug 1898883] Re: qemu-system-riscv64 failed to load binary kernel
 into memory
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="96ff31b88b65a0d0ea73b89333fe7c4a2669d8fb"; Instance="production"
X-Launchpad-Hash: d9177695015805e896d67d62313889f4ba42283c
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 17:40:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_HI=-5,
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
Reply-To: Bug 1898883 <1898883@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Just an update on this.

You can use -bios to load your image, which will load it to address
0x80000000.

In QEMU 5.1 `-bios none -kernel Image` will load the Image to
0x80020000/0x80040000 depending on XLEN.

QEMU 5.2 will now correctly load the above mentioned Image to address
0x80000000 if you don't load a firmware (`-bios none`).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1898883

Title:
  qemu-system-riscv64 failed to load binary kernel into memory

Status in QEMU:
  Invalid

Bug description:
  QEMU Version: 5.1.0
  Compiled in Ubuntu 20.04 for riscv64, following the guide https://risc-v-=
getting-started-guide.readthedocs.io/en/latest/linux-qemu.html.

  In qemu-system-riscv64, code at 0x80000000 will be executed by virtual CP=
U.
  For example, using `qemu-system-riscv64 -nographic -machine virt -bios no=
ne -kernel vmlinux -S -s`, my homebrew kernel(ELF file) will load at 0x8000=
0000. If I strip the kernel using `riscv64-linux-gnu-objcopy -O binary vmli=
nux Image`, qemu-system-riscv64 will not load the binary machine code into =
the riscv64 load address, but `-bios Image` will.

  In `qemu-system-aarch64` compiled by Ubuntu team, I can use `qemu-
  system-aarch64 -M raspi3 -kernel Image_aarch64 -S -s` to load a
  specific machine code binary into 0x80000. And the elf kernel can be
  loaded to that address, too.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1898883/+subscriptions

