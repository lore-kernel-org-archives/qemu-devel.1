Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F487C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:21:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A61421530
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HGOX9xMK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A61421530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40660 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOQGF-0001vn-6M
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 13:21:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQEa-0000lO-Ln
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQEY-0003iw-I6
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:19:59 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:46507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOQEY-0003hq-AF
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:19:58 -0400
Received: by mail-pg1-x542.google.com with SMTP id t187so6296963pgb.13
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 10:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=GxKlty//NneSEPGk/Yjl9BRLXR7xfKa1PpDqtzNF9P0=;
	b=HGOX9xMKp0gqcEWl5unpgmqx8QS2Hh0Gmg60RiV2yq6bVVA0wkpx0ZwKhASGwengfh
	Av3d6zERIwBMxsPPlYyvEZAxjLYqezeFhubDOWQV64MXrRSmVoiisYcu/8CB2d138ZpT
	T8ts0OjYt7711N1ZwJ9j2D8d+7m3XHCnrG8IbkVYEyra4On3pDxMk4Y9Rbk9Q+4tq8tg
	RuTi7oaI0kjpjCiPs+bfhd2P6RNnZhweTn9iClYt2lYRHnE/m58BQVHBkFiSdT4U7FgD
	nUxUmN8lK+8tQWgWB9ymENmRFGbkaQslj/PoxEvuD1O9lo9ttUMo7qeyYbZAtatUlRRB
	GPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=GxKlty//NneSEPGk/Yjl9BRLXR7xfKa1PpDqtzNF9P0=;
	b=PjGQsv6wcc2sn7kOQG4Oc6yeM1EIaRImXtT9dWMKHhBjXtiOTes3dYiFf5sEglFGq4
	+zXPK0z684qS7EUXrUd4A/u63jcXUlqcpsZ49YM3ARz4DrUqRl61FFZaQud8prDVyhnv
	HDAzcS58JrndGiNFb5hc6ZnlpR/7ZLXmHHEIrZMmNYAqeEUAgy7gDY3LxmXRnS8SuYmW
	FBIw0pINg0orKN/h0VCW0BXoQlulkpOt3sCaUXUYudenrkuSOQJfmknqcXA/ZoYgCdPk
	wmtcuD3XKfddHrvHo6/HaH7R1kp3jzuc5inrOsa8PmKI0yDP98UbtcZdBZDjYaP7pp9G
	THpQ==
X-Gm-Message-State: APjAAAWHpRpaC8rursER/NgnqvSkoCYwkbEVIxg6XF753a0eOsO1yAd5
	nvBx+EB5kTaaaZRtO0x8DF2MTw==
X-Google-Smtp-Source: APXvYqwbrlaUJ7rpPnQJs7SKR3ITJlNiMtuY5ahIDPN8gd3Vg8wPLuAs/ZSaqfiQC48R3Y+IMALB4A==
X-Received: by 2002:aa7:8652:: with SMTP id a18mr48896437pfo.167.1557335994944;
	Wed, 08 May 2019 10:19:54 -0700 (PDT)
Received: from [192.168.1.11] (97-113-27-95.tukw.qwest.net. [97.113.27.95])
	by smtp.gmail.com with ESMTPSA id
	128sm20006474pgb.47.2019.05.08.10.19.52
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 10:19:53 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190508145611.107133-1-ysato@users.sourceforge.jp>
	<20190508145611.107133-2-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c78b8c6e-2636-fa9e-df19-50c2b082c09a@linaro.org>
Date: Wed, 8 May 2019 10:19:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508145611.107133-2-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v10 01/13] target/rx: TCG translation
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

On 5/8/19 7:55 AM, Yoshinori Sato wrote:
> +static bool trans_XCHG_mr(DisasContext *ctx, arg_XCHG_mr *a)
> +{
> +    TCGv mem, addr;
> +    mem = tcg_temp_new();
> +    switch (a->mi) {
> +    case 0: /* dsp[rs].b */
> +    case 1: /* dsp[rs].w */
> +    case 2: /* dsp[rs].l */
> +        addr = rx_index_addr(ctx, mem, a->ld, a->mi, a->rs);
> +        break;
> +    case 3: /* dsp[rs].uw */
> +    case 4: /* dsp[rs].ub */
> +        addr = rx_index_addr(ctx, mem, a->ld, 4 - a->mi, a->rs);
> +        break;
> +    }

You need

    default:
        g_assert_not_reached();

to avoid the compilation error pointed out by Phil.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

