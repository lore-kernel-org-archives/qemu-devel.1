Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283EFC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:41:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C463A205F4
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 23:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="BwJbEPLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C463A205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsbkG-0000Z5-VG
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 19:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57790)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhP-0005JF-U9
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:38:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhO-0001sg-MK
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 19:38:31 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:2164)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <prvs=10717eeaa=alistair.francis@wdc.com>)
 id 1hsbhN-0001jk-Vu; Tue, 30 Jul 2019 19:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1564529910; x=1596065910;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=DdmPDvuvTdTMJK7ANSpW3TC2s/fLXf2JTxoSe9OWJVc=;
 b=BwJbEPLm4HwnOZ/KYRYAVJDSPrYRsKTTm0C9TbWvGdrXBuITOKacdW1c
 Q4W/p+VXPtZRgDbKBxNM5z63PTkkbwiUhhNkd0aQbuyXx2jHMnRXHqjvf
 WxfyXshxzq0V5hM8AzfhYSmlQzSNIo17PZy9ZfEMGQ6iX0V7ObPvfzL7U
 /UTW+YZ6X82trXYdB/c8R5cqIN9z2pC7f2faX28KjXT2rVkYFBr463YYj
 g8XTzNvRzaHhMJPhMKH8J5cMOfTptDiygct6vyRidwoYDr24dfwVkQFZF
 EQXH+re9kcGZVlgNko4nJsD47JjdXiotdZC3xMUGfk/X6IJBeLHKh5hqY Q==;
IronPort-SDR: 0wGghUNN2SRApxTiKArB7nIsLMAiNMEP9eqIfyXnsn4JXvTJyHiJ2cM/7OdHQSUGAYgfK0XYiP
 fCqyqxePA7mEuxJbWwk+mgZcvGR/Q5E+ZqvXkrFSkqMnQV+SiwVRTMmCETpL3dtqM7avx1fexk
 rUWiaVZcYbeKJz+W+kuvu3E4+q5aqk+apDJp0TJTYsNNFqpfnRFXvn9vGT6MFnsVzKD9v8h/wu
 6yaGukSeKRNwaHchtc+trMomDjeAWjumWKdxeuKijmYq5iF3uXxndkCqTyFWFkN5n1qF9VlPVM
 SJ4=
X-IronPort-AV: E=Sophos;i="5.64,327,1559491200"; d="scan'208";a="116132614"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 07:38:24 +0800
IronPort-SDR: m5nSw+oijeum8U5S4D1QdSQ8koZ0hHnDa6dHR7v39UihpBJ8RvKPfkW8s419ASZx+gvWndmqdC
 19irL9S9xEAl005Z9fnGZaFUVEDlnWg4d7vtK/pAO3O35aHAlW595+c/3kvblqVzCxMPlKFJ69
 BNSRUCBXlT61TpZOkb+6RHLiAjKkutCfsl3cVXVFhqvnjcykv/FzMlHtZ2wSfEP29vsJrJVmqL
 9iSBEfxYHP3jbqFyAN/uyF9z/jcEogerSO7VqzSbfjIZrS11xEopuWMLQEaTTdopadOD8XfiQo
 QUSuTzoz0x0P6wHo+QCkitcH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP; 30 Jul 2019 16:36:26 -0700
IronPort-SDR: 1WZ2KjeSlkN0+yHP9/3Q4t2mu0J/a+pxC25zp2cOQYCHx7bbBaTsrheMjQEE7lg+6FTB5ZjkQv
 5PvyvP2PG3i3XP/l4NdjeyEF9j2TWojf9xw572/YM9SrcnRjPw2oQ7Jh5liZrXcAUt5/R2ykS/
 H9RWQ79gxJIQ1aTphhYJw7uT4KHY4OJp3D3wZvQYOHOcqwUUQTR1D5bMMCTeQ5MsD5fu+UU7Eu
 DbQpLmtj0rsWmmTW3TPLMIPLm1dkw7Boa7quieQJQaHuwwHlZ6mryclpya0EoiCKmwbdZMos++
 0K8=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO
 risc6-mainframe.int.fusionio.com) ([10.196.157.58])
 by uls-op-cesaip01.wdc.com with ESMTP; 30 Jul 2019 16:38:24 -0700
From: Alistair Francis <alistair.francis@wdc.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Date: Tue, 30 Jul 2019 16:35:16 -0700
Message-Id: <cover.1564529681.git.alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.154.45
Subject: [Qemu-devel] [PATCH-4.2 v2 0/5] RISC-V: Hypervisor prep work part 2
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
Cc: alistair23@gmail.com, palmer@sifive.com, alistair.francis@wdc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The first three patches are ones that I have pulled out of my original
Hypervisor series at an attempt to reduce the number of patches in the
series.

These three patches all make sense without the Hypervisor series so can
be merged seperatley and will reduce the review burden of the next
version of the patches.

The fource patch is a prep patch for the new v0.4 Hypervisor spec.

The final patch is unreleated to Hypervisor that I'm just slipping in
here because it seems easier then sending it by itself.

v2:
 - Small corrections based on feedback
 - Remove the CSR permission check patch


Alistair Francis (4):
  target/riscv: Don't set write permissions on dirty PTEs
  riscv: plic: Remove unused interrupt functions
  target/riscv: Create function to test if FP is enabled
  target/riscv: Update the Hypervisor CSRs to v0.4

Atish Patra (1):
  target/riscv: Fix Floating Point register names

 hw/riscv/sifive_plic.c         | 12 ------------
 include/hw/riscv/sifive_plic.h |  3 ---
 target/riscv/cpu.c             |  8 ++++----
 target/riscv/cpu.h             |  6 +++++-
 target/riscv/cpu_bits.h        | 35 +++++++++++++++++-----------------
 target/riscv/cpu_helper.c      | 16 ++++++++++++----
 target/riscv/csr.c             | 20 ++++++++++---------
 7 files changed, 50 insertions(+), 50 deletions(-)

-- 
2.22.0


