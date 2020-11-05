Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA22EC4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A7F9206FA
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 15:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T3EMPN6v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A7F9206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kahVv-0006DV-8J
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 10:49:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thatlemon@gmail.com>)
 id 1kahUu-0004sa-FY
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:48:24 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <thatlemon@gmail.com>)
 id 1kahUs-0007Bo-GT
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 10:48:24 -0500
Received: by mail-wm1-x343.google.com with SMTP id h62so2063462wme.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 07:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lDgfSgOImud1CjAJ4IUlyzYJqxPIJjeWJz3gXjAPnGQ=;
 b=T3EMPN6vfUJ6tToJK2vPQDaVR0xDCzGiRejsYA7aqyjF+5/3WhE2h5NnH/4bq/FJar
 rDol74W/623BjM36oRzBHv+uPxK6lq5HYqn3JJ4aB3czgqU1QHEqfZLSBXxFE98b6YLc
 NhtTowOd0aanMdKk309ze7LSgMwqHsB8EltcHDBNFofSonhRssdhObNggywyiVgXaLHw
 dZ3CqtB9ATlSs3UoyTS7fjs/R6iqapMJC3xi+rC/qjHbHkXtMvIDNVD7PIdC1a4W4JC2
 buM3kEVnvOIc0e2L0c/oxyG46Z1FZePX2M+HxsmJUC/gAq/mMrlTXpY+K/NQOYMwibn1
 d8AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lDgfSgOImud1CjAJ4IUlyzYJqxPIJjeWJz3gXjAPnGQ=;
 b=LhDeSTyLUdeiVODgmjwNvpo12Ems9dBv3CG5+b6fnzrFbC4/Ras1+RUoVH0Wfb8IQW
 8IIjUgwfRgmjdxF6B/JfeVVoj2ljGy0wvf6UbKKwTIUeY57JQOdejz2BGpS4b3TSPqV4
 +nMHuKTwsglURZh6Klswfkf7FnpDI4kTyaq3ev3X+sHg9ypTpl4OBgaG67zXqKxzAprs
 +LD4mEGgILOCVoCjTURDleFUS8/pG8xYRxDk++CSKtAsRiHzKJy9BUM3JtYNqK0DFMdd
 rn5yRPd5sGB4c3Fcaldy161tcURZPfSbZi1XyfkqFNf+AQubGHqlIl78q4SO1u/FEbzk
 2VPg==
X-Gm-Message-State: AOAM5302HXj2jK95GruEF9/e3ihjpwpS9JsQchtVxDMF1T996zBdM13L
 OV0tcFd9yT1hjXKNEFGsJMi8ZAvomeKHnQ==
X-Google-Smtp-Source: ABdhPJyIzAXcxe4eyItAmWVDeeNkMaPnF45OcPqgWkmENOhFxKWMNZhVpEJ+70kreRtZ6DQfDhj7hA==
X-Received: by 2002:a1c:6302:: with SMTP id x2mr3630172wmb.121.1604591300855; 
 Thu, 05 Nov 2020 07:48:20 -0800 (PST)
Received: from [192.168.1.103] ([151.33.227.77])
 by smtp.gmail.com with ESMTPSA id z2sm2890160wmf.45.2020.11.05.07.48.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 07:48:20 -0800 (PST)
Subject: Re: [PATCH] linux-user: Correct definition of stack_t
To: Peter Maydell <peter.maydell@linaro.org>
References: <bf2b4da4-385d-a0f7-7915-4f31fa797898@gmail.com>
 <CAFEAcA94OTo=FT6yWVod6SYNEzowQ9ee8kKcih=q1T7TTrYBBw@mail.gmail.com>
From: LemonBoy <thatlemon@gmail.com>
Message-ID: <85656394-930c-cd95-df9b-4a6754f83c84@gmail.com>
Date: Thu, 5 Nov 2020 16:48:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA94OTo=FT6yWVod6SYNEzowQ9ee8kKcih=q1T7TTrYBBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=thatlemon@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 05/11/20 16:16, Peter Maydell wrote:
> On Thu, 5 Nov 2020 at 14:55, LemonBoy <thatlemon@gmail.com> wrote:
>>
>> From 914c30863b45d6fcd3e2fc83929bcac546be1555 Mon Sep 17 00:00:00 2001
>> From: LemonBoy <thatlemon@gmail.com>
>> Date: Thu, 5 Nov 2020 15:48:24 +0100
>> Subject: [PATCH] linux-user: Correct definition of stack_t
>>
>> Some platforms used the wrong definition of stack_t where the flags and
>> size fields were swapped or where the flags field had type ulong instead
>> of int.
> 
> Coincidentally, I just noticed this yesterday (am in the middle of
> trying to debug why qemu-sparc64 crashes trying to start bash...)
> 

What an interesting coincidence, I also stumbled across this bug while
debugging a crash with some sparc64 binary.

>> Due to the presence of padding space in the structure and the prevalence
>> of little-endian machines this problem went unnoticed for a long time.
>>
>> The type definitions have been cross-checked with the ones defined in
>> the Linux kernel v5.9, plus some older versions for a few architecture
>> that have been removed and Xilinx's kernel fork for NiosII [1].
>>
>> The microblaze header and the bsd-user ones remain unchanged as I don't
>> know if they are wrong or not.
> 
> As far as I can tell, Microblaze doesn't define its own stack_t,
> so it must be using the asm-generic one,  so I think it also needs
> changing.
> 

I'll change it and send an updated patch ASAP.

>> [1] https://github.com/Xilinx/linux-xlnx/blob/master/arch/nios2/include/uapi/asm/signal.h
> 
>> Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
> 
> Other than also changing microblaze,
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM
> 

