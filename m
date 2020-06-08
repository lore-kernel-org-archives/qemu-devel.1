Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C05C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0FF1206C3
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 13:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXZzFchO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0FF1206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiIGt-0004vQ-5Z
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 09:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiIG3-00044s-Hn
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 09:56:11 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:39685)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiIG1-0000lq-DF
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 09:56:10 -0400
Received: by mail-wm1-x341.google.com with SMTP id k26so16643741wmi.4
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 06:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=p7vgMZP4zOiIY2EXziZ+vo8sNpds//7+4Wh0cABhF1I=;
 b=MXZzFchO+IBcJ4FpOIigLgAwBar9/EH8EZ/7BoSUbKm/z2sojqaa7JLyyL6QIl3hJa
 jmp1RBxGmMhWDYl9ViyKn7yGPWHwNnslUHC1ZhpNtp/owY+gCm8irYeLNi9JX4kt3r1e
 GgTyJ86W27NusZZDn/Ia3lGS3/cXcWp1KfD8f8itDUp45lRN9j/rcQY/z6L/x8Tq31h2
 FzgFqlfkuJRPbFnSvEB8ALPldlGeUAX8xY/FsRIvafdNP1BusJgdQ1z9ElW55/4fjDf2
 dg4i7fGnVNHhX5POnxJpSktF+s4gEB48DW3iN4OB4FJHVi84mCgV/dvVEW/Er8T25vyV
 LKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=p7vgMZP4zOiIY2EXziZ+vo8sNpds//7+4Wh0cABhF1I=;
 b=tjB/72BIFjWeyOp7jUrxGil+8/ANOfoVz+GQEoXIj05YkRpPFNcjE/dZexfg6Awa8P
 QG4YR8XDXZvdBy0dPDIh31+dfjRj/+YyNK+xaQXGoI9IOslCRPze7+HjWW/WupO+nvQS
 e1km+DI2r5JdrdBSeJkZ0ZNxnh8plbKPKR2Ok4k4VdbXlw7toG7kJu2UiSME/v1f3RZu
 xyGzCohT4M8tgFykDHp+JegTfszSC2dhyVtZ6NIE44UVkM/i066yY6Z970igV6CAM+pC
 IsJ4+A2NIvYu28yWmeH//OX9kJYq4ODoHoG2Z4PDwx8E7NdhDdeKd5JrB/yS7zVJw3Hb
 uU3w==
X-Gm-Message-State: AOAM532C3RRM9llXLKZmx2aHFqe3WRfQaGDlFfx+4ddUZCDF5f2NSni9
 6wNfc2/kQbVpt8ByOGYo4BrOyg==
X-Google-Smtp-Source: ABdhPJw0KPltmkpizbZd5tsIH0ZMDm5JtSlBqjCED0/ciWobCkvxzFjiDS2tZoreUN0f+UzpIhLYWw==
X-Received: by 2002:a1c:b443:: with SMTP id d64mr15934946wmf.157.1591624567945; 
 Mon, 08 Jun 2020 06:56:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 67sm5590817wrk.49.2020.06.08.06.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 06:56:06 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id F28891FF7E;
 Mon,  8 Jun 2020 14:56:05 +0100 (BST)
References: <20200605173422.1490-1-robert.foley@linaro.org>
 <20200605173422.1490-10-robert.foley@linaro.org>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v2 09/13] tests/docker: Added docker build support for
 TSan.
In-reply-to: <20200605173422.1490-10-robert.foley@linaro.org>
Date: Mon, 08 Jun 2020 14:56:05 +0100
Message-ID: <874krl7jbe.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x341.google.com
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
Cc: Fam Zheng <fam@euphon.net>, peter.puhov@linaro.org, cota@braap.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> Added a new docker for ubuntu 20.04.
> This docker has support for Thread Sanitizer
> including one patch we need in one of the header files.
> https://github.com/llvm/llvm-project/commit/a72dc86cd
>
> This command will build with tsan enabled:
> make docker-test-tsan-ubuntu2004=20
>
> Also added the TSAN suppresion file to disable certain
> cases of TSAN warnings.
>
> Cc: Fam Zheng <fam@euphon.net>
> Cc: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

