Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FF3C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:35:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 291F320709
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QzE59B0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 291F320709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXoUN-0004l0-3H
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 10:35:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXoRv-0003gS-17
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:32:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXoRs-0005oe-Hc
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:32:49 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44771)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXoRs-0005oA-BL
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:32:48 -0500
Received: by mail-ot1-x341.google.com with SMTP id c19so3240467otr.11
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 07:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qJj8k3J2wILV578XxWxTSJaRX2KZaMUm/y8Zc925SYg=;
 b=QzE59B0prj7zPeb0tfxqRf5USI3LTtT9vinu7e4xkzeZogMj0gx8Olqm5pSXW6tRTT
 5iOzb/F2sdDYPJyyfcI+r/LAO33Tqoj3WEv1LJQRmAxfwR8KH9aPaX35X34akhVgUI8O
 6ZvP8KdAcsTK7AxXoNezEtWGrOU/PuJT6AL9r40HrLFTvahu45tJyCeffM2v0lTrzfle
 YplXE3/rWtsiJetqMAzw/995XshVDcCJV/O9SU/4ZP6h9DJVBEJWeXtg8HePFOglz8Oq
 fLOgOHbpNw8+j6ck8Pb9j/NHXy5pZZsO8fymMwpw4KnTLrmR2Y63/LvWcNK1U3bJcZC9
 TdKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qJj8k3J2wILV578XxWxTSJaRX2KZaMUm/y8Zc925SYg=;
 b=pV6Fp9D41QTJ8Hyq2d6eh6K9Udc2ZcTAwUUs0RNyxuFvqxLf5aReDQVHr8mmwn5sCe
 OQ7uXj2DyjKOrYz8BzzBi3hoM4TCMxU7r4qET3JRO7Pxgn10gqliDTgLiz92+Dh5Qxa/
 yd+c/9TQQZzxx/ZtpmVs3mvLxNNTtwo5gAN4HNGDmVJ3VTdzc8Y69yZIf26pyn1vspBs
 bOZcF4l2ykjhrwMUcEeAQKxQcr9ly2D1sFOrGrzTWgeDldAfj1rBqtkAAf0raRjVKYrQ
 X6prXUaOVNlgUwEP57fx7Sw2cT1iVIRk08vNlBtXQZ2b6kiHqW/72c/A4GiO0LXrb+sE
 6Fdg==
X-Gm-Message-State: APjAAAXFbAjKOwliMZBlFU1bVPd1kAB8lpbRnTPHwCVAPVSILEMHgSPK
 Qp5Euv0XGrDih71rB3TVhoY/+qy/5Lq6hFTQ8UyDMg==
X-Google-Smtp-Source: APXvYqy8VHRcm/uFbs0xe8NtkMDEmGjS/4wBZX8CfVVZWB92S0NUHtvvBiI6kQZWG7JgtT+Vdvo4PApetl+tqr1F+aQ=
X-Received: by 2002:a9d:12d2:: with SMTP id g76mr7271627otg.232.1574350367411; 
 Thu, 21 Nov 2019 07:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20191115154734.26449-1-edgar.iglesias@gmail.com>
 <20191115154734.26449-2-edgar.iglesias@gmail.com>
 <20191121152803.GB31462@toto>
In-Reply-To: <20191121152803.GB31462@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Nov 2019 15:32:36 +0000
Message-ID: <CAFEAcA9DxhXLzyaT9EYSfasAQh5yPsfLyMmTwX6twESJ1gfOig@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] hw/arm: versal: Add the CRP as unimplemented
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Cc: figlesia@xilinx.com, Stefano Stabellini <sstabellini@kernel.org>,
 Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>,
 Francisco Iglesias <frasse.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 Nov 2019 at 15:28, Edgar E. Iglesias
<edgar.iglesias@xilinx.com> wrote:
>
> Hi Peter,
>
> Can we consider this patch for 4.2?

Sure, it looks pretty safe. I've applied it to my queue
for rc3.

thanks
-- PMM

