Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4C9C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B505B2078D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 10:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IdMiWVSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B505B2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPNZS-000814-L5
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 06:18:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPNYT-0007ai-Vo
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:17:18 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:40757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kPNYR-0005lN-Po
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 06:17:17 -0400
Received: by mail-wr1-x442.google.com with SMTP id j2so8889602wrx.7
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 03:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=tvRXN5ZknoSqya6EqJrlT0TR7wJD8tO9Gl726VYBWjs=;
 b=IdMiWVSE+D5j74s+9GXxhWZ8I24kYEPqDnpoOg9kav4IUtaoxI3M4dkgtZb2O5a38m
 cCycbtCinls+mMHJqRRkuP0I9ua6gKGf3Z/Ezt9wrK7DlY63WIRVA3fkXydMB4QJVsx1
 I0ZQTkjSjVF49n2feowRk/Qwkp1v8Nk/OA9oFAoQ1x9iuygLnIaqGzaYC+WnNCD7afPj
 Sb3S230KomcZlJTu/B7+b+vW1XbjoGFgMf9gk57gTW2IJSO0bjvhVXQKYJeBXT8dLXQb
 JebiTtRqMR+Hwrm8Lv0OGPRMVsbP8225BLv/5BK7BCUomsG0LHPekSdCZmtbY2kFvUkp
 ZwJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=tvRXN5ZknoSqya6EqJrlT0TR7wJD8tO9Gl726VYBWjs=;
 b=DkJ2D/4KD7gB4vzFuJSk+RJaUW2qHfE45rfj9ECaGijaBsXcw0H+/1llAgH86gPlOh
 76d7lId0LHCmyVUATwDQdOwQN6P8+GeDthLAky6VXvXSJmZyS6U0AvAYoTIpPer6AR4D
 a5GYa6PBLjoS/LUBWZPmq247M6cfxxNjlWGdmLfVBA/HBc3iZ760ODVOSG9UI8l57x7C
 fptv8LDtgSWn5CLS940YVAZNOhSgqDCkY32UPWQYK4oTZKF5ivuikctlkjShGZPUeFr1
 wflfl38q+umlweFgo2pvvgNH3Dmwh/d/lKRH4eiruThqMBp9BK3ROwGXqPbxqGdCVr/W
 HFLA==
X-Gm-Message-State: AOAM5321X7Qerz1ZUS7n217rsf//IZur6MWpWXGYjvfbx5cllIn5JfAc
 UNEcmodD+2eqGDyUecpiWQLvQw==
X-Google-Smtp-Source: ABdhPJzPhftKoijMSDnyEKTxGsm3A4tFSwJphEOi7zDY+JM7mGZ7LUqWd/fO2RmgOllV/7/WpOCgrA==
X-Received: by 2002:adf:db4d:: with SMTP id f13mr17004086wrj.155.1601893033892; 
 Mon, 05 Oct 2020 03:17:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a82sm1412008wmc.44.2020.10.05.03.17.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2020 03:17:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 4C4471FF7E;
 Mon,  5 Oct 2020 11:17:12 +0100 (BST)
References: <20201001163429.1348-1-luoyonggang@gmail.com>
 <20201001163429.1348-4-luoyonggang@gmail.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Yonggang Luo <luoyonggang@gmail.com>
Subject: Re: [PATCH v3 3/6] cirrus: Enable plugin in cirrus for windows
In-reply-to: <20201001163429.1348-4-luoyonggang@gmail.com>
Date: Mon, 05 Oct 2020 11:17:12 +0100
Message-ID: <87wo052d07.fsf@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Yonggang Luo <luoyonggang@gmail.com> writes:

> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>

If the build doesn't work until your later fixes then this should be the
last patch in the series.=20

> ---
>  .cirrus.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 86ea33926a..5363142373 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -104,7 +104,8 @@ windows_msys2_task:
>      - C:\tools\msys64\usr\bin\bash.exe -lc "mkdir build"
>      - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && ../configure
>        --python=3Dpython3 --ninja=3Dninja
> -      --target-list-exclude=3Di386-softmmu,arm-softmmu,ppc-softmmu,mips-=
softmmu"
> +      --target-list-exclude=3Di386-softmmu,arm-softmmu,ppc-softmmu,mips-=
softmmu
> +      --enable-plugins"
>      - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make -j$NUMBER_O=
F_PROCESSORS"
>    test_script:
>      - C:\tools\msys64\usr\bin\bash.exe -lc "cd build && make V=3D1 check"


--=20
Alex Benn=C3=A9e

