Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525CAC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:17:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1596E20857
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 23:17:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Il5RO8Pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1596E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50456 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDzzj-0000BT-Ag
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 19:17:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDzyD-0007bZ-5n
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDzyC-0002Sx-8u
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:16:01 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:44842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hDzyB-0002SW-Rg
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 19:16:00 -0400
Received: by mail-pl1-x642.google.com with SMTP id g12so123780pll.11
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 16:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=fq9q1r+7wd2FWb4+TU9XCY3RdBBD1jeSJG9moiPM1gs=;
	b=Il5RO8PaNHKZaFMPYQ+O+tHjjLmqrZSbIIwnPeHkIflwveao4uXFpcZm9MgQhR9bRl
	pajA+ze+S3+bXALL3yY51K827gKaa8Wevw4XYRrEL//GCiNEGZIcXgUnPuESci+QBjZu
	W+Owbuit6UZjQSPuBqpjwFMBtt+wb6O7WJlnrA6yQ7BXKJyVFwC8XYsLN8ynUvxoU2Dh
	SeEqSVjqc21RYPEQpKfnOGmvnPmWCjtvS3mG6R4J1z5GtH1YGzBE6AV7iMxW24XqTgeX
	txPKiRzdtn+/59uZEJVfDH7Ita7iz61rR5+DzMGTUcH3gE2H81w1Y45dD7LKeOJ4MFqc
	Y/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=fq9q1r+7wd2FWb4+TU9XCY3RdBBD1jeSJG9moiPM1gs=;
	b=s6DiSV/rx+SQEJYe44A5bYVQFNupPRTAdyhnvaVkIGUWixhM51TQ/0PH9LCxYTGp3B
	mV/Y/1shvP5IFoS9pxSmGQ5IdUHyzVQKmmAQa7020Y6JcfOwyblg5gL3KvBletXrKUc1
	ctlKcYsL2+TBVg/b27A72Fdr3/J7Psw8wzMVwKASI63dpEBsrqCGMgyfTlNEooj96hQO
	1JyTqf/WBKbaAVBjawikYyo/VveBCZ+WaY12E8Efy0DNGa52R9+Tw6y24NYWaGps2rYz
	gHwmsFixDkZJ28ddwBzaicNO7N6ZCfjvOS3FFvXe861PGTZZEx8AExLN22JPvPcOYl3s
	CNsQ==
X-Gm-Message-State: APjAAAWVfPJx5aQ5ZAg8HsrFX//x7xZAGf8/csWzULF9N3SnuepIGJDM
	Aj+9/Di8+R63gA4NE0l6wg7ArC2azk4=
X-Google-Smtp-Source: APXvYqx287U8PjO6ZqRpOh0AzhtpA20N6Uu3GKMW2biAHgjuDFshYGPoj274qU1IVHSXvwEFrnYXQA==
X-Received: by 2002:a17:902:6b8b:: with SMTP id
	p11mr16342356plk.225.1554851757535; 
	Tue, 09 Apr 2019 16:15:57 -0700 (PDT)
Received: from [192.168.3.43] (rrcs-173-198-79-114.west.biz.rr.com.
	[173.198.79.114]) by smtp.gmail.com with ESMTPSA id
	k79sm16300238pfj.28.2019.04.09.16.15.55
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 16:15:56 -0700 (PDT)
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20190118213122.22865-1-richard.henderson@linaro.org>
	<20190118213122.22865-48-richard.henderson@linaro.org>
	<86bae9b3-75c8-64df-92d1-b4efc35b646c@vivier.eu>
	<c1dc5dbc-cbc7-16a3-9d14-c93b52c362fd@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <2004b6c4-0aea-f535-d2bc-80d5c14537be@linaro.org>
Date: Tue, 9 Apr 2019 13:15:52 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <c1dc5dbc-cbc7-16a3-9d14-c93b52c362fd@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v6 48/49] linux-user: Split out ioctl
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409231552.dRxK_F_Dac4Ca47kMugXhCfOK3TRNPyTkfvsaAsXlbg@z>

On 2/13/19 3:46 AM, Laurent Vivier wrote:
> On 13/02/2019 14:09, Laurent Vivier wrote:
>> Hi,
>>
>> this one is really a cut'n'paste but it introduces a problem with 
>> qemu-alpha, I don't know how/why:
>>
>>   $ sudo unshare --ipc --uts --pid --fork --kill-child --mount chroot chroot/alpha/sid/
>>   Unsupported ioctl: cmd=0x80047476
>>
>> And then it hangs.
>>
>> I'll try to debug.
> 
> In fact it happens with sid, with ppc64 too, but not with m68k and sh4.
> 
> And only with "unshare --pid --fork".
> 
> Without "unshare", the result is:
> 
>   Unsupported ioctl: cmd=0x80047476
>   bash: cannot set terminal process group (11507): Function not implemented
>   bash: no job control in this shell
>   Unsupported ioctl: cmd=0x80087467
>   Unsupported ioctl: cmd=0x80087467
>   Unsupported ioctl: cmd=0x802c7415

I'm just now getting back to this, and cannot replicate the issue, at least
rebased onto master.  With or without unshare, I see your "without unshare"
results.

The rebase onto master is at

  https://github.com/rth7680/qemu.git lu-split-6


r~

