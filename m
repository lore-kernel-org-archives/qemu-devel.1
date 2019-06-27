Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57FF1C48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:33:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167C420828
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XYvz23GO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167C420828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgRio-00062x-Bj
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 06:33:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50025)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgRfo-000505-Vj
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:30:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgRfk-0006s7-46
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:30:34 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgRff-0006c1-2n
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:30:28 -0400
Received: by mail-wm1-x343.google.com with SMTP id x15so5195080wmj.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 03:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=M52qTtcy0BAzLRs2pwfUlFO9XOoPcOXtomcXyBni8vY=;
 b=XYvz23GOj0/54qofjSFw1iROxrWIeE9mYllptZae686sycue4rryqnMGoltmqIPuGD
 P9fEgr7FyJlVhsd3K2lVim2y/ZZMWjZmqb0AKAwVKnS7Tn34bUAy9TmV5A2QRl0r6wnu
 CG+Q8c+hValcLhbzb1TCnZX5zGdPrZB7tEpylA62K0H+SWtH/0onayXF6msOzdA2MMvQ
 4G41m0owEZNmzjq41Ckb5D1fos16INBiQN9YyY9dTNmJkg1FgYjAMLt4aIHFRIfnBIwD
 C3w+LPzhONamqgbmqhMVosjm9ZZixlTkT9SBIiK5PBBbznoRp8nfd+KwNu2C+XyeLs4w
 zKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=M52qTtcy0BAzLRs2pwfUlFO9XOoPcOXtomcXyBni8vY=;
 b=XkW8SHWQdhWbc0LQZVOOYULRGtvpoYS/IuuLwgmuQe1V8zNTVKRVpq6ZFcpiF9QRRZ
 Dh7N3fLBzFkGl1j4V0vpK97D262O5963TUAY4CT6oAUeXHRR5hp/68yuTglFeYQnA2Vn
 qgVez4U6nKn0Z1gnLO9tL2ywZCTTTYLQ+bbKBXxXpIo9PcTiOG2IdITVK4TbR4SkEhb6
 yoDGDFVtIwI23GEQna7BMfYiMYu+NksevyUOqHs8RxnrflHY6m081H965MzBoH+PBJqM
 R367B+hU5vh9RqaTSu+wG3Gp/5Gqe9fqUMcUokror0VX/zeYXYRzzV8EAmA46mdHfw/q
 WMxA==
X-Gm-Message-State: APjAAAVXXUAd9HoyXaRe3B7+3JSTO+5/Y/jwMtq7752OOOY2VrV/yrxJ
 KtK4Sol8bOmkH5jyx7GZV7EQtQ==
X-Google-Smtp-Source: APXvYqxVDrb/VRujKMMc0KRcPLUatNGj5JLfJ3/Q5ewro0pALOOXiMlkAXcdPh7mNVwqZrEytcSJQQ==
X-Received: by 2002:a7b:c766:: with SMTP id x6mr2843948wmk.40.1561631417695;
 Thu, 27 Jun 2019 03:30:17 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id y6sm1944296wrp.12.2019.06.27.03.30.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 03:30:17 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190619050447.22201-1-jan.bobek@gmail.com>
 <20190619050447.22201-6-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6a1ee504-b334-684b-9ba3-09fd95d45237@linaro.org>
Date: Thu, 27 Jun 2019 12:30:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619050447.22201-6-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [RISU RFC PATCH v1 5/7] risugen: allow all
 byte-aligned instructions
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

On 6/19/19 7:04 AM, Jan Bobek wrote:
> Accept all instructions whose bit length is divisible by 8. Note that
> the maximum instruction length (as specified in the config file) is 32
> bits, hence this change permits instructions which are 8 bits or 24
> bits long (16-bit instructions have already been considered valid).
> 
> Note that while valid x86 instructions may be up to 15 bytes long, the
> length constraint described above only applies to the main opcode
> field, which is usually only 1 or 2 bytes long. Therefore, the primary
> purpose of this change is to allow 1-byte x86 opcodes.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  risugen | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

