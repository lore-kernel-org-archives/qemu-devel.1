Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00DFC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95F1020678
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 08:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95F1020678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iA8jd-0002F7-E3
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 04:21:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53577)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1iA8hS-0000cc-4R
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:19:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1iA8hQ-0002Sk-A4
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 04:19:01 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:42198)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1iA8hP-0002N0-Lm; Tue, 17 Sep 2019 04:19:00 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.04608306|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.120959-0.00373632-0.875304; FP=0|0|0|0|0|-1|-1|-1;
 HT=e01a16384; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS; RN=11; RT=11; SR=0;
 TI=SMTPD_---.FW9xxlT_1568708326; 
Received: from 172.16.28.186(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.FW9xxlT_1568708326) by smtp.aliyun-inc.com(10.147.40.2);
 Tue, 17 Sep 2019 16:18:48 +0800
To: Chih-Min Chao <chihmin.chao@sifive.com>
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-2-git-send-email-zhiwei_liu@c-sky.com>
 <CAEiOBXUveMJGpavU7_zK0UTdNniQvnXnw5MvE-hu7yHCSw8MPQ@mail.gmail.com>
From: liuzhiwei <zhiwei_liu@c-sky.com>
Message-ID: <6c7b73cc-a4ae-8b0a-b6b1-c578549aa2f4@c-sky.com>
Date: Tue, 17 Sep 2019 16:09:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <CAEiOBXUveMJGpavU7_zK0UTdNniQvnXnw5MvE-hu7yHCSw8MPQ@mail.gmail.com>
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 121.197.200.217
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 01/17] RISC-V: add vfp field in
 CPURISCVState
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, riku.voipio@iki.fi,
 laurent@vivier.eu, wxy194768@alibaba-inc.com,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 wenmeng_zhang@c-sky.com, Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 2019/9/11 下午10:51, Chih-Min Chao wrote:
>
>
> On Wed, Sep 11, 2019 at 2:35 PM liuzhiwei <zhiwei_liu@c-sky.com 
> <mailto:zhiwei_liu@c-sky.com>> wrote:
>
>     From: LIU Zhiwei <zhiwei_liu@c-sky.com <mailto:zhiwei_liu@c-sky.com>>
>
>     Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com
>     <mailto:zhiwei_liu@c-sky.com>>
>     ---
>      target/riscv/cpu.h | 28 ++++++++++++++++++++++++++++
>      1 file changed, 28 insertions(+)
>
>     diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
>     index 0adb307..c992b1d 100644
>     --- a/target/riscv/cpu.h
>     +++ b/target/riscv/cpu.h
>     @@ -93,9 +93,37 @@ typedef struct CPURISCVState CPURISCVState;
>
>      #include "pmp.h"
>
>     +#define VLEN 128
>     +#define VUNIT(x) (VLEN / x)
>     +
>      struct CPURISCVState {
>          target_ulong gpr[32];
>          uint64_t fpr[32]; /* assume both F and D extensions */
>     +
>     +    /* vector coprocessor state.  */
>     +    struct {
>     +        union VECTOR {
>     +            float64  f64[VUNIT(64)];
>     +            float32  f32[VUNIT(32)];
>     +            float16  f16[VUNIT(16)];
>     +            uint64_t u64[VUNIT(64)];
>     +            int64_t  s64[VUNIT(64)];
>     +            uint32_t u32[VUNIT(32)];
>     +            int32_t  s32[VUNIT(32)];
>     +            uint16_t u16[VUNIT(16)];
>     +            int16_t  s16[VUNIT(16)];
>     +            uint8_t  u8[VUNIT(8)];
>     +            int8_t   s8[VUNIT(8)];
>     +        } vreg[32];
>     +        target_ulong vxrm;
>     +        target_ulong vxsat;
>     +        target_ulong vl;
>     +        target_ulong vstart;
>     +        target_ulong vtype;
>     +        float_status fp_status;
>     +    } vfp;
>     +
>     +    bool         foflag;
>          target_ulong pc;
>          target_ulong load_res;
>          target_ulong load_val;
>     -- 
>     2.7.4
>
>
> Could  the VLEN be configurable in cpu initialization but not fixed in 
> compilation phase ?

Yes,  it's important that VLEN is configurable to support different 
types of cpu.

> Take the integer element as example  and the difference should be the 
> stride of vfp.vreg[x] isn't continuous
>
>     struct {
>         union VECTOR {
>             uint64_t *u64;
>             uint16_t *u16;
>             uint8_t  *u8;
>         } vreg[32];
>     } vfp;
>
>    initialization
>     int vlen = 256;  //parameter from cpu command line option
>     int elem = vlen / 8;
>     int size = elem * 32;
>
>     uint8_t *mem = malloc(size)
>     for (int idx = 0; idx < 32; ++idx) {
>         vfp.vreg[idx].u64 = (void *)&mem[idx * elem];
>         vfp.vreg[idx].u32 = (void *)&mem[idx * elem];
>         vfp.vreg[idx].u16 = (void *)&mem[idx * elem];
>    }
>
>   chihmin

It's a good idea. I will accept it.

Thanks for review.

Zhiwei

