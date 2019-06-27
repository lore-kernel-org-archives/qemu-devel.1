Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6256BC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 08:55:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3223320656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 08:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xoaBHPa0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3223320656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgQBo-00089J-G3
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 04:55:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57629)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hgQA0-0006Tn-Ee
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 04:53:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hgQ9z-0001Rh-BQ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 04:53:40 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33697)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hgQ9z-0001Pq-21
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 04:53:39 -0400
Received: by mail-wr1-x444.google.com with SMTP id n9so1589704wru.0
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 01:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mZB+qznjx1gb6RykpVrUE87DfPB/svc5XViJ+0mcxkI=;
 b=xoaBHPa01+mmmYzs0qqhoxfJwhwtS1knF1FKLY/lAiUH30LTSnotxEnAlzCdBTBxn2
 9tsKlyauF5qWMQjyQwcuB0IQr2oCIyt6kkBaWeMmEr6ZvUSrITh23FnGadAmwinPGjvu
 BMHHwffW064G/UmSKju3jNiQ3qlvW3NfMMl2rzN3exbtaGsvKymP+mzgINiQiD1bdOfe
 RIfrt4mnHTeG6KZl3hCxuxhWtYxuSrrhHQgrAnrp9ObctXrznKsF465YmmW3q+qBNGM7
 sNsPHoc78VIl+1qXlnj1+1mECRnaOpHzBRonHgBZVYP3eK6+Q+aAB840g5wXDqxG0HZW
 V0Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mZB+qznjx1gb6RykpVrUE87DfPB/svc5XViJ+0mcxkI=;
 b=Qj/LO3txLH9Uv3wy4O6lkdVEZ+77K6TPcm/2rRD+KeFx2Bs2E+lNcujmV0q3SqZWrf
 Zir80cOEZCWZ8wL4W28MUbPeqSf7Z1uli34jYkCW/F76TNXo7UGDWZ7XphhEy80jHTMC
 zoNOru7c/xqb4wrq3DLDgR3KXz3XQlNbwUrAT0m3iAQIm8CSBOn6l9lY7WGCm61CHfwf
 BYAWvau5d4+9nGg2wEH2ZzK1zSomciXEkyiCO5Tr6hgXRaw+HAQYH8tZmYhzNKb30AMY
 Ge1JdvdbVg9+OoSGV2Bs5pMeXaDcXOFBh0FRMfucMz6v5R3PSn0/FtpRna3INcoIPFr8
 Zt1A==
X-Gm-Message-State: APjAAAVF/9J2btdv8hbvxwa7FvvHMd8mPCxUAPpruToE8bY162emySJA
 rx1ZQtAR7HdmnSYyguswNVD4Iw==
X-Google-Smtp-Source: APXvYqwt7oFywtHHXHQW3+hfCBHMZ5p/mvg04h14sjB9iNCwV8MeqCIKZIMwOvO3uY9qLqMiTitPrA==
X-Received: by 2002:a5d:4601:: with SMTP id t1mr1194601wrq.112.1561625616909; 
 Thu, 27 Jun 2019 01:53:36 -0700 (PDT)
Received: from [192.168.2.137] (93-34-153-63.ip50.fastwebnet.it.
 [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id j132sm4820918wmj.21.2019.06.27.01.53.35
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 27 Jun 2019 01:53:35 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190619050447.22201-1-jan.bobek@gmail.com>
 <20190619050447.22201-2-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ba5161d6-5c31-fe9e-5079-04550333776d@linaro.org>
Date: Thu, 27 Jun 2019 10:53:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190619050447.22201-2-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [RISU RFC PATCH v1 1/7] risugen_common: add insnv,
 randint_constr, rand_fill
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
> +        my $value = ($args{bigendian}
> +                     ? ($args{value} >> (8 * $args{len} - $bitlen))
> +                     : $args{value});
...
> +        $args{value} >>= $bitlen unless $args{bigendian};

I think this could be clearer without modifying $args.
I mis-read these the first time around.

Perhaps

    my $bitpos = 0;
    my $bitend = 8 * $args{len};
    while ($bitpos < $bitend) {
        ...
        my $value = $args{value} >> ($args{bigendian}
                                     ? $bitend - $bitpos - $bitlen
                                     : $bitpos);
        ...
        $bitpos += $bitlen;
    }

> +sub randint_constr(%)
> +{
> +    my (%args) = @_;
> +    my $bitlen = $args{bitlen};
> +    my $halfrange = 1 << ($bitlen - 1);
> +
> +    while (1) {
> +        my $value = int(rand(2 * $halfrange));
> +        $value -= $halfrange if defined $args{signed} && $args{signed};
> +        $value &= ~$args{fixedbitmask} if defined $args{fixedbitmask};
> +        $value |= $args{fixedbits} if defined $args{fixedbits};
> +
> +        if (defined $args{constraint}) {
> +            if (!($args{constraint} >> 63)) {
> +                $value = $args{constraint};
> +            } elsif ($value == ~$args{constraint}) {
> +                next;
> +            }
> +        }

I don't understand what you're doing here with {constraint}.
Some additional commentary would help.


r~

