Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F84DC04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:46:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D3DD20645
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:46:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RFT2cmZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3DD20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35529 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS1Y1-00059l-N4
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 11:46:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1Vh-0003U3-Dm
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:44:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1Ln-0008Qq-60
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:34:19 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:38759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS1Lm-0008Q9-VN
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:34:19 -0400
Received: by mail-pf1-x444.google.com with SMTP id b76so5124386pfb.5
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 08:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=qVZQR1edhPV78VU3JtFDqDByMulsQaHLQQYoc4NhtVk=;
	b=RFT2cmZVOzChCYN8XYv0nwdXdI7Ofbd1yhLDuPCk3arOnLTq54TGPEE0zP9OCEm2wJ
	X8FZGft5EQ6VGTy1HRmDEOLjO3xTfCS/NnJGy4LNHygoGD8PjzuUAj+stROxhRpJ9+Lf
	zIDOpZNU4funxHNdpIK8VqmdDYQmTTTqn1zIHl1tD+9KK9YGcNvTPx4nktVUG4XQ/6Yb
	NI5q0OymwE49FyuzE+hU0Hfo91v90NQ5ltWHxo7rzR9eDI3X4QwUlreHtmD50/u5sDJ+
	TTiH6QBVWn7QEbsYn0TLQtoRy7lnRpF+fjWBQk2NC0+lWW7Nc0nk7da4gM72SPQplRlz
	F+7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qVZQR1edhPV78VU3JtFDqDByMulsQaHLQQYoc4NhtVk=;
	b=A12LvYrgBOBPIe0uhfLei+G7mthnydOhjsntF/KgggCkM5tANZ4LOHz/v+7YOvmfuQ
	gVF5PjEoyQ+QTFQcN/nVI1zZvN1aRvfmjk5NnuxJ1G6sFRVF+y8oMLCXtQIATZ66s+JS
	JpQDK/JeGDUmooeEBVnVAEaO0/Mbe3VTFB5vQ+T3Eeadzbs4wmBZkrvvdZwBdg7nMdfH
	/yA7Jb8lpRtMIOctsWQCyPKoot9C0ixKjHRJ7pIBMHgRv+f3vF/tswcdb/7BBDJ9fBIN
	LRy2Klchbb/HOf9Z8PNyZhtJsnQlSPk14FnqMJkGW8FIpfWgZV/V5hDbkfBTz2z5zsoy
	2P3A==
X-Gm-Message-State: APjAAAXBj0OEwxsb1KW2RtGpVfMzLT4HMiIeX6VGf3e4+dt2zgfSN37H
	XZ+CTksXWEJnFqOWo4Bnm7Z7jQ==
X-Google-Smtp-Source: APXvYqzHDsClpSZlQgwJPS6TxNrMfulb50CWnoNm0PVYLameDiV0F0JEmZehN3KL1nVDAOGhwNe4yg==
X-Received: by 2002:a65:5304:: with SMTP id m4mr43609868pgq.126.1558193657695; 
	Sat, 18 May 2019 08:34:17 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	h18sm12480818pgv.38.2019.05.18.08.34.16
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 08:34:16 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-6-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <fbd8e455-d885-2637-15a0-d0cd8971bc81@linaro.org>
Date: Sat, 18 May 2019 08:34:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517224450.15566-6-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [RISU v2 05/11] risu_i386: implement missing
 CPU-specific functions
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 3:44 PM, Jan Bobek wrote:
> risu_i386.c is expected to implement the following functions:
> 
> - advance_pc
> - get_reginfo_paramreg, set_ucontext_paramreg
> - get_risuop
> - get_pc
> 
> This patch adds the necessary code. We use EAX as the parameter
> register and opcode "UD1 %xxx,%eax" for triggering RISU actions.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  risu_i386.c | 35 ++++++++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


