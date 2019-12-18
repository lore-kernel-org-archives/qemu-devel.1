Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 102B1C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:59:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CED5D2176D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 16:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O8ysGq1B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CED5D2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihcfs-00013D-Q7
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 11:59:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40732)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihcf0-000097-L3
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:58:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihcez-0007jm-5E
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:58:54 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:56259)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihcey-0007Zx-L7
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 11:58:52 -0500
Received: by mail-pj1-x1041.google.com with SMTP id d5so1141073pjz.5
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 08:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2xYdTJGHOg4PV7izCo96sUKrslij+lJbCuxqKsphOSs=;
 b=O8ysGq1BAP1kPcuwLam/SF6MEVtZQ5SAkOj/Fu4ogfA+ozG+k9mvNcY0rRL3P37E8E
 MkZxASBIVG6rK6LJKG84moXAdCnsROr5tbPcdz4JYTElEXB5zdD1pvJQaXiaVUd36Qxv
 8XKTsfP3XLi9anzbxIlOMpYhS8qVCMgeme9uYnE+4k9VUHaYwRHwQHACeozxR/4OP1a2
 RrOTcGpClsDEOspacnban1O6WG41ff1YR6B9FWxKJrlToAOTqt+/2tXIbrM3aM25tZ0I
 yovBuLdTb+c+I49e80MsZfzzmsvlg1Mc0v7QnvGFb/kNnSMcx7yHoGLJ4U6/djM0YqB9
 hMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2xYdTJGHOg4PV7izCo96sUKrslij+lJbCuxqKsphOSs=;
 b=bWJ3cuqSYOPU/ZU6YBREIZ6+ktLJyAXPtFSljiX0t16Sw5ysBebIrALrDWeRI9/ku7
 WQn+8XLStjn332pYULrSt149vrcGhNqUyYpn3FH48uORVHogBKVBb8uLWoCLt6RHj9Us
 6Hdcb2clOI3ZKY28tdAyZdnJcKlKDxVVxd/fSk/Epf1oStSeyK84i4nL2A1aTRGxjeST
 rJEDcZx8fsjRhl9dGP3vDihxzzYHVAkK7C/5gTBd0j9DKWiDv7oYhqOtoO7wAZ154+Qj
 /+j2nGKzF2+h7iyyPQ9OtMA2NuoRvLl4zUDUkwWlzV0baHU2dy3g2jCxuyR0PUEfb9w1
 YgYg==
X-Gm-Message-State: APjAAAVQWsWztqH9rs9Kq1rlwxWERlgEaApq0DL1R1fT2dd7GgzH+t5D
 i8aTMEsAl3QB7cMfhJytyr1Fzg==
X-Google-Smtp-Source: APXvYqyKXOUi2oeaQCfaL6pSsz/8fTRBWsP6H5c4KFvdsX1jaZDbk4cHUBExd8NdSDhOdGbmr8OwTA==
X-Received: by 2002:a17:902:7c0d:: with SMTP id
 x13mr3867480pll.85.1576688329617; 
 Wed, 18 Dec 2019 08:58:49 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id e1sm4152751pfl.98.2019.12.18.08.58.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 08:58:48 -0800 (PST)
Subject: Re: [PATCH 5/7] configure: Unnest detection of -z,relro and -z,now
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20191218031920.6414-1-richard.henderson@linaro.org>
 <20191218031920.6414-6-richard.henderson@linaro.org>
 <881dff30-a729-6d7b-f823-5f136125ac0b@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6a556fb0-619f-ffab-e9b3-5afb17447bee@linaro.org>
Date: Wed, 18 Dec 2019 06:58:45 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <881dff30-a729-6d7b-f823-5f136125ac0b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1041
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
Cc: berrange@redhat.com, i@maskray.me, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/17/19 10:11 PM, Thomas Huth wrote:
>> +# Detect support for DT_BIND_NOW.
>> +if compile_prog "" "-Wl,-z,now" ; then
>> +  LDFLAGS="-Wl,-z,now $LDFLAGS"
>> +fi
>> +
>> +# Detect support for PT_GNU_RELRO.
>> +if compile_prog "" "-Wl,-z,relro" ; then
>> +  LDFLAGS="-Wl,-z,relro $LDFLAGS"
>> +fi
> 
> Looking at
> https://mudongliang.github.io/2016/07/11/relro-a-not-so-well-known-memory-corruption-mitigation-technique.html
> the idea of specifying these two options together was likely to get
> "Full RELRO" instead of only "Partial RELRO".

Sure.

> Thus, does it make sense to have "-Wl,-z,now" without "-Wl,-z,relro" in
> QEMU? Or should this rather check whether both are possible, then use
> both, otherwise just try to use "relro" alone?

Honestly, I expect them both to be supported in any binutils.

I split the two tests just because they didn't seem to be logically connected.
 But I had forgotten about, or perhaps never heard, the terms "full" and
"partial" relro.

I can put them back together with an appropriate comment it you like.  One less
thing to run during configure...


r~

