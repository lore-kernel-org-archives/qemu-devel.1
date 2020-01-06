Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B83FC33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 20:36:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9AE920731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 20:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVh9nrB7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9AE920731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioZ7R-0006EI-3k
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 15:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50353)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielhb413@gmail.com>) id 1ioZ6T-0005bw-Il
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 15:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielhb413@gmail.com>) id 1ioZ6S-0000TX-IU
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 15:35:57 -0500
Received: from mail-qv1-xf43.google.com ([2607:f8b0:4864:20::f43]:45210)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielhb413@gmail.com>)
 id 1ioZ6Q-0000RN-4w; Mon, 06 Jan 2020 15:35:54 -0500
Received: by mail-qv1-xf43.google.com with SMTP id l14so19594236qvu.12;
 Mon, 06 Jan 2020 12:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ZncD7zhSxxbabOsOGW71JUJwtsupPDeAceN9FfhoZgI=;
 b=pVh9nrB7tGk9kD/gd7ljzbrj66ytZyWvie+YujhPTWH9GaEgriMrRPfIFWXeGFrXs2
 oHF2+cBX7B4kKt9NHgMvDJHo1SyfgPsrODB3S7MDjpoUQFM7wywK4CyBff0VI3mIrEAA
 2hflGS1hEci0MMAuQmZdK/0JBhEtV/OMCsxnWK/uCKoYeUG9oGaDon3s3mJ3OjD2xnrw
 FM6GWzeOOZAjpaa4Vs5tI7pK7Ynf1YeLjETSMDethONDpiJGMSt461bAav1JLW54IEO2
 AtZbuRbRv1+PBfbefBP4WiyYQB53mfpem8FSilvWVDpF2A4HoCE1z8EeOoBaL+AxGjeT
 FCAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZncD7zhSxxbabOsOGW71JUJwtsupPDeAceN9FfhoZgI=;
 b=iUC+Ae8jI9gDc9is5CFA6cRiSyppl06YLxO/CT5nIi0DSc4QjYhN9Dxr3WPNwpfky+
 IiASktz/o9iZznJQY42Gd7gCgu5iD7vQjg1KXVzaecYwLcFGUCiPBaaxgWbrQtnyaU/x
 vmZQvfi86UbAqO1a4mg1yMjCFxQis+ItafGqlxPDXkJaUUQzmv9/JK90vOJgw7/I42I0
 nBDZEibCVKH8fC1B9SG64jJaicTMl5R0qsMLvR8Fqx6ZlRJuJLAi7tkcPlD8hyKqJ3Xg
 wZS+XqDIsaggObpIVfyNd6NPjzOHAJP/el4DXjn5/quxEDo3O0YYcA3yVIbvSWG1n2Ge
 VmnQ==
X-Gm-Message-State: APjAAAUqBFMd4nQ4bLm0qVL0yk4z+1EG+i3YIMGP5kZR+eoTDGfhrGzv
 JYtCKHrLuyCMS2aHKTKQmPsNf2DB
X-Google-Smtp-Source: APXvYqz3yRyxDM1/foc5ViV7uD7SAfEvpNEsojh3Xh4xXO68CL3cC5XX+iLQ6gsGfL1Zvlo5NfJBDQ==
X-Received: by 2002:ad4:518d:: with SMTP id b13mr80295621qvp.141.1578342953193; 
 Mon, 06 Jan 2020 12:35:53 -0800 (PST)
Received: from ?IPv6:2804:431:c7c6:655b:9e1c:e865:3705:e1df?
 ([2804:431:c7c6:655b:9e1c:e865:3705:e1df])
 by smtp.gmail.com with ESMTPSA id t2sm23749571qtn.22.2020.01.06.12.35.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jan 2020 12:35:52 -0800 (PST)
Subject: Re: [PATCH v1 00/59] trivial unneeded labels cleanup
To: minyard@acm.org
References: <20200106182425.20312-1-danielhb413@gmail.com>
 <20200106195457.GE2886@minyard.net>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
Message-ID: <f71eb524-571b-54d1-1a99-95d2896f6586@gmail.com>
Date: Mon, 6 Jan 2020 17:35:49 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200106195457.GE2886@minyard.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f43
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 1/6/20 4:54 PM, Corey Minyard wrote:
> On Mon, Jan 06, 2020 at 03:23:26PM -0300, Daniel Henrique Barboza wrote:
>> Hello,
[...]
>>
>> Which is cleaner and requires less brain cycles to wonder
>> whether the 'cleanup' label does anything special, such
>> as a heap memory cleanup.
> 
> I would disagree with this analysis.  To me, I often wonder
> when I have to add cleanup code to a routine whether there is
> some hidden return in the middle of the function.  That's a lot
> harder to spot than just looking for the cleanup label at the
> end of the function to see what it does.  For non-trivial
> functions I prefer to have one point of return at the end
> (and maybe some minor checks with returns right at the beginning).
> I'm not adamant about this, just my opinion.

I agree that what I'm doing here isn't a one rule fits all situation. This
is why I didn't purge all the 'unused' labels I found. The criteria used to
remove/spare labels will differ from person to person (although I believe that
cases such as patch 15 isn't too much of a debate), thus I'd rather leave to
each maintainer to accept/deny the changes based on the context of the code.

And for this same reason I don't think that a checkpatch rule is necessary.
The review process can take care of these situations and allow 'good unneeded
labels' to be in the code.


Thanks,


DHB



> 
> But if we are going to fix things like this, it might be best to add
> them to the coding style document and checkpatch script.  Otherwise
> these sorts of things will just continue.
> 
> -corey
> 

