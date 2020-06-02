Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 960C9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:09:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FD1206C3
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 17:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmghepCX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FD1206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgAPU-0002l5-KQ
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 13:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgAKx-0002ne-7p
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:04:27 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33505)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jgAKw-0007jC-9n
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 13:04:26 -0400
Received: by mail-wr1-x444.google.com with SMTP id l11so4181768wru.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 10:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TAtBZ9LmSFvncfGWbBMfAxu7cgDs/GE8yqsBZ01qbP4=;
 b=lmghepCXGvtjgefjAoeBRLPiCM7QQb99s+UhOd5cL0QkrECbbeQDVsPTVAT2M0vr6W
 8gUS9Z0Jw3fk9hy50EZo8VhJbiMuKyY6hQEuyAKZHjS85JmFyMsK/SDjLXbfI0+3g5tQ
 9p/Sqq5buJ7i9B/YZwp41eCKwEc8radjww7siGGxFXhMkimQmwbhQLUHxeMfQBq4+97B
 u395TApVP4ELTk4Ay1g9Rra7loim6+MnG0bacWbkegnslPE+Mkboi7GpYZtEaWlz9erw
 UdtiAYc0y4BuFBQr24zeAetnzLAtqpqbl+N2FhIdtSXxf2SFCc28R/sLVe0NyZ8obOa9
 hV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TAtBZ9LmSFvncfGWbBMfAxu7cgDs/GE8yqsBZ01qbP4=;
 b=eXMeYlLpQdBkGOgD1GkvsiFf6V4S+ZTHX5XGs0IDhfuouQso4MiJgVE1Zw94eEmFR4
 m9pBjsjJJ+6jR1+uIN9m4380YJuTK8DQyRA+6ZnuXsCO+xp6EVcuZmCb7WE8jbSBrYAE
 275Bv5+cainxEjMMPkUZp6ytWOjY0bRqqSyoonY5UepCZ/1TmQXiLHSUllKybDtWIjox
 4MYcCKrhBdn8P8QjFrN24XPxWQ8VeHI6tl0jOvkSNXgHPGVunlaBtJ2987uGi8uC6GV3
 ESw09mGhXqzzHDRJNFC4bHSg8LrBCKplgRjnwO4RKzCzDRGQ/fKbMGrOfAApOb/x21AQ
 MFYw==
X-Gm-Message-State: AOAM530VIH91SFaHv56srr1frVOvweAlB22Y/gp8AtGzGG9AIee22Wpw
 rK05UpRkL547bKrPD/Etzgc=
X-Google-Smtp-Source: ABdhPJwo4KkU4tA/K9NXUTGuFa6mcelry0WdFYGB1CF62u0GzaHNWtqXUo6oMraGrQPIiIHQuoGJPQ==
X-Received: by 2002:a5d:6986:: with SMTP id g6mr28166232wru.27.1591117464472; 
 Tue, 02 Jun 2020 10:04:24 -0700 (PDT)
Received: from [192.168.1.43] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id q128sm467243wma.38.2020.06.02.10.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 10:04:23 -0700 (PDT)
Subject: Re: [PATCH 00/10] Add RX hardware emulation
To: Yoshinori Sato <ysato@users.sourceforge.jp>
References: <20200531162427.57410-1-ysato@users.sourceforge.jp>
 <d7fc8b59-5a22-8383-b939-1cc73f8c2e66@amsat.org>
 <87zh9mn9g5.wl-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b0c9bbb1-1a4f-e682-7d0a-ea622fc5a1af@amsat.org>
Date: Tue, 2 Jun 2020 19:04:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87zh9mn9g5.wl-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Yoshinori,

On 6/1/20 4:32 PM, Yoshinori Sato wrote:
> On Mon, 01 Jun 2020 01:45:47 +0900,
> Philippe Mathieu-Daudé wrote:
>>
>> On 5/31/20 6:24 PM, Yoshinori Sato wrote:
>>> Hello.
>>>
>>> This series add to hardware emulation module for RX target.
>>>
>>> Details below.
>>> Interrupt controller, 8bit timer, 16bit comapare match timer and
>>> SCI is RX62N integrated peripheral.
>>> rx-virt - RX62N MCU and external RAM. It like gdb simulator.
>>>
>>> The compare match timer has a CPU interface similar to the SH4 timer.
>>> sh_timer will be deprecated and integrated into this module.
>>> SCI is also implemented in sh_serial, but the functionality is omitted.
>>> I implemented the complete one as renesas_sci.
>>>
>>> git repository here.
>>> git://git.pf.osdn.net/gitroot/y/ys/ysato/qemu.git tags/hw-rx-20200601
>>
>> Sigh. It is a bit unfortunate and demotivating that we can not
>> coordinate this. I was going to send a pre-merge for this today.
>>
>> What is positive is you unified some SH4/RX peripherals.
>>
>> I'll try to merge both series. If it takes too long, I might send my
>> current queue for you to review, then go back to this one you just sent.
>>
>> Regards,
>>
>> Phil.
>>
> 
> Oh. Sorry.
> 
> The old code had some spec differences.
> I have fixed those mistakes here.

Yes, I am glad to see how it evolved, in particular how you merged the
SH4/RX common peripherals :)

> 
> I would like to merge this if possible.

I posted the v33 of your v32:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg708317.html

As it is mostly reviewed and tested, it seems more reasonable to merge
what is reviewed, and then apply your latest patches on top. It took us
already a long time to get there, and I'd not start again to review 30
more times this version.

I believe if would be easier this way, you review/ack the v33 and we get
the peripheral cleanup on top. My 2 cents, feel free to disagree and
insist on restarting the whole review process.

Regards,

Phil.

