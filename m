Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A0FC4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17210208C7
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 04:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qqfJiT2E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17210208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ0so-0005So-4k
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 00:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ0qq-0004oh-GY
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:14:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54098)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQ0qo-0000sD-RF
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 00:14:52 -0400
Received: by mail-wm1-x344.google.com with SMTP id f21so844985wml.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 21:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wAn7xS15a4GKezf+UjY97VnX3k65BPP67shFAVkt3q4=;
 b=qqfJiT2EMDGsZBNq0TQv3dzuGJdPxW0BS+8qH80wD5UaTGYXnIrzq3Tyex/muAJmR8
 6zoS4w8aMaZoCWIP6pHjovpA3TaLnMG3o/e/OlkNvjt/2bEiXWEe7X2SadMQJ7ghJ6MY
 8r3f95NlbhuMWRAAyRtUokibNXG5xbbfsy43c4kQ1uhOQFGBjXXaqvYQ7OZbd7ihAiUd
 wGyhY+TEsgKy3BqhUFD6wHBs0K4ykVY0J5Ne5Kg2qUYwwIdRfBFzYiVbJahUfdksYCIW
 SSYAb2+kHmrZ9vjnWQzDngxUEjUyNl7va3VlQen/AQ8HtXV6OIW4105iz6oJTtGnouQc
 2NiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wAn7xS15a4GKezf+UjY97VnX3k65BPP67shFAVkt3q4=;
 b=FV4h+WrFYom+v5UqCVwzqWWgLaQ3TD2LAOWtgHnln0tkR/i5DRMSSnniq8YzxQoK2E
 OmL2DPMf/hiboZUM05B0m+3lEoHtEijDotBCZfeTZL3IJ57wpPJ1vFfA+Gncz79dyKL6
 ncZ1OJFANGEvjS+uO+V3ubBTVsvg9UTZMqAGFJhc0wrEUCuWKO8FbNx1zy+HgsibBv0i
 KOG6IiouaEzLbvLFaebAESn7AW+bawutapqHPuds0Gktwxw0Dc+C7Bux7ZPSOIZcx/Tg
 wUA++y9PtttDbcq7NKdnGBi1d1XI6HzOw2VGpBI/IREy+ynqAlV0SQOxM6PTJPtTzrKv
 DAyQ==
X-Gm-Message-State: AOAM530LLFUnzxELC7iaKhCu4fek02KAcO6+pWcl9ELf6Tt2xW0Eds5e
 dQZVqA5QtOd9QXExXWsbil8=
X-Google-Smtp-Source: ABdhPJwpaEwaYYUjjlRKrauQNzHObTd7PPyFGdyOW26/Ndys3ELMcKD7m+VKgRQBMp9YyHynl2waJw==
X-Received: by 2002:a1c:a795:: with SMTP id q143mr1059330wme.20.1602044087669; 
 Tue, 06 Oct 2020 21:14:47 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id g144sm861838wmg.30.2020.10.06.21.14.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2020 21:14:47 -0700 (PDT)
Subject: Re: [PATCH 13/14] arc: Add support for ARCv2
To: cupertinomiranda@gmail.com, qemu-devel@nongnu.org
References: <20200930204604.20663-1-cupertinomiranda@gmail.com>
 <20200930204604.20663-14-cupertinomiranda@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a1282d2b-16a9-0121-a12d-7e2cd23971aa@amsat.org>
Date: Wed, 7 Oct 2020 06:14:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200930204604.20663-14-cupertinomiranda@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.248,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Claudiu Zissulescu <claziss@gmail.com>,
 Shahab Vahedi <shahab.vahedi@gmail.com>, Shahab Vahedi <shahab@synopsys.com>,
 Cupertino Miranda <cmiranda@synopsys.com>, linux-snps-arc@lists.infradead.org,
 Claudiu Zissulescu <claziss@synopsys.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/30/20 10:46 PM, cupertinomiranda@gmail.com wrote:
> From: Shahab Vahedi <shahab@synopsys.com>
> 
> Add remaining bits of the Synopsys ARCv2 (EM/HS) support into QEMU,
> configure bits, arch_init and configuration files for softmmu (hardware
> emulation).
> 
> Signed-off-by: Shahab Vahedi <shahab@synopsys.com>
> ---
>  configure                       |  5 +++++
>  default-configs/arc-softmmu.mak |  5 +++++
>  disas.c                         |  2 ++
>  disas/meson.build               |  1 +
>  hw/meson.build                  |  1 +
>  include/disas/dis-asm.h         | 10 +++++++++-
>  include/elf.h                   |  3 +++
>  include/exec/poison.h           |  2 ++
>  include/sysemu/arch_init.h      |  1 +
>  meson.build                     |  3 ++-
>  softmmu/arch_init.c             |  2 ++
>  target/meson.build              |  1 +
>  12 files changed, 34 insertions(+), 2 deletions(-)
>  create mode 100644 default-configs/arc-softmmu.mak

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

