Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09C89C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C985221019
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 16:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AaOwVXGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C985221019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57747 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOm6F-0005Or-37
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 12:40:51 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOm4h-0004Nm-PR
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:39:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOm4g-0000S7-3k
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:39:15 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOm4f-0000RF-NQ
	for qemu-devel@nongnu.org; Thu, 09 May 2019 12:39:13 -0400
Received: by mail-pf1-x443.google.com with SMTP id 10so1606296pfo.5
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 09:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=7QanXo+t8UOZcAfjBJwbK8Cm6GQVP5+6DmXsezGXDIc=;
	b=AaOwVXGVsubqur/dUEm8rf9g6HW6sOhh56bVivG1ZqV6AYactdxgvJ9K70BY4cl9gf
	4V+gQoHy9dptvkyvmUk6iRLJK9MK8x55oa8zr35BvrqQbjbvzHmnNwgZ0LzsOo7n1a5x
	matB86VtSF5GFj9bFW7FTOvux9oeUkCb2yR7bB649rJ6CkWvHWwaVeXh78CZFLMyO26g
	dXCJayqAgYVYvOqjzBURK6zD8EBHZnenYCK6pK1U1Nk5CaXSpcjxGKaDLIGcJEyEXb8t
	m2GClsvBPHqj5+UnaHTq8WBYm/Z1KLhK3+e+5b0eptSJ6G27DigmixK7DhhLkP80HUX3
	hCIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=7QanXo+t8UOZcAfjBJwbK8Cm6GQVP5+6DmXsezGXDIc=;
	b=ExvG39sL5TDTsteD6grqYDmddKebF/1Ur+r9ZI7YlveqoKGbSX0XsmvniSXsCQf/Ep
	36hbhZFhZi0P+P60E6dlx3fBQn7vJ3egLnrFLkEcyBLEqJGE6BZiU/kd8+xCn1SrhXvc
	4g9YI9Mc3BunpulLtOfhOjcWd6f5DSqfxODNeVWcU/7Py5FHPf5SAEJ3j+hbAgv8wK7J
	ew0DrsP3IlaqFeruoIP4A7riAfbaYlFc8t52boCSg+v+DXmLL9Z0aOJPq+gcEUrRbije
	993MkXbLWszIqZ+3sz87KKGUY2fpf72wlNAtN0u4QFQpeyIEYziSLvUF7eRl8blCQnHZ
	NSnw==
X-Gm-Message-State: APjAAAW3j2KGCiC3fUPyf+T3V9zuYnp41t2maKeLu+y/eSjrgaC1cdGe
	W9u9qmE+B5TFy1G2sFm2RI8V1A==
X-Google-Smtp-Source: APXvYqz8O+jqrdAnGFazYg4qukcCyBLQr6x1GpaOZAavGl4xC7/XucCp56U6HvsldRxb7iqF4b2kug==
X-Received: by 2002:a63:d04b:: with SMTP id s11mr6903091pgi.187.1557419950823; 
	Thu, 09 May 2019 09:39:10 -0700 (PDT)
Received: from [172.31.99.192] (50-248-210-99-static.hfc.comcastbusiness.net.
	[50.248.210.99]) by smtp.gmail.com with ESMTPSA id
	g24sm6002632pfi.126.2019.05.09.09.39.09
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 09:39:10 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, Kamil Rytarowski <n54@gmx.com>
References: <20190508085645.11595-1-kraxel@redhat.com>
	<20190508085645.11595-12-kraxel@redhat.com>
	<461b0a0f-2843-afc3-6289-db08d6415771@gmx.com>
	<20190509064716.pcxsg3lbbfqv5ltl@sirius.home.kraxel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d4939e4c-4e31-4330-0180-8c3c73378d24@linaro.org>
Date: Thu, 9 May 2019 09:39:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509064716.pcxsg3lbbfqv5ltl@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH 11/13] tests/vm: netbsd autoinstall,
 using serial console
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
	=?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	Li-Wen Hsu <lwhsu@freebsd.org>, Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 11:47 PM, Gerd Hoffmann wrote:
> So, from looking at the patch it seems you need two mappings of the same
> page, one writable and one executable.
> 
> Or, maybe it is also possible with one mapping which is writable first
> when you fill it with code, then gets flipped over to executable when
> you are done with the initialization and want use it.
> 
> Is that correct?

That's certainly the way I read that patch.

> I suspect supporting that in tcg isn't exactly trivial.

It shouldn't be too hard, if required.  All of the writing to the buffer is
isolated to a couple of inline functions.

I do wonder if using paxctl -m as a part of the build process for affected *BSD
isn't just as easy?


r~

