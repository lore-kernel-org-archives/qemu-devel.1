Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE33C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:43:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85C14206EF
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 17:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQvHNO3b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85C14206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59858 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiMJi-00067T-Hh
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 12:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37086)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMIr-0005Vx-04
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:43:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMIp-000495-Dc
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:43:04 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiMIp-00046c-5u
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 12:43:03 -0500
Received: by mail-wm1-x343.google.com with SMTP id u2so10064061wmc.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 09:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RO78DT6aSxbZ2b9nntMNyluV9/1DF/2Ep/oWc2exqlo=;
 b=IQvHNO3b8iSftrTueik6bDyP51t2x2NiEkZO8I52IPm1j8EnSaxoO5Hd+oIXzKHoDu
 Q1p0bTIqCWTPupoNuUp3hfl+UiStPayaTf7ep0+lfojlbaFCBSU5DjwFSyXzmmELSu7k
 ncBn4NAIDzRxakAzl9GqiKQH28D3CcDiqB3rQWaJV2BujEZT7q+052Gfom9LI82KCrV8
 K7vYLjY1S11UCY2YJ9rUBXaXd5qzY/slkaH6+emKyWRBMGucOyrMMSDUT04rQkKxKWST
 3W0a3/+JquFrxGRNjhearzJYxqCElDbB1qt6e9BNq1nRGqHD+gxn+f/4pPF0G6njnR6T
 FeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RO78DT6aSxbZ2b9nntMNyluV9/1DF/2Ep/oWc2exqlo=;
 b=BVVPHBjCa4yPGDKvsUf8Utu2tdVXRAqjBRALsRqQKnOkeJtXMDsuJdEuymYU70VzDX
 yPaImSMcCvCPIilD8KsRBHZyK+8aUXRAg3eNO8KU2t/mBjI78rDNDxw7CU3TS4mschuB
 LpHtWq6y0hptOs1G9ITe1oeAMwoZgbtQCaPBTCws0rC4O58O+LC7gyktF7dU8LRSz0w4
 ixPdqsIq+j5IsWjQhYpENDO2G9mw9BeS28qSUFx6E6HBs1DiJgHy5uYkpQEfS34/hGjY
 bxSyIhlWhXmI2cCbwZ7NpIdBltofL5gl3ciRa9uyK2pnXXBoXFolBitcjC7toa81UNHt
 6MVQ==
X-Gm-Message-State: APjAAAWM46fQl98FJhzi5Xw5AWsTSNX2cNc9kZwmAJnkyO8dUX+fDaMA
 WlD5Gp+/7yyYMT8Jvi9JxD7WlWjqHd0=
X-Google-Smtp-Source: APXvYqx1BPMQYwskXRwpO02rHn9Sjv/rqiEMle0O5f3cbgbUCUu7D5Qafn8lucDWl9pXuwV4PFEIDw==
X-Received: by 2002:a05:600c:2318:: with SMTP id
 24mr17393061wmo.48.1576863781035; 
 Fri, 20 Dec 2019 09:43:01 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t8sm10411327wrp.69.2019.12.20.09.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 09:42:59 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 93AEE1FF87;
 Fri, 20 Dec 2019 17:42:58 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-9-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 08/28] target/i386: Use cpu_*_mmuidx_ra instead of
 templates
In-reply-to: <20191216221158.29572-9-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 17:42:58 +0000
Message-ID: <87o8w2dhb1.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Do not use exec/cpu_ldst_{,useronly_}template.h directly,
> but instead use the functional interface.
>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/i386/seg_helper.c | 56 ++++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 28 deletions(-)
>
> diff --git a/target/i386/seg_helper.c b/target/i386/seg_helper.c
> index 87a627f9dc..b96de068ca 100644
> --- a/target/i386/seg_helper.c
> +++ b/target/i386/seg_helper.c
> @@ -37,37 +37,37 @@
>  # define LOG_PCALL_STATE(cpu) do { } while (0)
>  #endif
>=20=20
> -#ifdef CONFIG_USER_ONLY
> -#define MEMSUFFIX _kernel
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_useronly_template.h"
> +/*
> + * TODO: Convert callers to compute cpu_mmu_index_kernel once
> + * and use *_mmuidx_ra directly.
> + */

I guess this would only be if it was a significant performance impact?
They seem to be mainly called for (I assume) infrequently called
helpers.

Anyway lgtm:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> +#define cpu_ldub_kernel_ra(e, p, r) \
> +    cpu_ldub_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
> +#define cpu_lduw_kernel_ra(e, p, r) \
> +    cpu_lduw_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
> +#define cpu_ldl_kernel_ra(e, p, r) \
> +    cpu_ldl_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
> +#define cpu_ldq_kernel_ra(e, p, r) \
> +    cpu_ldq_mmuidx_ra(e, p, cpu_mmu_index_kernel(e), r)
>=20=20
> -#define DATA_SIZE 2
> -#include "exec/cpu_ldst_useronly_template.h"
> +#define cpu_stb_kernel_ra(e, p, v, r) \
> +    cpu_stb_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
> +#define cpu_stw_kernel_ra(e, p, v, r) \
> +    cpu_stw_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
> +#define cpu_stl_kernel_ra(e, p, v, r) \
> +    cpu_stl_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
> +#define cpu_stq_kernel_ra(e, p, v, r) \
> +    cpu_stq_mmuidx_ra(e, p, v, cpu_mmu_index_kernel(e), r)
>=20=20
> -#define DATA_SIZE 4
> -#include "exec/cpu_ldst_useronly_template.h"
> +#define cpu_ldub_kernel(e, p)    cpu_ldub_kernel_ra(e, p, 0)
> +#define cpu_lduw_kernel(e, p)    cpu_lduw_kernel_ra(e, p, 0)
> +#define cpu_ldl_kernel(e, p)     cpu_ldl_kernel_ra(e, p, 0)
> +#define cpu_ldq_kernel(e, p)     cpu_ldq_kernel_ra(e, p, 0)
>=20=20
> -#define DATA_SIZE 8
> -#include "exec/cpu_ldst_useronly_template.h"
> -#undef MEMSUFFIX
> -#else
> -#define CPU_MMU_INDEX (cpu_mmu_index_kernel(env))
> -#define MEMSUFFIX _kernel
> -#define DATA_SIZE 1
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 2
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 4
> -#include "exec/cpu_ldst_template.h"
> -
> -#define DATA_SIZE 8
> -#include "exec/cpu_ldst_template.h"
> -#undef CPU_MMU_INDEX
> -#undef MEMSUFFIX
> -#endif
> +#define cpu_stb_kernel(e, p, v)  cpu_stb_kernel_ra(e, p, v, 0)
> +#define cpu_stw_kernel(e, p, v)  cpu_stw_kernel_ra(e, p, v, 0)
> +#define cpu_stl_kernel(e, p, v)  cpu_stl_kernel_ra(e, p, v, 0)
> +#define cpu_stq_kernel(e, p, v)  cpu_stq_kernel_ra(e, p, v, 0)
>=20=20
>  /* return non zero if error */
>  static inline int load_segment_ra(CPUX86State *env, uint32_t *e1_ptr,


--=20
Alex Benn=C3=A9e

