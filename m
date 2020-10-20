Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2028C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2408021534
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 14:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xLPxO+eI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2408021534
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUsm4-000295-46
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 10:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUshZ-0005BH-Fk
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:33:25 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:43133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUshU-0000nN-3h
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 10:33:25 -0400
Received: by mail-ed1-x541.google.com with SMTP id dn5so2070680edb.10
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 07:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fZ2F8raE+nkd5CcBTlfLFBayCR2ABggzo7wSTuWas5E=;
 b=xLPxO+eIHc8AN9bd0ouILNPJ+nbTKkm6ae0752F4RM1rr9+qLUedVL33rFYEPf9UqR
 /wkHmLSaP+6xr0PNUYS0PjtsOp2H6g9ITkIubk5BD8+gAbOevsAYbGMz062jBYqWFl+Z
 4J+9TkkNWi0dQMCm42Xaeb/lMmio1hwBpFjPSKOlH2Fn7KfglyURkVPaaV49FfjftJAe
 Zs/cqmsolD9NtPZf8WAw4HOzblWNRuVvKvBNPMFVtf+DLSHHwHihM/VRF+SNLkQ38u7c
 gW50D5CkJr9zc+k63M10ODtRolQxi0FBtjmPp4De7e5CqWOy6bIEstnIJUo/oe1EiUSg
 4keQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fZ2F8raE+nkd5CcBTlfLFBayCR2ABggzo7wSTuWas5E=;
 b=alz+6WGrPFGRTG+VjK/2revarOmSWBmu6eckWvyl9vYA/7x4nGtphWO1x2fXDPuuvy
 NOrTgc6xN4KbTYZVH2kMBuk8YR9PgMiXnkEn9jQk7E9krE36MGRRh1TGwf0kibkV5MZD
 NK9gCKqsUKJKlozMyYyf1dN6AFzPtlounnHfYgcelV4ULPHLDVMwqSW2jIlkVqI4btu8
 Ohk7Zd9Tz2sG6yCYRcamPHqF4wgZZv3DqdJiFaavMtg3vnQF3NGR2mGxdS9BbxwY7iuT
 GUmfImoJboZQG/w6SyknNyC6SdcPFLMwLjvlKzhKNVAMDQwVudYmGkg5oS0HA9SuhG8O
 gQwg==
X-Gm-Message-State: AOAM532uam2CWgSwenip7hoWqzuSQhb6tLdchqtScCo0NhSOAyvhPKVi
 zHx8cXbWA81kNXPC/KM/ZbaUVSR5ABn6//nIrtFfqQ==
X-Google-Smtp-Source: ABdhPJyeJd2T/yP1gGXqsYtfxMqpp1XZaqTpowUbdGOzGpViSIMF1n5z7JNvEMaQI/rHY2sWFyCWyCppl95BwP2kVq4=
X-Received: by 2002:aa7:c302:: with SMTP id l2mr3125193edq.204.1603204398469; 
 Tue, 20 Oct 2020 07:33:18 -0700 (PDT)
MIME-Version: 1.0
References: <20201017180731.1165871-1-f4bug@amsat.org>
In-Reply-To: <20201017180731.1165871-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Oct 2020 15:33:06 +0100
Message-ID: <CAFEAcA_qoM2=L+CaaZq1kMJ=NCaZZK7J0ieTEq151DFTks7ttQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/intc/bcm283x: Trivial tracing cleanup
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, Luc Michel <luc@lmichel.fr>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 17 Oct 2020 at 19:07, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Add trace event for IRQ from CPU/GPU,
> use definitions for IRQ numbers.
>
> Philippe Mathieu-Daud=C3=A9 (2):
>   hw/intc/bcm2835_ic: Trace GPU/CPU IRQ handlers
>   hw/intc/bcm2836_control: Use IRQ definitions instead of magic numbers



Applied to target-arm.next, thanks.

-- PMM

