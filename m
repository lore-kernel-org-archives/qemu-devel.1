Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB84C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:06:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AAAC2068F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ES06Cj+0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AAAC2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiMfj-0006mn-FU
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 13:06:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58222)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMcY-0002qm-49
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMcX-0000vj-3b
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:03:26 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:50791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiMcW-0000tU-T4
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:03:25 -0500
Received: by mail-wm1-x341.google.com with SMTP id a5so9827612wmb.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 10:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=29FOaR0VIIcd+uehc7F1UA+qVTJOMe9ImyXwHtq2884=;
 b=ES06Cj+0BqOW0VxgXgq+sUab6IUOV5X8lvGENiWKfI7B3zH97XlbYHTvaBefFPKHi/
 rtWld1ZwsWsZx+I/cPuoQCD14yd7rBTV60uYkzYUqs7SbxwGIILLpVO9K8f39oCof/xG
 Sdd8UkVoLWOIvjgzrQ9HRURX2ZrWPjYrhxn/KQt9zllKR+dfZ92b9RGSUskf8J7aFXSw
 BFr8U76BawVpIlbmy24Lnfs9VQ4XQ3o2fD/UyZ0AMNjoPIvSsKmQ2vOT4T8xcF5+4Y2r
 QgIBfIKv9pXy3LIh4bvw652rXuA0LnKkA9iNgx7gKYsK8vzvPx/qKLYyx8FmNBqnDoHF
 HS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=29FOaR0VIIcd+uehc7F1UA+qVTJOMe9ImyXwHtq2884=;
 b=mafH4pfns7KyXVdITZfBnWmuj25UtUKOEO6i/izIDTZyOyjiyClb6DdTGNUJtqsI3Z
 QqrNXnCiqlowsXNrL2AvfYGVL5hC7Q10d0T2ZLif9WSPb43ejhwTyZp9/S6Hl+1dxwgQ
 sa2PW31qNeHB2Qm6663JnSzCXKhfxSYDYSdZmJeIFvEhpjGMl8UvCIGJN1AcXhRhTdlc
 QJHiOX2uRCUWerCnTR613cGKCWenb91aeESEEb4wMIw7iBiqf3Ll0Bnpbbdj+QrCcRnS
 JjDx5+ipYsQ9uhYTr9J8eQ4yvasw3lkMJVlR1rT7EaA7CPHY5lfEk2/EFPpvqfNkwmp+
 d+aQ==
X-Gm-Message-State: APjAAAWpd623jmxnceR3QV4pOSFpP2CAxcTX9lFHX1espG3yEzImVx2X
 7YcoBME7CvnE9SJEHISQJfy45HLPpBU=
X-Google-Smtp-Source: APXvYqwxZwjbKRfIy9nL9F3ZWZnJ0qJbsaGQzows8hJqHbZeiy3JiLCnSfSQw1yIWQZzFlzhyiT8hw==
X-Received: by 2002:a1c:49c2:: with SMTP id
 w185mr17211220wma.138.1576865002590; 
 Fri, 20 Dec 2019 10:03:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n3sm10241046wrs.8.2019.12.20.10.03.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 10:03:21 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C9CBA1FF87;
 Fri, 20 Dec 2019 18:03:20 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-20-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 19/28] target/microblaze: Remove MMU_MODE{0, 1,
 2}_SUFFIX
In-reply-to: <20191216221158.29572-20-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 18:03:20 +0000
Message-ID: <87v9qac1sn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The functions generated by these macros are unused.
>
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/microblaze/cpu.h | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 95773089aa..32522f606b 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -328,9 +328,6 @@ int cpu_mb_signal_handler(int host_signum, void *pinf=
o,
>  #define cpu_signal_handler cpu_mb_signal_handler
>=20=20
>  /* MMU modes definitions */
> -#define MMU_MODE0_SUFFIX _nommu
> -#define MMU_MODE1_SUFFIX _kernel
> -#define MMU_MODE2_SUFFIX _user
>  #define MMU_NOMMU_IDX   0
>  #define MMU_KERNEL_IDX  1
>  #define MMU_USER_IDX    2


--=20
Alex Benn=C3=A9e

