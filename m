Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA41C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:05:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B7B820716
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBR3QkwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B7B820716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiMeo-0005XP-LM
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 13:05:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMbp-0002LP-Qx
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:02:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMbo-00007i-Pp
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:02:41 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiMbo-00005y-JS
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:02:40 -0500
Received: by mail-wr1-x442.google.com with SMTP id y17so10290077wrh.5
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 10:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:subject:in-reply-to:date:message-id
 :mime-version:content-transfer-encoding;
 bh=pf89wRkTJiUJlp2XpdoX78Ro9ZTlWmpCqC08QP+SGHU=;
 b=eBR3QkwB5oKdXCPze7uVI7Jnyw3IxGpIrwswdMHMfd0LEO6X7j7MX7MZj3Vubkf+k0
 W5kr9BmO5VB+BprzWq2pxP3vvENVu+Qk3eBiGe75bQQM3zfjYuHKpPADXJB+OlWfKWFb
 nPUMxiQe4Jw9BqkuUR7F12tCIAaSzV1lpKozA51SocJvEpL/v3dYKEhioOi6z+nWSh0X
 s+sCOl48n7/E/XZ6tDEbU2hIj2f6tp76EBPDErx6u6jv+xxuHS41STSwQN2UryMqjqC/
 8gUoiVROc9J7f59u6DdkefW1hpR0iqNx1RXLOvilhGjnPHzM4j8n40/VKQXuXPPkMV4v
 SDJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=pf89wRkTJiUJlp2XpdoX78Ro9ZTlWmpCqC08QP+SGHU=;
 b=gLErxrze2hj6OUt3hcOzQUszdTC7OFwdKsUzvmMWfETP0Yl+ly4Fb375794nO+BRhz
 NXTWJEYZr5WJIgo7ia32G6ey7q+Emo2Vm6Cn3JYR5O+MqZcXjISPo9uh9dPumELDaRc/
 bzVnyYRoGWMsM0F4ial3l3hz3TsaiSD7/JPrSvmj1GAq/Xr0583AhpH2al1H4FtZqSZJ
 rwhgXkGz1mU1rsvYs+MKR8ZbMd4LiUvij4kpzmX00vksNYXXoOwZFDG46P2T38ug8j7V
 lhipBsxt69p5U+ScxgFc0licQbFTkUCEbb0lmurwXY2nlLFpb1DzLG29lhunHHyOG1/a
 DODQ==
X-Gm-Message-State: APjAAAWYc1EeVU3Bz5EZPZYbr23zbJI6sVKsZ/hZUq0D/WXHUDtIW3Uz
 UX6HvM5BxhSUmnETJBc3W6kKZKjKnpI=
X-Google-Smtp-Source: APXvYqyxL5Y6fOPeCWlzgKPawpZyhI2C+vvgnYZONogWTa/qSt2xM9jV6qdUbj2XENcAmmKTYP9wRA==
X-Received: by 2002:a5d:5307:: with SMTP id e7mr17066615wrv.146.1576864959045; 
 Fri, 20 Dec 2019 10:02:39 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d16sm11730708wrg.27.2019.12.20.10.02.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 10:02:37 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 140F01FF87
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 18:02:37 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-17-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 16/28] target/alpha: Remove MMU_MODE{0,1}_SUFFIX
In-reply-to: <20191216221158.29572-17-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 18:02:37 +0000
Message-ID: <874kxudgea.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The functions generated by these macros are unused.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/alpha/cpu.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/target/alpha/cpu.h b/target/alpha/cpu.h
> index a530249a5b..3f782c0efe 100644
> --- a/target/alpha/cpu.h
> +++ b/target/alpha/cpu.h
> @@ -193,8 +193,6 @@ enum {
>     PALcode cheats and usees the KSEG mapping for its code+data rather th=
an
>     physical addresses.  */
>=20=20
> -#define MMU_MODE0_SUFFIX _kernel
> -#define MMU_MODE1_SUFFIX _user
>  #define MMU_KERNEL_IDX   0
>  #define MMU_USER_IDX     1
>  #define MMU_PHYS_IDX     2


--=20
Alex Benn=C3=A9e

