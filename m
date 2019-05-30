Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E4DC46460
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 18:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 286FB25F4C
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 18:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlnNVoqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 286FB25F4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57586 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWPba-0003i7-Ea
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 14:16:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWPaZ-0003M6-Me
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWPaY-0006qb-Uw
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:15:43 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWPaY-0006pm-Np
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:15:42 -0400
Received: by mail-ot1-x341.google.com with SMTP id t24so6520861otl.12
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 11:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=jrk8Hs+scHVbwqZTzpcKqRvdWq4wxjC7s+e1hOoNr8g=;
	b=BlnNVoqffBdB/c9DKhQDX5/OKmviq9uk5NXFzyN0aj5YlAw53kzrdd70KRQffcEuqK
	MKNib/+5i40R8J1g0vxaWvt2/UyTQhLECtmxgjQYsL265vXc6rygMtc5RBEtC4H3Tyem
	j5HqYdfeCdZshvLyZSwKtkT1s1Cq961N+JeAkSTZzgnXjskvodkh5PTlO+ep84X/jlgB
	t80+p4gdYHYffmW0Km8hmqP53Dwp9Wr0rSSEFK6QriwEL2Bg7WrINZaetfDAjU6/HEDf
	WwSrxFGec3bzbfDH26WBtT4xS/booGg5ZiNlJ1XWGLxFDBRF2q56uyOdsWG7l6kz74Fl
	hz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=jrk8Hs+scHVbwqZTzpcKqRvdWq4wxjC7s+e1hOoNr8g=;
	b=Eei7X98SZsuqoLe5IqTCf1PuqisKQNbe1zSfbhnnb/ttIgQTPtYe5IvjJYGY3vYaja
	PPpxum6tg1OwYHXY4BQQISpFiHCLzqUPS4WaIBZ68wfBIgWljmbMgvJ8DJ6wUhrN+pPX
	BzSo07B8Be97xzs+BiV94dUaDtsdX0gh6barKCBKv5UtchqV8KPpvpAVTIL47zMqpzvp
	a2v7/8jjQuW5wGvt/SkbdYuPCpFPHMc5viuUWJWbmthQB+7B1B2/jB/PbtO/4LeBIa6G
	3YC9kYvsDbKhoZKsTVB1XfzKuygZ3Op9O0Dfe1CnOSjvQNxBLXld4/DGO8/6fIjiprTy
	ppyg==
X-Gm-Message-State: APjAAAV0YaIDHQU7B6n8x8nUOipjIMz1DM8gXM3UU0pna09yrdlNoHQI
	tamh9VDuccCROgNcpb5q8NJQRQok0w2ZXQ==
X-Google-Smtp-Source: APXvYqxFcZ7iJCNsN3bKWfEFaCdv4rFT+Qruy0ZWb4ijy6dQcZdm+HDmA5YO2wXZGL+Mx9bKcLe4yg==
X-Received: by 2002:a9d:7cd2:: with SMTP id r18mr2666otn.345.1559240141134;
	Thu, 30 May 2019 11:15:41 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	v20sm1157690otk.66.2019.05.30.11.15.39
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 11:15:40 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190530101603.22254-1-alex.bennee@linaro.org>
	<20190530101603.22254-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <39efe9c1-e5cf-abda-a8ca-89c94d3bd7f3@linaro.org>
Date: Thu, 30 May 2019 13:15:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530101603.22254-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v1 01/26] editorconfig: add setting for
 shell scripts
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

On 5/30/19 5:15 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .editorconfig | 4 ++++
>  1 file changed, 4 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

