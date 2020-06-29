Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAD0C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 036E223888
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 10:09:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A1XqwAkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 036E223888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpqjP-0008WQ-4t
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 06:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jpqiY-0007MS-UA
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:08:50 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jpqiX-0005eU-7R
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 06:08:50 -0400
Received: by mail-wr1-x441.google.com with SMTP id s10so15884888wrw.12
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 03:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=s0Cr7cpNk+Q6SRN257PXKSNt9ZQQcco5k4Bs94Hjc1o=;
 b=A1XqwAkVvuZS+rcJ8kjH/DP6rxbr0V3K3j4UL3TYpSCs4ehFynUaPZmBI3i+/ZnX27
 s8GKx2r6CAkjR+X4Xxo8XezpdupRPfu8kbbE5FOneqm41US5Tvt4kRI97SwFu5sdhE7r
 DqUq+EwF2hjHuwxBvHSEhpARToF6yCLZiXm0YUibb7o51Ae1K6Ot60RrqnxME0MuCMZf
 dhM+bHUjmlTGed/eWqd3jq56limrWBan0e58hQtxoREo8tmeMQ2DSMCxNvNkmvX0b728
 TZsmNkckkTA2hYtx1WzI9+IsIEKIQwUY/2vYyToGD6c/jOh46GjhRHE/CIvXdtV0KKo1
 L/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=s0Cr7cpNk+Q6SRN257PXKSNt9ZQQcco5k4Bs94Hjc1o=;
 b=cZvzov4WMBzw0L9LVGpc+You6mDVpGfyTCSt/OQ2WA4/ta8FNu3KIplrnfXa7XRvH+
 8gCFsz64hpbdw6/0QW92BmuBaPdEHh1P+23SMRdK6x7Opdg49X8ziqEDnFeIuyXOr+CY
 dkQKzXK5Vlcci+WoyJQhS6ADpLl+ilC8mFxOBA1TiwCckfrGCuf43Xxdi9K+Ur4V4XMJ
 JH4WzIvEJgou+F3bcd2S/1OKpM2Xk1vgoEmPvz19aAnF1Yn4sV5f0C9SWYrA5B37Auow
 gsNPRgZCSPdATQxwXrnN1eEPLv+ETQ3m5XjRBu4TO/p/R7o1YmF1ummxvOriCVEIJBjh
 hnRg==
X-Gm-Message-State: AOAM532jubB8g+mTZECc/MmRhrKeOeWDUEVTh/Hhm7mLWPPlHiSgFiuP
 l5ctVYd4xTKPM3+j3RQ75yeRU1sCfaI=
X-Google-Smtp-Source: ABdhPJz6KS7z6Kh9QP/Qev61b/baXXREE1TfM89rI+PMMiKaOHbc6jvfshmvqqBCWHL+K+vN/bI4bw==
X-Received: by 2002:a5d:4611:: with SMTP id t17mr15482350wrq.243.1593425326718; 
 Mon, 29 Jun 2020 03:08:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l18sm25072941wrt.59.2020.06.29.03.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2020 03:08:44 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 321351FF7E;
 Mon, 29 Jun 2020 11:08:44 +0100 (BST)
References: <20200629094934.2081180-1-dinechin@redhat.com>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH] trivial: Respect alphabetical order of .o files in
 Makefile.objs
In-reply-to: <20200629094934.2081180-1-dinechin@redhat.com>
Date: Mon, 29 Jun 2020 11:08:43 +0100
Message-ID: <87sgeerxp0.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Christophe de Dinechin <dinechin@redhat.com> writes:

> The vmgenid.o is the only file that is not in alphabetical order.
>
> Signed-off-by: Christophe de Dinechin <dinechin@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  stubs/Makefile.objs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index f32b9e47a3..1df8bb3814 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -19,10 +19,10 @@ stub-obj-y +=3D replay.o
>  stub-obj-y +=3D runstate-check.o
>  stub-obj-$(CONFIG_SOFTMMU) +=3D semihost.o
>  stub-obj-y +=3D set-fd-handler.o
> -stub-obj-y +=3D vmgenid.o
>  stub-obj-y +=3D sysbus.o
>  stub-obj-y +=3D tpm.o
>  stub-obj-y +=3D trace-control.o
> +stub-obj-y +=3D vmgenid.o
>  stub-obj-y +=3D vmstate.o
>  stub-obj-$(CONFIG_SOFTMMU) +=3D win32-kbd-hook.o


--=20
Alex Benn=C3=A9e

