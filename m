Return-Path: <SRS0=/4tE=TV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693E7C04AAF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:57:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B8822173C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2019 16:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cxp4ZYxf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8822173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56916 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hT84T-0001B0-39
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 12:57:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hT83g-0000pj-NB
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:56:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hT83f-0007xs-PN
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:56:12 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34]:34046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hT83f-0007xS-JA
	for qemu-devel@nongnu.org; Tue, 21 May 2019 12:56:11 -0400
Received: by mail-vs1-xe34.google.com with SMTP id q64so11576309vsd.1
	for <qemu-devel@nongnu.org>; Tue, 21 May 2019 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=J4wFETQlNrziK1vkgH4sB+9Of2vK/vZ50gN/RUzHsz4=;
	b=Cxp4ZYxfBqBWTcqg/vLIg4vTTn6Dp/fGEGPIsoYvFszl+sXZJcUNMQKdI1eKW/yBDp
	mDeMEjp1JpeWbOwOVLi5GPUaKgdA0v7rsMHlvmisAr3FAvbUx5cn1lTu9veT28eEtaKD
	c7u/VpjxC4dtEuEdF1u4RBVJ2wHS7H7hWRLsULZMNSkKpytdBegc/8nHJeuTcKIqEAbn
	2C+9FNTQYYq6GMKOqXc+1l+o17Zyyr7t5abCYDIfFSZd1l5KW+FxAZvkqilGT+4Hclk5
	dQxXUcuwF//p0k7cXFU/T42Jy2LTCxCgsE3HJu7w7/FQ5aJaNe/0+ZkXoSjEdHvwTSxn
	ygrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=J4wFETQlNrziK1vkgH4sB+9Of2vK/vZ50gN/RUzHsz4=;
	b=YWjdrK5iQgiVmxvAW5ovplNX7m4MY652ul93jd2QURHOv2EsigI02sWY12b2AQ4yQi
	vdRhYS+N4peLuPkJ6O27JDH3ThyM3uBNGepwC9E87ivu9qPa42yh6K+EPBYpe+iTVTl2
	XKzCh8QVtbw8oHP+9PiSe/75cW+HxLev6w5U80uYKQXqnDH8PoluAfUftkDjWvEtndex
	VBplIwOpRbAVDtiuaB0LWadg9J1r0e0zi8czdwEUDgWnqr5aVtt7bUlghUdAnXRpkK5Z
	sW5C0AbXKpLq0bB+OczTPfM+YmhOFuzrCS8L7PYFq1MWCZ1obrKjiyaTekt/z/3qgc9u
	F6Rw==
X-Gm-Message-State: APjAAAVN+ymdL/YVSs0Ro+H3y4IHjj/exqQbqF+FtjAlVMxaobivzdPY
	e/nygGz/17COrajmL5KttTL0FLBS2nw=
X-Google-Smtp-Source: APXvYqyIj9lvU1Oo7Mu+dBH51bSxj/BMirWcwRoDRNu0U+cA9Z6kIcgwztp9dFHvN7PRo/Kab/ntBw==
X-Received: by 2002:a67:f105:: with SMTP id n5mr4912146vsk.23.1558457770600;
	Tue, 21 May 2019 09:56:10 -0700 (PDT)
Received: from [192.168.42.31] (ip-173-130-239-11.orldfl.spcsdns.net.
	[173.130.239.11])
	by smtp.gmail.com with ESMTPSA id c3sm2726518vso.2.2019.05.21.09.56.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 21 May 2019 09:56:09 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
	<alex.bennee@linaro.org>
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-8-jan.bobek@gmail.com>
	<87zhnhgw1c.fsf@zen.linaroharston>
	<CAFXwXrkiShudOkAKks7VwB5-tUskeY1pfSeftvS8n=ez8Zgeog@mail.gmail.com>
	<87h89ogoo0.fsf@zen.linaroharston>
	<eb8797f0-c615-e60d-0bb4-990e08901883@linaro.org>
	<87ftp7hljt.fsf@zen.linaroharston>
	<a6b08718-4c64-eb8f-3663-ee4dfdaaa9fd@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <06dee3da-977b-4b7f-e96a-80cdbac4db99@linaro.org>
Date: Tue, 21 May 2019 12:56:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a6b08718-4c64-eb8f-3663-ee4dfdaaa9fd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e34
Subject: Re: [Qemu-devel] [RISU v2 07/11] test_i386: change syntax from nasm
 to gas
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
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/19 12:48 PM, Jan Bobek wrote:
> I get the same behavior, but it only occurs on 32bit builds of
> RISU. Specifically, in risu_reginfo_i386.c, lines 172--178:
> 
>     for (i = 0; i < nvecregs; ++i) {
> #ifdef __x86_64__
>         memcpy(&ri->vregs[i], &fp->xmm_space[i], 16);
> #else
>         memcpy(&ri->vregs[i], &fp->_xmm[i * 4], 16);
> #endif
>     }
> 
> In the #else branch, fp->_xmm has type _libc_xmmreg[16], and
> _libc_xmmreg itself is a struct with a 4-element array of uint32s. On
> my box, this gets fixed by dropping the multiplication from the index,
> i.e.
> 
>         memcpy(&ri->vregs[i], &fp->_xmm[i], 16);
> 
> I wonder why Richard wrote it like this in the first place; did
> fp->_xmm use to be an array of uint32s in previous versions of this
> API?

I dunno what happened, but these indexes are backward.

>From <asm/sigcontext.h>:

struct _fpstate_32 {
    ...
        struct _xmmreg _xmm[8];


struct _fpstate_64 {
    ...
        __u32 xmm_space[64];  /* 16x XMM registers, 16 bytes each */



r~

