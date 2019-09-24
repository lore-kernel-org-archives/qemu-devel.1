Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D26D4C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:38:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CED02053B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 14:38:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j4yagwqX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CED02053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iClxF-0006RT-2J
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 10:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iCla9-0001Ka-6V
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:14:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iCla7-00006p-SX
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:14:20 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:42276)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iCla7-00006F-LV
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 10:14:19 -0400
Received: by mail-oi1-x244.google.com with SMTP id i185so1748321oif.9
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 07:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Mhd/FJiamKV8bgwxvhSM1XmfViMLPDMRpLbPk1h8UFQ=;
 b=j4yagwqXqS6lcOkOx5LSGKWlLY7JFtE0BSiUDKdT/0FUEo1UqAlkUOmbTGRRCzlYQd
 0tH7T1+Gffnwm7zqlAzsr8aoQsWIMlsiFYsW1Ii58h7uXiPoElHc8mwCXHRugHNH4eim
 fI38tAv+rKuucYWaAa1KAfpC80eYWTfqeF2a6kOcA4zNzKhAWp7b9ULGsPrDeEdPMAd5
 dVToJBdinNNvbzgJkJOM+NNBgeN5Aw6o+4mNwuvXHZjbmiFDC4ifq2As5wVh0MHO8rRW
 BEtnDgNNrNoOozizNFmaIQBn1OZngb016lQmCXLeudMN6LAdO4KTi2/Hi/juPoAoFAY4
 z+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Mhd/FJiamKV8bgwxvhSM1XmfViMLPDMRpLbPk1h8UFQ=;
 b=dEOmwlRM1EBsj7WULPAob3dIO/FPdk2C7crygiY+Kjf8K0Dwv74T58Y6sYG10FSnau
 u+BP3qr/GxXYdQsMEpUBBXFW9BWKyZSBPs/rQriqFS5VjLeTpwjP7+zjwtfb/f9ecJCo
 iojkV1Axs0yOGslAON+8CYMq8e8fD8QZ2nM6CQMzvYnoKzrbI42mr+Y8GHB4+7DN7JHu
 IN6ea8yy9ujIaNI5EAavmIGcS3TX9PwPJ8G4PY7X5crxYOZ6BmnhFWU4pJ8hQFkoxxem
 kHYow3R6clWlqTdcc7BUJCzm//vXZptFO2DLf4KZG+oaEh3A+Kptp85k/gIPltCQmZ9n
 QKXw==
X-Gm-Message-State: APjAAAXt3HfcI5iBJ/HMEtssabjMdBFasEYR/BbaTqO6Op3QO+uqlEb4
 WP5n6cH2Iky0Cg2ddGEsRCG38B8DnnhjvBzv/qftng==
X-Google-Smtp-Source: APXvYqyCHKxkL301M500Wq7L6Lv/EDs9iq+Q0krCF/oLYOe5OqnzTO2xYvrOB+osqHBO3nNrhIrC40YpcSs8q8zYVvw=
X-Received: by 2002:aca:50d8:: with SMTP id e207mr255616oib.48.1569334458739; 
 Tue, 24 Sep 2019 07:14:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190924141228.25009-1-philmd@redhat.com>
In-Reply-To: <20190924141228.25009-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Sep 2019 15:14:07 +0100
Message-ID: <CAFEAcA9a-OdpzLgqeO+iRTr3PNYxGZ+ECX_GVOQD0NLNk8OynA@mail.gmail.com>
Subject: Re: [PATCH] hw/timer/pl031: Add warning "do not use as model to
 implement a RTC"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 at 15:12, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Peter said we should "not use the pl031 as a good model of how
> to do an RTC, it has some definite flaws."
> Add this information to the PL031 header for other developers.

Lots of our code is less than great. I'm not sure this
specific case really justifies blazoning it in a comment header
at the top of the file... (If you do want to put in a comment,
being more specific about exactly what the problems are would
be better.)

thanks
-- PMM

