Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5E5C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:04:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2FF92080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 05:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="WMF3EC5o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FF92080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBB5a-0004tQ-Ua
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 01:04:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iBAwN-0006sR-Am
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iBAsD-0000ex-TK
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 00:50:26 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:42068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iBAsC-0000dR-TR; Fri, 20 Sep 2019 00:50:24 -0400
Received: by mail-qt1-x844.google.com with SMTP id w14so2780099qto.9;
 Thu, 19 Sep 2019 21:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=6/hI1t9pBCVpJTnR1y3IoHPCRw7/S+KvSWuUbiyLS6A=;
 b=WMF3EC5oo1SMOntJMxy7yVDrQiJBYxb6PRHUAVwod5x13uDugtT9Ei7YxbAiqZIFFm
 YpwPfjz4DMGEg/GjnAjSHwWB7X8tqvtG/Yoo6/i2xoJ54VdmM98l79CtuZwe2pisFs/x
 s2lIr1kzcoBTAbRHmTZ9QeugVIZvZj/XGtfAs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=6/hI1t9pBCVpJTnR1y3IoHPCRw7/S+KvSWuUbiyLS6A=;
 b=IiBZTQNz7AtA+hYg/bhAFJ/vZ7Bb3aT1KPP2tV7VSzBb1ucLwN2RyDwwiigu6sa5uq
 ACybEsXGj/KK+MJtjMzqmoPetj9jEIi3W/5mL7aDTkkFiD21IqwU6+iO08OXx1/fcTE0
 zQtfyxLGiae8gFONXffCA6/gcD4hZfX3d7N8U9QEHF7StQZr9YRtaB8xx92B3zVPXeWd
 h65VC+9SCT2US8iPxeyf+9lB13WFGS2kxibk+gGKIy6dqJqponnL0BGdRKkoiKnljqTv
 Y8t5b5JvWJd+8t65far3XsrcdFE+5z2mRv8rrV0f+Z6mfTDly0gjTiUN5C1A4XAQQTo3
 i2FA==
X-Gm-Message-State: APjAAAV1aGoQmQCgz+E17/kjb2LrDVFpM6PLEoFXLuxtuupfHYL2+hwL
 TU22Q3RFCyzWrJUZUAPh2IO4bo7Fz/7PcB/kHyM=
X-Google-Smtp-Source: APXvYqwZZ8+xmTI78z8QLpn1i61DOmVekd0lOpac7bsO0LUcaeN3ufL1gPpO2SyAIeK5KhP4rQJftwBk8NkhEfVIzv4=
X-Received: by 2002:ad4:42c8:: with SMTP id f8mr11236135qvr.94.1568955024075; 
 Thu, 19 Sep 2019 21:50:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190919055002.6729-1-clg@kaod.org>
 <20190919055002.6729-21-clg@kaod.org>
In-Reply-To: <20190919055002.6729-21-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 20 Sep 2019 04:50:12 +0000
Message-ID: <CACPK8XcPX5zRuJYDWquTrbwW8ZrYsqAeOo1bza1HbWcdDA00Zw@mail.gmail.com>
Subject: Re: [PATCH 20/21] aspeed: add support for the Aspeed MII controller
 of the AST2600
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 19 Sep 2019 at 05:52, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>
> The AST2600 SoC has an extra controller to set the PHY registers.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Joel Stanley <joel@jms.id.au>

