Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD13C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 02:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DF5620829
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 02:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DF5620829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k62xl-00054g-IF
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 22:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1k62xC-0004bF-Gp; Wed, 12 Aug 2020 22:26:54 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:33049)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1k62x8-0005Pp-P6; Wed, 12 Aug 2020 22:26:54 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.1112179|-1; CH=green; DM=|CONTINUE|false|;
 DS=CONTINUE|ham_alarm|0.0682781-0.00109182-0.93063; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03279; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=6; RT=6; SR=0;
 TI=SMTPD_---.IGpDMDT_1597285599; 
Received: from 30.225.208.90(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.IGpDMDT_1597285599) by smtp.aliyun-inc.com(10.147.40.2);
 Thu, 13 Aug 2020 10:26:39 +0800
Subject: Re: [PATCH v3 00/13] RISC-V: Update the Hypervisor spec to v0.6.1
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1597259519.git.alistair.francis@wdc.com>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <6e40b9b8-5883-7b49-e63e-2e24e8f5baec@c-sky.com>
Date: Thu, 13 Aug 2020 10:26:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <cover.1597259519.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: none client-ip=121.197.200.217;
 envelope-from=zhiwei_liu@c-sky.com; helo=smtp2200-217.mail.aliyun.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/12 22:14:07
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Cc: alistair23@gmail.com, anup.patel@wdc.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/8/13 3:13, Alistair Francis wrote:
> This series updates the experimental QEMU RISC-V Hypervisor spec to the
> v0.6.1 draft implementation.
>
> THis includes support for the new 2-stage lookup instructions and the new
> CSRs.
>
> It also includes the new 0.6.1 support for the virtual instruction
> fault.
>
> This was tested by running 32-bit and 64-bit Xvisor on QEMU and starting
> Linux guests.
Hi Alistair,

I am reading Christoper Dall's article on ARM virtualization.  As far as 
I can see,  Xvisor is type 1 hypervisor.

I want to  try this patch set. Could you share the method? Thanks very much.

Best Regards,
Zhiwei
> v3:
>   - Rebase on master
> v2:
>   - Update to v0.6.1
>
>
>
> Alistair Francis (13):
>    target/riscv: Allow setting a two-stage lookup in the virt status
>    target/riscv: Allow generating hlv/hlvx/hsv instructions
>    target/riscv: Do two-stage lookups on hlv/hlvx/hsv instructions
>    target/riscv: Don't allow guest to write to htinst
>    target/riscv: Convert MSTATUS MTL to GVA
>    target/riscv: Fix the interrupt cause code
>    target/riscv: Update the Hypervisor trap return/entry
>    target/riscv: Update the CSRs to the v0.6 Hyp extension
>    target/riscv: Only support a single VSXL length
>    target/riscv: Only support little endian guests
>    target/riscv: Support the v0.6 Hypervisor extension CRSs
>    target/riscv: Return the exception from invalid CSR accesses
>    target/riscv: Support the Virtual Instruction fault
>
>   target/riscv/cpu.h                      |   2 +
>   target/riscv/cpu_bits.h                 |  25 +-
>   target/riscv/helper.h                   |   4 +
>   target/riscv/insn32-64.decode           |   5 +
>   target/riscv/insn32.decode              |  11 +
>   target/riscv/cpu_helper.c               | 123 +++++----
>   target/riscv/csr.c                      | 171 ++++++++++--
>   target/riscv/insn_trans/trans_rvh.inc.c | 342 +++++++++++++++++++++++-
>   target/riscv/op_helper.c                | 176 +++++++++++-
>   target/riscv/translate.c                |  10 -
>   10 files changed, 761 insertions(+), 108 deletions(-)
>


