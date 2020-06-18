Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AD2AC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A85B208C7
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 16:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z67/CKa+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A85B208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlxi3-00083L-Nl
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 12:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54244)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlxh7-0006mt-RF
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:47:17 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:38598)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlxh5-0005Ix-Fw
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 12:47:17 -0400
Received: by mail-ot1-x342.google.com with SMTP id n70so5050653ota.5
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 09:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d6o7pV/Rlvas8MgIORxmMbx8sZnC/G1UN7zqfjxb8oU=;
 b=Z67/CKa+jrYZtvUNj75VZI8KpvYl1Kf3UeIxg/LpwRrXcYYBEfcEGLH+8lM0EaYotH
 76l9UdSILZNIkK6qe81lxvNnR/JXI05rRU4OAEOD6srdzMwX2IDIVaOU80GqQAJkKSqH
 cv0gudqqpD/uFEOwwHh3otZUKAZSpKF1oy67rgZIFuB2Ag8d+jkFEBrFxEIIlnMiz8D+
 GG+zHOZQ+3z6N/fX4HpGBTgAv1aNYdRY/goX3SvQZP+zgJtKtHXCXo/hhlKCn8LmA6eS
 12+N8zfv0sSbcWvEpmN1ZleJDcGMO+lQon768OQyOsMWGUGNZBeFbQU+S03BopIuoGUe
 Hq1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d6o7pV/Rlvas8MgIORxmMbx8sZnC/G1UN7zqfjxb8oU=;
 b=opGqDyl7iiHO494SXZxX/jS9MrWHuHE6R64WCs5jS6PCmFBgVXQaa0jrfE0gcnEdh0
 jivojgbzrMQEpHHUTf+5IF9X+6zKrpqNSmXLEsuIc5rPyFoXHD5E3g01x/gAP8T6/Hia
 pUQbpKZoUzqQckJ1hMlhugi1tdnLejKm3geF4tTl8h481X0G5XJIzp93d4/99bT5fYBl
 Vs/d3Xx2ukMnpWii/CXR6RHNnj7aurBrm73enMQcpixqxUWHdlTckxY8vZNQsG8hAZCt
 YA7zkHSkGddNbpyn+M+SqlgTmHLflqiB3Q+gKhUc/+kKBoY5kzuOE9BocCvCVKJ6+WoG
 CUqg==
X-Gm-Message-State: AOAM531nRFnUUk9Nm+y2QBvt7iCbMPMnXAR1MBwtWWD1f6C2Z0deZJRb
 1uN4Fa0ef6Aa7pG+oMLdS0SEVAHqHtyw3NSAIrl+fQ==
X-Google-Smtp-Source: ABdhPJxbT70nsTWAMdCBiheLbX14KOc5yK1hBNHJrgOwWLHmPQtq923+zfwbEvPO/ho7mG4YQ4oDnfroj4sNUXd1dm8=
X-Received: by 2002:a05:6830:8d:: with SMTP id
 a13mr4274853oto.91.1592498834477; 
 Thu, 18 Jun 2020 09:47:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1592266950.git.balaton@eik.bme.hu>
 <08998af9ba98092b7df53b8c759010bee6206261.1592266950.git.balaton@eik.bme.hu>
In-Reply-To: <08998af9ba98092b7df53b8c759010bee6206261.1592266950.git.balaton@eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 17:47:03 +0100
Message-ID: <CAFEAcA9d06tnLrvoND6PiUQfGDbAf_-N_hx8bZsPczJn=W0oNg@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] sm501: Optimise 1 pixel 2d ops
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 01:35, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> Some guests do 1x1 blits which is faster to do directly than calling a
> function for it so avoid overhead in this case.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/display/sm501.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

