Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9084BC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C3F7207BC
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 19:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="rSD4dLSu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3F7207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeOOH-0004uK-Hq
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 15:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49268)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOLv-00006E-RG
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:07 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:35458 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jeOLt-00071j-OY
 for qemu-devel@nongnu.org; Thu, 28 May 2020 15:38:07 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id 70C024C861;
 Thu, 28 May 2020 19:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 content-type:content-type:content-transfer-encoding:mime-version
 :x-mailer:message-id:date:date:subject:subject:from:from
 :received:received:received; s=mta-01; t=1590694679; x=
 1592509080; bh=jAf6p9MycTcNFZhY/r1wSMZiqT5f9w7Rh+JqM9akOzM=; b=r
 SD4dLSumrZesjW6kelkA2SAutibRz9kWznb/adkjstD0h+MA1DlTP0fDTonlEUGX
 iARxuU2ClOmjQ/KpRTYmz6sOC6NpYOjriL5wDysK9bFMTNbhHwa4COQE/xVcJOWb
 KPKEoYQx9n86k3xR9O3URC9WEDNgoSAn3KhEUTEZbo=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ae_vWPOQIGz4; Thu, 28 May 2020 22:37:59 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 0084F41227;
 Thu, 28 May 2020 22:37:58 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 28
 May 2020 22:38:00 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 00/13] i386: hvf: Remove HVFX86EmulatorState
Date: Thu, 28 May 2020 22:37:45 +0300
Message-ID: <20200528193758.51454-1-r.bolshakov@yadro.com>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 15:38:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Roman Bolshakov <r.bolshakov@yadro.com>, Cameron Esfahani <dirty@apple.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

This is a cleanup series for HVF accel.

HVF is using two emulator states CPUX86State and HVFX86EmulatorState
simultaneously. HVFX86EmulatorState is used for instruction emulation.
CPUX86State is used in all other places. Sometimes the states are in
sync, sometimes they're not. It complicates reasoning about emulator
behaviour given that there's a third state - VMCS.

The series tries to leverage CPUX86State for instruction decoding and
removes HVFX86EmulatorState. I had to add two new hvf-specific fields to
CPUX86State: lazy_flags and mmio_buf. It's likely that cc_op, cc_dst,
etc could be reused for lazy_flags but it'd require major rework of flag
processing during instruction emulation. Hopefully that'll happen too in
the future.

I tried to include sysemu/hvf.h into target/i386/cpu.h to add definition
of hvf lazy flags but couldn't do that at first it because it introduced
circular dependency between existing sysemu/hvf.h and cpu.h. The first
three patches untangle and prune sysemu/hvf.h to the bare minimum to
allow inclusion of sysemu/hvf.h into target/i386/cpu.h.

This might conflict with [1], but merge/rebase should be trivial.

1. https://lists.gnu.org/archive/html/qemu-devel/2020-05/msg07449.html

Thanks,
Roman

Roman Bolshakov (13):
  i386: hvf: Move HVFState definition into hvf
  i386: hvf: Drop useless declarations in sysemu
  i386: hvf: Clean stray includes in sysemu
  i386: hvf: Drop unused variable
  i386: hvf: Use ins_len to advance IP
  i386: hvf: Use IP from CPUX86State
  i386: hvf: Drop fetch_rip from HVFX86EmulatorState
  i386: hvf: Drop rflags from HVFX86EmulatorState
  i386: hvf: Drop copy of RFLAGS defines
  i386: hvf: Drop regs in HVFX86EmulatorState
  i386: hvf: Move lazy_flags into CPUX86State
  i386: hvf: Move mmio_buf into CPUX86State
  i386: hvf: Drop HVFX86EmulatorState

 include/qemu/typedefs.h      |   1 -
 include/sysemu/hvf.h         |  73 ++-------------------
 target/i386/cpu.h            |   4 +-
 target/i386/hvf/hvf-i386.h   |  35 ++++++++++
 target/i386/hvf/hvf.c        |  30 ++++-----
 target/i386/hvf/x86.c        |   2 +-
 target/i386/hvf/x86.h        |  89 ++-----------------------
 target/i386/hvf/x86_decode.c |  25 ++++---
 target/i386/hvf/x86_emu.c    | 122 +++++++++++++++++------------------
 target/i386/hvf/x86_flags.c  |  81 ++++++++++++-----------
 target/i386/hvf/x86_task.c   |  10 +--
 target/i386/hvf/x86hvf.c     |   6 +-
 12 files changed, 186 insertions(+), 292 deletions(-)

-- 
2.26.1


