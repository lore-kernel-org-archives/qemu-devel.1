Return-Path: <SRS0=rFyn=Y2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7447CA9EC7
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 17:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EDF21726
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2019 17:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/iVsvAv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EDF21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQxg8-0005CK-Mj
	for qemu-devel@archiver.kernel.org; Sat, 02 Nov 2019 13:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50723)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQxf2-0004k1-OS
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 13:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQxf1-0001fY-CI
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 13:58:04 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:38743)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQxez-0001QZ-J9
 for qemu-devel@nongnu.org; Sat, 02 Nov 2019 13:58:03 -0400
Received: by mail-oi1-x242.google.com with SMTP id v186so10814658oie.5
 for <qemu-devel@nongnu.org>; Sat, 02 Nov 2019 10:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iJr9Os6DuncpmRSq0a0XA+/ZFoa9N0kH2lP/a5knD6U=;
 b=I/iVsvAvVl95f8LFRNfZMjKSvG9DfiQXCgNd2Pi5rzEuTwlxRvkkmbdwNKhZBm8c9Y
 0t9UTsq+B1LLVX1y/ZjX+3XAdYWbK1AnRdJ8Erq3oaE1VV2tPvZqU1xRsO5JLqh5LS1o
 byU7exlyEv6K9hBvNvyrwIXMvamvhEwcVb1SELv80FFLipZ4IWHokjP9cM8npRSlLnC4
 bOhUjfDfmKsBBul+aao8uglGzZULjBmQ0ZMcmM7nCJMFPNF9vQBKWm24t3dQHY3b5CTj
 s/j5ot88dLNd8CFQOrJkPqqwagcT91dhn0gp+aoCkixw/QHNK+zYLqD3b2YxhBvau7hc
 bZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iJr9Os6DuncpmRSq0a0XA+/ZFoa9N0kH2lP/a5knD6U=;
 b=NVmADfPKWj3wPuyUpG7o1S5l6HMyh5QuHdBh5Y/D4QsTV/PmB12UQwzDdRPw7uCd6f
 da2Rt8n2gRzkLZ2dNGxEXT0BrkryrbifxLGxzt91g1LqhGEM/SyoJQ4hTMGQ/von41wO
 QWY5LnTPxu2CbCJ5XpqIOWoqavhiWFjb5BjfTmg8RkU+AN0CXLun5h9AJiItmMaWPhqX
 Zff+rGPQI2JEKFBzsSwx0Gfxw2tA7idI7qRs+YmPD+jSu6/koRW8GkwnVfb36AEc43Ox
 nef9sq4WTfYcZ5WMDu3JTcpXC01Ce0dzyUaF3m0KX06Rdtt0wv62rwxbZRWNmRX2d+40
 5fNA==
X-Gm-Message-State: APjAAAUSFB30eqF3MP1mY+2R5lihaZChGZ1QF6VoX/K9ToyDonp6Vdi1
 L/Rr5rbL5drAmaHwGR5nWpJGj0vHmwNqVNdFu4wr3g==
X-Google-Smtp-Source: APXvYqwkyKwRBB5UE8n+weGijBO1dDSFG7uCB4zRE3Wdo9YfUGD5sUT1ANytEw3IY7lpYcglkst5Wr+Pw3J8VM/Sp6M=
X-Received: by 2002:aca:451:: with SMTP id 78mr10580223oie.170.1572717478982; 
 Sat, 02 Nov 2019 10:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191101085140.5205-1-peter.maydell@linaro.org>
 <CAFEAcA-N-Fh7+NCHGPXuK-H6DUTOwjfCU6rmZGz4k8n+tkKdxw@mail.gmail.com>
 <20191101095438.a6wd2mal4w75irvg@kamzik.brq.redhat.com>
 <CAFEAcA9_PMjhEgMn3qnr1xsiGU5YkNr1KeCvez6pFm=93EzTpA@mail.gmail.com>
 <CAFEAcA9iTS8SXTFyGPwk+Wn_Aw-2rd9Wb_N3cH8iAxSOzzYyVg@mail.gmail.com>
 <20191101142540.dzu72u4fll6wcovk@kamzik.brq.redhat.com>
In-Reply-To: <20191101142540.dzu72u4fll6wcovk@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 2 Nov 2019 17:57:47 +0000
Message-ID: <CAFEAcA91r-_q+ZV3Jzuv3ri-RdH3J6wY0A5t95OR8vCUE16wHg@mail.gmail.com>
Subject: Re: [PULL 00/11] target-arm queue
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 1 Nov 2019 at 14:25, Andrew Jones <drjones@redhat.com> wrote:
>
> On Fri, Nov 01, 2019 at 12:53:42PM +0000, Peter Maydell wrote:
> > On Fri, 1 Nov 2019 at 10:34, Peter Maydell <peter.maydell@linaro.org> wrote:
> > >
> > > On Fri, 1 Nov 2019 at 09:54, Andrew Jones <drjones@redhat.com> wrote:
> > > > Darn it. Sorry about that, but if it's still failing then I think QEMU
> > > > must believe KVM is enabled, i.e. kvm_enabled() in QEMU must be true.
> > > > I can try to confirm that and fix it, but I'll need to set up this
> > > > environment first.
> > >
> > > Yeah, it looks like trying to run with KVM in an aarch32 chroot
> > > doesn't work but we don't notice it -- in qemu kvm_init() succeeds
> > > but then we fail when we try to actually create CPUs, so:
> > > $ ./arm-softmmu/qemu-system-arm -M virt -M accel=kvm:tcg
> > > qemu-system-arm: kvm_init_vcpu failed: Invalid argument
> > >
> > > we barf rather than falling back to tcg the way we ought to.
> >
> > I spoke to Christoffer and Marc about this, and they reckoned
> > this was basically a kernel bug (and ideally a 64-bit kernel
> > should just refuse to open /dev/kvm for an aarch32-compat
> > userspace process, because it doesn't provide the aarch32 KVM
> > interface, only the aarch64 one).
> >
> > In the meantime, we should just bodge whatever we need to
> > in this test to cause us not to bother to try to run the test,
> > in whatever is the most expedient way.
>
> How about just doing this (which can be cleanly applied to 2/9
> without conflicts on rebase)

Yep, that works. I squashed it in and have applied the
updated pullreq.

thanks
-- PMM

