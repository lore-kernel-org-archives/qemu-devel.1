Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B502C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149D1217D7
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 22:49:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ppi7H/zb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149D1217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:33767 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOrqt-0001VZ-8e
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 18:49:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrph-0000ts-Nd
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:48:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOrpg-0006lG-Ra
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:48:09 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:46314)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOrpg-0006kX-Ky
	for qemu-devel@nongnu.org; Thu, 09 May 2019 18:48:08 -0400
Received: by mail-pg1-x529.google.com with SMTP id t187so1933116pgb.13
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 15:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=AeZkrmzSFIAMabPsvVTKjOEFDCIZi5BYjF0m4ztvgT4=;
	b=Ppi7H/zbmFHG6W9yRhPuvSlPecdaE5XvETU6BUmd4NYgZPOpBPH1o9mn1SoLme+32B
	WLHZ3ZVTAq952Pe67Hvp88IP3sq6WTXGnwOHBmhtNDryS9utOfDf6vT5B90YTJlgTtjc
	r1H+SHBekW8M0e3xB9v54FRjOMo3/TmidyWivmfHi5/xwLSTAlvyptobAl32O8F1ryel
	E/sH0Oi/HUJHXHtSP+Wy7o/hDX3d57/O3rdbFyIxsju5pAwBvY4ndddjfJmNw7bkJmTA
	SgdjbcORf8ysp95CZYFUDlN/bUnFdAQ+rpePOSzTzzTUVeFLItFLqNXTIAKGY09H2enj
	7fIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=AeZkrmzSFIAMabPsvVTKjOEFDCIZi5BYjF0m4ztvgT4=;
	b=slUVUgUx7LdfDOnRYxXa3oXVsBrOIz4lDer06bUnCwBmQrXflH0cgsydbYZ8JAYgnu
	FhENVD+D+aD5ENZ5EqRQsGOlqrroHbRm8nTnFy+A6t/nI/WXnjIo+kBAbUIRHjjRfiGm
	09DHmgC95ey9iMQ4YIKgtqQ73fduQauvb1gNCTu7X7BQrVOEXsEVQbGtGoXePiKv8yM0
	riTLOqJpp6eAxEAVHBfQYaWYEgcm5zbqUnrCNdJt5oGQ2MCLuUm8LiedeE91ShkqeayW
	Y5Q0T2bopmdaFL/A63maBZToCFpMwEOKrDOCvWzLb0i5BFOa5sUVr41RAmWeT08ssg7K
	Lokw==
X-Gm-Message-State: APjAAAVae9gn2NH2XYNYmKUXJtFEaIW8H09G/AI7H8omurlBo6ykiYiY
	OB8EY4fDAGaz73CoZ/IxQ51F0w==
X-Google-Smtp-Source: APXvYqxm0q8sIrtnhKho7ggsdxeaOlZdqnB0plWM4qiLcyuAAllk6/h01V6IdyxoonCrc4YaCZ7JTw==
X-Received: by 2002:a63:ea0c:: with SMTP id c12mr8947949pgi.375.1557442087377; 
	Thu, 09 May 2019 15:48:07 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	b77sm6883859pfj.99.2019.05.09.15.48.06
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 09 May 2019 15:48:06 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190509165912.10512-1-alex.bennee@linaro.org>
	<20190509165912.10512-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <252a5c4b-6ba7-6fa7-8792-fe597e766757@linaro.org>
Date: Thu, 9 May 2019 15:48:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509165912.10512-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::529
Subject: Re: [Qemu-devel] [PATCH v1 05/23] semihosting: enable chardev
 backed output
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/9/19 9:58 AM, Alex Bennée wrote:
> @@ -51,12 +51,18 @@ static inline const char *semihosting_get_cmdline(void)
>  {
>      return NULL;
>  }
> +
> +static inline Chardev *semihosting_get_chardev(void)
> +{
> +    return NULL;
> +}

Isn't the point of this function to avoid...

> -                return write(STDERR_FILENO, &c, 1);
> +#ifdef CONFIG_SOFTMMU
> +              Chardev *chardev = semihosting_get_chardev();
> +              if (chardev) {
> +                  return qemu_chr_write_all(chardev, (uint8_t *) &c, 1);
> +              } else
> +#endif
> +              {
> +                  return write(STDERR_FILENO, &c, 1);
> +              }

... this ifdef?

Better to change

- char c;
+ uint8_t c;

above to avoid the cast in the call to qemu_chr_write_all?
Or perhaps we should adjust qemu_chr_write_all to take void*?


r~

