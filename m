Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BD7C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0664A20735
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:34:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H29KNPV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0664A20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGNDW-00007y-NG
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 09:34:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sophian.yoma@gmail.com>) id 1jGIFh-00051p-EQ
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sophian.yoma@gmail.com>) id 1jGIFg-0008CF-8t
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:16:05 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sophian.yoma@gmail.com>)
 id 1jGIFf-0008Bn-WE
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 04:16:04 -0400
Received: by mail-pg1-x541.google.com with SMTP id 142so1572270pgf.11
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2020 01:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=sksnqBm7tcBKY+pGSojS0eQ7r1QAgz+D4tDHhsxseZA=;
 b=H29KNPV2UxQSoqf4m52ib5o5negZCP/CD5lrz+5t4mobB4zqLSdumEBrsQWkVUNQ7h
 bzRIcQTH+BRZt8hg8K58Ev6J/wHCHlHGhSjYWhrVXEbf7yt+5z0GxwwePPqO7TJ+dkXa
 G04ufXtSWleLoDy5BFhoy+t8E8RYRw76YT/VrnE/wNk1bJ5xJAmYRw/wWaraoLFhh1Va
 13nam09qGNzGXzpQPNCKiiyf7VXjStNhiocXJYemJCiITVQGGEvBZAw6TJNbOZU3x1i0
 OY8qsMJJuhYx3ilqf930MyPfuMn1C7oVq8nMXkyQdvNmT3YYKvnHbBKuihRIFHzatODg
 QTwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=sksnqBm7tcBKY+pGSojS0eQ7r1QAgz+D4tDHhsxseZA=;
 b=O60XsHK/DzTzM0lgK0Z5JzFkC8Fp5rvQC/aRu8aKdbOT1Dcy21qduooevy28dgJ2ZO
 jNd+z9FufZNK2vhxrRrp70ywHh64ib3EoXc/aeXCktw9Fib7ATeiizpmkObamEs3oNtp
 HZktkkvUljSyfyOwFnqu5AR0PBE9cHTCRD0Am3Hkydv0Ia6HRJhvffvyTW03hTZFpbq7
 pnm2tNYPCiZFzin/0q3ey/4kcgx/iptVlF8MPy3Xpn0X+4vV7gx1h2Z9SwjAG9AsEUUc
 otFy7JLJPnLYWPOWuB/IB6JlowO8UOSVMsMm+InrZlC51mf5I/gJ9F6ETn+219NZ0XwR
 6rYg==
X-Gm-Message-State: ANhLgQ1a1UWSZVfMNySYei3jfTJJR5+P+Z5efn5jXVud74YoZ2bcCW6N
 8C/sFJgHGxSIh50hZLLn6OFzAvwHgpB5vw+VQ595tir7
X-Google-Smtp-Source: ADFU+vvmvSsZqnF6N/S9fXKiVcM4nNpErcZ4P2lLyAwoNWIV6AX9Ux21FIiXeW9oeh1XdwRwG2I2FFmX/9mek8/mims=
X-Received: by 2002:aa7:86ce:: with SMTP id h14mr22719418pfo.311.1584951361903; 
 Mon, 23 Mar 2020 01:16:01 -0700 (PDT)
MIME-Version: 1.0
From: yoma sophian <sophian.yoma@gmail.com>
Date: Mon, 23 Mar 2020 16:15:50 +0800
Message-ID: <CADUS3onjS+T-SSYC6ocKNm3oXsCpiQbDa0eJobhOnts3gZ_gEw@mail.gmail.com>
Subject: qemu-system-aarch64 windows binary run Arm64 defconfig kernel not
 working
To: qemu-devel@nongnu.org
Content-Type: multipart/mixed; boundary="000000000000e9fa4f05a1813e2c"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
X-Mailman-Approved-At: Mon, 23 Mar 2020 09:32:40 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000e9fa4f05a1813e2c
Content-Type: text/plain; charset="UTF-8"

hi all:
I try to use qemu-system-aarch64 windows binary for running arm64
defconfig kernel image but get Synchronous External Abort while
booting PCI devices.
The same Image that run on qemu-system-aarch64 linux binary is fine.
Is there any pci related kernel config need to be removed while using
qemu windows binary?

Appreciate ur help in advance.
=============================
My environment are:
1. the versionof qemu-system-aarch64 windows binary is 4.0.92
2.  kernel image:
     a. check out latest kernel from
         git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
     b. make ARCH=arm64 defconfig
     c. make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- -j32
3. run qemu with attach "qemu_run.sh"

Boot up fail log is attached
"qemu_win10_binary_bootup_aarch64_defconfig_fail.log.tar.bz2"
============================
below is excerpt from log, where Synchronous External Abort happens.
============================
[    2.453924] pci-host-generic 3f000000.pcie: ECAM at [mem
0x3f000000-0x3fffffff] for [bus 00-0f]
[    2.461280] pci-host-generic 3f000000.pcie: PCI host bridge to bus 0000:00
[    2.461855] pci_bus 0000:00: root bus resource [bus 00-0f]
[    2.462188] pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
[    2.462423] pci_bus 0000:00: root bus resource [mem 0x10000000-0x3efeffff]
[    2.462677] pci_bus 0000:00: root bus resource [mem
0x8000000000-0xffffffffff]
[    2.463565] Synchronous External Abort: synchronous external abort
(0x96000010) at 0xffff00000c000000
[    2.464656] Internal error: : 96000010 [#1] PREEMPT SMP
[    2.465093] Modules linked in:
[    2.465411] Process swapper/0 (pid: 1, stack limit = 0x        (ptrval))
[    2.465810] CPU: 1 PID: 1 Comm: swapper/0 Not tainted
4.14.128-00888-g15ac2b5e934a-dirty #8
[    2.466077] Hardware name: linux,dummy-virt (DT)
[    2.466315] task:         (ptrval) task.stack:         (ptrval)
[    2.466556] PC is at pci_generic_config_read+0xa8/0xd8
[    2.466748] LR is at pci_generic_config_read+0x44/0xd8
[    2.466925] pc : [<ffff0000085960a4>] lr : [<ffff000008596040>]
pstate: 200001c5
[    2.467169] sp : ffff00000804b8c0
[    2.467304] x29: ffff00000804b8f0 x28: ffff00000804bac0
[    2.467565] x27: 0000000000000001 x26: ffff80003d354e80
[    2.467892] x25: ffff00000804bac0 x24: 0000000000000140
[    2.468110] x23: ffff80003c5a0000 x22: 0000000000000000
[    2.468347] x21: 0000000000000000 x20: 0000000000000004

--000000000000e9fa4f05a1813e2c
Content-Type: application/x-bzip; 
	name="qemu_win10_binary_bootup_aarch64_defconfig_fail.log.tar.bz2"
Content-Disposition: attachment; 
	filename="qemu_win10_binary_bootup_aarch64_defconfig_fail.log.tar.bz2"
Content-Transfer-Encoding: base64
Content-ID: <f_k8470hhh0>
X-Attachment-Id: f_k8470hhh0

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
--000000000000e9fa4f05a1813e2c
Content-Type: application/x-bzip; name="qemu_run.sh.tar.bz2"
Content-Disposition: attachment; filename="qemu_run.sh.tar.bz2"
Content-Transfer-Encoding: base64
Content-ID: <f_k8470hib1>
X-Attachment-Id: f_k8470hib1

/Td6WFoAAATm1rRGAgAhARYAAAB0L+Wj4Cf/AQRdADiZSf9Rno/IU18z9X7aKPIbeayG66z3749O
/zeNjUgfz/81neqqhhlJlUwdx0JhG4oAgI15B/R0y3Bsfme4UvGv6LjmqCEP6/2mt78FlBlAcCgt
wUvt3ldOpqNenjlnQ+kzk936YbI6FdBpZibkwwMM08e1EkrkF75ptBQCk9WEaaTsXOuNbD1VkhOK
j4WnmprsmuMR2vvRImRgSW/AyM7tJHy6T6MX/7yGX6FBWp5zZJm8y30zHyUNCmHHMXfg6nouXWSQ
+PlVZl4X96MojJSbhsqJ9wGO1PtMEExHtmEh/e7o8Xd2kRdmEiOhfQR5/twdefiQdNTI3e4vq+1i
4oXhtksAAOUa1JKD+AKaAAGgAoBQAADYDmwhscRn+wIAAAAABFla
--000000000000e9fa4f05a1813e2c--

