Return-Path: <SRS0=sEuR=S7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25796C43219
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:26:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C3D20656
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2019 15:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zO4x4Z9v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C3D20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59235 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hL8AL-0005tP-Ez
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 11:26:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hL88h-0004oi-RM
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:24:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hL88h-0005Qy-2V
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:24:19 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:40676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hL88g-0005Q3-RC
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:24:19 -0400
Received: by mail-pg1-x52c.google.com with SMTP id d31so5309104pgl.7
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=MlYxx0cCM+L/d+XOE6VrpSZkcE/F0rhHab9M2T4p/Hk=;
	b=zO4x4Z9v0h61gFbMXFJswbq5dTv/A1pjTD6g3ttArFOiuTk0vpdkKr60dKPQ97CdEK
	q2BXW3aY6VoVjQyFgTVz8mNa++lP6zn2e+cwReSHM0ITJWUFziy68CPgVQJe1HpPZ3ib
	AqH0d+wCd1W3ldZECnRznLHVkaDTSfVmB09zTvriZvfQCZpKgzWVdabMtVgMszsYITVA
	sf0xmTJwtQraak135rsflF/wK7AjIdJJTq6aim9xVhDtSqLr+eF6LkXF2PrV78ab51hZ
	m99wTkqBjGnnP9O2jHuyNIUAALRhK8FMzbVRqhxxc9MDpPgOC/ayG06ACUpP0XWVML9U
	G6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=MlYxx0cCM+L/d+XOE6VrpSZkcE/F0rhHab9M2T4p/Hk=;
	b=sp/UBW9Y8i1n2wQIyxkY0pXVe48x863tQa8txVxf/ICcQ/qOZOu1JDX0J9GqBjI4x0
	uvNIuOgBnI99NPGrsYbaz3mT4ZOxr7gVg++7C9euROiMN6au4TZ8rjQnK5LMABJ4xPfZ
	NzYmgdviCurxYDlxgug3asxEsj7MTTT9TIxYtHOX8RzIs3OdiznerHZl+y8Xc5YJamyA
	sVDyrCLTFapJLmcvEuGvgJ404COl5hSi/QIeGdOqp3b+iKCQcuxXVm8MFlgVQCwQsFB/
	LeTmnv9BVdOq7TISU1TFJ/677xDRazoJMroOE399LF380C6ueMq2xBORJirtfPGj8q5w
	eaCQ==
X-Gm-Message-State: APjAAAXz70GEwwauG+BPS+VISIAkWRrrfHdp1XOh55SiOcUoGcG3FZ58
	Tl1S1n6V8jTP+/NVCSuiaFIqV7yR+18=
X-Google-Smtp-Source: APXvYqwg7wsrA49PNaCwuyz3iXQxvL8ahwD3WeYnKNgLmR5kX83Kp5TpO8kbViTTODOebyFGGxPY3g==
X-Received: by 2002:a63:5466:: with SMTP id e38mr60469003pgm.340.1556551456691;
	Mon, 29 Apr 2019 08:24:16 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	h74sm15544378pfj.5.2019.04.29.08.24.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 08:24:15 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-32-richard.henderson@linaro.org>
	<CAFEAcA9nWq44C=m3exNJBO-YpheGRdzzAL529uCaFtUNGCWGkQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ad201251-ce90-3680-74be-259189579c0e@linaro.org>
Date: Mon, 29 Apr 2019 08:23:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9nWq44C=m3exNJBO-YpheGRdzzAL529uCaFtUNGCWGkQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::52c
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 31/36] cpu: Introduce
 CPUNegativeOffsetState
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190429152358.h2HJW9PAHGRg6sSqM5MmBPQJpgGk67c9sFy7Wdv63B4@z>

On 4/29/19 7:43 AM, Peter Maydell wrote:
> It would be nice if we could do a compile-time assert that
>  offsetof(CPUArchState, neg) + sizeof(CPUNegativeOffsetState)
>   == offsetof(CPUArchState, env)
> 
> but I guess the possibility of within-struct padding
> between the two structs makes that dubious. Or does our
> generated code rely on there being no padding between neg
> and env anyway ?

It would be nice, but there *is* padding for some targets.


r~

