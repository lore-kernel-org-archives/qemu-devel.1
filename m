Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40FA8C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:40:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0829D2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 12:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LE7Nep21"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0829D2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxV5Y-000835-8l
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 08:40:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51562)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxV4c-0007Sd-Cy
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:39:14 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38453)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jxV4a-0004ov-VH
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:39:14 -0400
Received: by mail-wm1-x344.google.com with SMTP id f18so24999747wml.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 05:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tWVrdZrSQPk8h+iZLMt+1TIsQy4sjcRGHDIr21rMqZU=;
 b=LE7Nep219wWcHdQ7zcIW/nZUFoinvRhnT9RS8uQssRqMXFrAaxx0qH0SGYYYInEfqW
 M0tbWOEZmxGHDGtSphMEoDzmE+yO6ZPc5xwyecOHRVr7CJ0WqYW6xdhE8YAIGf2n2vGP
 VvyIncUdFUUBzUsYbnLh6eqtKhGlEO9paNEs6aCerwqffh6p8xX1DC725Fhe1xfWd6dd
 EXiJyGdYBJNQkL/RxPe8TtDPvf7I+mfRH7+ty2gtStj4FCVl7REhSv0dw/18nFg/7Ill
 VaiQPJBmdzFRConAjIVOhp0god6ykmhQMuvmvUEP/OAi+Ak0cvd4DVqxWl6mWc4wbnn0
 tJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tWVrdZrSQPk8h+iZLMt+1TIsQy4sjcRGHDIr21rMqZU=;
 b=Dyx+Yhg8znSsnyBDkhuZDbEAwfwqPhZSRlEXg8ibKSvsO4vTcsLU5mKiyNiAavLnkx
 hN3L2JmgVrVREQw7t3+PzJ2Qee+RLL0Ydy6zAe+E/6bg9/9C5RKTz4VL2Q/Gp6bU7RWw
 xeqZ1L8LOX51+3GrpXk8BmR4OlkctPZg3O5xKpsiprbkItCD3+5St2tHIKp9pJ1LMcuE
 Oq051AYUBiRrDhKWr1lUOrn0zlzzOYNT0MgeTlJgolAvWUTuSAYrkdtOdKTUSBVLAGDO
 4rc7uPpk7vgcOM15r0/lrO5JPA2ki30oA3nWV4U8ZjFY3MXGN7wPR6qib7Y7u1IlfQWh
 qU5Q==
X-Gm-Message-State: AOAM5307z3NF45U/kfpne+YJM1ePwSRjfxK6bqpBNAOlCY8/OLsDFJvW
 BZ9EQ27wiFakKUbWnP1RahA=
X-Google-Smtp-Source: ABdhPJypomygsfyc5sHGRDdaBmHa/qIvXFOZpFK95/OhYeVLpiI4GAURs+L9WazcKqVt86gThvDbKg==
X-Received: by 2002:a1c:9e84:: with SMTP id h126mr20503989wme.61.1595248751079; 
 Mon, 20 Jul 2020 05:39:11 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id o15sm1394949wrh.57.2020.07.20.05.39.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2020 05:39:10 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 4/4] hw/avr/boot: Fix memory leak in
 avr_load_firmware()
To: qemu-devel@nongnu.org
References: <20200714164257.23330-1-f4bug@amsat.org>
 <20200714164257.23330-5-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <506604e4-d908-5a28-78c3-a7a12acef999@amsat.org>
Date: Mon, 20 Jul 2020 14:39:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200714164257.23330-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Rolnik <mrolnik@gmail.com>, Stefan Weil <sw@weilnetz.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping?

On 7/14/20 6:42 PM, Philippe Mathieu-Daudé wrote:
> The value returned by qemu_find_file() must be freed.
> 
> This fixes Coverity issue CID 1430449, which points out
> that the memory returned by qemu_find_file() is leaked.
> 
> Fixes: Coverity CID 1430449 (RESOURCE_LEAK)
> Fixes: 7dd8f6fde4 ('hw/avr: Add support for loading ELF/raw binaries')
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/avr/boot.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/avr/boot.c b/hw/avr/boot.c
> index 6fbcde4061..151734f82d 100644
> --- a/hw/avr/boot.c
> +++ b/hw/avr/boot.c
> @@ -60,7 +60,7 @@ static const char *avr_elf_e_flags_to_cpu_type(uint32_t flags)
>  bool avr_load_firmware(AVRCPU *cpu, MachineState *ms,
>                         MemoryRegion *program_mr, const char *firmware)
>  {
> -    const char *filename;
> +    g_autofree char *filename;
>      int bytes_loaded;
>      uint64_t entry;
>      uint32_t e_flags;
> 

