Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8ACC31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:53:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A961E20861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 11:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UnxhsZ34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A961E20861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46328 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqCo-0002ey-O5
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 07:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55425)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcpzK-0004E4-UO
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:39:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcpz8-0003qD-0V
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:39:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37222)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcpz1-0003dD-Mc
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 07:39:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id v14so9580606wrr.4
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 04:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=xcsJmXN1iPpoITL+2C21MW4SUIPjkTlVB0s7wSPyq3o=;
 b=UnxhsZ34a6q86ltpDQDa+2ogvYXPKF+bxpdrvt2CViYmYI97cmnHtDywT9WpZ8tzwG
 G/KFbj2EdgESCzDpt2bN0DIiE56Ft8aqiREoCQOw3KMamR1sjOiX7D0MC0EL8hYpt0+U
 GpFsk+drFOGoxx7NS5lYNNSyNK5t6s9Rg1efmg+xGOTQr0JwNik7sdBbkWpKWj3WSckY
 xhHcEkgpGHa7owalHUahMkaOLgsyO1dGAIEj//acYOcHE0hVzZx9RERmNu/WIKzYnDYE
 RvveNIp+wQ7doOcO8fRdl8iC4VU5D2zRaI3MfbDV2Q2MIfrXJtYOD+IBqw2fIHv8kC58
 aWMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=xcsJmXN1iPpoITL+2C21MW4SUIPjkTlVB0s7wSPyq3o=;
 b=UkMy7omItNA7/7R+pFz5Mp14gDf4PpnMxy/chiiuKT2SeAEHIwnvS8fAj2RLhMHm7H
 wReGP3jPplir7FZZxRAIu0k+4OWy3RSjXNNyCTgyllsJ8fBvklaP3VAitGX967AKmLRv
 pTJM6DNDX25Xl2y2mRnqprjrMt2N4BjaY41Dar/mnZaGpFvewrGYsz4HGimtWobZ93vC
 NixPBfFKom4o/iTPezaHw+1PvhZeZPsDw3NjpVOYvttWyrgdSW3nup2BQWiOuPPNr4TO
 Mg6Ib5McXjLE2DllB8grxWDMt278aSE5RFtKISRkkih4diD9fRG6FdcAsZU2yXfFkkU+
 nzag==
X-Gm-Message-State: APjAAAVk1fQg85b/wUfh5USmtnpyjKTYtZkpPtEe/3d4nQz3EWEwg/y1
 7ISLkcj/xRDOe29BWK8i0w2pxA==
X-Google-Smtp-Source: APXvYqxg7FMvnD9tYdRWBXY2ABMWXoIEMwi9ymMtnELkzUhSo4J3iaHQt74HouAl5B6lU3vktVERkw==
X-Received: by 2002:adf:f60b:: with SMTP id t11mr20386209wrp.332.1560771560005; 
 Mon, 17 Jun 2019 04:39:20 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id u25sm9343422wmc.3.2019.06.17.04.39.19
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 04:39:19 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1FB781FF87;
 Mon, 17 Jun 2019 12:39:19 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-6-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190615154352.26824-6-philmd@redhat.com>
Date: Mon, 17 Jun 2019 12:39:19 +0100
Message-ID: <875zp4bfvc.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 05/23] target/arm: Add
 copyright boilerplate
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Robert Bradford <robert.bradford@intel.com>,
 Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: Robert Bradford <robert.bradford@intel.com>
> Reviewed-by: Samuel Ortiz <sameo@linux.intel.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index df4276f5f6..d3f3cb57d5 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -1,3 +1,10 @@
> +/*
> + * ARM generic helpers.
> + *
> + * This code is licensed under the GNU GPL v2 or later.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "target/arm/idau.h"


--
Alex Benn=C3=A9e

