Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB5D3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 08:04:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8A120899
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 08:04:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wF0DuEvx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8A120899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jquDB-0000g3-PX
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 04:04:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jquCR-000094-2G
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 04:04:03 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jquCL-00048e-6z
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 04:04:02 -0400
Received: by mail-wm1-x343.google.com with SMTP id 22so25697417wmg.1
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 01:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=vr+5zXNi7Phbbf7HjA2XZE1wIN2dDuoZnv7YZzo9eEE=;
 b=wF0DuEvx91aKZPQrQyy3lue3ncj5lCflu46p3p+XWqyGttoAlS8/KMs+MrjeKnUk04
 4iGsdbt9FyE6Zyxu8teaOjQMF3cPqsZ2ccuQxzncMGnAt33ysdTCM3I0AlML9nesEo6P
 vkLwQP0c/7o3a8xSErJxxh3K2VZMh8IElZsEjAkVI34FQyy9EAu3yhAVkFyO2luzMNH/
 9YgH39mUnLMFtA/5+oPCxNsmb3PAvITuxDOzSM1eXJJ76lNk7sI6GKCmTzOmxHnhRC9U
 do695Pe6PYWwzqHoEXiO4FhsQBx2curKHGr0JY7J6cLwypYx3V1HFf6mqiMNPe+73f6f
 svQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=vr+5zXNi7Phbbf7HjA2XZE1wIN2dDuoZnv7YZzo9eEE=;
 b=d2NY6mvPk+0OVZKwqdN7v63ci50OHqXrhJQ5Cs3x9EW8+jn/GHplNRf0wT45sw0LU0
 PMNTDhY6EFMnMvTU3B3Dq5TBXZZD49xnmMzb8uRm9Ax43N2s4YhMK036K0dObQAh1ok/
 22ETOux0cILsg/jJ753+nIUzJD0lM7onhH0jARC3lb1Su+g4zPZP8mu+61AsuifX81R2
 ye1ZKseYKXoLCcqfv9moVzT2Gg5znJALTh5JDsC4ukYcDwDoMMSX4tRQumwei04vvsf7
 a0spWQjTvZq12e2/DjI2z+vTH7y+v+P7tbNcVQX0MuAn7iuC/XLHnBup/2uYBfajDnLp
 cSHQ==
X-Gm-Message-State: AOAM5328xxjxnXlyifpIZ8fubTkKJQexNcq4N8v5o44v1zKgA6fwVlp7
 E+TwnMG+3ZC3TiA1lnFILJTSZw==
X-Google-Smtp-Source: ABdhPJweq9iWWNaWvpCXx+a9v1B0NH5wNXc7kV6DpTfqxLKOdTkONVxYbx/FKDBodGA5ilVlrP4ojQ==
X-Received: by 2002:a7b:ce14:: with SMTP id m20mr32746303wmc.129.1593677035348; 
 Thu, 02 Jul 2020 01:03:55 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y6sm10260053wmy.0.2020.07.02.01.03.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 01:03:54 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5C68C1FF7E;
 Thu,  2 Jul 2020 09:03:53 +0100 (BST)
References: <20200702051013.1127897-1-aurelien@aurel32.net>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH] MAINTAINERS: Remove myself from FPU emulation maintenance
In-reply-to: <20200702051013.1127897-1-aurelien@aurel32.net>
Date: Thu, 02 Jul 2020 09:03:53 +0100
Message-ID: <875zb6qr6e.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aurelien Jarno <aurelien@aurel32.net> writes:

> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Queued to fpu/next, thanks.

> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index dec252f38b..0535e043f0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -130,7 +130,6 @@ F: include/sysemu/cpus.h
>  F: include/sysemu/tcg.h
>=20=20
>  FPU emulation
> -M: Aurelien Jarno <aurelien@aurel32.net>
>  M: Peter Maydell <peter.maydell@linaro.org>
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>  S: Maintained


--=20
Alex Benn=C3=A9e

