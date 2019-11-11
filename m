Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7A8BC43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:12:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7661C21D7F
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 14:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSHRjalr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7661C21D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUAQr-0003BO-LN
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 09:12:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52611)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iUAQ9-0002YG-Vo
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:11:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iUAQ8-00058F-O9
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:11:57 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53662)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iUAQ8-00056i-GJ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 09:11:56 -0500
Received: by mail-wm1-x342.google.com with SMTP id u18so5849765wmc.3
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2019 06:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=UHW8VE/AJCf7IYOkZle63sRczOAQymMBowNJGjCAAh4=;
 b=VSHRjalrKrQsxOl20Yinz9qIRk+4Pck5U0OYqpVvlXEBHODjvhZwhyZcfYOSjrkeZh
 uCXdK5kNcKZLwC9XVG+l5O7M+gJ5N4gJ/qMPXqMBr4F2rNsimpeWUhSZJIapvtSnjvab
 ODNuHUpazavqVSWWAMdyH51DZryQrapq/PsVuKfCK3H5kIa1rwsqd925tYfEozvR5RK9
 6BAduW2CGi/cqTVtxSkWLdlvuoVyeAYo+weTGLiu5sc6a580iSaF0d7qjffmcN6vUxGF
 F0jD+KcSS+94vGqKEEn+h4YhZRBXV0Ulg4ltVLEMeGGt0ZV73f3+PSDVCdJafQcZMDUS
 Gx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=UHW8VE/AJCf7IYOkZle63sRczOAQymMBowNJGjCAAh4=;
 b=I9oqRQIv95bYTz1/2FCdUveY7+8XkHaOM13TWWJJSfndFrWRdQb+bsyEj0w8cdaDYK
 EKZm8na+TOB0shBQSJBWkg9nL09QDbrwGNxgeWtVFYhlUEQmgOngsDAi6zSK5EX7VODV
 XNtGftHGoqxUtndmk02PEOudChFJURwsltGNzP25L+2qjcKv0Suevtd7eZ9rYDtxdzPJ
 3zNXO3pDTDCioeWQGb1+z8pUQTq3btdxjL1Hl+mgB/tuEkVaTEJpEsmibKXH5fZQTBJR
 huEwrC0aOOj+Tded19ol4CxZbl+JgsUSLHaT3UTNRDcTjVGt+XKVdER6ZYP+IEcyWM/W
 1Swg==
X-Gm-Message-State: APjAAAVn1CA2N88mSk6XlSKSf4wAF5cj0XrSI2SSp9sdlfN5FleBqfdc
 IzmXguS6EsnJB0AmwLWzoaI94Qu4tOI=
X-Google-Smtp-Source: APXvYqyjOeHshUDLyUg9qJNRlaaeBnGUyfsAIwZrYkWdml1bffu9ZCetJmch+PNSCvkGh9YlE4249g==
X-Received: by 2002:a7b:cf32:: with SMTP id m18mr21036561wmg.166.1573481514461; 
 Mon, 11 Nov 2019 06:11:54 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i71sm33599504wri.68.2019.11.11.06.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Nov 2019 06:11:53 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D9A521FF87;
 Mon, 11 Nov 2019 14:11:52 +0000 (GMT)
References: <20191111125530.26579-1-alex.bennee@linaro.org>
 <cd4917d6-75b7-2c47-0c6b-07dda077c52e@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] tests/migration: use the common library function
In-reply-to: <cd4917d6-75b7-2c47-0c6b-07dda077c52e@redhat.com>
Date: Mon, 11 Nov 2019 14:11:52 +0000
Message-ID: <878soma4ev.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> On 11/11/2019 13.55, Alex Benn=C3=A9e wrote:
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>
> Could you please add at least a short patch description? (Why is this
> change necessary / a good idea?)

It's just a minor clean-up Dave happened to comment on last week. Using
the helper function is preferable given it abstracts away any system
differences for the same information. This is unlike linux-user which
has it's own reasons for using syscall wrappers.

>
>  Thanks,
>   Thomas
>
>
>> ---
>>  tests/migration/stress.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
>> index 0c239646934..915389b53ae 100644
>> --- a/tests/migration/stress.c
>> +++ b/tests/migration/stress.c
>> @@ -31,7 +31,7 @@ const char *argv0;
>>
>>  static int gettid(void)
>>  {
>> -    return syscall(SYS_gettid);
>> +    return qemu_get_thread_id();
>>  }
>>
>>  static __attribute__((noreturn)) void exit_failure(void)
>>


--
Alex Benn=C3=A9e

