Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 685B4C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:21:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31EEB20715
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jHYnvDBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EEB20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibbKw-0003Md-An
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 21:21:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58524)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibbKE-0002mV-PK
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibbKD-0003yz-NH
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:20:34 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40482)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibbKD-0003yl-Ht
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:20:33 -0500
Received: by mail-pl1-x642.google.com with SMTP id g6so7181365plp.7
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 18:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5hUapDdSTy6UoCaM66PJkqib1gmdUsvni7at3Ufdd7s=;
 b=jHYnvDBVn58Ny1PQUdsLQnJQpPYnabVyORpefXghJEcMTp7k4NYdar5CnmOMda27XM
 GT6yYXdrwrLII+FwZrurAeY8wq3XhhRTMM1SebX/zEjLTMursTOHxibXwWCc7xDbtB9Q
 5Iy4Usnd+d2xeKoa8SkQ4QtE5EYvTmzOW24EawViHoBQtr0bF+HPe332P6RR2QM125k5
 1hB1Re7CEYWSMCN4O2nzUUS9hKjT7rR7QRDjMlLvVqfyLOd0mZQ0+EcnKIV6iXlZ8xU6
 G5P0IclncwYpW7g9Qp5iDC+ShhFmcc8g69hYDLgGJvYN4jrLVAhFoHXnVANQp29RoouN
 UO9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5hUapDdSTy6UoCaM66PJkqib1gmdUsvni7at3Ufdd7s=;
 b=OpanNtsZXcc7pIKRfgcZmk8UXCQtYQjeO3EZ+4PNMt5f2OCcFl4kQOoW6wCSQX+t1H
 xwk3TCP3e06e4Gqcl3dFHSb1ygrijDEZ8d6jbo6UW5ESsaBAtZl4m2XbWt11ZlSBazXy
 OZ21S0whCuHiihmE3dEmA0wC+U9n9d2kpjEQkO5FMwFEJwTQhzcYyzDURQZPcksZ3ckc
 51ye0pAz50z1RT+jbimaSEPpKpUChru3MJu8QPC2B1cAJ/opkkicVbi0rlGfA0mC1rBw
 omaLTdpLcy478SMbaQhvurD0BByy4m6HVHhYXJBKSxI8UxHNtKAbbSR3ID1apBHuSzdA
 cI3g==
X-Gm-Message-State: APjAAAWlDDbZdJv8fkh+qABVIj/3qnmeA+ceOZCwkO/0o8D7HWbs+f2/
 +rsO/KdzmKgj2zLns7KxLNVqwQ==
X-Google-Smtp-Source: APXvYqzcXDYGSuCRSjKxq1xJuolroMKTSgTJZV9U8azUqGUsCSbKV2uX9/86J7AjdunGuI+f6h+ZnQ==
X-Received: by 2002:a17:90a:650c:: with SMTP id
 i12mr33314855pjj.28.1575253232515; 
 Sun, 01 Dec 2019 18:20:32 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id u7sm31314045pfh.84.2019.12.01.18.20.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 18:20:31 -0800 (PST)
Subject: Re: [PATCH v2 06/14] target/arm: use gdb_get_reg helpers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b6b96831-6f07-f452-a888-feeda7b57802@linaro.org>
Date: Sun, 1 Dec 2019 18:20:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191130084602.10818-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, luis.machado@linaro.org,
 alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/30/19 8:45 AM, Alex Bennée wrote:
> This is cleaner than poking memory directly and will make later
> clean-ups easier.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - make sure we pass hi/lo correctly as quads are stored in LE order
> ---
>  target/arm/helper.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

