Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0682C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 08:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1442220A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 08:52:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TEtrTn4S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1442220A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jt5oT-0008AT-16
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 04:52:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jt5nw-0007kI-3S
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 04:51:48 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jt5nu-0001up-Bu
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 04:51:47 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2so2085507wmf.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 01:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=B1JVCo5Z2KhJ3S+hvsHbz1CuB6AUfNWquYTEHrzhsps=;
 b=TEtrTn4Sl/AJ2yDd5MN1oGUizy1xGIaGH1neFWrGclBiSeezCwuYKc0GqyBzptJwLx
 5NQNsLOn32c8lnexhwmieF5ZtN6pukG6xItVxD31xkoletWs6U86SPEF9x9FvTM1D/bq
 PMO4Q1E/MC/bTLaUwiXQdk4dJJfspXOlNOua0DyvYKWq5+Xkp3eng+hlvQoMOFaivpam
 3wrm18vxZlHDu4aCLLlNsughBajWrYvI6nuKCY6g4ZRhXGVufxXzZhBgaPr0ZZBBvEsi
 iIaf+wd2jWlG2Vl7y9I3c6MHNR1jj3p94cRDtUNdFQx9VKIG9sgC1+9kqhj8DacJFc/N
 BaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=B1JVCo5Z2KhJ3S+hvsHbz1CuB6AUfNWquYTEHrzhsps=;
 b=o2/HfkRKiVp/sjxs91G6JyTTuyqalHHQ7GMoQ0QXy12X+yhomK9q9iD2Fgz9ImLS/w
 Cd8vZYaQjAz2WPv/iUJOyN78QzFFPLLEN/+nEKyghKZpDwLjs5Ln8KVK/qdF1jKpc/gU
 YMRICkjKK/Yrf3tmBSKuMbcJudrgf7DvbjFsrsz58krcDl+MXCDTS6VaxZIkRigrBQrV
 0cfgREwcJ0Mr1DaWPXFC1DPbYav4vM8GILLuV5JeIFAuRVISTVDr6mXHK5pQnFZ2ylje
 CGhIX7XDALMAcRdfzgQOnibP1r9OREer9SOlg5txedDBBMWJ+kkSUe1AwpsxA2e0NWvv
 Rx1g==
X-Gm-Message-State: AOAM531ViEq9L5LSrgB7qHtiWJQMDW6eKYsGb/fCVNv5DUniD/gq8XNc
 kqdRtl3bxiPy7v6muP5W96whkQ==
X-Google-Smtp-Source: ABdhPJzNnAqYUwaCgQ8kDMJQWWfxMYq79V9EDKIF1kSi0voWEyu5sHdMJaeQARflCXK5yMDcD5a1iw==
X-Received: by 2002:a1c:7d54:: with SMTP id y81mr8532084wmc.110.1594198304515; 
 Wed, 08 Jul 2020 01:51:44 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u20sm4474508wmm.15.2020.07.08.01.51.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2020 01:51:43 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F151B1FF7E;
 Wed,  8 Jul 2020 09:51:42 +0100 (BST)
References: <20200708082347.27318-1-jcmvbkbc@gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH] tests/docker: update toolchain set in debian-xtensa-cross
In-reply-to: <20200708082347.27318-1-jcmvbkbc@gmail.com>
Date: Wed, 08 Jul 2020 09:51:42 +0100
Message-ID: <87wo3emlsx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Max Filippov <jcmvbkbc@gmail.com> writes:

> Switch to the prebuilt xtensa toolchains release 2020.07.
> Drop csp toolchain as the csp core is not a part of QEMU.
> Add de233_fpu and dsp3400 toolchains to enable DFPU and FPU2000 tests.

Queued to misc/for-5.1-rc0, thanks.

>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
>  tests/docker/dockerfiles/debian-xtensa-cross.docker | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian-xtensa-cross.docker b/tests/=
docker/dockerfiles/debian-xtensa-cross.docker
> index beb73f46baa6..ba4148299c5a 100644
> --- a/tests/docker/dockerfiles/debian-xtensa-cross.docker
> +++ b/tests/docker/dockerfiles/debian-xtensa-cross.docker
> @@ -18,12 +18,12 @@ RUN apt-get update && \
>          git \
>          python3-minimal
>=20=20
> -ENV CPU_LIST csp dc232b dc233c
> -ENV TOOLCHAIN_RELEASE 2018.02
> +ENV CPU_LIST dc232b dc233c de233_fpu dsp3400
> +ENV TOOLCHAIN_RELEASE 2020.07
>=20=20
>  RUN for cpu in $CPU_LIST; do \
>          curl -#SL http://github.com/foss-xtensa/toolchain/releases/downl=
oad/$TOOLCHAIN_RELEASE/x86_64-$TOOLCHAIN_RELEASE-xtensa-$cpu-elf.tar.gz \
>          | tar -xzC /opt; \
>      done
>=20=20
> -ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLC=
HAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-csp-elf/b=
in
> +ENV PATH $PATH:/opt/$TOOLCHAIN_RELEASE/xtensa-dc232b-elf/bin:/opt/$TOOLC=
HAIN_RELEASE/xtensa-dc233c-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-de233_fpu=
-elf/bin:/opt/$TOOLCHAIN_RELEASE/xtensa-dsp3400-elf/bin


--=20
Alex Benn=C3=A9e

