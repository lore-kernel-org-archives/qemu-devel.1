Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C1B7C76186
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 21:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E0592082F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 21:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oITWAqjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E0592082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1howlP-0000Ot-8o
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 17:19:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33422)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1howlF-0008PO-GC
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 17:19:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1howlE-0007TV-IB
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 17:19:21 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:36110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1howlE-0007T0-A7
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 17:19:20 -0400
Received: by mail-pl1-x643.google.com with SMTP id k8so17297854plt.3
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 14:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8AiDs445dVFar3qr6Bp5S88rB6vyJdlepXlTrmXkM04=;
 b=oITWAqjXTgiadzjr19mtv6DH11B07FmWqJBogyXPw7/gXJvXrkG3TeclnG7NUKqogX
 yjhUzPXs9lVb4KntFJZwQ28AZq4+iLHVuelHKdT8Omm4bNuhPgWqTSzlQcJf2fiZHeiz
 zdKW26ToNxG0QajmMwVQfT3qjgVhOCJfFPnuvVfhdO/kiqmT4gWlUkEHMJU/KgE1UobT
 KQqKRQhiSrKMl1nGScfYh5f9nFWN6yC6frma2kSYTk3mzUBfWInwLafrTtRiJNDn7acu
 wA1ri0GlFAeJnn9TBFrb49nWRB6CUNjkX5MCeOT5jZx7pYdM/bGhzabiCb2d7YP4l0hf
 LB/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8AiDs445dVFar3qr6Bp5S88rB6vyJdlepXlTrmXkM04=;
 b=DolxRqjolnsEHE9dkn8ELUc4eNfJPACaCvRmW8QbnmSwwOBDXOiaWG84d4CbAnaV5d
 IIuAJntAHYErI5B0N8/NaJt5R2Qfk7766MzpFJbiosk2zz60FZs7ZWzBii4X5BHDr9yN
 dPZ0UqO7BOPy9qvIrKWEX+VheIhOGB3MxfWSMosTP/XTK+JOB1vUJTsw56VIeDUYL+ii
 EY8RCN58g3VI339YNDMsdVrC2Azk1pblKDS7j5xHpQYxxvoJp7NnwsMQwtsnmcdkCsqD
 BBy4E2+82tqBZauxGhj2kkJ384lCfAm5hCv2PfXvqBFOv8Z1wHZadWpOcDmemEyQAkhH
 FoyA==
X-Gm-Message-State: APjAAAXOB4vXODWPcySyuz5kXYT+kWIXHBGe5/2eesE/81xDDNe1fbSE
 gRpXwkqEtK0yfgE8BPIZgAim4A==
X-Google-Smtp-Source: APXvYqyJdfqEw3adeT5fAqtsmcNfTzhD+wXTRXc3rH73L00rHr6Ysbdnal0VmQ4TDI2tf1DSDgP+ZQ==
X-Received: by 2002:a17:902:12d:: with SMTP id
 42mr61988375plb.187.1563657558135; 
 Sat, 20 Jul 2019 14:19:18 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id 3sm37727616pfg.186.2019.07.20.14.19.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 20 Jul 2019 14:19:16 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-13-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ba0834cd-7b1c-3bf7-881c-8de1d9591b08@linaro.org>
Date: Sat, 20 Jul 2019 14:19:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711223300.6061-13-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [RISU PATCH v3 12/18] x86.risu: add SSE2
 instructions
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

On 7/11/19 3:32 PM, Jan Bobek wrote:
> +# F3 0F 2A /r: CVTSI2SS xmm1,r/m32
> +CVTSI2SS SSE2 00001111 00101010 \
> +  !constraints { rep($_); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
> +  !memory { load(size => 4); }
> +
> +# F3 REX.W 0F 2A /r: CVTSI2SS xmm1,r/m64
> +CVTSI2SS_64 SSE2 00001111 00101010 \
> +  !constraints { rep($_); rex($_, w => 1); modrm($_); !(defined $_->{modrm}{reg2} && $_->{modrm}{reg2} == REG_RSP) } \
> +  !memory { load(size => 8); }

Best I can tell, these are SSE1.  Likewise CVTTSI2SS.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

