Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE00C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7442F20848
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 16:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjzzfTM0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7442F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTSzT-0003Zc-HO
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 12:54:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTSxg-0002e1-4E; Fri, 16 Oct 2020 12:52:12 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTSxb-0004cZ-Ap; Fri, 16 Oct 2020 12:52:11 -0400
Received: by mail-wm1-x344.google.com with SMTP id e2so3665018wme.1;
 Fri, 16 Oct 2020 09:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sRf9Ps61BKo83USYQLTS5k20oTNuJo/3BYwIz+X6IQ4=;
 b=TjzzfTM0UzHOnGPemCUboc/rFzfRp3Ja+FXhzHQC6Smqn905myHnFeHhM4VmHv3kD2
 cJ75DX3SC4r6v2R0JuZ4wj4U8WqhCuKSlS+uYUIQa1CLA7eqJtPUSyfqNBODZEMu/ua4
 boFURnyKD/aCRXgAisLVM0zrIbKjvYupxJeKbf6iD46ObZrUjdgZCZvD1YvZ7c8yzRHb
 FYJHZHiXRiOGAqkFEI2g6nTV6wViZwhBIt8RqTQW5jc10LQFDYE7UTh2Y+3ehWll0SLD
 E/neiIa+nCtt0Emc2qFoDjdVu0I1ZsUsaUbsQ7L5fB+m2ZQqPPil726kQgN1lCelHN0A
 8yZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:from:to:cc:references:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sRf9Ps61BKo83USYQLTS5k20oTNuJo/3BYwIz+X6IQ4=;
 b=kI5XrCXuE96UJDymOGz5/G/JTG5R17jGLus95pKYbswy1rmJEV67Xxh8KU08ph8YHc
 xQEFZPfouJ/Dwqv0zL+DFu3HBMIxXpygnR9pfFxZOQ4aL1vOlkXE85nA0KWU06fLEdMN
 febPtSYV1jFwUqYjMADVGWaiJJwE0NimE1QoGMGP1OlPxzlKQFFx8+VifOotnyzTD9P7
 K86Ji1pLtJ2R/rc8HpwjOb58l44I1q+Ei6AQGQI0F6q9ZFa+6iow/73pKshoIS6A3WQU
 gx2EuWMJ8e6pdBJVgk0TdcCbJX0ewarY1ryXxia9r6khp6gLcIqvZFArEAjWnIPdRTt7
 0xmw==
X-Gm-Message-State: AOAM531yHnzMYkvBv86EER1DnQrjaoEUrKeykTGFPbFTDdzB1DdCiqnP
 CKpKwGYlcZmxzwL+Vmm+mZo=
X-Google-Smtp-Source: ABdhPJxRcRj1+Zy2QA9hKJXvEDeN4YpIyOgGKbzzhnK2z8zcNsDkSAKF1T36iCTeDF2sILHoygImQg==
X-Received: by 2002:a1c:7dc5:: with SMTP id y188mr4550966wmc.37.1602867125108; 
 Fri, 16 Oct 2020 09:52:05 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id a3sm3263812wmb.46.2020.10.16.09.52.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 09:52:04 -0700 (PDT)
Subject: Re: [PATCH v2] hw/block/nand: Decommission the NAND museum
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20200915171639.1355800-1-f4bug@amsat.org>
 <619d329d-f6b3-1e73-e151-a58e366db15d@amsat.org>
 <3647a01c-0932-3446-9bc7-e138ced496dd@amsat.org>
Message-ID: <f89e9e7d-5ab3-769a-f3d8-22fc05d80af6@amsat.org>
Date: Fri, 16 Oct 2020 18:52:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <3647a01c-0932-3446-9bc7-e138ced496dd@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Cc'ing qemu-trivial@ since this patch is reviewed.

On 10/15/20 8:12 PM, Philippe Mathieu-Daudé wrote:
> ping^2...
> 
> On 10/1/20 7:31 PM, Philippe Mathieu-Daudé wrote:
>> ping qemu-block or qemu-arm?
>>
>> On 9/15/20 7:16 PM, Philippe Mathieu-Daudé wrote:
>>> This is the QEMU equivalent of this Linux commit (but 7 years later):
>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f7025a43a9da2 
>>>
>>>
>>>      The MTD subsystem has its own small museum of ancient NANDs
>>>      in a form of the CONFIG_MTD_NAND_MUSEUM_IDS configuration option.
>>>      The museum contains stone age NANDs with 256 bytes pages, as well
>>>      as iron age NANDs with 512 bytes per page and up to 8MiB page size.
>>>
>>>      It is with great sorrow that I inform you that the museum is being
>>>      decommissioned. The MTD subsystem is out of budget for Kconfig
>>>      options and already has too many of them, and there is a general
>>>      kernel trend to simplify the configuration menu.
>>>
>>>      We remove the stone age exhibits along with closing the museum,
>>>      but some of the iron age ones are transferred to the regular NAND
>>>      depot. Namely, only those which have unique device IDs are
>>>      transferred, and the ones which have conflicting device IDs are
>>>      removed.
>>>
>>> The machine using this device are:
>>> - axis-dev88
>>> - tosa (via tc6393xb_init)
>>> - spitz based (akita, borzoi, terrier)
>>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>> Peter, as 4 of the 5 machines are ARM-based, can this go via your tree?
>>> ---
>>>   hw/block/nand.c | 13 ++++++-------
>>>   1 file changed, 6 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/hw/block/nand.c b/hw/block/nand.c
>>> index 5c8112ed5a4..5f01ba2bc44 100644
>>> --- a/hw/block/nand.c
>>> +++ b/hw/block/nand.c
>>> @@ -138,7 +138,7 @@ static void mem_and(uint8_t *dest, const uint8_t 
>>> *src, size_t n)
>>>   # define ADDR_SHIFT        16
>>>   # include "nand.c"
>>> -/* Information based on Linux drivers/mtd/nand/nand_ids.c */
>>> +/* Information based on Linux drivers/mtd/nand/raw/nand_ids.c */
>>>   static const struct {
>>>       int size;
>>>       int width;
>>> @@ -154,15 +154,14 @@ static const struct {
>>>       [0xe8] = { 1,    8,    8, 4, 0 },
>>>       [0xec] = { 1,    8,    8, 4, 0 },
>>>       [0xea] = { 2,    8,    8, 4, 0 },
>>> -    [0xd5] = { 4,    8,    9, 4, 0 },
>>>       [0xe3] = { 4,    8,    9, 4, 0 },
>>>       [0xe5] = { 4,    8,    9, 4, 0 },
>>> -    [0xd6] = { 8,    8,    9, 4, 0 },
>>> -    [0x39] = { 8,    8,    9, 4, 0 },
>>> -    [0xe6] = { 8,    8,    9, 4, 0 },
>>> -    [0x49] = { 8,    16,    9, 4, NAND_BUSWIDTH_16 },
>>> -    [0x59] = { 8,    16,    9, 4, NAND_BUSWIDTH_16 },
>>> +    [0x6b] = { 4,        8,        9, 4, 0 },
>>> +    [0xe3] = { 4,        8,        9, 4, 0 },
>>> +    [0xe5] = { 4,        8,        9, 4, 0 },
>>> +    [0xd6] = { 8,        8,        9, 4, 0 },
>>> +    [0xe6] = { 8,        8,        9, 4, 0 },
>>>       [0x33] = { 16,    8,    9, 5, 0 },
>>>       [0x73] = { 16,    8,    9, 5, 0 },
>>>
>>
> 

