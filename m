Return-Path: <SRS0=i8Yf=47=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30078C0044D
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 09:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9D272073C
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Mar 2020 09:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wNEUkZgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D272073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jD2nD-0006tp-3V
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 05:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38681)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2md-0006LB-6j
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jD2mb-0008TD-7f
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:08:38 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46652)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jD2mb-0008QV-01
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 05:08:37 -0400
Received: by mail-pg1-x544.google.com with SMTP id y30so6451643pga.13
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 02:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=FAMcJQAFrXIY8F3+mTu0MyN3DE6W++w2LB1aMVn5Jaw=;
 b=wNEUkZgpg0dX8ru+K0z/VYnSL8LJbfH0ZvmbYc4yLjNi5N/BvsZ4qjp+9ZrKag43ZU
 qWDrGtpR5seNCux58ohamFmPTgcjRyMfhlmQsjGr/CD3b2pPcniIxdjBVBmTKsuZxbsE
 yeK6q/uzH+KvrrEh1ZpQva0AebX7vRJjDZYfzCsU+PbzlHvavqJ5fWH7jvi83Zi/PoqZ
 djSrtyzsRy7cZUfpbGyGiGmLPm6Fbt1Gs/B1yS79c1+gYncsYK5rradW4gnDCgbmJp5M
 HZ2eIdqbHWTj+lGDfM/FvrsgeVUgsUhMTmnbRUWc5SazPyI6crNFyqKMlHsI0a2IRMRL
 Hz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=FAMcJQAFrXIY8F3+mTu0MyN3DE6W++w2LB1aMVn5Jaw=;
 b=Muom5LE9Vjq8n27FgBm6EUA8tRLiOkA857R3U/S+7QMKZEQro8QJVvNMnpM1nI7Iow
 d7IqS8AGLwDIL6sZ9U2Qn4cAQAxI5BH3em3jjAeEEIP6rqv6E1eqI8Fry8GLj2Wm9mid
 KgL/E4OFsJBgAl85h/vRWaq0V5yst1FNgFP/faYHcieDniUvuEaTHVHxcFUvTwSpMMn8
 Nn3Hwq3IKWasYxnau5evMGlYn3M6qjl7l7CHGU/dbA6Vc8CMAA5Cr1bZCQGONk86/z9D
 HwqTVmLWPDLL/WDejBiTPQExsW3WRxZD84LNeS7wBT2eHeNWeku+N3KRT2uViJL84QKF
 EBwg==
X-Gm-Message-State: ANhLgQ1hy1OLGTdot9yqI8twuudxRIFYIGhY23T803SKsv674GDivFy8
 fN7Q2TgVSULNpWJxVdhE7BvujA==
X-Google-Smtp-Source: ADFU+vs7N0hheqsOmGbCwEacTMpGqqaeCtmJnvC+ji0sGfRC7wwIYd6MkemEYkIwCuE79+Xncjy/7g==
X-Received: by 2002:a62:2e06:: with SMTP id u6mr17240236pfu.262.1584176915538; 
 Sat, 14 Mar 2020 02:08:35 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 c83sm19908328pfb.44.2020.03.14.02.08.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 02:08:34 -0700 (PDT)
Subject: Re: [PATCH v5 38/60] target/riscv: vector floating-point compare
 instructions
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-39-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cf8688d1-560c-73f1-8e62-559df34e3eeb@linaro.org>
Date: Sat, 14 Mar 2020 02:08:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200312145900.2054-39-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/12/20 7:58 AM, LIU Zhiwei wrote:
> +static uint8_t float16_eq_quiet(uint16_t a, uint16_t b, float_status *s)
> +{
> +    int compare = float16_compare_quiet(a, b, s);
> +    if (compare == float_relation_equal) {
> +        return 1;
> +    } else {
> +        return 0;
> +    }
> +}

You really need remember that boolean results in C are 1 and 0.
You do not need to keep translating true to 1 and false to 0.

> +static uint8_t vmfne16(uint16_t a, uint16_t b, float_status *s)
> +{
> +    int compare = float16_compare_quiet(a, b, s);
> +    if (compare != float_relation_equal &&
> +            compare != float_relation_unordered) {

Indentation.

> +static uint8_t float16_le(uint16_t a, uint16_t b, float_status *s)
> +{
> +    int compare = float16_compare(a, b, s);
> +    if (compare == float_relation_less ||
> +            compare == float_relation_equal) {
> +        return 1;

Indentation.


r~

