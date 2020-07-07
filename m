Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CABDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:32:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64840206B6
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 10:32:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dqarDZ/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64840206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsktM-00058x-NJ
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 06:32:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jskrF-0003Te-OC
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:29:49 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jskrE-0004b1-2j
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 06:29:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id f18so36523291wrs.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 03:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=g+ApyGLNtK1e/9QH9GgEnX74G46D+owQbgq3FZCgWZo=;
 b=dqarDZ/I1vGovwcWcK6GURcWUOFg7PaaimSeAbwam2mhVTWCWsMFPGMiSb1gXpiSLT
 WGjMsteDRthFJ/57b8m8VuLc8Kp0rgDdQBmOvHxA+wZkpUHfMvOCsWEr81H/ygxNIi6p
 x5WbIjyZ+Ibe5g4l3fqcrd2Ieh8GERLmJ4/ly9SDGMzJ6dQwfqkkX6L4Nf/Qp8nXWzHa
 /3IN7XqQh98UHXnNsjHipi/c64nxEwTQocO9ucJKloEoCW/i3xFX8ZRoT3loY3bmvap2
 QXbazky/oK1g34fDPMS+jvUHrgKy6b2FhRPhak1ipFUiD5a8WgHBBKedNN8oRE/fZFqf
 StuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=g+ApyGLNtK1e/9QH9GgEnX74G46D+owQbgq3FZCgWZo=;
 b=nJ5rJYiHcLVk6XtNk3InM/rPj27AAZPrOLOaNAeQ9sqirG8OZGttl4d7GAHFeY+kBF
 bLuIar8fuNEk+vQghkgPI+qd+5Or/cuUMqXLJzc0P7oOW4c/yQ0htcmVwaZsy2PTgMcn
 4hHTb1Bg+sStU8tGd6iy9Fv2yv9p8wXQXjKMGAqKfSyVGMqbR505IKjeGi/K32NxARCp
 NjfxhHuLOCxr51PbaRDTd3Pu6d7lpQ1u/qAiv/JW5Gkv2d15M0cgCir69nfQhKMNCzC2
 jv8MHF+Ag5RjuDxwZam6sosnwxkkfEe9tVcR89kP9J/kmuCfenUneqlYZLjP4Tpi16OX
 DQfQ==
X-Gm-Message-State: AOAM532dQBz/dptk9ZHv5R/bNYNzVyjSLijrAfsYqaGilM2OcTstr86V
 D4Gm8b4A5W7bUanFK+6/qvfQEA==
X-Google-Smtp-Source: ABdhPJwKeDVQAT7Rbu9OfI4Vgza2Hxau793+BbMud3FXgVljZRd5Kj7SsEkt1MwC6sfCs+NgkglP8g==
X-Received: by 2002:adf:dd83:: with SMTP id x3mr57796664wrl.292.1594117786567; 
 Tue, 07 Jul 2020 03:29:46 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c11sm400879wmb.45.2020.07.07.03.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 03:29:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E57B91FF7E;
 Tue,  7 Jul 2020 11:29:44 +0100 (BST)
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
 <20200706234737.32378-4-jcmvbkbc@gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 03/21] softfloat: add xtensa specialization for
 pickNaNMulAdd
In-reply-to: <20200706234737.32378-4-jcmvbkbc@gmail.com>
Date: Tue, 07 Jul 2020 11:29:44 +0100
Message-ID: <87v9izobxj.fsf@linaro.org>
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

> pickNaNMulAdd logic on Xtensa is the same as pickNaN when applied to
> the expression (a * b) + c. So with two pickNaN variants there must be
> two pickNaNMulAdd variants.
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: "Alex Benn=C3=A9e" <alex.bennee@linaro.org>
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>

Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

