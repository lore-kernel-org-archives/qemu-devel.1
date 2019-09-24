Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCD4C432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:12:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69E49214DA
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kqMZ+Wtn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69E49214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCmUN-0006ZV-2W
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 11:12:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35354)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iClJm-0002zt-3J
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:57:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iClJl-0000DJ-06
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:57:25 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:34892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iClJk-0000CX-Q5
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 09:57:24 -0400
Received: by mail-oi1-x243.google.com with SMTP id x3so1717719oig.2
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 06:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vMmaji/RGvedZuk2RaAUa4vZZdlLr5fEGxEDI7CiFeE=;
 b=kqMZ+WtnkhbtzhvlhjXwwscfrRXT/w8p9CzN4cOMWKvu1omYxEUFGnwiU2zpMvcNof
 tqo8b9ZzusPkgOr4vPlOqEkOQCTGKUba1YjVfU41HNOdBPwflhfYjr2VCRGqg+D64tyt
 AVFqe3KQSLm/1rwq2Rit7zFsTuLfv8fOu8dHtGfBhE9z9iESI2eZZEEGfQ+A6TKZANzI
 5AFhZRTPxDmjaeN805mMEAVeqJ5iypxiHSzKzjMELgH6A7Egkj4/hTN3Fs8iQsOvXu0L
 5jEClyQpsguDnbqx3AXYQvG619RZmgUemA/a3EFpxBsqYkoGS/CsuBY7HrmjkZnWPwFw
 0weQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vMmaji/RGvedZuk2RaAUa4vZZdlLr5fEGxEDI7CiFeE=;
 b=dsom2n+XZF/AgUbm9mdyqsZhJ3LljtkfD+3AVqwi9u4EjDBvYw++bxGpBnjsSYY6mY
 +cV4rYWkfD2myptkGzBwg0fsrfcnlJg1QflOVR34u+6v52cIu+H9CxHIWrB5txUo8mYR
 kUX1nMu4WWclaSehQ8Cm0ILj84JBLnElZyTBl5zwn7oZvXmNZHecNoKvoFqaMCTYTBPv
 LJT7mamYMDOfrEJ+XtkoUoXBBbSJcJemMiEcC1o21CYgOt0VvJA2BvocDlXCb7wUFCNX
 GM7pwDqs2d7s5XagUK9pO4i5xHS9A2mrJvl4Kq+fj5uwbTja6MDk7SIotrKzairNDqZ7
 Fqww==
X-Gm-Message-State: APjAAAVfveNy7HmD7de6RYxkGBzY5dcF0z45GhuDK5os/pvG/QFm4UBP
 /Qqc0QQQ2swqZNtIvTpRBTRiQJN7lzEGi1B+8vLohQ==
X-Google-Smtp-Source: APXvYqyk8uNERiTw5KlM/VZ2fU3MnQFHMG461Tkz+7/aVpoyCEKM5OREzdXY+E0Rc3W0AF6AZuwb9lcv6b1BpPLazyg=
X-Received: by 2002:aca:f54d:: with SMTP id t74mr151470oih.170.1569333442752; 
 Tue, 24 Sep 2019 06:57:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190924124433.96810-1-slp@redhat.com>
In-Reply-To: <20190924124433.96810-1-slp@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Sep 2019 14:57:11 +0100
Message-ID: <CAFEAcA_2-achqUpTk1fDGWXcWPvTTLPvEtL+owNSWuZ5L3p=XA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Introduce the microvm machine type
To: Sergio Lopez <slp@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm-devel <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 at 14:25, Sergio Lopez <slp@redhat.com> wrote:
>
> Microvm is a machine type inspired by both NEMU and Firecracker, and
> constructed after the machine model implemented by the latter.
>
> It's main purpose is providing users a minimalist machine type free
> from the burden of legacy compatibility, serving as a stepping stone
> for future projects aiming at improving boot times, reducing the
> attack surface and slimming down QEMU's footprint.


>  docs/microvm.txt                 |  78 +++

I'm not sure how close to acceptance this patchset is at the
moment, so not necessarily something you need to do now,
but could new documentation in docs/ be in rst format, not
plain text, please? (Ideally also they should be in the right
manual subdirectory, but documentation of system emulation
machines at the moment is still in texinfo format, so we
don't have a subdir for it yet.)

thanks
-- PMM

