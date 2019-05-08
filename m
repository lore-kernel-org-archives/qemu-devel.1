Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C21CC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:26:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8F16216F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VhXfDEyo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8F16216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40752 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOQL1-00076W-3v
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 13:26:39 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQJC-0005G8-1p
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:24:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQJB-0006UY-1l
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:24:45 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635]:35132)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOQJA-0006U3-Iq
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:24:44 -0400
Received: by mail-pl1-x635.google.com with SMTP id w24so10250765plp.2
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 10:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=HrFTSUIu61jOw1peQtA/Iupgxciy8WI3II7dT997cCU=;
	b=VhXfDEyobLRlhHEyuYgY1nNF536g578Z5WU1SfRBjCbLviXIvkd/QEJF/E/HmvW1fu
	BgvXuzpdDEKD29PyCV5DQGgszjxkOgSQ2O6ejliemsd6fxpLxYmIhtsCtRSqvMHvJprw
	jEMVEfXitCLmXT42gWTf1EuMctUq0t7I3OzzzXN+rXWZFc27rSyOXS+uQ7304GdVkpZ5
	UgX7e0Shq2fbzQVdijzEnejEcIQFf1sn/6j2JSqgcpMOxRzZOFBvCSBKyHW7jF7aNFgc
	2Z5c/p03cqtHjRo0zZOSYaB0CKvKv8gwYCnMUUBliqHNc8SxqpNPOmcVRp4wB//4Jfe4
	uUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=HrFTSUIu61jOw1peQtA/Iupgxciy8WI3II7dT997cCU=;
	b=RhiS4vA0uM5dqOv8SRmSAnLnI/nVEFPA1xP5F3AR1SEKQe59bFDdpNruEqg7AB1GmR
	SHM/ehZFuEsWZ1/OE6wn9FtX6ZXA/7XKpY7mbxIBk03iTVYVQCTT++PhU9oHgWult5QI
	lknAwoqw01s5vbQgqWjk7FdiHeZV+PRFymEx2KqmplA2bC/oK/7zQNK98mwvuvFWXw+c
	2jSNyFqZa8itxSrBpe/9mD1W584l9rSmZnrylwQwHDx88PC5YBbeyry7MBIquMmsgdsb
	5zu0axpXb+/qYN6s9uf2iVtQSh1RiFyNkfIS5YTIFPaE87HrApla+5ohIaspp7NklzD7
	J9iw==
X-Gm-Message-State: APjAAAX5BBrPSFQLvskfetTkADeYhxp6M8SqL8gey3Pl7x6lHiZnDksR
	giC4kP26bvnVEBsnHOtulCgjxQ==
X-Google-Smtp-Source: APXvYqzQoYSZJqhTo7GBdcZwNRWMS/TB33QlLAQl6E9mUcv88cViYFXN3gk6cD2bRBRunAajFpeo6w==
X-Received: by 2002:a17:902:29e9:: with SMTP id
	h96mr49022903plb.258.1557336283363; 
	Wed, 08 May 2019 10:24:43 -0700 (PDT)
Received: from [192.168.1.11] (97-113-27-95.tukw.qwest.net. [97.113.27.95])
	by smtp.gmail.com with ESMTPSA id
	u66sm22282046pfb.76.2019.05.08.10.24.42
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 10:24:42 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190508145611.107133-1-ysato@users.sourceforge.jp>
	<20190508145611.107133-4-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b3355c8f-5463-a7af-24b3-18d9687b3e3f@linaro.org>
Date: Wed, 8 May 2019 10:24:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508145611.107133-4-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::635
Subject: Re: [Qemu-devel] [PATCH v10 03/13] target/rx: CPU definition
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 7:56 AM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  target/rx/cpu-qom.h |  52 ++++++++++++
>  target/rx/cpu.h     | 196 ++++++++++++++++++++++++++++++++++++++++++++++
>  target/rx/cpu.c     | 222 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 470 insertions(+)
>  create mode 100644 target/rx/cpu-qom.h
>  create mode 100644 target/rx/cpu.h
>  create mode 100644 target/rx/cpu.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


