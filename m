Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42B13C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C980220815
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 12:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C980220815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54595 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRFqc-0001b2-QF
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 08:50:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRFol-0000Gl-9k
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:49:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hRFoh-00007i-Tt
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:49:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hRFoh-00005B-P5
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:48:59 -0400
Received: by mail-wr1-f66.google.com with SMTP id d9so3309930wrx.0
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=tEE4UjBX4z7ardUlhrXQ1kvjs/LJcBk85s+8v4yEK0I=;
	b=uL5IbijmPJG3MYGd7yulRkfcy+U5kOHc4K3s8bmFoJa3wgUl76iAKu0oF+2Iv1PQPK
	iQuqVOWSCt2YMCWE8OTsWwMEiJv8xJUj5OLA3Y23EfJaYTdq+kybe0EmiM61l3+hhXBz
	M3kVLw1J8iUU4lEUv0dHeIgg+5TJ0tjWwtCZdsmMaFWYj1Sj6jyPEbKcbXCTQhmIZu9K
	CGNjaBdocmJ7apny0cxwLEh+6Q+vkNoJ6fAYYndXxloZu9bVfGWuUdWmfGgXqkKEzBKL
	ByDfnPx8MKEfDgGkudBK/SyQgCkvisp0k8fJhAUvUiqA2lzzv1RjDQjC0wjxxfeVoWoO
	vTog==
X-Gm-Message-State: APjAAAXW0paLa3FlSXWgLyPZGcJQcpO3jm3GIrV3uqrTOLrBPPWs2RdY
	IvTasnJkueuvHhiieTYp3x8deA==
X-Google-Smtp-Source: APXvYqynTtNkE4Kqp02qcay/5t2usuykMCUjsGsSn22eSGpT+ARR+5dsSeLAVx5AOLADM4U1F+cuVA==
X-Received: by 2002:adf:f487:: with SMTP id l7mr31386506wro.127.1558010935377; 
	Thu, 16 May 2019 05:48:55 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	q14sm3042969wrw.60.2019.05.16.05.48.54
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Thu, 16 May 2019 05:48:54 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190516055244.95559-1-ysato@users.sourceforge.jp>
	<20190516055244.95559-12-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <76b23848-b949-8cfb-1e94-5984fa25eda3@redhat.com>
Date: Thu, 16 May 2019 14:48:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190516055244.95559-12-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH v13 11/12] qemu/bitops.h: Add extract8 and
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/16/19 7:52 AM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qemu/bitops.h | 38 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/include/qemu/bitops.h b/include/qemu/bitops.h
> index 3f0926cf40..764f9d1ea0 100644
> --- a/include/qemu/bitops.h
> +++ b/include/qemu/bitops.h
> @@ -301,6 +301,44 @@ static inline uint32_t extract32(uint32_t value, int start, int length)
>  }
>  
>  /**
> + * extract8:
> + * @value: the value to extract the bit field from
> + * @start: the lowest bit in the bit field (numbered from 0)
> + * @length: the length of the bit field
> + *
> + * Extract from the 8 bit input @value the bit field specified by the
> + * @start and @length parameters, and return it. The bit field must
> + * lie entirely within the 8 bit word. It is valid to request that
> + * all 8 bits are returned (ie @length 8 and @start 0).
> + *
> + * Returns: the value of the bit field extracted from the input value.
> + */
> +static inline uint8_t extract8(uint8_t value, int start, int length)
> +{
> +    assert(start >= 0 && length > 0 && length <= 8 - start);
> +    return extract32(value, start, length);
> +}
> +
> +/**
> + * extract16:
> + * @value: the value to extract the bit field from
> + * @start: the lowest bit in the bit field (numbered from 0)
> + * @length: the length of the bit field
> + *
> + * Extract from the 16 bit input @value the bit field specified by the
> + * @start and @length parameters, and return it. The bit field must
> + * lie entirely within the 16 bit word. It is valid to request that
> + * all 16 bits are returned (ie @length 16 and @start 0).
> + *
> + * Returns: the value of the bit field extracted from the input value.
> + */
> +static inline uint16_t extract16(uint16_t value, int start, int length)
> +{
> +    assert(start >= 0 && length > 0 && length <= 16 - start);
> +    return extract32(value, start, length);
> +}
> +
> +/**
>   * extract64:
>   * @value: the value to extract the bit field from
>   * @start: the lowest bit in the bit field (numbered from 0)
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

