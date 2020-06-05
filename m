Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA2AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9C3E206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gK7IAaLP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C3E206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEgm-0004Jb-4G
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEfB-0002CH-OE
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:53:45 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43429)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhEf9-0004tj-HU
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:53:45 -0400
Received: by mail-wr1-x443.google.com with SMTP id l10so10247319wrr.10
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 08:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=0ywUrKfUpLgjpcf5wzKneETkV2LMfE2TylBvOMx+B8A=;
 b=gK7IAaLPdnFm0gCR4kUfehoBKSiJ7DznIp7yPi4QZuC2eLOdxWAe3QBrNiD+NbJIBO
 QRX3+VkI/d3Ibad0n6LeU6NlD3QGRJDECZdn0dv23gd6ddEce+4u9QDDCogO/XOgYzTE
 XiGAfiLAdRiAmIUZRQRfR+G5ViKU17lxaGDZNBMdT9xxG08v5Ia3zZPyK4jhQ9VSO39N
 DP2maV8V9C+TP7UXRy1pjxxIz7lieupP5b8xgTb2Il+7yUoKSFrr8LDsnsmiScTOKD55
 Vg1xX6CUy6e86wnhvWppAAYlWJqei38G6znrm4X/664y+j2ZvUy0f8Z4B0dJVlKep3G0
 fqEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=0ywUrKfUpLgjpcf5wzKneETkV2LMfE2TylBvOMx+B8A=;
 b=ZkGv+knx0URzSOEeLv0xtpDY4sCbc9SlNOvgoZXKMX/YWZbMf1LIOqkVm0Labp7fMf
 AGSTZ+qTdhteCT67YlUy8R2C+0TkM+az8c6msXoQMjIptQsdUw8eUatOBk58aeZ0AZ1L
 XwIWTIxA5BRl3KUlC3Y3Z4ptaHUhuvR6/sHJfeXADr1Wr9NxDHQDrylIFR8N0QrMFVD9
 4jdw5iDwDysNtjnl3NQfRYS44o11H4aS5eZAbJQRDo5CimlxoBgd40iDoE3c1y54rfoE
 9MQxwHeRPiqW61OjS9cyhYm1X7BDGXRx+/Ne2W9RmwXc9AOXoOh3DqNiiLyhaBeMSPAr
 Jg3A==
X-Gm-Message-State: AOAM533xxoL6mP5WkWAez/zlUMGaPf/Wji4K6AZQDbl8ZmlhyD4dmB5U
 SCAWJdSdmOyxQ7HQ6RvxRPm3gQ==
X-Google-Smtp-Source: ABdhPJxmPGic9AiTgC9ti0aek8T7elKUDC3ZTm7utdYAAFiKUmRr2Zkf14MuTlk4OBAUR6MSwV+nVw==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr10330387wru.83.1591372421912; 
 Fri, 05 Jun 2020 08:53:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 5sm17054308wrr.5.2020.06.05.08.53.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 08:53:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 41D701FF7E;
 Fri,  5 Jun 2020 16:53:32 +0100 (BST)
References: <20200604034513.75103-1-richard.henderson@linaro.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH] configure: Disable -Wtautological-type-limit-compare
In-reply-to: <20200604034513.75103-1-richard.henderson@linaro.org>
Date: Fri, 05 Jun 2020 16:53:32 +0100
Message-ID: <87bllx4igz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x443.google.com
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
Cc: thuth@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Clang 10 enables this by default with -Wtype-limit.
>
> All of the instances flagged by this Werror so far have been
> cases in which we really do want the compiler to optimize away
> the test completely.  Disabling the warning will avoid having
> to add ifdefs to work around this.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  configure | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configure b/configure
> index f087d2bcd1..693f01327f 100755
> --- a/configure
> +++ b/configure
> @@ -2009,6 +2009,8 @@ gcc_flags=3D"-Wno-missing-include-dirs -Wempty-body=
 -Wnested-externs $gcc_flags"
>  gcc_flags=3D"-Wendif-labels -Wno-shift-negative-value $gcc_flags"
>  gcc_flags=3D"-Wno-initializer-overrides -Wexpansion-to-defined $gcc_flag=
s"
>  gcc_flags=3D"-Wno-string-plus-int -Wno-typedef-redefinition $gcc_flags"
> +gcc_flags=3D"$gcc_flags -Wno-tautological-type-limit-compare"
> +

nit: the pattern is reversed compared to the previous lines (foo $gcc_flags)

I had exactly the same patch in my local tree but it wasn't enough for
clang-9 which I was using for a sanitiser build. I ended up
having to apply --disable-werrror to the configuration.

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

