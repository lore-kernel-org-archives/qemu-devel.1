Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEE6C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 23:13:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F10221F0
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 23:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qJQUc42D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F10221F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGsEv-0007St-NT
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 19:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGsEN-0006rX-Gi
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 19:13:23 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40408)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGsEL-0003We-U2
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 19:13:23 -0400
Received: by mail-pg1-x541.google.com with SMTP id j34so7588136pgi.7
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nF2XoJPc1wjSLU1yEhwrBeQhZkNm2qMTelrTXDfs/7w=;
 b=qJQUc42Dobe4ZvmMruXbBnrPzu1Qo8aRMSGIvg8N3PBPzII/04HMncsoct8tg8vkaY
 ihEl01z45vmbsLk3K30TbKCO8ZLbSQiAgLyQGjWn7X6kthGKOulqnzhy9y4/su7QwGnM
 AK1AW+auI6QUINtwJrH1CKVklKBYoWrDXbXBLtu9ogNB/9m0BPiChMw2VE5T0zzuMJcT
 lw8gZxvdIIBgxSqsAVMox7gez+QltlIzvs6yiiDo9uQsb+6k1ILovwnQ3QqiJcoYhQ1a
 El8BXpO1AaLFftRruxmmncySVHXexLHl4TxEWKxIoixor/2mAG88UiMi6DflEiu0aeiI
 v5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nF2XoJPc1wjSLU1yEhwrBeQhZkNm2qMTelrTXDfs/7w=;
 b=cEc2DwsylVQuc4aWSO1cOmmNBlc+dYfBQV6uhVRidmmaOZLtV8lLkBupiPx46zeTDr
 LSH1FwZnTWxwXJK1+zyFBl+9aPTm3m+894vJO+cMIbr80kwykdYfjBZ52i6xLowigp+Z
 xoMayXU0NjWdSaLCQ6bEicRQ1u63QFwmBZXXrdU0X3ecTYcGywFL92E87/j4EoRm0+Ur
 DMEhYlPa+M9XSyqAJG1u6pf3Fet7A0gNai7dDBnbqRWGww0DoNb30ulf4G9J3YldyFTJ
 SA3e/386X1BAV3vzpAMvhSAqjqIIa7BeqdPIDaq6cqnT2NzGPsqit4LXbkvud/h5RXhX
 o+Zw==
X-Gm-Message-State: AOAM532naDpkIQcCc+98/sfvLs25zGSnhgPVDgNRPQz+HX8A6Gz67VTM
 QJVnVhPYQNVIqmIBXbZSH4fw+Q==
X-Google-Smtp-Source: ABdhPJwtE1xg3i2XEUWpzIgykUSOge0kc0dLGL0c2VRqY2RHG1V3NJfzU+/Dqd4H5eRDupQ8EwPmxg==
X-Received: by 2002:aa7:8aca:0:b029:13e:d13d:a13e with SMTP id
 b10-20020aa78aca0000b029013ed13da13emr4198641pfd.38.1599866000196; 
 Fri, 11 Sep 2020 16:13:20 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l79sm3244337pfd.210.2020.09.11.16.13.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 16:13:19 -0700 (PDT)
Subject: Re: [PATCH] hw/block/nand: Decommission the NAND museum
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200814132118.12450-1-f4bug@amsat.org>
 <75f7421f-3ea4-ff6c-2c92-0ea9b5b8fdc1@amsat.org>
 <60cf8562-d0fc-7a3e-4988-a983394a5927@amsat.org>
 <c549f61d-fff9-542a-c30a-ec7558b1c37c@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <628f9011-654b-a694-9f19-b1bab78d1fa7@linaro.org>
Date: Fri, 11 Sep 2020 16:13:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c549f61d-fff9-542a-c30a-ec7558b1c37c@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/20 7:46 PM, Philippe Mathieu-Daudé wrote:
> ping^2
> 
> On 8/22/20 10:03 PM, Philippe Mathieu-Daudé wrote:
>> ping?
>>
>> On 8/14/20 3:23 PM, Philippe Mathieu-Daudé wrote:
>>> I forgot to Cc qemu-arm@, doing it now since most of the users
>>> of this are ARM machines.
>>>
>>> On 8/14/20 3:21 PM, Philippe Mathieu-Daudé wrote:
>>>> This is the QEMU equivalent of this Linux commit (but 7 years later):
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f7025a43a9da2
>>>>
>>>>     The MTD subsystem has its own small museum of ancient NANDs
>>>>     in a form of the CONFIG_MTD_NAND_MUSEUM_IDS configuration option.
>>>>     The museum contains stone age NANDs with 256 bytes pages, as well
>>>>     as iron age NANDs with 512 bytes per page and up to 8MiB page size.
>>>>
>>>>     It is with great sorrow that I inform you that the museum is being
>>>>     decommissioned. The MTD subsystem is out of budget for Kconfig
>>>>     options and already has too many of them, and there is a general
>>>>     kernel trend to simplify the configuration menu.
>>>>
>>>>     We remove the stone age exhibits along with closing the museum,
>>>>     but some of the iron age ones are transferred to the regular NAND
>>>>     depot. Namely, only those which have unique device IDs are
>>>>     transferred, and the ones which have conflicting device IDs are
>>>>     removed.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


>>>> ---
>>>>  hw/block/nand.c | 13 ++++++-------
>>>>  1 file changed, 6 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/hw/block/nand.c b/hw/block/nand.c
>>>> index 654e0cb5d1..7d7ccc9aa4 100644
>>>> --- a/hw/block/nand.c
>>>> +++ b/hw/block/nand.c
>>>> @@ -137,7 +137,7 @@ static void mem_and(uint8_t *dest, const uint8_t *src, size_t n)
>>>>  # define ADDR_SHIFT		16
>>>>  # include "nand.c"
>>>>  
>>>> -/* Information based on Linux drivers/mtd/nand/nand_ids.c */
>>>> +/* Information based on Linux drivers/mtd/nand/raw/nand_ids.c */
>>>>  static const struct {
>>>>      int size;
>>>>      int width;
>>>> @@ -153,15 +153,14 @@ static const struct {
>>>>      [0xe8] = { 1,	8,	8, 4, 0 },
>>>>      [0xec] = { 1,	8,	8, 4, 0 },
>>>>      [0xea] = { 2,	8,	8, 4, 0 },
>>>> -    [0xd5] = { 4,	8,	9, 4, 0 },
>>>>      [0xe3] = { 4,	8,	9, 4, 0 },
>>>>      [0xe5] = { 4,	8,	9, 4, 0 },
>>>> -    [0xd6] = { 8,	8,	9, 4, 0 },
>>>>  
>>>> -    [0x39] = { 8,	8,	9, 4, 0 },
>>>> -    [0xe6] = { 8,	8,	9, 4, 0 },
>>>> -    [0x49] = { 8,	16,	9, 4, NAND_BUSWIDTH_16 },
>>>> -    [0x59] = { 8,	16,	9, 4, NAND_BUSWIDTH_16 },
>>>> +    [0x6b] = { 4,        8,        9, 4, 0 },
>>>> +    [0xe3] = { 4,        8,        9, 4, 0 },
>>>> +    [0xe5] = { 4,        8,        9, 4, 0 },
>>>> +    [0xd6] = { 8,        8,        9, 4, 0 },
>>>> +    [0xe6] = { 8,        8,        9, 4, 0 },
>>>>  
>>>>      [0x33] = { 16,	8,	9, 5, 0 },
>>>>      [0x73] = { 16,	8,	9, 5, 0 },
>>>>
>>>
>>
> 


