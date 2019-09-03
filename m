Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB16C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:50:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D12222D6D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D12222D6D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5C0r-0006Nf-W9
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 12:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i5BXI-0003W4-7Q
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:20:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i5BXF-0000fu-Qv
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:20:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i5BXF-0000fU-JP
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 12:20:01 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2D5EEC04D293
 for <qemu-devel@nongnu.org>; Tue,  3 Sep 2019 16:20:00 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id f10so20126wmh.8
 for <qemu-devel@nongnu.org>; Tue, 03 Sep 2019 09:20:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hw27mxT6ObZtqvKoETGQ5lY6IQyW7gki2ry6rOYqd9E=;
 b=A9t7vZR3tdC+KZFQ58/hnqPdDQBzQ0vUeks0gOdWwuysQM9SjAyVshI2xxwq5BKYef
 swOmns8DIuRMILkz8C4FTzLihtrrskDiho8IDM/XT1nnSQBnbdtNrADqzmK7ui+AqWmW
 ufoOY5HUgXoI0kY8ZmkEOtpVGSfvIEgcGcaIxdXVHbkJJAqJtq1saCF7/KVoo2bYRVrv
 g5MmiGaMvbeSTKtynWS9l2LawdMqLkrlXBIU72OJyvBZNjHi/6qvez4i2r2cI/iJN2Gs
 Zy1bMov3NYEF90Mypp97P9yNN+b3w9M60FF62dnALzXLGpcBwJxQ/BHiPh1pwHfOhS/m
 A/Rg==
X-Gm-Message-State: APjAAAVYbdXZ+cN06rbz4eUC4TI+KncHzzW8YbYedxuBJ4gINPsUsBlS
 89ziSqJhYzGkzZSDFx6UPhmhyfwPf3La/wV0dzdt4op4EVmRgfTYIz9vCiaKNEQh4PtwZINqjD+
 Qsn/rkP2+eHHWcsA=
X-Received: by 2002:adf:9083:: with SMTP id i3mr998825wri.310.1567527598979;
 Tue, 03 Sep 2019 09:19:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyKfJBkxrl7Pk0Dzbo7ETG3LOHeZMaLKLe9+0jDYrUbY5UZ4wMk7bcclMt+7S+AsZA5s14y5Q==
X-Received: by 2002:adf:9083:: with SMTP id i3mr998793wri.310.1567527598716;
 Tue, 03 Sep 2019 09:19:58 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id h32sm24187879wrh.62.2019.09.03.09.19.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Sep 2019 09:19:58 -0700 (PDT)
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
References: <20190903154810.27365-1-thuth@redhat.com>
 <20190903154810.27365-4-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <bb6eb994-532e-7afc-bb27-aa5d56080b50@redhat.com>
Date: Tue, 3 Sep 2019 18:19:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190903154810.27365-4-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] target/arm: Make m_helper.c
 optional via CONFIG_ARM_V7M
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/19 5:48 PM, Thomas Huth wrote:
> We've already got the CONFIG_ARM_V7M switch, but it currently can
> not be disabled yet. The m_helper.c code should not be compiled
> into the binary if the switch is not enabled. We also have to
> provide some stubs in a separate file to make sure that we still
> can link the other code without CONFIG_ARM_V7M.

If there is no M support, the translate code shouldn't even generate M
calls, so the stub shouldn't be necessary.
Anyhow I guess this code will be simplified by the ongoing decodetree
conversion from Richard.

> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/arm/Makefile.objs   |  3 +-
>  target/arm/m_helper-stub.c | 58 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 1 deletion(-)
>  create mode 100644 target/arm/m_helper-stub.c
> 
> diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
> index 5cafc1eb6c..225e7a70a9 100644
> --- a/target/arm/Makefile.objs
> +++ b/target/arm/Makefile.objs
> @@ -36,7 +36,8 @@ obj-y += tlb_helper.o debug_helper.o
>  obj-y += translate.o op_helper.o
>  obj-y += crypto_helper.o
>  obj-y += iwmmxt_helper.o vec_helper.o neon_helper.o
> -obj-y += m_helper.o
> +obj-$(CONFIG_ARM_V7M) += m_helper.o
> +obj-$(call lnot,$(CONFIG_ARM_V7M)) += m_helper-stub.o
>  
>  obj-$(CONFIG_SOFTMMU) += psci.o
>  
> diff --git a/target/arm/m_helper-stub.c b/target/arm/m_helper-stub.c
> new file mode 100644
> index 0000000000..8ec9de0fb6
> --- /dev/null
> +++ b/target/arm/m_helper-stub.c
> @@ -0,0 +1,58 @@
> +/*
> + * ARM V7M related stubs.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#include "qemu/osdep.h"
> +#include "cpu.h"
> +#include "exec/helper-proto.h"
> +
> +void HELPER(v7m_bxns)(CPUARMState *env, uint32_t dest)
> +{
> +    abort();
> +}
> +
> +void HELPER(v7m_blxns)(CPUARMState *env, uint32_t dest)
> +{
> +    abort();
> +}
> +
> +uint32_t HELPER(v7m_mrs)(CPUARMState *env, uint32_t reg)
> +{
> +    abort();
> +}
> +
> +void HELPER(v7m_msr)(CPUARMState *env, uint32_t maskreg, uint32_t val)
> +{
> +    abort();
> +}
> +
> +uint32_t HELPER(v7m_tt)(CPUARMState *env, uint32_t addr, uint32_t op)
> +{
> +    abort();
> +}
> +
> +void HELPER(v7m_preserve_fp_state)(CPUARMState *env)
> +{
> +    abort();
> +}
> +
> +void write_v7m_exception(CPUARMState *env, uint32_t new_exc)
> +{
> +    abort();
> +}
> +
> +void HELPER(v7m_vlldm)(CPUARMState *env, uint32_t fptr)
> +{
> +    abort();
> +}
> +
> +void HELPER(v7m_vlstm)(CPUARMState *env, uint32_t fptr)
> +{
> +    abort();
> +}
> +
> +ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
> +{
> +    abort();
> +}
> 

