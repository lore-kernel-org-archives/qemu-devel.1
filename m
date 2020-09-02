Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A45C3C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2563120767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zclbJEkq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2563120767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVzr-0002Ew-4G
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42162)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDVzG-0001kP-5v
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:51:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35347)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDVzE-0007GP-DC
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:51:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id e16so165637wrm.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 09:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=yMHFOH2hPdxfECAFN7SykhfbJWzNWfIXkjLK+LyQheM=;
 b=zclbJEkqMso57Hq016/chBrkJaZjwjozee2ge+/+xQMDINat36d8d0xDwXUV2nM3ZW
 xMGXzt2ws4gYVnKffA3Suwol8uiZ6OdNlCAx18Z6eB7rrXW/OLDE1Mt4+PEv3bRQaGd3
 Hr5MViM/JN1kJ6xdxi2XZnSEwSpEn7SV5IT5DZNLRXRIWtVFF1LsH+gzxmMIfH+94lVe
 oFOLUY0IBe9xjnQrky6pD/g8R6hbQxSZGoD01I5MhWyVan5YpUOf+mi3SoQO+pisnUsE
 5OWQVElKyCvj8MPWddTRZEJDVR8B3PxouzqPJqwGPbspPWryP4OovXJxS+Qal2GedE0G
 E2kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=yMHFOH2hPdxfECAFN7SykhfbJWzNWfIXkjLK+LyQheM=;
 b=r0GTnkDQSb5G1uFQSSuFO4NHcAnrlAqQYndKBIk8cYjfMUHz0Axk4G1A5S92kDnkXS
 6s8KmatYptWvOd434+vPK/p7W/mKBO3G+fAHgbsihQb5ESn6nEMWqfXel11BhdRsZltX
 Y7iowW1O1NuAQxDMo4ZCBNKiUSu4Di9FgwwEaf9Cd/rm9YIPiHszJffaexO/gDo7Jj6o
 4tymt/FOHYN1TkpPtvzreokr/KXYikmqedtO9YUFvxpJ6mZJiwsJU9er685SMhToqQR6
 meodoXzYPQvo3ON+pgekVVgNr28NWZVm/7hKtOmyFfsQGSZySDhFRUuvYuzpY4w8z+Vs
 6Vrw==
X-Gm-Message-State: AOAM533a34I5YBRF9E8V4cQ+me0Cz+sFMzDai6SUT3zdT+Cof5PKKZKT
 Sc1SX4xGnr1VYEv10XIzwu7v3A==
X-Google-Smtp-Source: ABdhPJxlNiaaWCmfFTLR2egLpohFc+s++qyq8wV5WPmBwu4Z81EGGE3ubzaJmZPwSN7F21MX2rznVQ==
X-Received: by 2002:adf:fe42:: with SMTP id m2mr7828275wrs.367.1599065510686; 
 Wed, 02 Sep 2020 09:51:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 8sm421301wrl.7.2020.09.02.09.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 09:51:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E6E111FF7E;
 Wed,  2 Sep 2020 17:51:48 +0100 (BST)
References: <20200902080046.10412-1-pbonzini@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] qemu-iotests: move check-block back to Makefiles
In-reply-to: <20200902080046.10412-1-pbonzini@redhat.com>
Date: Wed, 02 Sep 2020 17:51:48 +0100
Message-ID: <87r1rk3yvv.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> check-block has its own test harness, unlike every other test.  If
> we capture its output, as is in general nicer to do without V=3D1,
> there will be no sign of progress.  So for lack of a better option
> just move the invocation of the test back to Makefile rules.
>
> As a side effect, this will also fix "make check" in --disable-tools
> builds, as they were trying to run qemu-iotests without having
> made qemu-img before.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I've pulled it into my testing/next tree but feel free to include in
your next PR if you beat me to it.

> ---
>  meson.build                    |  2 --
>  tests/Makefile.include         | 15 ++++++++++++---
>  tests/qemu-iotests/meson.build |  4 ----
>  3 files changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/meson.build b/meson.build
> index 55c7d2318c..356af9142c 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -1095,11 +1095,9 @@ if have_tools
>               dependencies: [authz, block, crypto, io, qom, qemuutil], in=
stall: true)
>    qemu_io =3D executable('qemu-io', files('qemu-io.c'),
>               dependencies: [block, qemuutil], install: true)
> -  qemu_block_tools +=3D [qemu_img, qemu_io]
>    if targetos !=3D 'windows'
>      qemu_nbd =3D executable('qemu-nbd', files('qemu-nbd.c'),
>                 dependencies: [block, qemuutil], install: true)
> -    qemu_block_tools +=3D [qemu_nbd]
>    endif
>=20=20
>    subdir('storage-daemon')
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 9ac8f5b86a..08301f5bc9 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -468,7 +468,6 @@ check-tcg: $(RUN_TCG_TARGET_RULES)
>  .PHONY: clean-tcg
>  clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>=20=20
> -
>  # Python venv for running tests
>=20=20
>  .PHONY: check-venv check-acceptance
> @@ -523,8 +522,18 @@ check-acceptance: check-venv $(TESTS_RESULTS_DIR) ge=
t-vm-images
>  # Consolidated targets
>=20=20
>  .PHONY: check-block check-unit check check-clean get-vm-images
> -check-block:
> -check-build: build-unit
> +check:
> +
> +ifeq ($(CONFIG_TOOLS)$(CONFIG_POSIX),yy)
> +QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) =3D tests/qemu-iotests/socket_scm_h=
elper$(EXESUF)
> +check: check-block
> +check-block: $(SRC_PATH)/tests/check-block.sh qemu-img$(EXESUF) \
> +		qemu-io$(EXESUF) qemu-nbd$(EXESUF) $(QEMU_IOTESTS_HELPERS-y) \
> +		$(patsubst %-softmmu,qemu-system-%,$(filter %-softmmu,$(TARGET_DIRS)))
> +	@$<
> +endif
> +
> +check-build: build-unit $(QEMU_IOTESTS_HELPERS-y)
>=20=20
>  check-clean:
>  	rm -rf $(check-unit-y) tests/*.o tests/*/*.o $(QEMU_IOTESTS_HELPERS-y)
> diff --git a/tests/qemu-iotests/meson.build b/tests/qemu-iotests/meson.bu=
ild
> index 3de09fb8fa..60470936b4 100644
> --- a/tests/qemu-iotests/meson.build
> +++ b/tests/qemu-iotests/meson.build
> @@ -4,7 +4,3 @@ if 'CONFIG_LINUX' in config_host
>  else
>      socket_scm_helper =3D []
>  endif
> -test('qemu-iotests', sh, args: [files('../check-block.sh')],
> -     depends: [qemu_block_tools, emulators, socket_scm_helper],
> -     suite: 'block', timeout: 10000)
> -


--=20
Alex Benn=C3=A9e

