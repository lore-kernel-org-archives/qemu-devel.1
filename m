Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB37C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:13:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C99C420734
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 12:13:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RqT+qYmV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C99C420734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jizbY-0004Kz-2o
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 08:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jizUu-0002R0-4C; Wed, 10 Jun 2020 08:06:24 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35693)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jizUs-0004s3-UP; Wed, 10 Jun 2020 08:06:23 -0400
Received: by mail-wm1-x341.google.com with SMTP id q25so1601258wmj.0;
 Wed, 10 Jun 2020 05:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EYiwOCPGoH4QL4obrdsR0/VwwDZDDBEVLLPNRHJRRYk=;
 b=RqT+qYmVdEWSvhYLuuc0yogGzkbXfqiCrthkSFHzUnRtkfsasSQAP6uF+6gD9d7U1r
 pot9DHAhHEWFOafY9zFTW+4n9K1V+xAKBzHFyI2uNC59hzqTnc8dukX9j3Jd7SUZHcZi
 ksrDe94YTxjaZbDqxMIGcKBxnAJ3u9Oc9PdaO8JH+wHpeRHSmjvF4z9SuOquxUbCo9Op
 Yx3O23xnx7YRgo/rgY72nuL0k3nMwUlyuBI+nb8VrYU3msLdBxeIMKwRwV/Ci7i5/2nO
 ABhoauDSUa7cEdq2iZIlKs7aNl/lPosAq+IjbTaDGYhpSw4wuoQyXH4u1WRoxF4jPgJx
 7KLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EYiwOCPGoH4QL4obrdsR0/VwwDZDDBEVLLPNRHJRRYk=;
 b=aHMviyPbuy+vMsqRkjr8RAU4xyyv/kTb/c1o4LliyHM1vOOMrEESrhSki2Blx8FBLc
 EEPpna5wzrQAks1RDMCPLuJ0LERD5HVeXxanYJJ7GChP9yX6sJOtKolfHRxcGH/vN4Je
 ZmXl//AFtV/KSgxx2u2G2TcwfYuxmgUdzdHnB7gIUYHFGv0UeFqCtRRyUtejq/bvDBkY
 foiResGcLSZLFKHMerRhn2osc3/N+/TicUdyFyqusbV9+xJuVsqIjYnzkCj8J3xt53zC
 pAjWXFlPAmVudLwpU92bGLYGtbTXmIBIGAV/ADv1b0RJhrLfCGtmNtjwxLkc3KZenB8R
 0DnA==
X-Gm-Message-State: AOAM531H4HF7XZWWbqkbPuQBYelOmI/T0xoOzJjnQ8y5xnyVC9uVxfob
 QaTkFcXQzV8eti+G9nSPqDI=
X-Google-Smtp-Source: ABdhPJzBGLW2YIicCwNMpYS8Uw5lsG/q8bRzyorlRAZNIR+gMnqNv0znJ+APqf8BiZVL4TwTsWm6HQ==
X-Received: by 2002:a1c:1f4d:: with SMTP id f74mr2753607wmf.12.1591790769992; 
 Wed, 10 Jun 2020 05:06:09 -0700 (PDT)
Received: from [192.168.1.38] (181.red-88-10-103.dynamicip.rima-tde.net.
 [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id d18sm7851366wrn.34.2020.06.10.05.06.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jun 2020 05:06:09 -0700 (PDT)
Subject: Re: [PATCH v2 1/8] MAINTAINERS: Mark SH4 hardware orphan
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <20200608090142.6793-1-f4bug@amsat.org>
 <20200608090142.6793-2-f4bug@amsat.org>
 <CAHiYmc5UUaSKB6Ee0ds_hj0FBTzt0iLxzNWySt0mcZ9dvtZNyA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2503a468-d343-b40a-bf4e-628f3e8f56e3@amsat.org>
Date: Wed, 10 Jun 2020 14:06:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHiYmc5UUaSKB6Ee0ds_hj0FBTzt0iLxzNWySt0mcZ9dvtZNyA@mail.gmail.com>
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
Cc: Fam Zheng <fam@euphon.net>, Thomas Huth <thuth@redhat.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/10/20 1:08 PM, Aleksandar Markovic wrote:
> пон, 8. јун 2020. у 11:05 Philippe Mathieu-Daudé <f4bug@amsat.org> је
> написао/ла:
>>
>> Aurelien Jarno expressed his desire to orphan the SH4 hardware [*]:
>>
>>   I don't mind being [...] removed from there.
>>   I do not really have time to work on that.
>>
>> Mark the SH4 emulated hardware orphan.
>>
>> Many thanks to Aurelien for his substantial contributions to QEMU,
>> and for maintaining the SH4 hardware for various years!
>>
>> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg708400.html
>>
>> Message-Id: <20200601214125.GA1924990@aurel32.net>
>> Acked-by: Aurelien Jarno <aurelien@aurel32.net>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>> ---
> 
> The basic idea of the patch (as read from the title and the commit
> message) is good and positive.
> 
> The problem is that the patch does something different than the commit
> message says - pretending that it just orphans something. Which is not
> good. Actually, very clumsy and bad.

I can improve my English (actually I am trying, I started to take
lessons 2 years ago). Remember it is not easy for non native English
speaker to elaborate non-technical topics.
As a side note, it is also hard sometimes to understand contributors who
uses a very advanced English level with fancy words, as we have to take
the time to translate to understand. Even if we learn new word, this is
not often the best use of our time.

> It creates a whole new subsection in MAINTAINERS file (not said in the
> commit message), without any consistency with the current organization
> in the file. That new subsection looks completely misplaced, living
> with "TCG CPUs" neighbours. On top of that, it creates a new
> precedent, leaving many unanswered questions, like: Should other
> targets follow the same pattern?

If you look at git-log history, you'll see at the beginning there
were not much separations in directories. Everything was altogether.
Adding a new machine meant add the TCG emulation code and the hardware.
The contributor adding TCG emulation was doing the harder work,
usually doing it for a particular machine (hardware). Then other
contributors could add other machines, and were maintaining only
their machines. See commit b6f97c14f59 importing the short
MAINTAINERS from SVN. It was already split in 3 broad categories:
- TCG cores
- Machines / Hardware
- Subsystems (the rest)

In October 2010 (fd5d5c566af0) Anthony Liguori rewrote MAINTAINERS
using Linux style tags.

In January 2011 (42f5a7e9367) Aurelien Jarno clarified the
difference between the TCG host part (backend, under the tcg/
directory) VS the target part (frontend, under target/).

Then the project grew, and eventually in May 2012 Paolo Bonzini
started to clean, by moving files into "subsystem" directories
(see 5e8861a0361..c353f261946). In March 2013 he followed by
splitting various hardware files from the hw/ directory
(see 0d09e41a51a..47b43a1f414).

In November 2013 (f05b328c9d8) Stefan Hajnoczi clarified the
importance of the 'block' subsystem (later completed in
commit e7c6e631b1 in April 2015).

2015 still, Paolo keeps cleaning (c17652ee409 cover the
TCG backend disassembler, 062710000db introduce Peter
Maydell for the ARM hardware).

In October 2018 Thomas Huth added the target/ folder
(commit fcf5ef2ab).

Recently last year (6347e1f1cc7) Markus Armbruster tried
to better describe the TCG frontend ("Overall TCG CPUs")
and backend ("TCG target") differences.


So while the difference between TCG emulation (or other
accelerators, KVM, ...) versus the hardware emulation is
not perfect, there is a separation (and the community
failed at clarifying it).

You can see when you were introduced as maintainer for the
MIPS target (commit c92023bfd) you were also added as
maintainer of the MIPSSIM and Fuloong 2E machines.

In commit 485cd9820 you volunteered to maintain the Malta
machine, so I believe you have a good understanding about
the difference between target code and hardware code.

> 
> I personally think that creating a new subsection is just a code
> churn, waste of everybody's time on unimportant things.

Eh... I read that after spending 1h writing the previous
paragraph. Yes, you are right.

> 
> Wouldn't it be simpler that you just changed statuses of all Aurelien
> sh4 sections to "Orphaned", as he already said he approves, and leave
> sh4 sections reorganization to a future maintainer?
> 
> If you really want to reorganize sh4 sections, these changes should be
> in a separate patch. "Orphaning" patch should contain only changes of
> statuses.

Good idea! Maybe if you send a patch to show me how to do it, it
will be easier to understand what you mean.

Thanks for also caring about the SH4 hardware, the code was
prone to bitrot and needed maintainer to look after it.

Regards,

Phil.

> 
> Regards,
> Aleksandar
> 
>>  MAINTAINERS | 10 ++++++++--
>>  1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 6e7890ce82..49d90c70de 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -299,9 +299,7 @@ SH4 TCG CPUs
>>  M: Aurelien Jarno <aurelien@aurel32.net>
>>  S: Odd Fixes
>>  F: target/sh4/
>> -F: hw/sh4/
>>  F: disas/sh4.c
>> -F: include/hw/sh4/
>>
>>  SPARC TCG CPUs
>>  M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> @@ -1948,6 +1946,14 @@ F: hw/*/*xive*
>>  F: include/hw/*/*xive*
>>  F: docs/*/*xive*
>>
>> +SH4 Hardware
>> +S: Orphan
>> +F: hw/sh4/
>> +F: hw/char/sh_serial.c
>> +F: hw/intc/sh_intc.c
>> +F: hw/timer/sh_timer.c
>> +F: include/hw/sh4/
>> +
>>  Subsystems
>>  ----------
>>  Audio
>> --
>> 2.21.3
>>
>>
> 

