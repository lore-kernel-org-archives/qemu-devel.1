Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7C5C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:08:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2A1820748
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 12:08:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eIF8aYoD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2A1820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtrpS-0004Kc-1O
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 08:08:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtroI-0003BZ-G4
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:07:22 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:40657)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jtroG-0000hT-HX
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 08:07:22 -0400
Received: by mail-wm1-x32d.google.com with SMTP id f139so5670678wmf.5
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 05:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/vmzPUVe7zubGfFwwM3N45gsH+S+fJ9JECe2KqAuA7E=;
 b=eIF8aYoDlgyZE2K/+z5iUwFKTDJ1DuiFqyqROoKMTAJHeoPICdBui0aREJuDYd0M7v
 Pshw3U+09JC6E1XU3dXpW2wKJMDdIuj9iSSOeYDu79KKCSuR8o/PS6RtxEn/UGXZ/WYL
 TrEP4ZVo1qQFRpwiqmHmp2ofj0DWCkzJIJ/NLuCEBMyjaMX98V36pA9K/qRbBka+CYZB
 uXP2PpXABmGY7/KzwBlnnfRXP2wRs1fLl2Gk6UeeQ1ApXfv4+y2yzg+gEPZbddAy+9tI
 DFx2DxQeJPwkXLnBiMLSuA7UlFLO43pScD8Jn7/GM5/o5clpcB8OqulsCV/tefGOvJO9
 IEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/vmzPUVe7zubGfFwwM3N45gsH+S+fJ9JECe2KqAuA7E=;
 b=Cc+8Cx4Kp5PhGz8vdFbmZqO13bXbS0HT3S2dmTKNkqSCo03iII0KJ835zPPxx4E+2b
 bLVqusLidFZyjE6D9dQUoHmiBkGszwHHrW1gq/jahisY9PXX9L/ZiUlzZ6AKjwQV/boK
 SHTt407afkWztIg7b09kL1AbviVRG4LBIxIgAyxU8Om1c5PKooH5tCIxTGga3ieH4cN2
 gAq7NJFd2/OXa/cXtduSq+ZGUMkCBTyo/+DDpQcOzEAHAJ/T/EfjDPnXd2PXYobST+sm
 yYPxsu7CzoSL48MXW3QSTXLRWAD+BwguKAcARylAzpybPN7DSD0z+ug17Y2DATqD60o1
 948Q==
X-Gm-Message-State: AOAM533SBVa5oSedS3Kb6KlnihyLNOkVIX2oZP6v5VBuU6+nW8TKDf7Q
 cQqGSJyhkDkKLRtsUk5EvAZR1g==
X-Google-Smtp-Source: ABdhPJwuK2KrRxTRnHFChBdXb1f06tyNcvoZvIjrFaQXgIT6GamMExVRhPlBBMNFSPRCinzCtdo72g==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr5236009wmc.106.1594382838803; 
 Fri, 10 Jul 2020 05:07:18 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id r10sm9904879wrm.17.2020.07.10.05.07.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2020 05:07:15 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2772C1FF7E;
 Fri, 10 Jul 2020 13:07:15 +0100 (BST)
References: <20200710104920.13550-1-frank.chang@sifive.com>
 <20200710104920.13550-61-frank.chang@sifive.com>
User-agent: mu4e 1.5.4; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: frank.chang@sifive.com
Subject: Re: [RFC 60/65] softfloat: add fp16 and uint8/int8 interconvert
 functions
In-reply-to: <20200710104920.13550-61-frank.chang@sifive.com>
Date: Fri, 10 Jul 2020 13:07:14 +0100
Message-ID: <87k0zblgjx.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


frank.chang@sifive.com writes:

> From: Frank Chang <frank.chang@sifive.com>
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Did I miss the rest of the series somewhere?

Otherwise this looks fine to me:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e

