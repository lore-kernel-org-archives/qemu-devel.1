Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3B9C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 18:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B98C02072C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 18:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qzmlhPdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B98C02072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbTkU-0004c0-UR
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 14:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbTgi-00074S-5O
 for qemu-devel@nongnu.org; Wed, 20 May 2020 14:43:32 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630]:35490)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jbTgh-0001Oq-0F
 for qemu-devel@nongnu.org; Wed, 20 May 2020 14:43:31 -0400
Received: by mail-ej1-x630.google.com with SMTP id s21so5379927ejd.2
 for <qemu-devel@nongnu.org>; Wed, 20 May 2020 11:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=/U0LVRAYEjeTHgPTT6NPWSUKoY5QKwDDSE33F8XyCgQ=;
 b=qzmlhPdHGuS/Gg3/XXlMFti8y/Yx9R+X35mdEXCjMQPiPsd2EwS05wXHunudF+HG8I
 lQxEXdQRn0OD6AW3dU1q0jwgxDlVVDIlP6n3oTIFELxgzzMMK0+9uPpSzgSzhjYnu2yf
 O/Mk+lnqVOd/0UAD2PqJMeleI3IuKrWN01kudSRxtmncXa+ej60YAzu8ekzkYeyGU9rt
 CE0YtiPgLoMuQckz733plCsEMJqOsQWG1b0ZjljyPgXsOF0zcGZJC/cX8EnLc3vLeb3g
 GDiF+13dwcVP7KqTx7iTBgRATuMaJhqI8LX/BZDl1X5V45FYpVs3+bCxJ0BoraxlTg0V
 SjKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=/U0LVRAYEjeTHgPTT6NPWSUKoY5QKwDDSE33F8XyCgQ=;
 b=GtCFZlVzuwsuLmO+5BBy5TdwlumCHs/tZjglHvW6yt4yqnh1Fd7o+stvpJIndwkJe6
 QwMLAjfazKuL5V3TYvjmeQkd1gUfIyNwJwur2aT4WKRqc8cAlWh1/BVKIMiOBDmSKKx5
 Yxlikc3wP0ngI4PIyU9b/afrc3OE4lQiykZmvP4CRoeQcNzX9ddQgXid5ATnGznE8WxF
 G5xK4liA1YNqbLwlD66pViMxerYjx7v+XUGkEOLBUTaKnnQIz7ipgUAlxrY2N+UPeVyP
 RgcL6EbSVs8O8jYoqKRM9+6YUVdaT95gbw6PvrgFgoY1j8ajNbg/KKTi1d5BjHS5d6PP
 Ew9g==
X-Gm-Message-State: AOAM532lYj0q7A86jhkmHlYQt8uXOFHBNMDDoma6psmM4yij4Ug/xLpd
 7Up3ux3bw1J44C2C6/uQlOadQg==
X-Google-Smtp-Source: ABdhPJw+lR/B01nHBtNfmfw/pAECrq3higRF7v7ZiRDNRD07ICYsA+qmEtvC+Ejs5v8ArJsfcl+EFw==
X-Received: by 2002:a17:906:3a11:: with SMTP id
 z17mr419925eje.460.1590000206730; 
 Wed, 20 May 2020 11:43:26 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a13sm2422097eds.6.2020.05.20.11.43.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2020 11:43:25 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B09751FF7E;
 Wed, 20 May 2020 19:43:24 +0100 (BST)
References: <20200519025355.4420-1-richard.henderson@linaro.org>
 <20200519025355.4420-17-richard.henderson@linaro.org>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [RISU v2 16/17] aarch64: Reorg sve reginfo to save space
In-reply-to: <20200519025355.4420-17-richard.henderson@linaro.org>
Date: Wed, 20 May 2020 19:43:24 +0100
Message-ID: <87mu62fnw3.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Mirror the signal frame by storing all of the registers
> as a lump.  Use the signal macros to pull out the values.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I haven't been able to get my model to boot yet to test but I'm pretty
happy with the reported change in trace size.

--=20
Alex Benn=C3=A9e

