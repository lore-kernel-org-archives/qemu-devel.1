Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18618C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:47:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6268208C0
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:47:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OnW2yDFW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6268208C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52392 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd0P1-0003Zm-0q
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 18:47:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37848)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0NA-0002YC-QC
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0N8-0001XK-O7
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:45:08 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c]:35077)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hd0N6-0001U2-Vn
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:45:06 -0400
Received: by mail-pg1-x52c.google.com with SMTP id s27so6567965pgl.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 15:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=pUDVQKQj1TLD3PHHgA5b8e9ekK1wLWz6ypVOSNFkXyM=;
 b=OnW2yDFW85etToT2mqW4lxh5K+ZFz/AaRfwp6Q215OS9em86Gi+5eTBaP/AGRX+Pah
 4D+5TJkZfW6JHRELgUnJhfEqEv/icjYxoU8QDx//vy+mLSKRaPz//Jvagtj6oQxqK4SJ
 mpsE3ouGgaYJ9q9CdvWda0rBaYbP7gXMWUp/HmbwobSaqzoECbDtTsukJegiFGmZvF97
 GrcfSUBrrXv23s44J1pCNa1V2AzNjYQ9s50bejrobo8qBTLbvpC/o7Mifk7H6ovvYTzG
 Dpb5g+2+u8icXNX/L4rlDIS0Boa/7u7t0hhZ7xuZCECa8iDnftBGkgV8Ti+JjvPO8dgt
 NMkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pUDVQKQj1TLD3PHHgA5b8e9ekK1wLWz6ypVOSNFkXyM=;
 b=HPi8wp6GUImmyTPJ+6bL9Hq88EPJMXGG5Sfh/oUjTx+yFx485TbIQA7S5XAXSCEguN
 yy10p1o5LMHrz0HrUqMnFl/VPHDtuyvwOS+RryyGMdDAEBcG+/cAtT7iolRFfCXlkE0w
 6y/ohtz8QkB+PagAiGS9BZtPoPd/QoQS+ZKpkQtNgaUF+NSyL491zIUvl/1dx1hnt0KJ
 8GSkxUGbeY3HccP0Uh8zTinVjBCFYmx87TV7nFJ17wVFLoPhCOI7ZefGmMxCagDjuvID
 qeECSLT14tFIGuVg5Zg0DJuH+f/7URxPFhRHfH8f66S6VyPHZy2hyxXqYTMlkwrPeRgM
 YZBQ==
X-Gm-Message-State: APjAAAX6bOM3yvq6Vor85hblygIHYhfl5l8jgm9eFX7BLDKPRzp1NuZG
 1RX0X5QCxPWbsFCizgiqpG1eQA==
X-Google-Smtp-Source: APXvYqylGPQG1WUEQjgBiiwGfMGjcblN3pAr1BUQ8p7PIKaPrz1+pqxTSoAvdo+ogd+tiXx6VPJN8g==
X-Received: by 2002:a62:160b:: with SMTP id 11mr116099439pfw.30.1560811503685; 
 Mon, 17 Jun 2019 15:45:03 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id a16sm19316856pfd.68.2019.06.17.15.45.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 15:45:03 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-38-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <53e14a5c-0689-17d7-2b62-1649398561a9@linaro.org>
Date: Mon, 17 Jun 2019 15:44:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-38-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::52c
Subject: Re: [Qemu-devel] [PATCH v3 37/50] translator: inject
 instrumentation from plugins
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> @@ -95,6 +103,10 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
>              ops->translate_insn(db, cpu);
>          }
>  
> +        if (plugin_enabled) {
> +            plugin_gen_insn_end();
> +        }
> +
>          /* Stop translation if translate_insn so indicated.  */
>          if (db->is_jmp != DISAS_NEXT) {

This will of course not be reachable if db->is_jmp == DISAS_NORETURN.
Do we want to not bother calling the plugin for this case?


r~

