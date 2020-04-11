Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F395C2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 18:46:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D23620732
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 18:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hQLYP/H1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D23620732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNL9L-0005tE-HX
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 14:46:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36297)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jNL8O-0005Kv-NR
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:45:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1jNL8N-0003Ci-8A
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:45:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1jNL8N-0003CT-03
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 14:45:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id k11so5197897wrp.5
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2020 11:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=lQthDA9olWnF/xPodzgttQ/inOBFiCBLx+WmZhgU3pM=;
 b=hQLYP/H1FYcT28VqO16bndb0Lqbb495+fVDIGOldP+JRTIjlAFEtKCyQgsGzhSEo6h
 7pAv055N2DX4r8kNHdH55h4jx471YAzO/dzIWwNjI0swFHWCz8i4lqc9s8/v8PFvYTDe
 xapYEdA7HL1QjiHZ0HLQjFA50qteTVGeENuh6eu2NdO9RgZ4eFpTItxLBsLuw4Ud2dXj
 Da/ZZJs+DFW96EJGZslr5AtVKWvQrW/LwCK5Jkc6uMHZ5DKo88uTsM2quN/kbyvw89jd
 dDPk7EsBoR065hlFPyKUbEKPqPxRI1ZOY0bhwUafazy1Oy7+bJF6p947cKnv/kRmZmp+
 kFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=lQthDA9olWnF/xPodzgttQ/inOBFiCBLx+WmZhgU3pM=;
 b=me0mBY7YYEhfzn+dd9HpsHZpQcaZAq1qTlKh9t/rDWe49ZKk7XaYjQInjWmFxY3P4T
 pcL8VGBmDm8v6x5CZNYpAIju3jYYrNY2YCWC2USu2S2coZz/zOuRS4Df8Dqh2tv3oW/m
 gV11VPYn6IFTQzkjfrYGlSAVXda83X71yB0JdkqIiCOaptK5PiVaTgVWp1ad3OZvt9p4
 P5Vfbl79ssteqAMpxlsc+AKV3ZfHZf6JprmEB4Zp6Aw4MluMrO1LBtXhWLUMt/3V3Nli
 n1NKHGQRe1rSaN6IUb1u1PanmvbwDfwvWFkgEEpZKWI0Tm4ZhabaWv5aaJ5u4HO9ftEz
 RqAw==
X-Gm-Message-State: AGi0Pubr/rzBoCBPsNF53eSahJL95dS4Eq/iSQsSFEHfvQ45Tgl7tRKd
 PWG6C+7KjDlt+0C4GCg3ozCAMA==
X-Google-Smtp-Source: APiQypImMVysGb6MjCllwF2QpPpGpy8dtWw9G/PDYx6t1/bapLu3dMB7yQunxvtdsiK91myZl2ohZA==
X-Received: by 2002:a5d:6a47:: with SMTP id t7mr10831012wrw.29.1586630737574; 
 Sat, 11 Apr 2020 11:45:37 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id f141sm7751350wmf.3.2020.04.11.11.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2020 11:45:36 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5684A1FF7E;
 Sat, 11 Apr 2020 19:45:35 +0100 (BST)
References: <20200326230838.31112-1-richard.henderson@linaro.org>
 <20200326230838.31112-2-richard.henderson@linaro.org>
User-agent: mu4e 1.3.10; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 01/31] target/arm: Add ID_AA64ZFR0 fields and
 isar_feature_aa64_sve2
In-reply-to: <20200326230838.31112-2-richard.henderson@linaro.org>
Date: Sat, 11 Apr 2020 19:45:35 +0100
Message-ID: <87o8rx97zk.fsf@linaro.org>
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
Cc: rajav@quicinc.com, qemu-arm@nongnu.org, apazos@quicinc.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Will be used for SVE2 isa subset enablement.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

