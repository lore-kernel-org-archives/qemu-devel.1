Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134DFC3A5A7
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 07:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0159214AE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 07:52:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0159214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4h8g-00088v-Rs
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 03:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33257)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i4h7q-0007jy-Hq
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 03:51:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1i4h7n-00025Q-Os
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 03:51:46 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:59775)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1i4h7n-0001sk-Ca; Mon, 02 Sep 2019 03:51:43 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.08585322|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.108841-0.0017065-0.889452; FP=0|0|0|0|0|-1|-1|-1;
 HT=e02c03307; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=12; RT=12; SR=0;
 TI=SMTPD_---.FNN9pas_1567410693; 
Received: from 172.16.28.187(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FNN9pas_1567410693)
 by smtp.aliyun-inc.com(10.147.43.95); Mon, 02 Sep 2019 15:51:36 +0800
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <1566959818-38369-1-git-send-email-zhiwei_liu@c-sky.com>
 <ba8c7451-b0a7-0405-f881-0c6d0d8574fb@linaro.org>
 <3b85e9b6-8799-9682-9aaf-b688924cb52e@linaro.org>
 <841ebe5f-dd5e-c59d-d7e9-c246ad7741c0@c-sky.com>
 <f81553cc-0f95-003e-f608-f83f9a7e8dd2@linaro.org>
From: liuzhiwei <zhiwei_liu@c-sky.com>
Message-ID: <b439e5a8-8ade-2f90-d298-9cedd1b2333b@c-sky.com>
Date: Mon, 2 Sep 2019 15:45:43 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <f81553cc-0f95-003e-f608-f83f9a7e8dd2@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Subject: Re: [Qemu-devel] [PATCH] RISCV: support riscv vector extension 0.7.1
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
Cc: peter.maydell@linaro.org, palmer@sifive.com, sagark@eecs.berkeley.edu,
 kbastian@mail.uni-paderborn.de, riku.voipio@iki.fi, laurent@vivier.eu,
 Alistair.Francis@wdc.com, alex.bennee@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/8/29 下午11:09, Richard Henderson wrote:
> On 8/29/19 5:45 AM, liuzhiwei wrote:
>> Even in qemu,  it may be some situations that VSTART != 0. For example, a load
>> instruction leads to a page fault exception in a middle position. If VSTART ==
>> 0,  some elements that had been loaded before the exception will be loaded once
>> again.
> Alternately, you can validate all of the pages before performing any memory
> operations.  At which point there will never be an exception in the middle.

As a vector instruction may access memory  across many pages,  is there 
any way to validate the pages? Page table walk ?Or some TLB APIs?

> As it turns out, you *must* do this in order to allow watchpoints to work
> correctly.  David Hildebrand and I are at this moment fixing this aspect of
> watchpoints for s390x.
>
> See https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg05979.html

I am interested in wathpoint implementation and  once implemented the 
user mode watchpoints in the wild.

A backtrace of watchpoint is like

#0  cpu_watchpoint_address_matches (wp=0x555556228110, addr=536871072, 
len=1) at qemu/exec.c:1094
#1  0x000055555567204f in check_watchpoint (offset=160, len=1, 
attrs=..., flags=2) at qemu/exec.c:2803
#2  0x0000555555672379 in watch_mem_write (opaque=0x0, addr=536871072, 
val=165, size=1, attrs=...) at qemu/exec.c:2878
#3  0x00005555556d44bb in memory_region_write_with_attrs_accessor 
(mr=0x5555561292e0 <io_mem_watch>, addr=536871072, value=0x7fffedffe2c8, 
size=1, shift=0, mask=255, attrs=...)
     at qemu/memory.c:553
#4  0x00005555556d45de in access_with_adjusted_size (addr=536871072, 
value=0x7fffedffe2c8, size=1, access_size_min=1, access_size_max=8, 
access_fn=0x5555556d43cd <memory_region_write_with_attrs_accessor>,
     mr=0x5555561292e0 <io_mem_watch>, attrs=...) at qemu/memory.c:594
#5  0x00005555556d7247 in memory_region_dispatch_write 
(mr=0x5555561292e0 <io_mem_watch>, addr=536871072, data=165, size=1, 
attrs=...) at qemu/memory.c:1480
#6  0x00005555556f0d13 in io_writex (env=0x5555561efb58, 
iotlbentry=0x5555561f5398, mmu_idx=1, val=165, addr=536871072, 
retaddr=0, recheck=false, size=1) at qemu/accel/tcg/cputlb.c:909
#7  0x00005555556f19a6 in io_writeb (env=0x5555561efb58, mmu_idx=1, 
index=0, val=165 '\245', addr=536871072, retaddr=0, recheck=false) at 
qemu/accel/tcg/softmmu_template.h:268
#8  0x00005555556f1b54 in helper_ret_stb_mmu (env=0x5555561efb58, 
addr=536871072, val=165 '\245', oi=1, retaddr=0) at 
qemu/accel/tcg/softmmu_template.h:304
#9  0x0000555555769f06 in cpu_stb_data_ra (env=0x5555561efb58, 
ptr=536871072, v=165, retaddr=0) at 
qemu/include/exec/cpu_ldst_template.h:182
#10 0x0000555555769f80 in cpu_stb_data (env=0x5555561efb58, 
ptr=536871072, v=165) at /qemu/include/exec/cpu_ldst_template.h:194
#11 0x000055555576a913 in csky_cpu_stb_data (env=0x5555561efb58, 
vaddr=536871072, data=165 '\245') at qemu/target/csky/csky_ldst.c:48
#12 0x000055555580ba7d in helper_vdsp2_vstru_n (env=0x5555561efb58, 
insn=4167183360) at qemu/target/csky/op_vdsp2.c:1317

The path is not related to probe_write in the patch().

Could you give more details or a test case where watchpoint doesn't work 
correctly?

>
> r~
>

