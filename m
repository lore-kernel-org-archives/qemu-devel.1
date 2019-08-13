Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ADFC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 06:08:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B7720679
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 06:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aSY7JH1U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B7720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxPya-0000nB-W2
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 02:08:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50771)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hxPy9-0000Hp-U2
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 02:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hxPy9-0003Qb-3Z
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 02:07:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hxPy8-0003Q8-TH
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 02:07:41 -0400
Received: by mail-wr1-x444.google.com with SMTP id r1so7515226wrl.7
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 23:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XNVjCBoAv7zEoGiDgEi/qhFo9gc+LI1CvykQD6jVo0M=;
 b=aSY7JH1UIRSpWpTqxSLR+uDXTf8KpPRzzi9SXRanWCfdP28DrksZmGOKjwHooD3WYf
 mcEMVQMT54v1fet3ozkW1tcfpDkbnY2zBK1dHp1pT7iSst+Ynywt8bMWPpwfivxwpXAA
 O+nW2cgVI1VMj2FYhEde2ArfcaPSZYrGwZTZ9FmMQEDvaIuSC4JQ/ojxdaWp8rOVsWGl
 CNlfZfOrU4bamU+dO2qI9SLww+EXlrDmqtJ6tNu8/lBuDTLLwHgKGEbklRaMKRRlR+kr
 MIoZSCjbMl5EOSHPbFMveSCp03RdjyAXWqR0/ewhvm5L0ca0M+Wm61E5/KCT6/u4dGuZ
 /4AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XNVjCBoAv7zEoGiDgEi/qhFo9gc+LI1CvykQD6jVo0M=;
 b=Q1PhXAscPedujY6Kkz4T9NetGA4+lLG1GzS5F35JZ4PRTf0abzqQcdhWEuIVfE2dyY
 OuDIzFgoJifO4BGE8Lp7W2E6CKd3B7LvFxn7WQjkdt+ZfLiD/0KeKyFHcriLtP0nOSXE
 +vkrXj1zj+Of70mhyibHkW4jh6Xa1z9NfJZ8fctRXnKzwCuKRHdlY+ca7vwEe7tVsnaS
 hAxhadMflAlpKFel834zfCtL78Z0L/dHP2LNhzLYOosAEpcpzJk4uRDaoYiauStpV9wc
 c9PWiruR0drGCkflbSZPxWLaH7y6lz1nbcn4gu/cPGwuC1po5/MK8BmM/FL6/OkBMk72
 d9UQ==
X-Gm-Message-State: APjAAAUVtDHlzVxOgHtYp1CvETF8g6Lw6QesSCzogcYuUfKUp1oTLt4a
 WR/xJVZ4MR1RUrLS5yVV9vH9yA==
X-Google-Smtp-Source: APXvYqxml6koHY5FUjSBUqlcsk41BE3jd2Z1Pb5+vStQm4TWIw1+EAZafALBPaKgqWfrV+JqN2aTPA==
X-Received: by 2002:adf:f507:: with SMTP id q7mr21217018wro.210.1565676459401; 
 Mon, 12 Aug 2019 23:07:39 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id c6sm491772wma.25.2019.08.12.23.07.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 12 Aug 2019 23:07:38 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190810041255.6820-1-jan.bobek@gmail.com>
 <20190810041255.6820-17-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b0bfa230-f508-ace2-6daf-75f2156251d6@linaro.org>
Date: Tue, 13 Aug 2019 07:07:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190810041255.6820-17-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RFC PATCH v2 16/39] target/i386: introduce
 instruction operand infrastructure
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/10/19 5:12 AM, Jan Bobek wrote:
> +#define INSNOP_INIT(opT, init_stmt)                                \
> +    static int insnop_init(opT)(CPUX86State *env, DisasContext *s, \
> +                                int modrm, insnop_t(opT) *op)      \
> +    {                                                              \
> +        init_stmt;                                                 \
> +    }
...
> +#define INSNOP_INIT_FAIL        return 1
> +#define INSNOP_INIT_OK(x)       return ((*(op) = (x)), 0)

Return bool and true on success.


r~

