Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A58C3F2C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 02:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D4D2469B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 02:18:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D4D2469B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7VER-0004rT-DA
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 21:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j7VDh-0004Nb-Iz
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 21:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1j7VDg-0005rC-Gt
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 21:17:41 -0500
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:36784)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1j7VDg-0005dX-34; Thu, 27 Feb 2020 21:17:40 -0500
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07691746|-1; CH=green;
 DM=CONTINUE|CONTINUE|true|0.369896-0.0143644-0.61574;
 DS=CONTINUE|ham_regular_dialog|0.0436093-0.00338842-0.953002;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03306; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.GtTbse6_1582856253; 
Received: from 192.168.3.18(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.GtTbse6_1582856253)
 by smtp.aliyun-inc.com(10.147.41.158);
 Fri, 28 Feb 2020 10:17:33 +0800
Subject: Re: [PATCH v4 4/5] target/riscv: add fault-only-first unit stride load
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200225103508.7651-1-zhiwei_liu@c-sky.com>
 <20200225103508.7651-5-zhiwei_liu@c-sky.com>
 <2b7d7af1-61ee-edf6-5e57-1108428f920c@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <47ee82fc-777f-5665-cee6-cad9875b2990@c-sky.com>
Date: Fri, 28 Feb 2020 10:17:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <2b7d7af1-61ee-edf6-5e57-1108428f920c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org, linux-csky@vger.kernel.org,
 wxy194768@alibaba-inc.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/2/28 4:03, Richard Henderson wrote:
> On 2/25/20 2:35 AM, LIU Zhiwei wrote:
>> +GEN_VEXT_LD_ELEM(vlbff_v_b, int8_t,  int8_t,  H1, ldsb)
>> +GEN_VEXT_LD_ELEM(vlbff_v_h, int8_t,  int16_t, H2, ldsb)
>> +GEN_VEXT_LD_ELEM(vlbff_v_w, int8_t,  int32_t, H4, ldsb)
>> +GEN_VEXT_LD_ELEM(vlbff_v_d, int8_t,  int64_t, H8, ldsb)
>> +GEN_VEXT_LD_ELEM(vlhff_v_h, int16_t, int16_t, H2, ldsw)
>> +GEN_VEXT_LD_ELEM(vlhff_v_w, int16_t, int32_t, H4, ldsw)
>> +GEN_VEXT_LD_ELEM(vlhff_v_d, int16_t, int64_t, H8, ldsw)
>> +GEN_VEXT_LD_ELEM(vlwff_v_w, int32_t, int32_t, H4, ldl)
>> +GEN_VEXT_LD_ELEM(vlwff_v_d, int32_t, int64_t, H8, ldl)
>> +GEN_VEXT_LD_ELEM(vleff_v_b, int8_t,  int8_t,  H1, ldsb)
>> +GEN_VEXT_LD_ELEM(vleff_v_h, int16_t, int16_t, H2, ldsw)
>> +GEN_VEXT_LD_ELEM(vleff_v_w, int32_t, int32_t, H4, ldl)
>> +GEN_VEXT_LD_ELEM(vleff_v_d, int64_t, int64_t, H8, ldq)
>> +GEN_VEXT_LD_ELEM(vlbuff_v_b, uint8_t,  uint8_t,  H1, ldub)
>> +GEN_VEXT_LD_ELEM(vlbuff_v_h, uint8_t,  uint16_t, H2, ldub)
>> +GEN_VEXT_LD_ELEM(vlbuff_v_w, uint8_t,  uint32_t, H4, ldub)
>> +GEN_VEXT_LD_ELEM(vlbuff_v_d, uint8_t,  uint64_t, H8, ldub)
>> +GEN_VEXT_LD_ELEM(vlhuff_v_h, uint16_t, uint16_t, H2, lduw)
>> +GEN_VEXT_LD_ELEM(vlhuff_v_w, uint16_t, uint32_t, H4, lduw)
>> +GEN_VEXT_LD_ELEM(vlhuff_v_d, uint16_t, uint64_t, H8, lduw)
>> +GEN_VEXT_LD_ELEM(vlwuff_v_w, uint32_t, uint32_t, H4, ldl)
>> +GEN_VEXT_LD_ELEM(vlwuff_v_d, uint32_t, uint64_t, H8, ldl)
> We definitely should not have a 3rd copy of these.
Yes, I will remove it by add a parameter to GEN_VEXT_LDFF.
>
>
>> +        if (i == 0) {
>> +            probe_read_access(env, addr, nf * msz, ra);
>> +        } else {
>> +            /* if it triggles an exception, no need to check watchpoint */
> triggers.
Yes.
>
>> +            offset = -(addr | TARGET_PAGE_MASK);
>> +            remain = nf * msz;
>> +            while (remain > 0) {
>> +                host = tlb_vaddr_to_host(env, addr, MMU_DATA_LOAD, mmuidx);
>> +                if (host) {
>> +#ifdef CONFIG_USER_ONLY
>> +                    if (page_check_range(addr, nf * msz, PAGE_READ) < 0) {
>> +                        vl = i;
>> +                        goto ProbeSuccess;
>> +                    }
>> +#else
>> +                    probe_read_access(env, addr, nf * msz, ra);
>> +#endif
> Good job finding all of the corner cases.  I should invent a new cputlb
> function that handles this better.  For now, this is the best we can do.
That will be better.

I learn a lot from SVE and some S390  code. Thanks a lot.

Best Regards,
Zhiwei
>
> r~


