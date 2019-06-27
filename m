Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206ECC48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 09:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3D0D2082F
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 09:08:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S9h/T5El"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D0D2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgQNw-0006Rz-7F
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 05:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59969)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgQLW-0004NC-08
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 05:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgQLU-0002iu-VX
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 05:05:33 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37543)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgQLT-0002gF-6s
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 05:05:31 -0400
Received: by mail-wm1-x342.google.com with SMTP id f17so4833778wme.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 02:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=b4hiGFXZGy8vG8ftNMGtlqPOo+EChgLajNk9A/PjAgc=;
 b=S9h/T5ElFFRfsHOJvGGFOvUz2ocPSMU8ZT+/sq3NWGZxiauaNhKsn13Bj9Gi+5bCPA
 vJ+cWVt198NuSQoxo9gnfMkvGQokAK7L/5KxmZl2u36t5QpCLHGoEnRlXkBuLLo0STka
 lKPo98LGud4O1oharSVuR6l0Wv3unzHBmu+sQEBzlLzuSgbiH/bGJ+n/ZReqEXDRQIZd
 p2RDqTqFrSssN4g0QIAn7p6UsUzVSJSwupKizWwS8i6curJGB2j/aDWvZD5IHbO3B3T2
 ++Ou7NIT9eDf+F8SJmXmP8OcCwJRGwoY6zeAf/J6s4merl7UFG2eh55PqRc+CLS7rEUM
 6Dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b4hiGFXZGy8vG8ftNMGtlqPOo+EChgLajNk9A/PjAgc=;
 b=oyk6Byu5vhC9AkWpH/q1CPq12wcyOidZUBj6VamgPWtvrTVRKd4ix1Zw/XhBZjDd4+
 NFHHkgFOAWUIiBD3Eh/arxjbx99MTHXlIt+5E1kvwPYhNeGnSJkfKmWEurUi3gP0Xfab
 lQcjIsqZl1eQ3pKdNTr+rKaztnhpzcafg7XNbV0nLxS9jVmvEE8sKMhtBC82iJONtqgc
 s6YOhzxqH89x1cze95n3ff6GGCqhG3ZvG0AlbsZqpOMmjdrsKn6XKNzr/n/Dhxns/7mR
 sG93ySt5Lxtcdnk+Uu+rlrhz3VynO+ZrU0CgrHY2ajwXc2pI9PNMpM+z8XUFhx75WWL1
 26aw==
X-Gm-Message-State: APjAAAV2cdYhV4zMJfvdvB6dOh+hyeRApY1/p/RVV7J2Qrm/2VN3kIb1
 67oQ0Fe/05r30C1b/kXsbZQFPQ==
X-Google-Smtp-Source: APXvYqyscX0MnI7b5M5IySt2o/QOH1YUZFC0rmQ20MTf7vOWnirzvq8upzjSbNo8Qhmx8K0npVuDYA==
X-Received: by 2002:a1c:7310:: with SMTP id d16mr2323519wmb.107.1561626328597; 
 Thu, 27 Jun 2019 02:05:28 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id f1sm4008814wml.28.2019.06.27.02.05.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 02:05:28 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190619050447.22201-1-jan.bobek@gmail.com>
 <20190619050447.22201-3-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <55edf7b2-f27e-5dd3-95d9-70e958786699@linaro.org>
Date: Thu, 27 Jun 2019 11:05:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619050447.22201-3-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
Subject: Re: [Qemu-devel] [RISU RFC PATCH v1 2/7] risugen_x86_asm: add module
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
> +sub rex_encode(%)
> +{
> +    my (%args) = @_;
> +
> +    $args{w} = 0 unless defined $args{w};
> +    $args{r} = 0 unless defined $args{w};
> +    $args{x} = 0 unless defined $args{w};
> +    $args{b} = 0 unless defined $args{w};

What makes you believe that REX.[RXB] are dependent on REX.W?
Or are these merely cut-and-paste errors?


> +sub modrm_encode(%)
> +{
> +    my (%args) = @_;
> +
> +    die "MOD field out-of-range: $args{mod}"
> +        unless 0 <= $args{mod} && $args{mod} <= 3;
> +    die "REG field out-of-range: $args{reg}"
> +        unless 0 <= $args{reg} && $args{reg} <= 7;
> +    die "RM field out-of-range: $args{rm}"
> +        unless 0 <= $args{rm} && $args{rm} <= 7;
> +
> +    return (value =>
> +            ($args{mod} << 6)
> +            | ($args{reg} << 3)
> +            | $args{rm},
> +            len => 1);
> +}
> +
> +sub sib_encode(%)
> +{
> +    my (%args) = @_;
> +
> +    die "SS field out-of-range: $args{ss}"
> +        unless 0 <= $args{ss} && $args{ss} <= 3;
> +    die "INDEX field out-of-range: $args{index}"
> +        unless 0 <= $args{index} && $args{index} <= 7;
> +    die "BASE field out-of-range: $args{base}"
> +        unless 0 <= $args{base} && $args{base} <= 7;
> +
> +    return (value =>
> +            ($args{ss} << 6)
> +            | ($args{index} << 3)
> +            | $args{base},
> +            len => 1);
> +}

These are interdependent, in that SIB requires MODRM.RM == 4.  But I don't see
anything that either enforces that or validates it, either here or within
write_insn below.


r~

