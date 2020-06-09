Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78605C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:45:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369042074B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 15:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCjyKs/P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369042074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56466 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jigRD-0007Dp-DZ
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 11:45:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38732)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jigQB-0006Oq-MF
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:44:15 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:38864)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1jigQA-00085i-7D
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 11:44:15 -0400
Received: by mail-ed1-x543.google.com with SMTP id c35so16786467edf.5
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 08:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Z9ZnnGkEcUhiCT3nRIZmEUNcnDyDZGhXhgZzVMAb7SI=;
 b=YCjyKs/P0fMxhkEp582iAFnFBvgfdVNV4jUWb9aJJzrTuz5MTnqQolUse1muIFHsS8
 UKTX+++QwRZA8MDBQWIsxJgNleJRlI18zXDnNVaKxeFcNpIbyIxi3za2ssZp1zzfbeQg
 F4dHUhygzqCu/p0C2wSuw9nzUZUc/dCHYBwVgOkoOuPP0tmHaBXOCkr/S3HWIsfQoKfB
 RyJqsbPjYHUKYAUNOGVPdnfkLxGy/z+h48HDQlEgRgnbfsB0Q5m/I4wlr7vkqzr2ZC+L
 +ZhwaZHgrMf+sR28oaPdJYzVdBDNttjCbqjdgPlQO/oZkkOPs/KNIjLAYa7Ml743mIAh
 tdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Z9ZnnGkEcUhiCT3nRIZmEUNcnDyDZGhXhgZzVMAb7SI=;
 b=n6cv24wyoRe66oyWWDaCw1RyFnbVhItyd5oaS954jFOMSqsshZMbVuoSDFRYnviBKU
 TqkkQJqytjw117YlZgHtJ0jCvee073pXPw2XDcumBBomkiOUIGJjuqVHJUl6rYwRZQjI
 7qGi/Vb0ZDM4XNimQVr4fbsHNHVwL7xpJcLknND+Wm6qZL3WoV1upQ0I++dXd1HOX60N
 /dd6h/f5hf6sSp/xqWr9SvF0dLfCoWhygQE07mEu87h/QhpqnXWlxptLon9/++9DYVnE
 Azz2lDDUcNxtMQ1wUkEIgaGRXh9JF4u5SwdlE55Sg+7qgx2mN934UQTRO1hLleBuSymj
 /uLQ==
X-Gm-Message-State: AOAM530liXGUzNJ/zTVxGlObMSc/dLxiyfj87pYd0vTaSYWCPepBbYZi
 v3fBBIqPNmlxbxZE24JASvjDBacsNBql3by83cY=
X-Google-Smtp-Source: ABdhPJxlRpVnpFPtcVaUhxsK5OMEs3RO0FnaE9A048QoKurNiehHD62BmFqcIyR0C5USvmisjp8D/XcIRCGqzsGi2Mg=
X-Received: by 2002:a50:bb41:: with SMTP id y59mr27057140ede.311.1591717452052; 
 Tue, 09 Jun 2020 08:44:12 -0700 (PDT)
MIME-Version: 1.0
References: <1591559185-31287-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <CAFEAcA-0Y6rFNrsD2SN13eZArCk3Ydvf6kv7OZaQ07fmFdSZZQ@mail.gmail.com>
 <CAHiYmc7NuEROi312sq_veTNjRMAv3ZXbBLJGRwrB+1znktBexg@mail.gmail.com>
In-Reply-To: <CAHiYmc7NuEROi312sq_veTNjRMAv3ZXbBLJGRwrB+1znktBexg@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 9 Jun 2020 17:44:00 +0200
Message-ID: <CAL1e-=hChB-OpetJWLLXvHWWNgjn2ZGVrJcHB7FTWk45vTFPJQ@mail.gmail.com>
Subject: Re: [PULL 00/21] MIPS queue for June 7th, 2020
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=aleksandar.m.mail@gmail.com; helo=mail-ed1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 8, 2020 at 3:17 PM Aleksandar Markovic
<aleksandar.qemu.devel@gmail.com> wrote:
>
> =D0=BF=D0=BE=D0=BD, 8. =D1=98=D1=83=D0=BD 2020. =D1=83 15:05 Peter Maydel=
l <peter.maydell@linaro.org> =D1=98=D0=B5
> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> > On Sun, 7 Jun 2020 at 20:46, Aleksandar Markovic
> > <aleksandar.qemu.devel@gmail.com> wrote:
> > >
> > > The following changes since commit 175198ad91d8bac540159705873b4ffe4f=
b94eab:
> > >
> > >   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200605' i=
nto staging (2020-06-05 17:45:59 +0100)
> > >
> > > are available in the git repository at:
> > >
> > >   https://github.com/AMarkovic/qemu tags/mips-queue-june-07-2020
> > >
> > > for you to fetch changes up to ffbd8a88e8872d61fa5622a0075eddbe719510=
67:
> > >
> > >   target/mips: Enable hardware page table walker and CMGCR features f=
or P5600 (2020-06-07 21:34:14 +0200)
> > >
> > > ----------------------------------------------------------------
> > >
> > > MIPS queue for June 7th, 2020
> > >
> > > Highlights:
> > >
> > >   - Registring change of email address for two contributors
> > >   - Cleanup and improvements of FPU helpers
> > >   - Enabling some features of P5600
> > >   - Adding two Loongson-3A CPU definitions
> > >   - Moving futher towards Loongson-3A KVM support
> > >   - Two checkpatch warnings are known and should be ignored
> > >
> >
> > Hi; I'm afraid this fails to build on non-Linux hosts
> > (OSx, BSDs, Windows):
> >
> > hw/mips/common.c:21:23: fatal error: linux/kvm.h: No such file or direc=
tory
> >
> > Looking at that file, it also makes the mistake of putting
> > an include line before osdep.h, which should always be the
> > first include in a C file.
> >
> > The more usual way to arrange this kind of "real implementation
> > of a function for the compiled-with-KVM case, stub for
> > the #ifndef CONFIG_KVM case" is to put the real implementation
> > into a C file that's only built for the CONFIG_KVM case:
> > obj-$(CONFIG_KVM) +=3D whatever.o
> > (it may be simplest to just put it in the existing target/mips/kvm.c?)
> > and then either
> > (a) provide the non-kvm stub version directly in the .h file
> > that declares the prototype for the kvm case:
> > #ifdef CONFIG_KVM
> > int mips_kvm_type(MachineState *machine, const char *vm_type)
> > #else
> > static inline mips_kvm_type(MachineState *machine, const char *vm_type)
> > {
> >     return 0;
> > }
> > #endif
> > (b) alternatively put the stub code in a built-for-non-KVM
> > source file:
> > obj-$(call lnot,$(CONFIG_KVM)) +=3D kvm-stub.o
> >
> > i386, s390x and arm all have examples of this kind of "stub
> > version plus for-kvm version" function that may be useful
> > as examples.
> >
>
> Thanks for your detailed response and pointers!
>
> I am going to work with the original contributor on this.
>
> I am planning, of course, to send another, corrected, pull request,
> but not sooner than in 5-6 days.
>

I changed my mind. Since the offending patch is logically independent
from other patches and vice versa, I am going to send a pull request
this evening, without it, rather than wait for it to be fixed.

Truly yours,

Aleksandar


> Aleksandar
>
> > thanks
> > -- PMM
>

