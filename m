Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D13B0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 07:40:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C4AA23333
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 07:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tAznm8hA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4AA23333
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47772 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpoPJ-0004JO-VB
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 03:40:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpoOh-0003rF-3v
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 03:40:11 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52237)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jpoOf-0004qI-Go
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 03:40:10 -0400
Received: by mail-wm1-x342.google.com with SMTP id q15so14375590wmj.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 00:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=BPektP+Uh+GYLL9y4lVexxIG0AVJqTFfTTfU+psZ+FM=;
 b=tAznm8hA117jzoA4fWeHsLru1B+NED+K03sxo4hZnH4FfxvZ7phXzCu5hxz08p9BTi
 WfiqkYCPjjIoxfnSyYRaMOfiu1YvX/b4YFPm7k1oe0CKI8szgxijT6/AEwKGi5ch7qSU
 GrDkUEim4MgeeKJF68MHxQuDA3NUl22EMVOCZojeC6JMyUoG4cHB0Qs7SXhaARsnKSaF
 OnK3y8LAS7ujJmcRbkrA7VHbKWxQ6cKEG8DdCYUbP/r9Ld1riFrvL0seGoQ9liugdnZD
 +pM4BJT0+dYOQ3TZhYHjgZeJm/ZI3yo3lui4LTblnV/hpKjmJmgG7fMd9IGEKUZI1usM
 R8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=BPektP+Uh+GYLL9y4lVexxIG0AVJqTFfTTfU+psZ+FM=;
 b=dYIUYjFq1LPmWRmbc4zMJiJVZMWfUP6iOeYhILawHaywtOol/Hv7W+gl+cg3vr30pr
 CYT96fZtd2nzd+3ft7/51efhA2bWB0V+d5KBm+OUcW5lY3YTtHM24oizg96dF/eudC9K
 39C5BrCNgIWqNl0dqHA1OP30IlxqhwjGFvDeat+WaQo9kSgOAsy1Y4SzCJKYXgf3S/70
 eeRd3MB9HndwFIj9PMLNU5CUBNTWGvMt0etIn1HxLQjQqT0wTfHbVVaGVt2sSwXnCvNY
 ZE3wbZPa9ZVZShqgNWWEa7wKxGqm6cuTgeyC1Kq05xzpQzNJpba0Ge1ftZ4CCEJZWh2J
 1+LA==
X-Gm-Message-State: AOAM530kWxdM42NxPwX3v+CEzgEQ3VE3EleNA46DnuYIrkw8lv96W//a
 ixweZ1QgnChvGuu+leh4JKzDU1rJ4lA=
X-Google-Smtp-Source: ABdhPJwl5ibcVpp2OEgR4SDm5D7Yd8VQ1MynyuydBi5PhRq/80WTxN/tGn2dSrd0HkxxqsTA7SRC8A==
X-Received: by 2002:a1c:31c6:: with SMTP id
 x189mr14727153wmx.182.1593416407723; 
 Mon, 29 Jun 2020 00:40:07 -0700 (PDT)
Received: from [192.168.1.37] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id d18sm14099336wrj.8.2020.06.29.00.40.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2020 00:40:07 -0700 (PDT)
Subject: Re: Crash when running Qemu.
To: Peter Maydell <peter.maydell@linaro.org>,
 Jean-Christophe DUBOIS <jcd@tribudubois.net>
References: <20d398f5-729e-57a7-db92-2243c106d832@tribudubois.net>
 <CAFEAcA8wfgQxAzr_MJ+wr6XXKAHGRx5i0SXA44XDbHhum5JEwQ@mail.gmail.com>
 <2f7b2149-f671-a814-8ed7-4fb3aa885429@tribudubois.net>
 <CAFEAcA_CBcvCmjYt=jgd-RXja4vYbWcQ87=xNoGVuUkr7FBrsQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <11dfd675-6ef5-3773-c0ef-148ae60c72c9@amsat.org>
Date: Mon, 29 Jun 2020 09:40:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_CBcvCmjYt=jgd-RXja4vYbWcQ87=xNoGVuUkr7FBrsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/28/20 7:05 PM, Peter Maydell wrote:
> On Sun, 28 Jun 2020 at 17:46, Jean-Christophe DUBOIS
> <jcd@tribudubois.net> wrote:
>>
>> Le 28/06/2020 à 16:38, Peter Maydell a écrit :
>>> On Sun, 28 Jun 2020 at 11:56, Jean-Christophe DUBOIS
>>> <jcd@tribudubois.net> wrote:
>>>> jcd@jcd-UX305CA:~/Projects/µCOS/work$
>>>> ../../qemu/qemu/arm-softmmu/qemu-system-arm -machine mcimx6ul-evk -m
>>>> 128M -display none -serial stdio -kernel ./OS.elf
>>>> double free or corruption (!prev)
>>>> Abandon (core dumped)
>>> I can't repro using your command line but without the -kernel option,
>>> so it's probably specific to something your guest code is doing.
>>> I tested with git commit e7651153a8801dad6; which commit are you
>>> using?
>>
>> I was on master (553cf5d7c47bee05a3dec9461c1f8430316d516b)
>>
>> Reverting the June 23rd commit series on PCA9552 fixed the problem for me.
>>
>>> Can you provide either the elf file or a repro example that
>>> doesn't need it ?
>>
>> Please, find the OS.elf file as attachment.
> 
> Ah, thanks for tracking that down. Philippe, the valgrind
> error in Jean-Christophe's other email in this thread suggests
> something's wrong in the typeinfo or the class init for the
> pca9552 changes you've made -- would you mind having a look at it?

Oops... sure!

