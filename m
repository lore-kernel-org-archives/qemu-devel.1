Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B810C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9FF2071A
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 17:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ilr8QJJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9FF2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60844 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdzx7-0007Mw-GS
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 13:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39200)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdzwP-0006en-S0
 for qemu-devel@nongnu.org; Wed, 27 May 2020 13:34:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:43953)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jdzwO-0007nf-Or
 for qemu-devel@nongnu.org; Wed, 27 May 2020 13:34:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id l10so2131217wrr.10
 for <qemu-devel@nongnu.org>; Wed, 27 May 2020 10:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=oREaau9QqRVp9GscW0MET/vrUxVWeklB/WTcKCSWNs8=;
 b=Ilr8QJJIZS5qB9M+XPC9y65mF68BHBLIpT+jG5yn6Dh1kn0FNsofY3F5DKf9td32gK
 mMKPjiARDyHFPxLW1NA80ee3gadZ89fyzbm0MHmr7FQMW/FGROirz5zjgg3abc+hU6gC
 bM9+dJXKt8bbJ2GkDe96TwmTARWGLVGJCECfhvxWzA3Bwr5ANkjdq9noGaxMFb2IHWr8
 6G93XXtJtvYTJ2Nv/bOYIIhYR9+koNhu7KR4X2ym2esspQXSz2gusWq8evG5POx2fbtb
 bA19mdjimzayMgzDvzdYZQjnXqEV1nhQC0KevLpNts/kj0/Vizg9icxX66llSx97y1cL
 enIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=oREaau9QqRVp9GscW0MET/vrUxVWeklB/WTcKCSWNs8=;
 b=GbuYOATxrdVGWYPf4dbaLfUdCuuWBwJltbt9Lb1YslQhnWmFO5kVJyyTYjuhO4J/Q+
 W+YPIKtYacmbloDhs6B2GeqdQLZ99h3I/OR4bsqcWqcS69wUBMfksrlQzzKtMZW1LF4A
 WGQhffXTeVpCysuHxbt6bBrdoFmeqGkA7o+yQ031wCXioC4j64zkc8N2nXyVYZiZEokg
 HOBfeVS4CtHT1t6C/xrZeG1hFO/8eikTXyonTLBl0+qdrnxkCSHM+0+piAkGk3n2DEJg
 6XRrerKtQ2Ifjbgv++bisgV0L4yDsq8r7AXDFw5rOG+Rbky1YYVBfUrM8QKiNV88hJUj
 oxyw==
X-Gm-Message-State: AOAM533N4BPbxYMG7Of+eYsFuVBs91/d3RLJyCKVl6nNOMq1oa1JydiN
 /wAbyZVPcW9cK0bzRowkb7krb0guL9w=
X-Google-Smtp-Source: ABdhPJyO/CnJcTvdzwD5gPH+pK/JjKF38tQ2eqM2SD55IDgq1teSkAf0pKESqqzn6zjtzhzS4qEy2Q==
X-Received: by 2002:a5d:4d05:: with SMTP id z5mr25215472wrt.130.1590600845886; 
 Wed, 27 May 2020 10:34:05 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p16sm2976600wru.27.2020.05.27.10.34.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2020 10:34:04 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 839491FF7E;
 Wed, 27 May 2020 18:34:03 +0100 (BST)
References: <20200525131823.715-1-thuth@redhat.com>
 <20200525131823.715-5-thuth@redhat.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 4/7] gitlab-ci: Move edk2 and opensbi YAML files to
 .gitlab-ci.d folder
In-reply-to: <20200525131823.715-5-thuth@redhat.com>
Date: Wed, 27 May 2020 18:34:03 +0100
Message-ID: <877dwx5lkk.fsf@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> We have a dedicated folder for the gitlab-ci - so there is no need
> to clutter the top directory with these .yml files.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  .gitlab-ci-edk2.yml =3D> .gitlab-ci.d/edk2.yml       | 0
>  .gitlab-ci-opensbi.yml =3D> .gitlab-ci.d/opensbi.yml | 0
>  .gitlab-ci.yml                                     | 4 ++--
>  MAINTAINERS                                        | 2 +-
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename .gitlab-ci-edk2.yml =3D> .gitlab-ci.d/edk2.yml (100%)
>  rename .gitlab-ci-opensbi.yml =3D> .gitlab-ci.d/opensbi.yml (100%)
>
> diff --git a/.gitlab-ci-edk2.yml b/.gitlab-ci.d/edk2.yml
> similarity index 100%
> rename from .gitlab-ci-edk2.yml
> rename to .gitlab-ci.d/edk2.yml
> diff --git a/.gitlab-ci-opensbi.yml b/.gitlab-ci.d/opensbi.yml
> similarity index 100%
> rename from .gitlab-ci-opensbi.yml
> rename to .gitlab-ci.d/opensbi.yml
> diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
> index bc6aee6aba..5208d93ff8 100644
> --- a/.gitlab-ci.yml
> +++ b/.gitlab-ci.yml
> @@ -1,6 +1,6 @@
>  include:
> -  - local: '/.gitlab-ci-edk2.yml'
> -  - local: '/.gitlab-ci-opensbi.yml'
> +  - local: '/.gitlab-ci.d/edk2.yml'
> +  - local: '/.gitlab-ci.d/opensbi.yml'
>=20=20
>  .update_apt_template: &before_script_apt
>   before_script:
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bde5fd480f..d43c98115c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2534,7 +2534,7 @@ F: roms/edk2
>  F: roms/edk2-*
>  F: tests/data/uefi-boot-images/
>  F: tests/uefi-test-tools/
> -F: .gitlab-ci-edk2.yml
> +F: .gitlab-ci.d/edk2.yml
>  F: .gitlab-ci.d/edk2/
>=20=20
>  Usermode Emulation


--=20
Alex Benn=C3=A9e

