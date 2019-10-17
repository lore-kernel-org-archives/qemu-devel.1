Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B7AECE58D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:21:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43B8220872
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 17:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M5F13e/B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43B8220872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL9So-00004u-S1
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 13:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL8MZ-0006jK-T7
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:10:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL8MY-0000ZK-FA
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:10:55 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37253)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL8MY-0000Z5-9k
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 12:10:54 -0400
Received: by mail-ot1-x341.google.com with SMTP id k32so2379882otc.4
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 09:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4pccs28A3obC2PWpJv9i2yXkR50++8k8gHsTRlSoNyc=;
 b=M5F13e/Ba5j7krASuoq9b7V05tAPKAFi9XrieCcxg8qLSCU5SGpuinWIHK1PCamkS9
 lPssevGyx10h0H2/dzgstftdAm5iTwYEoKT3UfeWoqQs2FkVvAvgoQ6OZp5ZtFFvL/Ot
 YRdZcFuBLytZ1KHytcTAbPL+payZgvNS+qIlhXOFpUsy++2UP8ims0kDfk7qr0rphyOF
 bay4DbvyK9+0hE5qbOZfWFEj5loqY3dxo5tdAbLVr3nWLmwfBKKtHF8ezCy1fiV/3m6X
 wKXpAx3gRd+rOG8P88sWfyykptJ9FSHxNQh6D3BEJOnr+7eDxGGLPDv1hLUJ2aYNGvUG
 iy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4pccs28A3obC2PWpJv9i2yXkR50++8k8gHsTRlSoNyc=;
 b=hLB6pBzjgH2Y1IDaG2AOyqLoHUkUsJ9R0eELYFKfG8YPRKtMDDfJbESPG5gTPwIa2y
 XdpCq48uSZIgRYCVrk39dviy87LwR2we71bG+0R5jtmY+3TDFrIXKPtDMQ5eV+wfYOIR
 t78yu0ycplCjyxMsII8fjvcvi+6QrKIZD9S0Hzp8pfUNMSst23sanNc07/4pkl7ytIPa
 AXGo2iHaji/a3OUXCIacBL+pOTCYlpB5lPor5A9PuZ3nenTS2dnH8VWJM4EXoe3l6wJN
 0+flTfieXbL5lJMvCIVQETiE8eixvz8Rw1QKV6cz14HGNtwT6yDOpOPLYvBNbV/K4eBB
 FnaQ==
X-Gm-Message-State: APjAAAUrj8soXIqDb2wN9E8jACkbr4/6mOVEC5e7TZyXHfK+ImvP6qrT
 GUD5Brbsz5GT2mt4V93MD77tWZA+WWRIc0JN5nQ7aA==
X-Google-Smtp-Source: APXvYqwPS8ytHPWS3QyoObXLeAL6Jcq68wu+BEHpTLqkufeyRfo/7bQBJHE+Wdj+oy6Byh5TgZIOqgrZrzb8p49CCRI=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr3787149otg.91.1571328653377;
 Thu, 17 Oct 2019 09:10:53 -0700 (PDT)
MIME-Version: 1.0
References: <20191017132905.5604-1-peter.maydell@linaro.org>
 <20191017132905.5604-6-peter.maydell@linaro.org>
 <18066f84-ea56-20c3-6e43-58978f8569bb@redhat.com>
In-Reply-To: <18066f84-ea56-20c3-6e43-58978f8569bb@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Oct 2019 17:10:40 +0100
Message-ID: <CAFEAcA-CFGt3vXnrvtbXF-GOJmx=34GdbrhnNHyPnHAnguKtuw@mail.gmail.com>
Subject: Re: [PATCH 5/8] hw/timer/altera_timer.c: Switch to transaction-based
 ptimer API
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: Thomas Huth <huth@tuxfamily.org>, Magnus Damm <magnus.damm@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Michael Walle <michael@walle.cc>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Guan Xuetao <gxt@mprc.pku.edu.cn>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 17 Oct 2019 at 17:09, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 10/17/19 3:29 PM, Peter Maydell wrote:
> > -    t->bh =3D qemu_bh_new(timer_hit, t);
> > -    t->ptimer =3D ptimer_init_with_bh(t->bh, PTIMER_POLICY_DEFAULT);
> > +    t->ptimer =3D ptimer_init(timer_hit, t, PTIMER_POLICY_DEFAULT);
> > +    ptimer_transaction_begin(t->ptimer);
> >       ptimer_set_freq(t->ptimer, t->freq_hz);
> > +    ptimer_transaction_commit(t->ptimer);
>
> This looks odd because timers are not running at this point (REALIZE),
> but if we don't protect it, ptimer_set_freq() will trigger the assertion.

Yep. The same pattern is used in several of the other ptimer
users where a fixed frequency or period is set immediately after
init.

thanks
-- PMM

