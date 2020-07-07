Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAA2C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 11:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9891A20702
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 11:32:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Jvbxd7Ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9891A20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jslpW-0000sk-PY
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 07:32:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jslod-0008QR-5m
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 07:31:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jslob-0006bA-7c
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 07:31:10 -0400
Received: by mail-wr1-x444.google.com with SMTP id j4so42348360wrp.10
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2020 04:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=zrBr7BIv8VPH7Obo1cm5vtYbYjigCd4X9fJbH0UvJmA=;
 b=Jvbxd7Ma0lVoVavlmOEdfciuwmikPK1qR4a5mg6FsGwOj2B72rj6jKlKjuuiK/+hxP
 cNhCZxB4DjUKO3EVD1eXjDB430d6Y/obqMTjjMCPf8+sAD8QAYdnGrrnPgiemCwEv29D
 fEPrN23a5yAbQffXAxvkkTlaOpsxC8wAZz7ZIU2m26WppMb0mxOsJDjEME6CkQCI5p+z
 qsCYbP7z4MN8Q32B1eoEfTSnwVJaPrvtq1ECz9G4l7F6HNkLbGVG9Q04aZSK8EJ2tWoD
 QuJUvhgzOYn/9wwkaLTpqorIEpX2NFHIpXxHnTFbiRgpb433Y7tKFk6qGkH00X2G8ChB
 zBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=zrBr7BIv8VPH7Obo1cm5vtYbYjigCd4X9fJbH0UvJmA=;
 b=E1FuD7PzIsAMWUbUoW1WppfbY2X0l1wwPnVy3tig5/CdqTYU/sK35qw0xhaC0Dplfx
 93D17PWUQ6JR8EdLAA9Gr/p3D1DqplV8gXr5MTM2nPBz+JbBf4a++IjiN0j4JpG9kQFF
 /pFQpdeu7u+tqg/4adIMFtouzfIpacDPKON9hu4LnbFJG8Xm06WZoH1rJrPbeU4TZZd1
 L9kRZ5tgmBasQPGnc2ByTopdL2biHvNaIGAMhyvM8GAsMlVxZh0IgpCKUSFHPKBSgXOF
 G3XY26654V22pKBB8gqbRSlsOSzphEfFAarmmzCXccCM+qyPk25A11I0wgYl6jbCiz6U
 pa/A==
X-Gm-Message-State: AOAM532q4Aj+CKny2wGaoo4BxDLLkDj8ifQITs0ewksehgP3r9Gm4qA4
 1Za7w97oHDf3ITQIYbNxEyqeTQ==
X-Google-Smtp-Source: ABdhPJxHkFc2V5EWKD6kBy9+gfvka5zWk2o+Sj0blSQLRPGSDgybVBE+RlV3+UOaGnF/+b2elhAmDw==
X-Received: by 2002:adf:d842:: with SMTP id k2mr55090040wrl.239.1594121467482; 
 Tue, 07 Jul 2020 04:31:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k126sm778383wmf.3.2020.07.07.04.31.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2020 04:31:05 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2E8C11FF7E;
 Tue,  7 Jul 2020 12:31:05 +0100 (BST)
References: <20200706234737.32378-1-jcmvbkbc@gmail.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 00/21] target/xtensa: implement double precision FPU
In-reply-to: <20200706234737.32378-1-jcmvbkbc@gmail.com>
Date: Tue, 07 Jul 2020 12:31:05 +0100
Message-ID: <87pn97o93a.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Max Filippov <jcmvbkbc@gmail.com> writes:

> Hello,
>
> this series implements double precision floating point unit option for
> target/xtensa, updates FPU tests and adds two new CPU cores, one with
> FPU2000 option and one with DFPU option.
>
> Max Filippov (21):
>   softfloat: make NO_SIGNALING_NANS runtime property
>   softfloat: pass float_status pointer to pickNaN
>   softfloat: add xtensa specialization for pickNaNMulAdd

I've only looked at the softfloat bits as I'm not familiar with xtensa
at all. However you can have a vague:

Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

for the series - congratulations you pass your own tests ;-)

--=20
Alex Benn=C3=A9e

