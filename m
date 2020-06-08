Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241C9C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:11:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E41392072F
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 11:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="paDL/NqI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E41392072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiFgJ-0005nl-Ok
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 07:11:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiFfE-0004lO-M7
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 07:10:00 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55104)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiFfD-00078a-Sj
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 07:10:00 -0400
Received: by mail-wm1-x342.google.com with SMTP id g10so14923552wmh.4
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 04:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=RTkz8aoAeTXUgQT5OfQvsppF3yMOR7TpfBxGPIyi4Is=;
 b=paDL/NqIRULs/B/E9mzKLmS94doWKWy3KvkWakN5DahkcjvGno0wE7fLzT3Bjbadz3
 izDwIjI2xeMv1KjaITSxI072y4xcMI5HHrQP8uCqc9s6SDa9Sbq8k8oyj0WCl6zL1x1d
 moeD/yjiwQpzr3b63O4hC4nm7CXvPliB/0AEYPmz4F65FgqG3JEXSQ6odBa4k/HkLO27
 IpwzTVBVqKntJL6nBVLGZzdKaJuD1uesolhKpvg4zGx5UfmHo9VfZjdi5IF08BEU8OzX
 sbX/7aJbbRGcLbjn6/96aQK+hiQf9OMOK4lHsIEdU8E/MEEPY+Kgx69jl/jQCnxx9+VK
 PZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=RTkz8aoAeTXUgQT5OfQvsppF3yMOR7TpfBxGPIyi4Is=;
 b=Asazf9rW1HC74dDxhfvnKmGnqgS3vTCErHinVHFHwdf4kehjDHuLN4QJkzGG3iyATR
 2Brz8uc34p25932FzRDnYwtuRclEwU3b7BrahrVIud5UPqJ0VpZ3pJvg4t3ydGcnF84R
 K07DlapAGKUTFzN3VJ8ebM4k9tLmE4IIKdOHoFaTkjhJgbObpaV2dQtdK+mgUPKeGXlW
 dpScFrD+WFbxVUCk8NYN90GWTZTFs6424PHD3rUAHL0pFJc62mDkyRND0yt6DR4AGgRX
 5AaQMVvKTp1SlGrV15t/44bU/LV1+hG+ncvr2GuPGCkyJD8TSRF2+YBR5LDI+WPmE+AZ
 yNyg==
X-Gm-Message-State: AOAM530KLSf8OL/bgsBS+QAe2zHgXCC/eqfG8imQvex/rnlsqg2Wov5O
 s4UwPWEBHDk87xki12HorUnJsg==
X-Google-Smtp-Source: ABdhPJxdQtiCLCjZfMiM3/kQRHByYn3utO0jWMRsJDpZZz2ejhGOWvjopxe0XElUXDUy8mdCR8Evfw==
X-Received: by 2002:a7b:c1c5:: with SMTP id a5mr15667314wmj.35.1591614598385; 
 Mon, 08 Jun 2020 04:09:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c70sm11727047wme.32.2020.06.08.04.09.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 04:09:56 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 49ED31FF7E;
 Mon,  8 Jun 2020 12:09:56 +0100 (BST)
References: <20200605093256.30351-1-philmd@redhat.com>
 <20200605093256.30351-11-philmd@redhat.com>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [PATCH v6 10/11] Makefile: Allow target-specific optional Kconfig
In-reply-to: <20200605093256.30351-11-philmd@redhat.com>
Date: Mon, 08 Jun 2020 12:09:56 +0100
Message-ID: <87a71d7r0b.fsf@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Allow use of target-specific Kconfig file.
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  Makefile | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index f8a45e1379..d5009cd304 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -423,11 +423,13 @@ MINIKCONF_INPUTS =3D $(SRC_PATH)/Kconfig.host \
>                     $(SRC_PATH)/accel/Kconfig \
>                     $(SRC_PATH)/hw/Kconfig
>  MINIKCONF_DEPS =3D $(MINIKCONF_INPUTS) \
> -                 $(wildcard $(SRC_PATH)/hw/*/Kconfig)
> +                 $(wildcard $(SRC_PATH)/hw/*/Kconfig) \
> +                 $(wildcard $(SRC_PATH)/target/*/Kconfig)
>  MINIKCONF =3D $(PYTHON) $(SRC_PATH)/scripts/minikconf.py
>=20=20
>  $(SUBDIR_DEVICES_MAK): %/config-devices.mak: default-configs/%.mak $(MIN=
IKCONF_DEPS) $(BUILD_DIR)/config-host.mak
>  	$(call quiet-command, $(MINIKCONF) $(MINIKCONF_ARGS) \
> +		$(wildcard $(SRC_PATH)/target/$(call base-arch, $(firstword $(subst -,=
 ,$@)))/Kconfig) \

As discussed on IRC I think we can emit base-arch into config-host.mak
from exiting data and then utilise that rather than re-coding the data
inside rules.mak.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

