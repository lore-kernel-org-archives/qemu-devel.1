Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA4DC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:04:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 980EC20716
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:04:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hOcpVv4R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 980EC20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiMdh-0003hE-NM
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 13:04:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMc0-0002Tk-NM
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:02:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iiMbz-0000L5-M7
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:02:52 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37738)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iiMbz-0000Ig-Fd
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:02:51 -0500
Received: by mail-wm1-x341.google.com with SMTP id f129so10131107wmf.2
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 10:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7kDmZhoO5/bznVBD81W5KeIm1h45FhLlVidRUE2YIrw=;
 b=hOcpVv4RDFqTdsrbhnw7Cg72oeHU6obx5y1b0mkOyiSsgv1MPe2S4gS1SjCa3RNqIc
 DgQRhAqdzWElTuyOvDioByimPeVJuuRFVfCkYClLKAI25v0kgzzPGUmHXcbNqK/wsTs1
 Z5AQ2B14dEqHU6OoL3CxIktuScrOa6OKjymrkcZm3RdIjSweCVJzGPTHiGN6a5cJ7w8d
 owZ3DhiM4zhfSq72aXaMYaN7HHddt9f/Q3UUb2Npm1CEOBWDL1tXX6b/BldR1xUzKUW6
 StKJWQKUHQxIKdaCNAo4LVexGhSz8AjBmS+0EBUWANITak2CZxKkJPnqr/GKriWFQjbF
 bwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7kDmZhoO5/bznVBD81W5KeIm1h45FhLlVidRUE2YIrw=;
 b=cGrwEhqJw9Db4CxvHGIjv63bhB7FdoXPmQQC179dQwgzo6eQQsRDdiOgpkzmIxb5ok
 wpfgoQAsssieU9ae4+DaVK4sO/OJuIIORts/f+jSmPvBhp3Ath7YT2yk9IvJ6QfMEbaw
 dG3YeeRvW1I1pIRgFgJV/6XjFKAzY8AkdH1d0GTtrF6t/SQVjYLGpZtawnEfJO9EXRD0
 NamHhR75wAIq6/EIZLbePeEr96+3uJmnyWAReYSAGmhbl4zoY/R6ZKjwwMaTmYHio1Fb
 ijQuCdixt6xYtZvi+iJBbKZ3qCRd7Rpigui3gdxQCK+rbKgx0Z72fUo6If+x9BB90cyt
 +kDw==
X-Gm-Message-State: APjAAAUTHHVbk/sKB15U5w2OD74U5LdT5UbXyOJaFrqbg0yWcgjgVh6b
 QIMHVWDvy0O9B8GsqnktQuTv2Q==
X-Google-Smtp-Source: APXvYqyyodcMWSplnIyI6dPYkb0jjNZCxyFvyQvRdDHr/4OxckyjYLMtQIxbKIBDwLfZAYLAgOdPuw==
X-Received: by 2002:a7b:cbd6:: with SMTP id n22mr17431333wmi.118.1576864967808; 
 Fri, 20 Dec 2019 10:02:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id b68sm10762848wme.6.2019.12.20.10.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2019 10:02:46 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id BD6981FF87;
 Fri, 20 Dec 2019 18:02:45 +0000 (GMT)
References: <20191216221158.29572-1-richard.henderson@linaro.org>
 <20191216221158.29572-18-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 17/28] target/cris: Remove MMU_MODE{0,1}_SUFFIX
In-reply-to: <20191216221158.29572-18-richard.henderson@linaro.org>
Date: Fri, 20 Dec 2019 18:02:45 +0000
Message-ID: <871rsydge2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> The functions generated by these macros are unused.
>
> Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/cris/cpu.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/target/cris/cpu.h b/target/cris/cpu.h
> index aba0a66474..bc43bc23a1 100644
> --- a/target/cris/cpu.h
> +++ b/target/cris/cpu.h
> @@ -252,8 +252,6 @@ enum {
>  #define cpu_signal_handler cpu_cris_signal_handler
>=20=20
>  /* MMU modes definitions */
> -#define MMU_MODE0_SUFFIX _kernel
> -#define MMU_MODE1_SUFFIX _user
>  #define MMU_USER_IDX 1
>  static inline int cpu_mmu_index (CPUCRISState *env, bool ifetch)
>  {


--=20
Alex Benn=C3=A9e

