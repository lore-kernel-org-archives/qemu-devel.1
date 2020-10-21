Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A4AAC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:31:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C1CD20795
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 10:31:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z6dG4RqS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C1CD20795
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVBOn-0004cw-GW
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 06:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVBMx-0003Nn-AN
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:29:23 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39745)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kVBMu-0006JN-Jx
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 06:29:23 -0400
Received: by mail-wm1-x343.google.com with SMTP id d3so1474014wma.4
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 03:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=TdwRZ7rBOCFE2n6etOekAvQgVo9aP4FW3zOA1tprhPU=;
 b=z6dG4RqSmhgjjR2RWdaq19fNbob688fijZ5wB3tWpfTfoWeBMuKtkCkoXas3FjwLbs
 AraKrcvLUP46D3ppaIdzFDlnLbLj0LwBaiJjubcEHZbPl4IMXki0gkpcpg6sc+mOQZSo
 iKD1hOonZR6s4xGPjYTeU/HuVM+U6uH88hRTLWO8+Ie1/q4WCvtdBcR/EwDUjdesB/ve
 +3LlQsCVWhGbQhzMTy8a2fYw4tayQz/gXNuMuCB1QHFsTohpcMxZ+Arc24lSQ8DRAI8O
 +KCnRzjOK/0Cp8unP85rkHDE2Y2sxoOT7OFzNwdoD7LGttM/pCM8ikJKcJRPLzYkfNrV
 ZVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=TdwRZ7rBOCFE2n6etOekAvQgVo9aP4FW3zOA1tprhPU=;
 b=pcE8XIZHazIfdO8j1qrPUJe4XDSvhnGgLm55dYp3UIUdeDhpjH6XaPz+2g1/ukgQTu
 6qfA4cAqtgcc5GnXgubA+ikc2UiwvD3G2XJFRbTJG6eJ6DhlfCUWN3b7gfWDH415KPiQ
 IyVOeH/XmdJazgaKBRD7MZCgAHCYUaiLvej4wZdacMGbO+fiZ4n9kqfJVCI8VVfvxyKd
 4GkYHF1iVVleplVjufel4dbX6Ac9yBp76tdzNYZL71LsGF6llE6Bc8YoVrHOPjNIjBFu
 i7hW5L6xCV33Q/kSWUojpl6+ySSJga/hbUfHxFKsfWHLLfGwoVXWfopdYJbmx+1k01wt
 oTNA==
X-Gm-Message-State: AOAM532IAsPmQkVCmBw8+ZEKKkV96pGmGW0wEOlOJjqUbdb9izK4L+VH
 /oRNe+9CtB6MDxc2luF190cumg==
X-Google-Smtp-Source: ABdhPJz+pHG3pYnYl0+pfFO6cqgMzh+Tzh4fqyOJcFIYbEF6qigFDOLLsUQRoIDiANyt1YLp62ZKDA==
X-Received: by 2002:a1c:2905:: with SMTP id p5mr2834925wmp.187.1603276159140; 
 Wed, 21 Oct 2020 03:29:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n9sm3235529wrq.72.2020.10.21.03.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 03:29:17 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 23FE71FF7E;
 Wed, 21 Oct 2020 11:29:17 +0100 (BST)
References: <20201021072308.9224-1-thuth@redhat.com>
User-agent: mu4e 1.5.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] tests/docker/dockerfiles/centos: Use SDL2 instead of SDL1
In-reply-to: <20201021072308.9224-1-thuth@redhat.com>
Date: Wed, 21 Oct 2020 11:29:17 +0100
Message-ID: <87imb3x476.fsf@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, qemu-trivial@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> We do not support SDL1 in QEMU anymore. Use SDL2 instead.

Queued to testing/next, thanks.

>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/docker/dockerfiles/centos7.docker | 2 +-
>  tests/docker/dockerfiles/centos8.docker | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/docke=
rfiles/centos7.docker
> index 8b273725ee..6f11af1989 100644
> --- a/tests/docker/dockerfiles/centos7.docker
> +++ b/tests/docker/dockerfiles/centos7.docker
> @@ -31,7 +31,7 @@ ENV PACKAGES \
>      perl-Test-Harness \
>      pixman-devel \
>      python3 \
> -    SDL-devel \
> +    SDL2-devel \
>      spice-glib-devel \
>      spice-server-devel \
>      tar \
> diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/docke=
rfiles/centos8.docker
> index 585dfad9be..f86931f955 100644
> --- a/tests/docker/dockerfiles/centos8.docker
> +++ b/tests/docker/dockerfiles/centos8.docker
> @@ -2,7 +2,7 @@ FROM centos:8.1.1911
>=20=20
>  RUN dnf -y update
>  ENV PACKAGES \
> -    SDL-devel \
> +    SDL2-devel \
>      bzip2 \
>      bzip2-devel \
>      dbus-daemon \


--=20
Alex Benn=C3=A9e

