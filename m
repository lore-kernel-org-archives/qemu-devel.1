Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488B9C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:30:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1272F2065F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXQ6hkhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1272F2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jskrn-0003sb-BU
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:30:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jskqq-00030g-Bz
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:29:24 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38418)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jskqo-0004Xv-SY
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:29:24 -0400
Received: by mail-wm1-x343.google.com with SMTP id f18so45952217wml.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 03:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=UVzE7qqSSvSmEVYY/r7PWWRBODddPIVT/Jszww3wnXw=;
 b=AXQ6hkhJNurYnDXf+dNNt0tp98oEtajigEFcOsBM6YqNCYRPkFMmLihD/CLcX8fLpd
 eX3eLpyg9yL18eeIwxa1HmT200IR54/Cg+MfZmrht2z+g+7y3J7Xs0b+K0P3gk9wI/cx
 kRlG1SrNODQPzDF9cA1JX4jfSk3qFfKG5BAJeY3rr5nkdq5w6CZLGdBPJFDTtSfKrjb4
 bkUnmcPpHPiDs/rauhuIugixooK7vncoADgcV7nwSMPvOud7Zl5GIyXaiOGYSFeurGkN
 1sGEj+Kb/8OJvEEXU81+/m3dgpVPyyq45MXG78eMavG1n94Lathhjeo3VsRlb3uHCv5l
 xPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=UVzE7qqSSvSmEVYY/r7PWWRBODddPIVT/Jszww3wnXw=;
 b=q4g7nGSPPy1i8Ndd9ovj14tFwXZMqAwadXPl/htmcBsXxkbV6r2nrOvmEnQV699f1w
 xe0aXlagen6b0bTQK8Qu7M3YTQoCIPOITQfF0tRjRdLa/VBXyqrCV4z+5nZdJXLqkP6E
 GFDOY9KHKp3k/HBpEsrLQCovdjCoxiW7UbJQ+pMirUAlVlITpVVgRcrvxf1caifj4Kui
 GIuCobR7/+bcS3AuoV3nf3FheCKcET5W+NUdARxX5zIyH1ytXDRw3oX8TMXFjTYTvC/s
 0oJirzFpoyQb6rc5wPJWo7LYxfu6KISoYXzW9DvACTymG55lQrKMFJ2FetXn8CJM7/Y/
 5/GA==
X-Gm-Message-State: AOAM530Fu5tmKmow4juIDl5H4oeyvyqwTvFPFY4La/em5U+izZMht1Qo
 EhEPNXOpYXMhz6AAV+3X66B9Hg==
X-Google-Smtp-Source: ABdhPJxNaBLgoqYUHQhfHrMnUYxHAUZAKQz/WR38akuPeSFCoMVsEifxpOJO40wb1y5ahl9Gu2Yg6A==
X-Received: by 2002:a1c:b007:: with SMTP id z7mr3338973wme.37.1594117761051;
 Tue, 07 Jul 2020 03:29:21 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w2sm371326wrs.77.2020.07.07.03.29.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 03:29:20 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 7B9F11FF7E;
 Tue,  7 Jul 2020 11:29:19 +0100 (BST)
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <20200706234737.32378-3-jcmvbkbc@gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 02/21] softfloat: pass float_status pointer to pickNaN
In-reply-to: <20200706234737.32378-3-jcmvbkbc@gmail.com>
Date: Tue, 07 Jul 2020 11:29:19 +0100
Message-ID: <87y2nvoby8.fsf@linaro.org>
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
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Max Filippov <jcmvbkbc@gmail.com> writes:

> Pass float_status structure pointer to the pickNaN so that
> machine-specific settings are available to NaN selection code.
> Add use_first_nan property to float_status and use it in Xtensa-specific
> pickNaN.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

