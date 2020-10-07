Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96AE2C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:58:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1160A20782
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 11:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H52p5AR3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1160A20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ85L-0002oE-KZ
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 07:58:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQ841-00016c-SW
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:56:57 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36039)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kQ83y-0001eb-RC
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 07:56:57 -0400
Received: by mail-wr1-x442.google.com with SMTP id z1so1827076wrt.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2020 04:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=N+QdIBb6xdvqxez6TK0xKZHg68jzfjvp0EPuwfaQdNE=;
 b=H52p5AR3Huhnf5UAaxD/i69GCuV5hrEvdA7nNIN1JiKuuVJFnF3O2MTYNl65z4enUQ
 xWh/NHq+R5zsOcGk3sGv0vUJyXV2g0mrbFkgHi+SqSkha5AyxT64bzzw/OeDBe5nuWVG
 83/gVRahbpQ1NZZ5dlycIOpfExdXeeNv4JuqQQFx0Wd/35qvVma+URUgN+In61dDekOS
 iDsFYV92CYptuxDrrkR6IbMBA0xsBIi9QQOQJ1WHDTLioeBvdDdlq3Ddri6huPtFVUu3
 VetmlLj0sUzkMdgxILu1ZAvxTpTApqTFC78et1g2hDsukd8ODkEeig7NT+uzRNCNyo4c
 agFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=N+QdIBb6xdvqxez6TK0xKZHg68jzfjvp0EPuwfaQdNE=;
 b=sxUixCZLg+Wn2Ca4poQ38f51bevCYj8FrLI82+ValtBDf/GLlECN5xk/0wV+mFgdiD
 30X8Bj7D4Dw7CI9fWDMBQy9PPCT1SHQDKhYqi+cVB1WKYG03n+ID6/Qm3CA/n1VlJZRE
 pjFitoiAI2ST3rnI6a4bHP2pSl8IXLnjezACf3yrblzoHDMWOk7fPTzs23Xo32Vosy5h
 3nzRpT0PV9uGwmC8BN6MAGtjm30eaM8Kz5KI6g5osXAiNuSKghesbXEjTzm6RsciD7ei
 Uqg5MSWxHsL725rKTCHkALH1WfRp0KFUxHv3J8fxdSJeNyjqmdJ2Mcf0rY7pz/xD0zbV
 Vp1w==
X-Gm-Message-State: AOAM531onMMd5ZN/3pxKwKAcQz5bU2DpVWjjVKY34aCK6yEedZQBlUEt
 QIP8pMOFnO/DWYeGll8cZqyubw==
X-Google-Smtp-Source: ABdhPJwRy5Fko8RWXTZuXs8dfSpZSff0uVEh0+vBMvI5VNTEB5pQ5ETZJAPoy3TnhBPUoY5Qqp6GZg==
X-Received: by 2002:a5d:494c:: with SMTP id r12mr3095339wrs.406.1602071812803; 
 Wed, 07 Oct 2020 04:56:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j17sm2624606wrw.68.2020.10.07.04.56.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Oct 2020 04:56:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DF2281FF7E;
 Wed,  7 Oct 2020 12:56:50 +0100 (BST)
References: <20201006174347.152040-1-thuth@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] tests/docker: Add genisoimage to the docker file
In-reply-to: <20201006174347.152040-1-thuth@redhat.com>
Date: Wed, 07 Oct 2020 12:56:50 +0100
Message-ID: <875z7m1c71.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: qemu-trivial@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> genisoimage is needed for running the tests/qtest/cdrom-test qtest.

Queued to testing/next, thanks.

>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  tests/docker/dockerfiles/centos8.docker      | 1 +
>  tests/docker/dockerfiles/debian-amd64.docker | 1 +
>  tests/docker/dockerfiles/fedora.docker       | 1 +
>  tests/docker/dockerfiles/ubuntu2004.docker   | 1 +
>  4 files changed, 4 insertions(+)
>
> diff --git a/tests/docker/dockerfiles/centos8.docker b/tests/docker/docke=
rfiles/centos8.docker
> index f435616d6a..0fc2697491 100644
> --- a/tests/docker/dockerfiles/centos8.docker
> +++ b/tests/docker/dockerfiles/centos8.docker
> @@ -8,6 +8,7 @@ ENV PACKAGES \
>      dbus-daemon \
>      gcc \
>      gcc-c++ \
> +    genisoimage \
>      gettext \
>      git \
>      glib2-devel \
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/=
dockerfiles/debian-amd64.docker
> index d2500dcff1..314c6bae83 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian-amd64.docker
> @@ -14,6 +14,7 @@ RUN apt update && \
>  RUN apt update && \
>      DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt install -y --no-install-recommends \
> +        genisoimage \
>          libbz2-dev \
>          liblzo2-dev \
>          libgcrypt20-dev \
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
> index ec783418c8..85c975543d 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -15,6 +15,7 @@ ENV PACKAGES \
>      findutils \
>      gcc \
>      gcc-c++ \
> +    genisoimage \
>      gettext \
>      git \
>      glib2-devel \
> diff --git a/tests/docker/dockerfiles/ubuntu2004.docker b/tests/docker/do=
ckerfiles/ubuntu2004.docker
> index cafe8443fb..f4b9556b9e 100644
> --- a/tests/docker/dockerfiles/ubuntu2004.docker
> +++ b/tests/docker/dockerfiles/ubuntu2004.docker
> @@ -3,6 +3,7 @@ ENV PACKAGES flex bison \
>      ccache \
>      clang-10\
>      gcc \
> +    genisoimage \
>      gettext \
>      git \
>      glusterfs-common \


--=20
Alex Benn=C3=A9e

