Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4272C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:46:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85DAE20775
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 18:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Td/7aobe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85DAE20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtbZL-0004n3-S3
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 14:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtbYY-0004FV-Re
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 14:46:02 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:37667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jtbYW-0001gt-E7
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 14:46:02 -0400
Received: by mail-oi1-x242.google.com with SMTP id 12so2722357oir.4
 for <qemu-devel@nongnu.org>; Thu, 09 Jul 2020 11:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=3kpbldytbHFLFvJnDvvCuBLwCoOs0v9NjC6PiB2hZvQ=;
 b=Td/7aobe8jiff563YEHfcdY1NiVpPOZmZ+kyCZHBf6Z9RFdqfq5rAUdRYG0BCol2Mp
 gMUmHTXy5a4rmwFQxte/17TOhjwF1tYe8StqlKn4lljUs95ZB/jwrrLWsRV00XNlhTn5
 l/pcpCGZy3hZ9ssfAaO6+ZlIGtuPP6t63tV+u9VY7vJZt78Z42Ehukw1YkJE4CgnH+eG
 QsZ3k9EkWI+e3U3OTWsNuRb0qZrWCk+W10KsDl6zB7soIkZa0pzL9LB1f6wRL6cNCX+K
 ZYRvQIGFwjc9yVmmNRbuRrTuXqQIFuyNz6nRQidRXOnu5HOXUXAIvTHeX3vm2uzznIjw
 AsZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=3kpbldytbHFLFvJnDvvCuBLwCoOs0v9NjC6PiB2hZvQ=;
 b=jMkvfgygEtp7nw4MP+HzRjirwYG/exYtwXmD8imtxPZ5QllLGIWxtFdDWiVRX1eINx
 EtRDEWE3PMNtCWunwG/sLQFdzobh3tNgQ8i19CXgpOhpoOgV0/Iy/5mHeQXtJ9tva3mg
 GljT7JT8WFJIEBWX2UAzaAxFC0cnYGdXzi2PtxmHLX6VC2rY+0Sxr4vW352b3/IHiQlZ
 pnSTdM8hCQLOUm85thlRlbyN4e6cwWcjcICoRLmRRn7GON7Y3taG9a/HFaEESj/CopkN
 1Lkm9rE8rldA5hwAf6sbjFq/u3tir1MNNsZ8I2SZUXFqk11W3Qrz/eBKQnU6pj1Qmqmf
 /yfg==
X-Gm-Message-State: AOAM533YbE6/qp8H1PsescGFoaSBikDmLhUaBWxvgjCb0los1Q4TOJXS
 jLFPLUSF7WIKdZAwvBn3eag3DPdUw7REj5CjjQQ6OQ==
X-Google-Smtp-Source: ABdhPJygZLoM4kW8tKqssWpl1z20/e4p/NK42eICSiLlAl9K/teosdFzhDQEwjuVTm/gCtrZ1ddJH+zA2g1GJ//caM4=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr1277445oib.163.1594320359006; 
 Thu, 09 Jul 2020 11:45:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200705213350.24725-1-f4bug@amsat.org>
In-Reply-To: <20200705213350.24725-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 9 Jul 2020 19:45:47 +0100
Message-ID: <CAFEAcA9q94W2J2+07jPVbp_oX1J+vVvmLWXxj7gTJatbLwrB4Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/sd/pxa2xx_mmci: Do not create SD card within the
 SDHCI controller
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
Cc: Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 5 Jul 2020 at 22:33, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> SDHCI controllers provide a SD Bus to plug SD cards, but don't
> come with SD card plugged in
>
> This series move the SD card creation to the machine/board code.

As with the other series, I can take this via target-arm.next
or you can have my
Acked-by: Peter Maydell <peter.maydell@linaro.org>
for an sdcard pullreq for 5.2.

PS: this series didn't seem to make it to patchew.

thanks
-- PMM

