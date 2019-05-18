Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B817FC04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80FAE20872
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QhbL7aZS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80FAE20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35378 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS1HP-0001Vj-PG
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 11:29:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1FI-0000LH-JB
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:27:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1FG-0004eH-OA
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:27:36 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636]:33756)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS1FF-0004d5-1r
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:27:34 -0400
Received: by mail-pl1-x636.google.com with SMTP id y3so4726457plp.0
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 08:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=6HEmvZotv0ZuiygPlKEUD7ayfnjWLFJSxY5VE8wAgxk=;
	b=QhbL7aZSXTOVjFP7Rkq9mPXpVugypHLByF8dioGjldK8qTPmCPRO1NZ/+/SPIjUrFM
	hl7HuY0YwxcN0GJIXLO0MSBqHldwoaywGUksNV0uGKtabmk5B5txWV7taJwkcI3435VO
	LjpCfJFY392jLnwlWotSIYRzrCG/0QK7be/RhGh77DUYqTn5LVUs7YL++MBjF6Q1AA2g
	hxDlqkOHlxg5Pv8uZ1ArFB1glRFOIXeUeoBiY1JM2quc8PS/XYkb2d6kfCB2nPrsYl+m
	+tsfS7nw3LlkxEUCY+aq6dJ7bHt0w5KqNJbnaijYOO+VNdh1Tz4pc8Jax3hKSPhDwvm7
	toqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=6HEmvZotv0ZuiygPlKEUD7ayfnjWLFJSxY5VE8wAgxk=;
	b=fAe5WbDz60mYJq7CRzElaja0AMZiKwE6EmAExXMvgPf/nA74EAkHTBusKxhnYqvg47
	+xfRvaoUFiExHLVWO1SmK7LzLLqDcu0esBnjPGKMKCw5hIxaj3T9zcdGO2PkeaGyAcwa
	z49tFq9GWOcYoffu4j0BduhBp8ct14YjxHH+oT6pCWQVUGCzxJ7UA4DgZF52yubd12kc
	ngFjgsuvtEpIB25fLuNzwzb+MLqaayfIlWxLVfDpyviibVHQZaandKYQodhwOV7Q1inw
	jSlif1+bejNBhcEt4q3T6NkDJXteppeFZATrwe62ovJP6aBCCply6ceVwEGybrUKpWuk
	hVuQ==
X-Gm-Message-State: APjAAAWlZoIfXIOAayNNGrT9PadH9m/SXiBpGK1Qsahd+7HP8I2/5Lo/
	eOOaJVf96tRSLLODgGSJR9VXwQ==
X-Google-Smtp-Source: APXvYqzA0N1yuFa3fw3d4r6qeFyT29BEWV6uVrUHTMiAePAu6Kqhk5RtfGBYtXqaxcExZdojzPTSAg==
X-Received: by 2002:a17:902:e091:: with SMTP id
	cb17mr63509025plb.222.1558193250937; 
	Sat, 18 May 2019 08:27:30 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	n12sm12152387pgq.54.2019.05.18.08.27.30
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 08:27:30 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-4-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <61b2c9b7-4cfb-7023-a3ee-bef4fbefce02@linaro.org>
Date: Sat, 18 May 2019 08:27:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517224450.15566-4-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::636
Subject: Re: [Qemu-devel] [RISU v2 03/11] risu_i386: move reginfo-related
 code to risu_reginfo_i386.c
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
> In order to build risu successfully for i386, we need files
> risu_reginfo_i386.{h,c}; this patch adds the latter by extracting the
> relevant code from risu_i386.c.
> 
> This patch is pure code motion; no functional changes were made.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  risu_i386.c         | 54 -----------------------------------
>  risu_reginfo_i386.c | 68 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 54 deletions(-)
>  create mode 100644 risu_reginfo_i386.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


