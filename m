Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A72DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:55:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0324223117
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TISiTnV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0324223117
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55370 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3fQc-0004vI-2A
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 08:55:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3fPm-0004Dz-Ez
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:54:34 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41336)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k3fPk-0005vq-N5
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 08:54:34 -0400
Received: by mail-ot1-x342.google.com with SMTP id a65so26883596otc.8
 for <qemu-devel@nongnu.org>; Thu, 06 Aug 2020 05:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ma5Spo8GB6B6vpsylIDasmSoZ8sei6BF0p9K2xGKKno=;
 b=TISiTnV8waiu4/S5+LTBUOFoUK5QuLpjjHMR+towkIIAkt0SbWAm0LNDbllhNy97ai
 38OgIwdUd6XVUfN3Y1edN1rLbSt4IMH9s9fmX9MfnEf0BVVbgIZndKvKxABAWLyHXBuJ
 tII7/eDa29WS4QCpATOzJqe+FDAEMi7bz29KG2jwL0/JGuhUSxZSvQ5jq7PPBS1woqeD
 uSwbq9gYsPulMX9XpItbHR3yrXyRQT60yYme8PQYa/m2MzwOEnr2hv2XkMOxDJbJtWbk
 CRW8ZHwvDMeo0pUSpqeg8QtpYnObAATLEnRBylswvih16TmI5dwyXJ1oajbHoU3dwPj6
 2syA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ma5Spo8GB6B6vpsylIDasmSoZ8sei6BF0p9K2xGKKno=;
 b=svmzS1/gM8C9DRLq+dBbYtn9RUz4MuOz5SfDK9qrDXJobTvN4NLnLC/0rzUGnS7GXa
 5ti51YSrDerjbfzPFOhwcPAdBEOmcIX0u67+NfhIf+9euuuibtgzNBEFw09+1h8AdHcq
 /HczDanPYoDfjE4DWXUH+Sn2Mo/HK/BabyzxC3xh7szMkxVM/ximUijCNm7zMTgdNPsI
 miIvEw8CxPeXP51UvH2aiJAOOXbKCpbbiAEISnmOuee9Q8uzH51E5bbklMlvJX9xRsbz
 zktiwGk4ZwHHR3u1ocrx4rKeUgPi086NvlFBiJoYqZd+orkwd7CF9hOQncB8NdtfFlrf
 /vAw==
X-Gm-Message-State: AOAM531xpMtji+cVXxkw9F2f6P2uc3h4pc+Uh1a24i20/OdIENNAEAxo
 fovN9CDyZhTdxkeghOhfNKXZllBbjmkg96U2a4cM1w==
X-Google-Smtp-Source: ABdhPJxt7DmSqLAi38l08pj3MoqOIZni25WD19SsvxRH6uoolKalZ+bn5SoF184yL4T+LNJerEMPpdHGcOE4dWQRBvk=
X-Received: by 2002:a9d:39c2:: with SMTP id y60mr7000005otb.91.1596718470944; 
 Thu, 06 Aug 2020 05:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200709152337.15533-1-f4bug@amsat.org>
In-Reply-To: <20200709152337.15533-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 6 Aug 2020 13:54:19 +0100
Message-ID: <CAFEAcA_Sbaai_TPMVkGHKGGhfyjc1Mk2Z6pWSVkLcwHLVZVzNg@mail.gmail.com>
Subject: Re: [PATCH] hw/cpu/a9mpcore: Verify the machine use Cortex-A9 cores
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Rob Herring <robh@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm <qemu-arm@nongnu.org>,
 Randy Yates <yates@ieee.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jul 2020 at 16:23, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> The 'Cortex-A9MPCore internal peripheral' block can only be
> used with Cortex A5 and A9 cores. As we don't model the A5
> yet, simply check the machine cpu core is a Cortex A9. If
> not return an error.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/cpu/a9mpcore.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

Applied to target-arm.next (for 5.2), thanks.

-- PMM

