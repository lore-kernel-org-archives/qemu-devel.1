Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4246C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D1AF206B6
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 09:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nkYEXSgz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D1AF206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZWDS-0001Jk-Ij
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 05:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59970)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZWCR-0008Hg-ER
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:00:11 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40292)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jZWCQ-000887-BQ
 for qemu-devel@nongnu.org; Fri, 15 May 2020 05:00:11 -0400
Received: by mail-wr1-x444.google.com with SMTP id e16so2582920wra.7
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 02:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=ODafr75E3Um8Jo0xIkAoea3FgPNJAjDKQEOH9D+QlKk=;
 b=nkYEXSgz3BwRAUFCA/poQMGs3WQBQ07p4Ci+HPbbyMqfT8mUWNmLKrbZE8Sl40zcx5
 TNDND3bJG5MUVp4BmmjvsoCP6LtzxRzMc+E9NiHndVDeiqoG3scAd9uCTiOCUUdwv893
 +Ujze6mfGt/3zsrO7yf7bWOKnT9x9OOnkpUKTveaduyY7nBXyva/nD3Z/S9VPhYoHM+7
 J9zKOsbW0lMRYYdVEv2yhxHg8rboK05BGnZJANK4ofCkUhi38uFVZT1yzJ75ASJH3rdf
 hLPXxPg5kE1qyO+3kpeztBYasgd4RDu6P+6l0ArTtyOmRRSiI1saihvKBYVL85c8pw8B
 DHNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=ODafr75E3Um8Jo0xIkAoea3FgPNJAjDKQEOH9D+QlKk=;
 b=Av+29FEH7kaeUv1GE3UgCFX6uGEpEMTWzSDlyCWhIzo0+HnUveWkT1Kc3K5TyKGJ+x
 t3vdno20FT/XsiUs6PQKYAD0j7p4+RXPTqNOM5GN33c/AUThsol6oCmFQldpJLT27iLy
 /VkDL2TsUb0aB6/qgT0qCg5My18XkRl5lCAtLpQ5Rn1dfv30wRIMVw9P1FTXV7mNZZkX
 6bJU0tveXtzZoZ+uVKd7CKy9ahhuf8gcxyNaFGVnt4jB9NXk/XOSCiYbDGm207I7i++u
 +SHnNSGTJnV1U3sK0qi8qEOurSr0EvGALufjbltOGBRJWNRz5oF8IP1bbRdF+43tK/9P
 e/dA==
X-Gm-Message-State: AOAM530MZ+E3VAxAxXP94L67vBiCfUlgb77Wr6Zvd7glbuwflyXO8P9J
 jDfkcAhi6JVUYEovUhi9dsGVpA==
X-Google-Smtp-Source: ABdhPJwu3m4SN+7vz+8nvZi2LmpWMMXEWu3knBCSX4kkKAaIXgBi0o4a4vSk/nhXdMeYkebnr2Mqpw==
X-Received: by 2002:a05:6000:1241:: with SMTP id
 j1mr3126872wrx.42.1589533208730; 
 Fri, 15 May 2020 02:00:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n9sm2600291wrv.43.2020.05.15.02.00.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2020 02:00:07 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9E4EC1FF7E;
 Fri, 15 May 2020 10:00:06 +0100 (BST)
References: <20200507151819.28444-1-peter.maydell@linaro.org>
 <20200507151819.28444-2-peter.maydell@linaro.org>
User-agent: mu4e 1.4.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/5] docs/system: Add 'Arm' to the Integrator/CP
 document title
In-reply-to: <20200507151819.28444-2-peter.maydell@linaro.org>
Date: Fri, 15 May 2020 10:00:06 +0100
Message-ID: <87pnb5d149.fsf@linaro.org>
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
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> Add 'Arm' to the Integrator/CP document title, for consistency with
> the titling of the other documentation of Arm devboard models
> (versatile, realview).
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  docs/system/arm/integratorcp.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/docs/system/arm/integratorcp.rst b/docs/system/arm/integrato=
rcp.rst
> index e6f050f602b..594438008e4 100644
> --- a/docs/system/arm/integratorcp.rst
> +++ b/docs/system/arm/integratorcp.rst
> @@ -1,5 +1,5 @@
> -Integrator/CP (``integratorcp``)
> -=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D
> +Arm Integrator/CP (``integratorcp``)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20=20
>  The Arm Integrator/CP board is emulated with the following devices:


--=20
Alex Benn=C3=A9e

