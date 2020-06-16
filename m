Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFD9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:29:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABAA5208D5
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 17:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QiGhHVbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABAA5208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54546 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlFOv-0004sT-W6
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 13:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51534)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlFNo-0003mH-0S
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:28:24 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36596)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jlFNm-0002Y7-2j
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 13:28:23 -0400
Received: by mail-wr1-x442.google.com with SMTP id q11so21648315wrp.3
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2020 10:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=CbIdcvNynIh9qgfMr2MC/xODyGTB4Twvz4Shij1PRtQ=;
 b=QiGhHVbQ474TyxA85zcgwytGVhfU/kfl6Rcw/luYCTov3Na0oEiibq+YPQNuPC5j9k
 OSUzln96jpiXcuLVQZaAzpXc2Co1oOAtgC4VkrIPsN9nzQrUzmw/bNAFyAQAxxfnWrKQ
 xOux3lKHLBqM6g0RCdcytc5ZCdEj4QY/8THYkt338QUnbDx8uQZlrFrxrG0bNxEe228t
 2asqnh/DmUSotS5BjItEHnJui+lV8fTTa5ppl1/+ZMCByPb9b0in0MCjiJNca5eS35/h
 MJv9R3d1RRzOXr7q6C8UgLbanqLudCeMSb3t2W4Zhq1BjCr4l9WhGmlMD7211U/rAEQu
 KS2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=CbIdcvNynIh9qgfMr2MC/xODyGTB4Twvz4Shij1PRtQ=;
 b=UHFfNLLYOOmmbDNNrLm1hQR+tvjV+HnsiqsO5mRHm0JdjNTpZkGF5qjos3EVY1bii6
 H99djpcTTkIt0kQmSDGblsJdzc3Pa576p0tVsniVifBEskmT0SlMUIVBHO78fy5PprYg
 QtzSw0L5yV+FY3DyZ0OYiotaVc2loE518mV2ctDjWq5QwkH5SrC1QiKeDhYZPTI3bx6r
 SakL1qhwqOWAcQa3+u+t1OOBhOzryUO2ffBSzARumWXf4RJzbSO4r2f0cFlkbeMv6tc9
 O/S2/lPugSSk/LTWk1nspY5UW0pWH+LxMpP27elFD6IsmOzxCraWMhDPKBnnPtzaGnJz
 n5/A==
X-Gm-Message-State: AOAM5338ucwFLQfwxAKGq7mCKFfLClwdwv4FPpdAZ+FL0oVM9OLPfc82
 EeoN4DAygB3rz1v6mgEPuxrJ6A==
X-Google-Smtp-Source: ABdhPJz3GmXEL8QCocsxQyVXgOl3jfGT4pbY7/IdFqo5baZsDA0LoqbT05SnASb+K1JB3LV8W+mqAg==
X-Received: by 2002:adf:f789:: with SMTP id q9mr4440465wrp.251.1592328499885; 
 Tue, 16 Jun 2020 10:28:19 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id o18sm5240128wme.19.2020.06.16.10.28.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2020 10:28:18 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 346451FF7E;
 Tue, 16 Jun 2020 18:28:18 +0100 (BST)
References: <20200604085441.103087-1-kbastian@mail.uni-paderborn.de>
 <20200604085441.103087-7-kbastian@mail.uni-paderborn.de>
User-agent: mu4e 1.5.3; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Subject: Re: [PATCH v2 06/15] tests/tcg/tricore: Add macros to create tests
 and first test 'abs'
In-reply-to: <20200604085441.103087-7-kbastian@mail.uni-paderborn.de>
Date: Tue, 16 Jun 2020 18:28:18 +0100
Message-ID: <87366uzzrh.fsf@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:

> This kind of tests is inspired by the riscv-tests repository. This adds
> macros that makes it easy to create single instruction self containing
> tests.
>
> It is achieved by macros that create a test sequence for an
> instruction and check for a supplied correct value. If the value is corre=
ct the
> next instruction is tested. Otherwise we jump to fail handler that writes=
 is
> test number as a status code back to qemu that then exits on that status =
code.
> If all tests pass we write back 0 as a status code and exit.
>
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  tests/tcg/configure.sh                    |  7 ++-
>  tests/tcg/tricore/Makefile.softmmu-target |  2 +
>  tests/tcg/tricore/macros.h                | 53 +++++++++++++++++++++++
>  tests/tcg/tricore/test_abs.S              |  8 ++++
>  4 files changed, 69 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/tricore/macros.h
>  create mode 100644 tests/tcg/tricore/test_abs.S
>
> diff --git a/tests/tcg/configure.sh b/tests/tcg/configure.sh
> index 6e8659d488..cd857433d9 100755
> --- a/tests/tcg/configure.sh
> +++ b/tests/tcg/configure.sh
> @@ -85,7 +85,7 @@ for target in $target_list; do
>      xtensa|xtensaeb)
>        arches=3Dxtensa
>        ;;
> -    alpha|cris|hppa|i386|lm32|m68k|openrisc|riscv64|s390x|sh4|sparc64)
> +    alpha|cris|hppa|i386|lm32|m68k|openrisc|riscv64|s390x|sh4|sparc64|tr=
icore)
>        arches=3D$target
>        ;;
>      *)
> @@ -169,6 +169,11 @@ for target in $target_list; do
>        container_image=3Ddebian-sparc64-cross
>        container_cross_cc=3Dsparc64-linux-gnu-gcc
>        ;;
> +    tricore-softmmu)
> +        container_image=3Ddebian-tricore-cross
> +        container_cross_as=3Dtricore-as
> +        container_cross_ld=3Dtricore-ld
> +        ;;
>      xtensa*-softmmu)
>        container_image=3Ddebian-xtensa-cross

I'd of been tempted to include this with the build infrastructure patch
but whatever...

>=20=20
> diff --git a/tests/tcg/tricore/Makefile.softmmu-target b/tests/tcg/tricor=
e/Makefile.softmmu-target
> index 4a2cd6f218..1b1f220c7c 100644
> --- a/tests/tcg/tricore/Makefile.softmmu-target
> +++ b/tests/tcg/tricore/Makefile.softmmu-target
> @@ -7,6 +7,8 @@ ASFLAGS =3D
>=20=20
>  QEMU_OPTS +=3D -M tricore_testboard -nographic -kernel
>=20=20
> +TESTS +=3D test_abs.tst
> +

Also you could use wildcards so adding new tests is simpler but anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

