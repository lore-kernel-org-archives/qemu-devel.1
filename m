Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F026CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFA2920772
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzN7l0ex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA2920772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtphU-0003xj-2n
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:52:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtpgp-00035u-QW; Fri, 10 Jul 2020 05:51:31 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51396)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtpgo-00076B-Ck; Fri, 10 Jul 2020 05:51:31 -0400
Received: by mail-wm1-x341.google.com with SMTP id 22so5466562wmg.1;
 Fri, 10 Jul 2020 02:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kUb43I6NVsZfyoypkRi2RaPQxrWf7k6QCnIyz9rIGb8=;
 b=FzN7l0ex1wYVU06w+J6mGNKZP2Ge5dO/gs0tlR0l9oNTbLwwIhAzCvsSNRFlao8yQd
 ZghnIeDxawAwfLG63kxpGJTjo1kKYHDcacL/XVvs3j+E0uZxolLcnjAgUuwHtmwSAmG6
 IB2S5xb+6vFbhkMkCCmb1hnrvWaA4CV9OXejCXjvBqBxe4vmkv2bpe12M8Am4oqQv7H/
 iplsVMJIGzFMrDKamEg1iCYcAV7mEnYHTfla3/iLbY4EsYvtiE0357WPZgOuOd4ljNNB
 sYPUeQo72wljpMCeW03rQbBv0E1w7tDQIITS0NTqREy3S6exWUkW/OC5u1sK4NOqkAY5
 KFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kUb43I6NVsZfyoypkRi2RaPQxrWf7k6QCnIyz9rIGb8=;
 b=tlZw7C8UAVVGboBKQ/Z/4661K5LX7LUpqBXnD0vdikGW82xYhyWrYiN4hek5eMhhfo
 v0s1FkMipnY6/NLIzf9TDQlYGR+b8JzlwhKID/1m9VnYiIrpBUxPWg/z6DmfjkGaxf/W
 TponCvw90mv9+xQlL8uAvOKL55m4jjPlQB7/A6IewnZhiCdbXlF0Ga7TRYqcWMg2WQ0m
 cPZ5kt3r+t0/qZncCEeytxE6pHD2OdPZbU2bMfRIEmZfvFy66jq63MrzNyFUPWrqGUfB
 6rJRTu1QyAIElUJJrW+yKOiWj5B2UNdVLMTbxATQVf7/pro2HIxiRX0GEhJhiia7Nk8a
 R0Hw==
X-Gm-Message-State: AOAM530DvqiGmaWaSX26lXLs5nvRFu+BvOUPRyBf2h3RgUS4iSi/R4Sn
 U9goPfYD3eiAq1X7GQ0ynwR7tOX0sCs=
X-Google-Smtp-Source: ABdhPJyvRm5uxD/BFfztU1XuKhGRe8fB7c3K2DooHVwPKO4eBHp0wXkN53t5EOSuFOocxyRXZ5yZ9w==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr4141260wmj.57.1594374688091;
 Fri, 10 Jul 2020 02:51:28 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id g14sm10117685wrw.83.2020.07.10.02.51.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2020 02:51:27 -0700 (PDT)
Subject: Re: [PATCH] hw/register: Document register_init_block @memory_size
To: Laurent Vivier <laurent@vivier.eu>, Alistair Francis <alistair23@gmail.com>
References: <20200707062308.4531-1-f4bug@amsat.org>
 <772cb98e-865c-0c75-ffa2-60773a6df2dd@vivier.eu>
 <CAKmqyKOebG+=vFMXoNKA+4A__hq5srKV6oGa1TOcmiaLYUgTww@mail.gmail.com>
 <444a1458-6de4-b963-9d8b-914ae6c50033@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <fc37f085-b94d-18aa-9d1f-a4c5a873456e@amsat.org>
Date: Fri, 10 Jul 2020 11:51:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <444a1458-6de4-b963-9d8b-914ae6c50033@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/9/20 10:17 PM, Laurent Vivier wrote:
> Le 09/07/2020 à 19:19, Alistair Francis a écrit :
>> On Wed, Jul 8, 2020 at 5:43 AM Laurent Vivier <laurent@vivier.eu> wrote:
>>>
>>> Le 07/07/2020 à 08:23, Philippe Mathieu-Daudé a écrit :
>>>> Document the 'memory_size' argument of register_init_block().
>>>>
>>>> Fixes: a74229597e ("register: Add block initialise helper")
>>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>>> ---
>>>>  include/hw/register.h | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/include/hw/register.h b/include/hw/register.h
>>>> index 5d2c565ae0..fdac5e69b5 100644
>>>> --- a/include/hw/register.h
>>>> +++ b/include/hw/register.h
>>>> @@ -181,6 +181,7 @@ uint64_t register_read_memory(void *opaque, hwaddr addr, unsigned size);
>>>>   * @data: Array to use for register data, must already be allocated
>>>>   * @ops: Memory region ops to access registers.
>>>>   * @debug enabled: turn on/off verbose debug information
>>>> + * @memory_size: Size of the memory region
>>>>   * returns: A structure containing all of the registers and an initialized
>>>>   *          memory region (r_array->mem) the caller should add to a container.
>>>>   */
>>>>
>>>
>>> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
>>
>> Can this go via the trivial tree?
>>
> 
> Yes, I will try to do a PR before the hard freeze.

No rush, if there is nothing else in your queue
you can safely keep this for 5.2 ;)

