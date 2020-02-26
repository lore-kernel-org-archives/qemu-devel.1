Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD0AC4BA2D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3616520838
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 22:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uO4qgUxR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3616520838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j75bz-00012x-EV
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 17:57:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j75af-0008Ed-Mu
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:55:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j75ae-0002tU-K6
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:55:41 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:35524)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j75ae-0002ru-Ds
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 17:55:40 -0500
Received: by mail-pg1-x544.google.com with SMTP id 7so393065pgr.2
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 14:55:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6pTrTW2yxzhcyTv22bbpHT3wemj2wTbUxloA7/tytpc=;
 b=uO4qgUxR8Hy5bm48qSeSmUy77qXL4Smm9vAKfpbzxZwPSrlRrzSqvNofuFqsY44nUj
 7s5fM9ZnIcqLkQ+gz8p7oT+WBCpCNYIVc9/aagKn7gba3unzjOhZ0EnGQfdSaNqdEbPq
 /WwD22fcFFMjuDjzIo5ejI5Zo0Uo/AIf11+JFORlubazX6h8cVgAY6YTwmLPHq81cFBj
 Qy9iBWsfdSmipJj++S0CmYkBJ0wP4goH+rSAM9PiKt0eXzRrjxyDR4iLhYXsrhDmbtWJ
 n1ppp0jA+7CeqhPTJYbLDSuN1hx4wMidna+4Ukd9V7yXjpZTXTkCSzSz3Z7VarMKnxK8
 xonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6pTrTW2yxzhcyTv22bbpHT3wemj2wTbUxloA7/tytpc=;
 b=aT6vCpLJx5aiPCk0V8yvNQ5kHwjKRgvrDsrO9WNBnBu+tuT5OEc+QDM6/r72HCja/B
 hw9AL+k2iFLNPhLk/kubTEOmpLXfISiS+nHL/pWYpTQEYIKTcgPTyRKwVCdKCOLZUhIL
 w3XRt/TZM1XY+BUN1vhuAXLfTxMplObsjnm0nI5L5XB6532xnRtamXYH25J9wWvQRZJ3
 bLylWQu3TvaWJLSY2WdA2KEY77WCi5S1wTzOcDAo7e+gRxXn7N6YKXHBJZZGvjp27lpJ
 L+l53B9rqPIgDnGiBnCj51M6DKLfRJ1zWfZlM2bpnOam1X+SWy1FTcFd8qt3g7Bf7C04
 9ywg==
X-Gm-Message-State: APjAAAVn2gU1o7lLcmijaWdkUA7W5Ks8G1eo4HEBwveXqlNprtZ2kWmm
 PmC4Bqn6L9cZg9ulW+ohypxnLw==
X-Google-Smtp-Source: APXvYqzPkWGjGgy7qNRkSzRNBzqkFyQzH4ecjg2aWHrqQomX3f/Iy3PomIHJWGPCgBs6Ei/RWOR1Og==
X-Received: by 2002:a62:33c6:: with SMTP id z189mr1002969pfz.246.1582757739161; 
 Wed, 26 Feb 2020 14:55:39 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 64sm4093441pfd.48.2020.02.26.14.55.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2020 14:55:38 -0800 (PST)
Subject: Re: [PATCH v1 4/4] accel/tcg: increase default code gen buffer size
 for 64 bit
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200226181020.19592-1-alex.bennee@linaro.org>
 <20200226181020.19592-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2ca7b55b-5674-370d-5c4d-dc8b7782ca64@linaro.org>
Date: Wed, 26 Feb 2020 14:55:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200226181020.19592-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/26/20 10:10 AM, Alex Bennée wrote:
> While 32mb is certainly usable a full system boot ends up flushing the
> codegen buffer nearly 100 times. Increase the default on 64 bit hosts
> to take advantage of all that spare memory. After this change I can
> boot my tests system without any TB flushes.

> +#if TCG_TARGET_REG_BITS == 32
>  #define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (32 * MiB)
> +#else
> +#define DEFAULT_CODE_GEN_BUFFER_SIZE_1 (2 * GiB)
> +#endif

This particular number, I'm not so sure about.

It makes sense for a lone vm, running in system mode, on a large-ish host.
It's more questionable for a large-ish host running many system mode vm's,
although one can tune that from the command-line, so perhaps it's still ok.

It does not make sense for a linux-user chroot, running make -jN, on just about
any host.  For linux-user, I could be happy with a modest increase, but not all
the way out to 2GiB.

Discuss.


r~

