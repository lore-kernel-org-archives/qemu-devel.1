Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24530C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:47:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E696320665
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dhihTXS6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E696320665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35202 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYvYD-0007jy-62
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 12:47:41 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYvX5-00072z-Oq
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYvX3-0006LT-NL
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:46:31 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:46207)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYvWy-0005fw-VU
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:46:27 -0400
Received: by mail-oi1-x241.google.com with SMTP id 203so2031788oid.13
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=NdDsgNS1vRliIN8o6avcKnAbfcXKt0MwnjK6Og/p7V8=;
	b=dhihTXS6hK/gEPdTIntYAEVECjFLn0t2NAacgzcadbQh3nhEscAwyljmBfgSjBHuMh
	C95TIGbUo3KkDEVGLDviswQHmzR7X/4hda002kb1q0lhMveFSBeFxgzyBqjmHwzT3/Bz
	6atDjR0Lp0R2ZbujVKzkAU0JmJQ6l+S7+5Uq2z4TVNOgOZ1gBAufM5rWA8fKDaDAbr1i
	OEdED0gRct3MB9opZdyf8Z9/IiaQPYATjiP7/Zx/rkXZ6Ld8mSVWTxkGEuqCIXxQrGeM
	5j1wxy9/DDQF+vhkrxtCa3u8ZwBvvKVbAjOmJieQ3gWfmAyAxgrCTVr7uK7rhVj5Ns1k
	pzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=NdDsgNS1vRliIN8o6avcKnAbfcXKt0MwnjK6Og/p7V8=;
	b=pbVMRd7Vy1K0wSgmbno3/ca7Vs+Rn87UMQ7rRvh/KbEIhe9NH0+JWinOX8+WFCG44C
	wDdBK79cSIBg1P+z426kxD2fJsL+nNaGer0xEmmGt6Uq799L4/mFai1gM1/mU1ANGppk
	5Wt0iKFqEFwZxesjSuJkNCqkhSagKWpO1Bsj4pxQk0M/1kt9HslRinZyI+qyaSwH3u3Q
	QOpOPdA98tS3SnazU0jno5pzwlDpOxtg0QbOl8LhRTOv/XUqG/paVd41120hTp9HQ4fz
	QohQBVaB7tueARk85q6bugGG42PVGMMsyQThfQ3QH/uPbtfuOpSkA0JMGZADsN6EQ6YZ
	BPNA==
X-Gm-Message-State: APjAAAVse+0nOZEmMEElgsL02ZGYEeZPmqQvAUaSTDg2Z4m/vB4b8fH0
	BmdQZLQjyQw0j6Nk9tiV8psW8g==
X-Google-Smtp-Source: APXvYqw3GBHW97yXfuNRxZp6gSgikXZmHH81MfUWfwkqy+2itBsKTeUwgXQIibcugDYl5Ck2/fygog==
X-Received: by 2002:aca:59d6:: with SMTP id n205mr684124oib.2.1559839577099;
	Thu, 06 Jun 2019 09:46:17 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id b25sm730080otq.65.2019.06.06.09.46.15
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 09:46:16 -0700 (PDT)
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
	<1559816130-17113-2-git-send-email-stefan.brankovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0d30e79a-12c8-7fa5-237c-25bd00682d2b@linaro.org>
Date: Thu, 6 Jun 2019 11:46:13 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1559816130-17113-2-git-send-email-stefan.brankovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 1/8] target/ppc: Optimize emulation of lvsl
 and lvsr instructions
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
> +    tcg_gen_addi_i64(result, sh, 7);
> +    for (i = 7; i >= 1; i--) {
> +        tcg_gen_shli_i64(tmp, sh, i * 8);
> +        tcg_gen_or_i64(result, result, tmp);
> +        tcg_gen_addi_i64(sh, sh, 1);
> +    }

Better to replicate sh into the 8 positions and then use one add.

    tcg_gen_muli_i64(sh, sh, 0x0101010101010101ull);
    tcg_gen_addi_i64(hi_result, sh, 0x0001020304050607ull);
    tcg_gen_addi_i64(lo_result, sh, 0x08090a0b0c0d0e0full);

and

    tcg_gen_subfi_i64(hi_result, 0x1011121314151617ull, sh);
    tcg_gen_subfi_i64(lo_result, 0x18191a1b1c1d1e1full, sh);

for lvsr.


r~

