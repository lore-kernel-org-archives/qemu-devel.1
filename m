Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4043FC433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09C2B20758
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q1HBULXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09C2B20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juvM0-0003Yb-6V
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juvLC-0002bv-9a
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:05:42 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:45044)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juvLA-0004Dq-ML
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:05:41 -0400
Received: by mail-oi1-x242.google.com with SMTP id k6so10470419oij.11
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 03:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=eqW9Kj52y69ZnpMGvLNWRCX82+2t7WxidfGVLvjziz8=;
 b=q1HBULXJB8n69p5SBIZPP0W3Q1xRm1Wo5CdxKLf/e7G5faZTrpmsReixp5tOTZrek6
 wp+z4BPv6OlN3aZS/vX9GR5ccWHQj2VQBZ+rsF5zENxUfuDj6sI99o3xllW9+K9vctzG
 /6vy4gGS2eHKGQ7zolBEEYZ4JO2BuXLD0a7dIL/ajSWr14pbBws/iy/NCJPJaWwpzG9I
 cTb5Kl6zk77wiikl5z54XvEBcqiOXTWdyu+gkKpmu/McTC3653HUa0lQU3E5zRkAA/Rp
 VYQCT/7LAAF235UYiJ7ropcSF70yn0UktC8PCgLs1ssPQ8x9tpwBmtjeTTX74bhSaGk0
 FYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eqW9Kj52y69ZnpMGvLNWRCX82+2t7WxidfGVLvjziz8=;
 b=BIFPzLUMzaw2rjSczkubZovu9/icGyo0twwPXi794zr5y2ninzKD08V21jjrWpkbjo
 ofQNkXLtaLroy4u6TZ0YnyM+NQT6egxC+13EPVxdbcpnau+Ff+G4dNHzkv01ciFpp+QR
 V7iOT5fLSzsQuPLmEHygAgGnOj3X3fJvqaURufYr1wtGzfh2DAVpd/QtqXjkETBMOKSB
 q7ivY4sWpCoWotV6dWs+ZrP7+VD+HRbY8rRkgm7EK0dVVspPCYTk+gxkM8FxKExsHKsO
 L2cCpo7Td42oNeA0XbkyRIN7FCmCVKPXHRStbxJfVVWFfUGf15gDCT6yjDUd8qcP8lPB
 XwMw==
X-Gm-Message-State: AOAM532VSKOKUA6O1/Kv6z5SzXnynnWe/1wp12rl2XxND0J2Lic4W87j
 tOaDdkOYq9uSgNcEb36TdaS6xOvQSO34SjZ9cK0DVg==
X-Google-Smtp-Source: ABdhPJxRc/uRhPMqcNoLShXO8PxZAelUzUyOCyNBcT2To2rSiPOBGoiAsmzRBdHgIGVxld0g1zOTxgwbOa3jHqcoQV4=
X-Received: by 2002:aca:1706:: with SMTP id j6mr12708772oii.146.1594634738340; 
 Mon, 13 Jul 2020 03:05:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200628214230.2592-1-peter.maydell@linaro.org>
 <20200628214230.2592-3-peter.maydell@linaro.org>
 <4c049b0c-f305-729a-748d-0a7742b496ed@amsat.org>
In-Reply-To: <4c049b0c-f305-729a-748d-0a7742b496ed@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2020 11:05:27 +0100
Message-ID: <CAFEAcA_JCSs6BCCw-MYOO8RcyXQ_iNZ63KjuwqEPM7yuvWsdTA@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/arm/palm.c: Encapsulate misc GPIO handling in a
 device
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jul 2020 at 09:57, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
> Why not make it a generic container in the MachineState and create
> the container in hw/core/machine.c::machine_initfn()?

I don't think we create containers like that for any other
machine, do we?

thanks
-- PMM

