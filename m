Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F34C28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 18:42:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED57A25FC3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 18:42:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W556Io+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED57A25FC3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57799 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWQ0Z-0000rw-0y
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 14:42:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWPzc-0000Vt-NY
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:41:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWPzb-000718-OO
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:41:36 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:42573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWPzb-0006zv-GF
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:41:35 -0400
Received: by mail-ot1-x342.google.com with SMTP id i2so5650494otr.9
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 11:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=cXN/y8HPGPq2FL9q4I1vyUtc/hptaQ0jVf+OMVBP3GE=;
	b=W556Io+a6b2GV6TaivBbbbzzqGHn1WO/hok+sYF94RjPYf6klINY2yr3H/aB0C5tqf
	DHtNr+fLhAL9JJPSJBOpfMFg6VPe59/QE6CpAsIly6p4Dn7TCz+zBmai4zfh/Uynj9Mh
	OdBc9uZFhTGQU6DLfxU+54h8PCNMV6OzN5rLmiqhiXi87Fa4sxn4kfvFG8o+Jb9ycufn
	aweRPVy5nZ2c9Oq/yDybvGgH5+xc1vHs4nq3qyYMcVGYPyuuRQBcM/NT+k70fBDj6LY0
	BZX7A90GWLNHghXhfSNnhdenoBxod4KjJcZC5f+LbFqdehocnBNZjanP+O06DJay1dzv
	BMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=cXN/y8HPGPq2FL9q4I1vyUtc/hptaQ0jVf+OMVBP3GE=;
	b=TkqCxQ7QcR1NO7/dQXsQXKMB46w4SS2OhAwC7usGzy1+UacpoKz/CH6dcDfNHLMA6g
	k6muWsDH0y0TtVE35eEkuu4qLA5m/YERr9U7jv8WZYkP5jUta7cP0zvbOhijN6eBOnvM
	f291vrCfMOyEPzV61EnoWccETJf4E/TrRQ1LnACVq6p6w2uUhfEostO/9kgRZwtEJGqf
	g0PsPMynCYnOpnE0QWVdzCdlG21K/3prumuCo3MIw97HvwdIxUA/+lNuLMwUa2/eGpIU
	s6RpKVDHXZE0PBm9HQmjq73vAbX3VgjlegfXfOcRladUFwYZNslnvcWSz6DADyFtB1+E
	26hQ==
X-Gm-Message-State: APjAAAUDxFgk21mTzK9HfCRq4CAfMgkcR/wHWn7VUFVixZ59Yyd6mztb
	6pJMYrhiZsAke7m+X2mv5H9I3g==
X-Google-Smtp-Source: APXvYqxDXQUOzJrBFDno28ZdnSDLPGSI63gy7mSvOxyCNJ6OVKbXJ2wGEpcbjSXcOdvMJBlSz4qeBQ==
X-Received: by 2002:a9d:7858:: with SMTP id c24mr41091otm.64.1559241694210;
	Thu, 30 May 2019 11:41:34 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id i8sm1290404oib.12.2019.05.30.11.41.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 11:41:32 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190530101603.22254-1-alex.bennee@linaro.org>
	<20190530101603.22254-3-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <088331e9-44e1-facd-917f-cab471288ecf@linaro.org>
Date: Thu, 30 May 2019 13:41:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530101603.22254-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v1 02/26] qemu-io-cmds: use clock_gettime
 for benchmarking
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
	"open list:Block layer core" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/19 5:15 AM, Alex Bennée wrote:
> -static struct timeval tsub(struct timeval t1, struct timeval t2)
> +static struct timespec tsub(struct timespec t1, struct timespec t2)
>  {
> -    t1.tv_usec -= t2.tv_usec;
> -    if (t1.tv_usec < 0) {
> -        t1.tv_usec += 1000000;
> +    t1.tv_nsec -= t2.tv_nsec;
> +    if (t1.tv_nsec < 0) {
> +        t1.tv_nsec += 1000000000;

Rather than counting zeros, should we move or copy NANOSECONDS_PER_SECOND?

> +    double time = (double)tv.tv_sec + ((double)tv.tv_nsec / 1000000000.0);

On that same vein, I'll note this can also be spelled "1e9".
Also, the casts to double are superfluous, once we have one FP constant.

> +static void timestr(struct timespec *tv, char *ts, size_t size, int format)
>  {
> -    double usec = (double)tv->tv_usec / 1000000.0;
> +    double nsec = (double)tv->tv_nsec / 1000000000.0;

Similarly.

>  
>      if (format & TERSE_FIXED_TIME) {
>          if (!HOURS(tv->tv_sec)) {
>              snprintf(ts, size, "%u:%02u.%02u",
>                      (unsigned int) MINUTES(tv->tv_sec),
>                      (unsigned int) SECONDS(tv->tv_sec),
> -                    (unsigned int) (usec * 100));
> +                    (unsigned int) (nsec * 100000));

The multiplier here is wrong.

The existing formatting here is bonkers, which doesn't help.  Why should we
convert to double, divide into a fraction of a second, shift the decimal place,
and truncate conversion to integer?

The formatting should clearly be

  snprintf(ts, size, "%u:%05.2f",
           (unsigned int) MINUTES(tv->tv_sec),
           SECONDS(tv->tv_sec) + nsec);

so that the complete seconds plus fraction of a second is rounded to two digits
after the decimal point, and is left-padded with 0's so that the entire number
fits in 5 characters, not forgetting the decimal point itself (i.e. 00.00).

Likewise to the other two occurrences in this function.


r~

