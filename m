Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBECC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B73C620868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 17:04:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/5MXqhE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B73C620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35375 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYvoc-0004dB-TI
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 13:04:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYvnK-00041u-1j
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:03:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYvnH-0002j8-I5
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:03:16 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:44290)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYvnF-0002WE-1h
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 13:03:13 -0400
Received: by mail-ot1-x329.google.com with SMTP id b7so2611792otl.11
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 10:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=7cYNqzCZv+mh0g4ckV8RR0xyUU2FdMFvpFhwzR7hqas=;
	b=G/5MXqhEcobd8dUC/ybANQI8CAr++Wkqv7iHNJQV8kQueDzpZww2mrVMVRGM5yUw2Z
	V+n1uixb/wOmcUGW1jPyqzy/vW0Lu4Op5ML4xeMgWHvq8HAiZkcrUKB7s8ndziXd+CJS
	kCKCPYBH7SDVGtM6UH0XQSN2IELFiyw6Za4Tnwff7p/+/a6l2nL4FExSodIg7Yg7zuq0
	8N1KuDMKqDD8ICsWMiCo5596v4m+JQdM66yHslWflTwqFsFzR/kJ9yfXTDrDPGWitPTP
	cqOkL/IXLkoWM7k/bYfBtJ/1bpO3BwQTQiQ4rPVsfOM2HDr4vdQKMuHX8+w0zpWI8RlB
	WiDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=7cYNqzCZv+mh0g4ckV8RR0xyUU2FdMFvpFhwzR7hqas=;
	b=AyeclHDKr92uJDeK2x+btPU45V3Awa/cvVqAzwvRkngJjsxeCc+wetcjGF35/dwpEo
	gNvPc+HSy8SRw1xrH1c9wsVO68nKvMxBCubqmViw0HEKSj9GW5OWCbzsRSCsUNuGz8SG
	t1kih7/H8JHYSLXZGzCT3JxwUi4ZIWoDCoKzVVyFxbJN6BkGa4StTtKa+15jmH36tWJz
	6071iBum9eA+498yLvvuVkfeAqsjd8DD39+lHQSwZoDidqIHTdtVuOQpwm0RxA1u3Hzz
	bPJJDJ03pm5wBHGCvUpaLHPDl3tvNV4mu0ppkjiSVq3MAdarYviGPsO6FZ4kXRyUd05F
	ZjCQ==
X-Gm-Message-State: APjAAAWE0LscUBjUSZvQj+QAMg2nOXP69PPZjQOVJyVK3EXys/CLE1Ay
	dMJ14dL0t7JzOxisrp6U9u6IqZO9wRmuJg==
X-Google-Smtp-Source: APXvYqyL7cQ7flmo4ve4KTeUDrHpCkjmpAMi5b/DYzEJ8M7iWOXYtsV//nu6H1lSICxvu4qB3sk/Sg==
X-Received: by 2002:a9d:27e8:: with SMTP id c95mr15841222otb.101.1559840589864;
	Thu, 06 Jun 2019 10:03:09 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id k17sm794119otl.13.2019.06.06.10.03.08
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 10:03:09 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
	<1559816130-17113-3-git-send-email-stefan.brankovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d73b67d1-5776-d9e6-3d7d-2c3e84f3b9a9@linaro.org>
Date: Thu, 6 Jun 2019 12:03:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559816130-17113-3-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::329
Subject: Re: [Qemu-devel] [PATCH 2/8] target/ppc: Optimize emulation of vsl
 and vsr instructions
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 5:15 AM, Stefan Brankovic wrote:
> +    tcg_gen_subi_i64(tmp, sh, 64);
> +    tcg_gen_neg_i64(tmp, tmp);

Better as

    tcg_gen_subfi_i64(tmp, 64, sh);


r~

