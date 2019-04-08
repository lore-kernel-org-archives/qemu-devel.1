Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40F6C10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA0B820879
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 18:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NfX83RaX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA0B820879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57440 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDZUS-0000SC-IY
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 14:59:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDZTW-0008N7-DS
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDZTU-0002hf-CS
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:58:34 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hDZTO-0002e8-Mn
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 14:58:30 -0400
Received: by mail-pg1-x543.google.com with SMTP id g8so7831659pgf.2
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 11:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=6fkTjz2w1D3OI8clBnTCyyWX/zrkqMakd5kG04MOSXw=;
	b=NfX83RaXb34x8DdTmRtK0RBZwuPrm8cuFGx5hg7KKOxx/0AvjM/zbdcSfYgDGPJZUl
	bYlacRF0AHYELuu91g/pBTYQNol+gx+r1u98ELmiG/516qWSWHYJJ54Go1wiOGIoE8cb
	a3Nts6zSVqcMOQBKIMmvpIuoPGUpuyVMfWlMOlptimheL5DcMgWong8Nldh4gJDq4SST
	Tdf6D8WdrNXFeg1tnj2jj9uncJjHOLXKKDhD7tplQs2qqT4rHmtBjdBcniDa20hdtqOf
	W81wlFP5XtthHSqRyMzU/g3e5Xxg35dPYKhrblMvGKaR3pBCHAWnttj9/UfUjwGhf89/
	x7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=6fkTjz2w1D3OI8clBnTCyyWX/zrkqMakd5kG04MOSXw=;
	b=KpGNAP3sfzIYLcEfXcI5ooj3qofVM/636/Is3+ZCu6ddHZBZXTDtwoY2tVknDCo1Wj
	lIZVjd0dfpzgBLcND8XU1xAjv0XLkm+7eNnVi40UK7+sNsQnwPfjo/SyiHYel82ouqTo
	NRxnCfQi13dgBhl/PCOrJ7TlTwa5Runxs585DHssMyyi6abPXGzmsSC4kCMuY555SKEU
	EVSCvDKovxpw7tWYkKTzPhF5bdlJtH1MPB7pazXBgNRgMbtNLtTpJ/e9xMsqTSeKzScI
	LFCrSx2t7fyfgir1yBIVlfy41Nu0MkoNkyU8KzcaPqi3p89kcYs5QT017QgwcVTbor20
	h4oQ==
X-Gm-Message-State: APjAAAWmbNo4vypnPDDtjpnpi8onkbSYK56l1DoSiNIDv+gvytbPNcoW
	8dDNWYy1YFrrmkYLx2N+BoHATA==
X-Google-Smtp-Source: APXvYqxI3I/bVBm4RobH5TRbExY2FtbeN21owYh+Z7mB3rN9A1KmvpOVEpL8+3v5LvLSDXJUeyQXQw==
X-Received: by 2002:a63:c706:: with SMTP id n6mr20480878pgg.310.1554749900699; 
	Mon, 08 Apr 2019 11:58:20 -0700 (PDT)
Received: from [192.168.3.43] (rrcs-173-198-79-114.west.biz.rr.com.
	[173.198.79.114]) by smtp.gmail.com with ESMTPSA id
	k10sm18795179pgo.82.2019.04.08.11.58.19
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 08 Apr 2019 11:58:19 -0700 (PDT)
To: Sergei Trofimovich <slyfox@gentoo.org>, qemu-devel@nongnu.org
References: <20190323222412.9825-1-slyfox@gentoo.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <bbceff60-323c-a94e-f236-f0f55751d8cf@linaro.org>
Date: Mon, 8 Apr 2019 08:58:15 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190323222412.9825-1-slyfox@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH] powerpc: fix denorm float->double
 conversion
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
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408185815.SrBzOWLXs4kbxjFD_brGjPkfMn6X_VUhOflzwkPXEbQ@z>

On 3/23/19 12:24 PM, Sergei Trofimovich wrote:
> Here denormalization conversion has a few bugs:
> - significand (abs_arg) has 32-bit unsigned wraparound in
>     ret |= abs_arg << (shift + 29);
> - significand does not drop explicit leading '1' in denorm
>   'float' when converting to normalized 'double'
> - significand had an off-by-one shift

Correct on all points.  Thanks for the test case and analysis.


> +        /*
> +         * Conversion mechanics:
> +         * float denorm (2^(-126) - biased):
> +         *    [ sign (1 bit) | exp32 (8 bits)  | sign32 (23 bits) ]
> +         *                 s                0    0001abc...def

FWIW, the overlap between "sign" and "significand" is why I prefer the term
"fraction", even though the term itself is less precise.


>          if (unlikely(abs_arg != 0)) {
>              /* Denormalized operand.  */
> -            int shift = clz32(abs_arg) - 9;
> -            int exp = -126 - shift + 1023;
> -            ret |= (uint64_t)exp << 52;
> -            ret |= abs_arg << (shift + 29);
> +            int lz = clz32(abs_arg);
> +            abs_arg &= ~(1 << (31 - lz)); /* [2a.] */
> +
> +            /* shift within sign32 includeing leading '1' */
> +            int shift = lz + 1 - (32 - 23);
> +            int exp = -126 + 1023 - shift; /* [2b]. */
> +            ret |= (uint64_t)exp << 52; /* [3.] */
> +            ret |= (uint64_t)abs_arg << (52 - 23 + shift); /* [4.] */

I think perhaps using deposit makes things clearer, since we don't have to
explicitly remove the msb in that case:

E.g.

@@ -67,10 +67,10 @@ uint64_t helper_todouble(uint32_t arg)
         ret = (uint64_t)extract32(arg, 31, 1) << 63;
         if (unlikely(abs_arg != 0)) {
             /* Denormalized operand.  */
-            int shift = clz32(abs_arg) - 9;
-            int exp = -126 - shift + 1023;
-            ret |= (uint64_t)exp << 52;
-            ret |= abs_arg << (shift + 29);
+            int msbm1 = 31 - clz32(abs_arg);
+            int exp = 1023 - 126 - (23 - msbm1);
+            ret = deposit64(ret, 52, 11, exp);
+            ret = deposit64(ret, 52 - msbm1, msbm1, abs_arg);


Thoughts?


r~

