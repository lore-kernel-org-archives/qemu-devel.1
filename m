Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6259C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:48:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D19A2078E
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FK0a4BG5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D19A2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDU46-0000Sv-PS
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 10:48:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDU3E-00082n-SM
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:47:55 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36972)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kDU3C-00041L-KQ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 10:47:52 -0400
Received: by mail-wm1-x343.google.com with SMTP id a9so4854930wmm.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 07:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=I6KyCIC0XSdOqI+M+7jzVngfvjTlucsuEn/3jZVCJQo=;
 b=FK0a4BG5HPkRWBP3DINqlvjTeF5IKnEIf6U9yZ8AZ1lGfrz3wivfwN5KlahQCBp6jS
 oGgX3eetfP3oqxEOPBR905GqozORrEYjRNQwX9URINM8m0CoziHENmEtFSYCNC6zRCVK
 H6//GRU6ttObq7SVvgq4/GphnQAcXlULiCvIE2c47OfIGPvbARDgETwj7V55bkiTwnoK
 94NYsROLavoCAYhoXboq/gOplwz8HCpUe4UyZzebKyytHGNHcJ2NMi3rGOQkjF0gRFjH
 hggBYW2V5dPViCEZ9YjhWvwsPjERFyeF2kRo38J4+jdlBSbTmu42eyh9hKCbQvCfscns
 mKug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=I6KyCIC0XSdOqI+M+7jzVngfvjTlucsuEn/3jZVCJQo=;
 b=SF2i0xN4XQ7Qi7BA9xob1w5tFxhFi0HPiU3vQPTE2DGIuyld5M751T8uWHCAqh8fLQ
 pIF4LukADaXtNjbuKyvGeDqaCKIEe0LEcL3VXJKnWeEVxD/n9lhNSl32n6zZKwG7EwdL
 5SJR2eSDlgxuzCpb9l+YJCn1Mp7pIM5FNOzMUkhL/BHTp2QDp++dTrsTDuamJacE506v
 JuaXE+P67YLNmJpz77I5hUARDFerr8uosaPtXJmbtMaX08nzsZfwO0Hon0TKhxAAnFMg
 iOF0dC6p2dGhNqm4BUXmr/pwjHrJc/7Ry75W73irBoNtFmSxU/6kD9ckkI43eeom2qkI
 oT0A==
X-Gm-Message-State: AOAM532BvkXZ4xHYcCXVrWQWhyhDJ+c46FFPa00X/socy21gQx7hrg5z
 iPvZWQqVCyul+yPIZwV8ORfBufPu7QYKnw==
X-Google-Smtp-Source: ABdhPJw7FdxJwkN4wXtrPT8T2+6p7AYyg1zDKX7exGA51XPmjnrsQ4MVfBzINQ6b4zFg22n2dvcE7Q==
X-Received: by 2002:a7b:ce0d:: with SMTP id m13mr1070562wmc.83.1599058068549; 
 Wed, 02 Sep 2020 07:47:48 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id y6sm7647181wrt.80.2020.09.02.07.47.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 07:47:47 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C9A4E1FF7E;
 Wed,  2 Sep 2020 15:47:46 +0100 (BST)
References: <20200902125917.26021-1-pbonzini@redhat.com>
 <20200902125917.26021-2-pbonzini@redhat.com>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 01/39] configure: Add system = 'linux' for meson when
 cross-compiling
In-reply-to: <20200902125917.26021-2-pbonzini@redhat.com>
Date: Wed, 02 Sep 2020 15:47:46 +0100
Message-ID: <87tuwg44ml.fsf@linaro.org>
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Paolo Bonzini <pbonzini@redhat.com> writes:

> From: Thomas Huth <thuth@redhat.com>
>
> Meson needs the "system =3D xyz" line when cross-compiling. We are already
> adding a "system =3D 'windows'" for the MinGW cross-compilation case here,
> so let's add a "system =3D 'linux'" now for Linux hosts, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Message-Id: <20200823111757.72002-2-thuth@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  configure | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/configure b/configure
> index 8a3acef89d..b58627f4aa 100755
> --- a/configure
> +++ b/configure
> @@ -8163,6 +8163,9 @@ if test -n "$cross_prefix"; then
>              ?:*) pre_prefix=3D/ ;;
>          esac
>      fi
> +    if test "$linux" =3D "yes" ; then
> +        echo "system =3D 'linux'" >> $cross
> +    fi
>      case "$ARCH" in
>          i386|x86_64)
>              echo "cpu_family =3D 'x86'" >> $cross


--=20
Alex Benn=C3=A9e

