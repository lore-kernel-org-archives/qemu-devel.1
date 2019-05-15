Return-Path: <SRS0=zTTU=TP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00725C04E53
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90A320818
	for <qemu-devel@archiver.kernel.org>; Wed, 15 May 2019 16:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gRXFpDOj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90A320818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39508 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQwhX-0006gF-JA
	for qemu-devel@archiver.kernel.org; Wed, 15 May 2019 12:24:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQwg8-0005sY-VH
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hQwg7-0006d3-St
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:22:52 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hQwg5-0006ZV-VS
	for qemu-devel@nongnu.org; Wed, 15 May 2019 12:22:51 -0400
Received: by mail-pf1-x443.google.com with SMTP id b76so229930pfb.5
	for <qemu-devel@nongnu.org>; Wed, 15 May 2019 09:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=C1oyxAzsQeeNCGbw5lRtk/JX1xi9l8PA9oCk2tyAWgs=;
	b=gRXFpDOju7t8cUfjSKzNsR4/s1o3UbLKG9KZYBdt94GEnvuOw3KJ+0Fi8LL7VJxC/n
	YQB+7Wv8yySHuqXnB4TdaHDRBQzy2qFok6MnLwRPvAyOfBBbIKtmQl65tmT2/929kQ0j
	MZkjXw6e5zhGvTNvHr774R4bIiCr2dkPsnvjI7tUdxIQbD3etcixLA/GxalOW7HRjFYe
	mHKN/hLEhdMPTzqNJdLxtdEKALVKtmrOopt0LgQlD8wa1iILQU+jQhGJSFGKWPW3p908
	75m65J5D/bA/DFxl3XRgw+5UB1oBPj3eQ6DaUWxgXSj8ddoM0G7xJkSC/0nQ5BFOpvW/
	Ejzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=C1oyxAzsQeeNCGbw5lRtk/JX1xi9l8PA9oCk2tyAWgs=;
	b=WWJb+ttUxMyiF76VUl/gnmNgwHcdQsMfJ0VQsjF4ZEsIFnccaeQ1AyxWQ8P4QWZQSQ
	fPmA92ud+FNrLu8G6LkGq31hM9jLLNE+qLTgiY9W978lGc1ckER0kTUwB2be/84/QmxI
	4Ib/9TRxmoU048r3Riu71qHqVcyzgBjbT62eO0mLmJWIf4O8rYKTZV1JxcZ3ykUhZrth
	Ms2+8GormkVrmPXRp+YbskV6cH5AWDnxYR1luFALxWRxzpdkOVMnMdHT8kU4jf6Tg3aI
	k/qNq1ZxL9j4KWFpHYLG6RmyDTQTTl/1ZRKuTyyCsDEUbhIrdYHd9qLXSlDhfH235z8V
	YgYw==
X-Gm-Message-State: APjAAAXmoPC35Zrbeeu46syQ/5nwPI2sXYa35UuglfMtr7u7TkwMWhXP
	+IdH4PQZuKScpr8AVlORwX5xEA==
X-Google-Smtp-Source: APXvYqw0OPypD02DkghfO9OWuckb5abnN+NLiEK/PTogyG03yr720Q2/nt80wW79fIzejQV85lqxvQ==
X-Received: by 2002:a62:1a0f:: with SMTP id a15mr26955486pfa.111.1557937366487;
	Wed, 15 May 2019 09:22:46 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	t5sm2795592pgn.80.2019.05.15.09.22.45
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 15 May 2019 09:22:45 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190514061458.125225-1-ysato@users.sourceforge.jp>
	<20190514061458.125225-12-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d7a58033-efe2-d911-f5fc-fe1f066d69ae@linaro.org>
Date: Wed, 15 May 2019 09:22:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514061458.125225-12-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v12 11/12] qemu/bitops.h: Add extract8 and
 extract16
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
Cc: peter.maydell@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/19 11:14 PM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  include/qemu/bitops.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

