Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A6EBC2BB84
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:26:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C5892074D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 15:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eABT3L6x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C5892074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEDbu-0004wr-4v
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 11:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48802)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEDar-0004Br-88
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:25:37 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46464)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kEDao-0004Qh-P3
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 11:25:36 -0400
Received: by mail-pg1-x543.google.com with SMTP id 31so4475119pgy.13
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2020 08:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Xx1rdMe3HpP9XmQG2cfyi3toWF59kRJQcdYWhSVveVU=;
 b=eABT3L6x17JDVJSayovHc7Smt/V0p+lATezQ51iRstQxcs/MRlSJqh4uIqkCgagX1N
 qauvKj4lmtuOu7EFbWAa0mACxoiYmiz2jQpMn6mv3a1hxtTFm92hYbBkcTa2RRr3vjkv
 kC9ddOC5KEY5duwpKoq9RFHHc1DlGIWVq5n7zed8tsKSfdsNCWzNQk1K4IYo4V09G6Zq
 FqmPwMLgDSHna9iZdrBdquB7OaTjVNovcx/s0zR7ooNRtsG6Ipaf3F2psqTsT8HUzH3i
 3fsQS6FSWV9iI6z9qjCfRU/5/RSgIywKuGlNR2El0rWH8x2gXGxnAI4FuRDxHHHs/F6g
 xgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Xx1rdMe3HpP9XmQG2cfyi3toWF59kRJQcdYWhSVveVU=;
 b=VkAXnGkBDzURAfm3amVWjfZ/OK7XnQi6j7V06fWL4ash6GsOCMGKParTSOufm8ugo3
 Po+xbGL9C9khp7DMy/xehssbuFtXFTjB94FserW/d5NjKFo5piuXtkpI9743lSIq1Sjm
 krRkG4qdnVMmn4J2jXhTiCeznY7hItFNHm/kQ8/JRbm3Bdi/qifbLTfUw1Z0ooWpTGox
 Ni5Ym1JU1O09E+1e55gFo8UNIbWbCGwrZ2251edoAGHkbWKOKUXqWvdCL2WpulZS+DhI
 ska2kKgJjXuuycp3EZ68ZF4UY6yNqhBkPolH5zuZbXBHOEaUdXD0Elf/L5MQ9u0T0ZXP
 2SQw==
X-Gm-Message-State: AOAM530yjSxTn0SZGcUJe2I0a6I1ldDTzc7eofHWC4TKWYx/8xFboosu
 +YvMBDKmi1MQGX5Y8XfFgjoatg==
X-Google-Smtp-Source: ABdhPJyO4zruVnzI/SRahjQwouDPiUAPs720/Lvpj4W2IMN/tmTBhxpbqrU7NbWgrUvAitoDnnjx/w==
X-Received: by 2002:a65:5c0d:: with SMTP id u13mr7908179pgr.333.1599233133076; 
 Fri, 04 Sep 2020 08:25:33 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v18sm6883854pfu.15.2020.09.04.08.25.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 04 Sep 2020 08:25:32 -0700 (PDT)
Subject: Re: [PATCH v2 05/12] target/microblaze: Fill in VMStateDescription
 for cpu
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
References: <20200903072650.1360454-1-richard.henderson@linaro.org>
 <20200903072650.1360454-6-richard.henderson@linaro.org>
 <20200904122003.GN14249@toto>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <07370a54-846f-9dd9-e6f2-1c9bdf216e3c@linaro.org>
Date: Fri, 4 Sep 2020 08:25:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200904122003.GN14249@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.107,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/4/20 5:20 AM, Edgar E. Iglesias wrote:
>> +static VMStateField vmstate_mmu_fields[] = {
>> +    VMSTATE_UINT64_2DARRAY(rams, MicroBlazeMMU, 2, TLB_ENTRIES),
>> +    VMSTATE_UINT8_ARRAY(tids, MicroBlazeMMU, TLB_ENTRIES),
>> +    VMSTATE_UINT32_ARRAY(regs, MicroBlazeMMU, 3),
>> +    VMSTATE_INT32(c_mmu, MicroBlazeMMU),
>> +    VMSTATE_INT32(c_mmu_tlb_access, MicroBlazeMMU),
>> +    VMSTATE_INT32(c_mmu_zones, MicroBlazeMMU),
>> +    VMSTATE_UINT64(c_addr_mask, MicroBlazeMMU),
> 
> These last 4 entries are elaboration-time settings, i.e they will not
> change during VM runtime. I don't think we need to transfer these since
> we expect the peer to setup the same kind of microblaze?

Ah, I see.  Yes, migration is only supported between "like" systems.

Though in this case I wasn't thinking so much of migration and the other uses
to which VMState gets put, like record/replay and the follow-on patches for gdb
reverse debugging.

>> +    VMSTATE_UINT32_ARRAY(pvr.regs, CPUMBState, 13),
> 
> pvr.regs are also elaboration time setup and should be read-only during
> the VM's lifetime.

What do you think about moving all of these to cpu->cfg, so that all of the
configuration-time stuff is together?


r~


> 
> If you fix those, this looks good to me.:
> Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
> 


