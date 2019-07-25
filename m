Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2E0C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:04:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14C2A217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 14:04:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4IfEept"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14C2A217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqeMM-0004dP-9m
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 10:04:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57518)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqeMC-0004E3-Bx
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqeMB-0001Vf-Ai
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:04:32 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:46611)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqeMB-0001Uw-4D
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 10:04:31 -0400
Received: by mail-ot1-x341.google.com with SMTP id z23so23403850ote.13
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 07:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=exWLwmzWzTgwuOT1U/bctrzD7f3MX89ZgJpXpNn5CO8=;
 b=e4IfEeptM/k3r0PLW6hPmXL4W0WIUME2SXVNAM2d6u2vlFXUKYsQMPnSy8nscxWYf8
 JXP4+1//ixdbnkr87rSLGSGpbsmgzclRhxJrEcCc1u+UjfbTK5+KPQ1V2iib0fBmANMV
 X6VzN1asPSRbzBg9Z647M2c8jU4TaXEFN3LBr8O0Sx+fSDNaVKWUVsvSa8CWee4pCMyn
 HjyIzN+uFgG+C4XbKF2Dd51XoLQ3VDGy+pflvafnjRtV43Ba/pvUB4NKxAbO8ATTrCMZ
 MLHvZACA/EQbptSb5oEGDtDBPTSIHRQZ6UQY1+hSNpoLozD5Hkbm9y/inm5MCUQKgw7f
 NW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=exWLwmzWzTgwuOT1U/bctrzD7f3MX89ZgJpXpNn5CO8=;
 b=bzGTDrYRhN2Zg02TGWABg8j0pO7oeAjquo7JIBXa+6KkQB897C6+Ft/yefhW7K9Yfz
 pdAbflNAtrjjDdCS9gfxTJmzVFzpP9gLhDWt70WRrYPXIpiYVtrMJV2yP7+9crWMpa9G
 AjZN5fcQVtfYY1Yl3DOher7T1ZXQzm/AALBA9z6gE+ruzLj6TuOkPmeycN/LhLd7mq9P
 6ecLLxXfWi8efHSsH1VeZ+cg4IDxEvGOseD67CfrhiqGiZ5gATlEbf6kWZjcIJjtCIfI
 mRRLSQoT0xlmSLwFrCHnMDz9clhmaTPFZ0NV/eaRTHeRCGk94IbEDvRx5HPe90doMNj3
 Q5SA==
X-Gm-Message-State: APjAAAXwFrINO0muEGXNTajuh2QZwUkegtGLyFzo36tn6tWhAwSwTknj
 KSnt0xnAVcIUNfUHB/paVXJ1ZVt6pzm2zkYXiCeHZA==
X-Google-Smtp-Source: APXvYqyFu62bspEZsaGgdhWXsKzUO63VZbNzXq1FzAenetYWarnom4linSwVDoq3EUtTHoXWHno7vs8S7pQa3hrD4HY=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr61609827otj.97.1564063470068; 
 Thu, 25 Jul 2019 07:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190702121106.28374-1-slp@redhat.com>
 <CAFEAcA-k76t9_TJnYSF_kocgba9dYMyf=Q6OBY2VVuhiWsbqrw@mail.gmail.com>
 <87a7dwnxwj.fsf@redhat.com>
 <CAFEAcA_XfRS1b-4ANmR5WLL=19Md6Dp7+M_FAK8pQAJn2MaCOA@mail.gmail.com>
 <20190702220400.GA13923@localhost>
 <20190725055908-mutt-send-email-mst@kernel.org>
 <CAFEAcA-uDtTFOyTwMY5KtWeqvirxDejQdvnx5OCZ8pyUhKhE+w@mail.gmail.com>
 <87pnlymm47.fsf@redhat.com> <d48da49f-c8d8-00f7-1634-569e8d924b8a@redhat.com>
 <CAJSP0QUJCh-SaZ9NQ+Wr8vr7R+gBsfhYmBrx45B4z2G9v9L=1A@mail.gmail.com>
 <20190725080556-mutt-send-email-mst@kernel.org>
 <CAJSP0QVvnXV8Ha0yaO84qLL6unVroV5GqcuL-x9ruB7o_24WBA@mail.gmail.com>
 <ddc31318-dc52-b9f2-5a9d-bd1fc650df5b@redhat.com>
In-Reply-To: <ddc31318-dc52-b9f2-5a9d-bd1fc650df5b@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2019 15:04:19 +0100
Message-ID: <CAFEAcA-zBb0mXX1JLoWxz46JDAZFySUZpdONo5uw=KLgJqJ94w@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v3 0/4] Introduce the microvm machine type
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Maran Wilson <maran.wilson@oracle.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jul 2019 at 14:43, Paolo Bonzini <pbonzini@redhat.com> wrote:
> To me *maintainability is the biggest consideration* when introducing a
> new feature.  "We can do just as well with q35" is a good reason to
> deprecate and delete microvm, but not a good reason to reject it now as
> long as microvm is good enough in terms of maintainability.

I think maintainability matters, but also important is "are
we going in the right direction in the first place?".
virtio-mmio is (variously deliberately and accidentally)
quite a long way behind virtio-pci, and certain kinds of things
(hotplug, extensibility beyond a certain number of endpoints)
are not going to be possible (either ever, or without a lot
of extra design and implementation work to reimplement stuff
we have already today with PCI). Are we sure we're not going
to end up with a stream of "oh, now we need to implement X for
virtio-mmio (that virtio-pci already has)", "users want Y now
(that virtio-pci already has)", etc?

The other thing is that once we've introduced something we're
stuck with whatever it does, because we don't like breaking
backwards compatibility. So I think getting the virtio-legacy
vs virtio-1 story sorted out before we land microvm is
important, at least to the point where we know we haven't
backed ourselves into a corner or required a lot of extra
effort on transitional-device support that we could have
avoided.

Which isn't to say that I'm against the microvm approach;
just that I'd like us to consider and make a decision on
these issues before landing it, rather than just saying
"the patches in themselves look good, let's merge it".

thanks
-- PMM

