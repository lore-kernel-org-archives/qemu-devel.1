Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE35C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B46B0206E2
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 19:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XRVMsFOF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B46B0206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgCWi-0008Pb-SO
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 15:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgCVm-0007JL-3u
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:23:46 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36683)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgCVl-00049L-4c
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 15:23:45 -0400
Received: by mail-wm1-x341.google.com with SMTP id d128so4303056wmc.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 12:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=PM6PwGweRQbxLvtKx2SLTfWSUzctBbSIUlp8uKuLPfM=;
 b=XRVMsFOFFPYlevByHeXOuhnwkEhHxCUkELesiW1pb2Uei2TkEAvX/i7H1g3ymlp3/7
 bkZbdF2PRn+Kl3RX7sFa4yOzoRCIWRNgPy4A1gYzoo2cbB2sHL94t8dJxfKha8agU6GK
 oEu5ihPcDB24vMu41kXeVwFRc10R6zf8vnYB0rCXYGNnXTft+oLR4YivmFzqxVnoKc47
 CQ5USL7Mdnf+1/ieoj+kCgdW53FeU1zxMvmmkbE7TXujCjOM0hxQ5zQvQ7fo+XayIvE/
 ALhqtC5aqMLG/D/zsBGKX/7GSTJV+c9JEnH2Jgf8MQ7DUWfftByRElNhwFVwDdRaDqom
 +rsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=PM6PwGweRQbxLvtKx2SLTfWSUzctBbSIUlp8uKuLPfM=;
 b=Gz2qCesHDfFKNudkAQ8+s8s6Pa09NqXTm3anXS+LMYpxmZfUlzXYRepG+u1hv+kpNO
 ADPe2B9ytakWIjgzFS9iomd2vVGCY6TGLa5RBb3Gz/ubqO88JXfeyB45n/EjI0KanXNi
 TC0vfphpd0gQpT1FNeNJTlpYS98oc8OJ9/sqYT2hsF8+qFCtq2HBWrcxXIbzCVtG68rB
 kgb3RM8kqQyfcG5vesaDEUesUUzp/3elMQWhMLLtf9y948h+VeKMAzmqFk5bG6ZU8lkq
 b1RZIkWSfT8EgKC1dh1YbIDtnU4OM31q2lWS46rIHDpIcsVAiTSraFeTZJsvvFMuMQMB
 av8A==
X-Gm-Message-State: AOAM531mHKSsGfeAom+xZ5k2AWNRYEhlaTuWDzC4vGjxTFKRhokns4g5
 RL05SeUysLYiNHj4EnzmyAabiw==
X-Google-Smtp-Source: ABdhPJw0MyJf1YlOkWi9YAglE8CKTX2JeZGaADUvJo+EGaXxFINVvAXivdG+SsexJn+Fwms7XXPpGA==
X-Received: by 2002:a7b:c358:: with SMTP id l24mr5785458wmj.13.1591125823716; 
 Tue, 02 Jun 2020 12:23:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a3sm5154830wrp.91.2020.06.02.12.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2020 12:23:42 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8FF9A1FF7E;
 Tue,  2 Jun 2020 20:23:41 +0100 (BST)
References: <20200529132341.755-1-robert.foley@linaro.org>
 <20200529132341.755-3-robert.foley@linaro.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v1 03/12] thread: add qemu_spin_destroy
In-reply-to: <20200529132341.755-3-robert.foley@linaro.org>
Date: Tue, 02 Jun 2020 20:23:41 +0100
Message-ID: <87blm16zlu.fsf@linaro.org>
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
Cc: peter.puhov@linaro.org, cota@braap.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> From: "Emilio G. Cota" <cota@braap.org>
>
> It will be used for TSAN annotations.
>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> Signed-off-by: Robert Foley <robert.foley@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/qemu/thread.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/include/qemu/thread.h b/include/qemu/thread.h
> index d22848138e..e50a073889 100644
> --- a/include/qemu/thread.h
> +++ b/include/qemu/thread.h
> @@ -215,6 +215,9 @@ static inline void qemu_spin_init(QemuSpin *spin)
>      __sync_lock_release(&spin->value);
>  }
>=20=20
> +static inline void qemu_spin_destroy(QemuSpin *spin)
> +{ }
> +
>  static inline void qemu_spin_lock(QemuSpin *spin)
>  {
>      while (unlikely(__sync_lock_test_and_set(&spin->value, true))) {


--=20
Alex Benn=C3=A9e

