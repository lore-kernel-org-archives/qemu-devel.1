Return-Path: <SRS0=2W3W=T4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66B3C04AB6
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 21:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E49A2075B
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2019 21:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rKiIEUNf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E49A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43032 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVjki-0003ZA-6t
	for qemu-devel@archiver.kernel.org; Tue, 28 May 2019 17:35:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hVjjv-0003DC-P0
	for qemu-devel@nongnu.org; Tue, 28 May 2019 17:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hVjju-0008Pd-TS
	for qemu-devel@nongnu.org; Tue, 28 May 2019 17:34:35 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hVjju-0008NY-MN
	for qemu-devel@nongnu.org; Tue, 28 May 2019 17:34:34 -0400
Received: by mail-oi1-x242.google.com with SMTP id w144so281215oie.12
	for <qemu-devel@nongnu.org>; Tue, 28 May 2019 14:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=mbCa80eI2fD0zcMHDnr9VPez84wtN+Cgrkhyv6gWRiY=;
	b=rKiIEUNfcSgDoFwa169GYJ6CEvbqOrziekR3POa4nnNGKuO2T/tmqjOc2YIGPAW7ob
	fWCxjz5nU/XFIqYTg84g3afoMULDlxqCcuQU8KLW3Dpe6aG1EKG7KSvzceiQj8WHkOtM
	VtHYRzSVJ44GptAFjqJ8yXN7P022sLtcO9VtV7p2EcrXkrXf9ZuVHEe9CzdoULlpgJrz
	NlWaVsnKISWQXd6GlyLNsu8o6HOdY8rj5NOr1EA/+lhs7QG/HMB1IaxC3ikpOKROpb8o
	aol8yFXD5BtFPls71U+mlz/URT9qMSer5iybZCFMPpQ/AZh5avW1j+2qUlZutGRBmfjk
	VcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=mbCa80eI2fD0zcMHDnr9VPez84wtN+Cgrkhyv6gWRiY=;
	b=KST3KswWu02bsfGSjxJA+neni3W7SkAwPpIWFMmOq4A+HZ/q7w0UrQwdsbo9RewA1V
	2Unib7me6RZuZZnZwa2AEbZ+TsYdzXOAbuIIr0fufpHHyosXt/5YDUpFpjgbyAHywSlE
	Lui7KEbyvo49nsYq2E/lMI05MEreA/Tc18HQCiYd9Ds4/8lD3gcthvYtWLYookU00imx
	ch6EzWSXettrleFipqzYeAP0TgQF3Bxzq9OT5gr+2HqaDz32bulsd9AbjXKWX6hKfdGy
	kis49ki7JUVOJgc1kLsxw5DIzWqhPkLJo/uJX/CzeDyule8WXHScJsIqCsNP9xTlgvHV
	nqeg==
X-Gm-Message-State: APjAAAVHMyyujDIKTGB24Ocp4rU84vSOYmyZua9aqnc2dqUrd5xIZw1h
	9P+btwTOUd/6AF0qfMVp0o+Ctg==
X-Google-Smtp-Source: APXvYqzCvFEao0D5GvD2SlMXAQzVeeNN3fnvlOjFxk3bjOLD/c8w+E41KdEpAtxX4W7zWQlUyyI18g==
X-Received: by 2002:aca:dec4:: with SMTP id v187mr4194082oig.19.1559079273430; 
	Tue, 28 May 2019 14:34:33 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168]) by smtp.gmail.com with ESMTPSA id
	w130sm5819738oib.44.2019.05.28.14.34.31
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 28 May 2019 14:34:32 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190522222821.23850-1-richard.henderson@linaro.org>
	<20190522222821.23850-17-richard.henderson@linaro.org>
	<a8a1fd49-c368-ed38-4d56-8743db5dd5b5@redhat.com>
	<7d00bc45-fbc5-9096-af44-253779063319@redhat.com>
	<09cb162c-594c-4863-2dfd-ae30b218bc9c@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d0a8b16f-e0f8-64b9-3ca6-3ef044c18af7@linaro.org>
Date: Tue, 28 May 2019 16:34:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <09cb162c-594c-4863-2dfd-ae30b218bc9c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PULL 16/16] tcg/i386: Use MOVDQA for
 TCG_TYPE_V128 load/store
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

On 5/28/19 1:46 PM, David Hildenbrand wrote:
> FWIW, this seems to be the easiest way:
> 
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index f0d9a6a36d..d363ae0fb3 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -66,7 +66,7 @@ struct CPUS390XState {
>       * The floating point registers are part of the vector registers.
>       * vregs[0][0] -> vregs[15][0] are 16 floating point registers
>       */
> -    CPU_DoubleU vregs[32][2];  /* vector registers */
> +    CPU_DoubleU vregs[32][2] QEMU_ALIGNED(16);  /* vector registers */
>      uint32_t aregs[16];    /* access registers */
>      uint8_t riccb[64];     /* runtime instrumentation control */
>      uint64_t gscb[4];      /* guarded storage control */
> 
> 
> Makes it work for me again.

That's the right fix, and exactly the bug that I was hoping to find with
11e2bfef7990 ("tcg/i386: Use MOVDQA for TCG_TYPE_V128 load/store").


r~

