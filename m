Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D735ACA9EAB
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A57F8222C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 14:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WZofIa95"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A57F8222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40860 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLTC3-00030D-Tm
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 10:25:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59334)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLT2A-0001B3-JM
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:15:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLT27-00017D-2L
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:15:13 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45157)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLT26-00016R-PP
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 10:15:11 -0400
Received: by mail-ot1-x341.google.com with SMTP id 41so5055438oti.12
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 07:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BlzVq9+AMGPMLacU+sHt4TVQEGsqdmskKDXy04V2Qzs=;
 b=WZofIa95/FTHmkB8x7VD6Ktf6GtQV9BhvAea/yTP9iVgNI0eA1B3gLvenwWsVx+Jk6
 fuxKwiVxpr5piRzmMGE9nSx7wggey4npfbAJrOHMNkfR52rhpSix4iiQ+4pzTCB9y/TZ
 Z3Mu5tONxX66idmr/pAlBPzNiCUm6x9bPSAIvWU9hsh36ul+0RncEfShObwnWrMJen5n
 hvY2T7uUjOHTfu+EzPjKP0tLk24oFQTFodgiDFXaBO5EtHeJSFEBORBqI+ka+GPHxlDY
 dDZ6AIjd6TF5ulYl0EUS9U9s+nWdfrMw/cCxSuryoo7wHGBd8DhP2jK7l+Fid+UdCxw8
 FnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BlzVq9+AMGPMLacU+sHt4TVQEGsqdmskKDXy04V2Qzs=;
 b=dXUrXMsCXfnXo4fvwb9QWB1kGLJi50PlIyq9bAUI4K7A4CtKjuKV4zgQx/HCsVEjq9
 M/enxmWJxvUDOuhmygn0Ft/Ff6GkAK/PMd9Q5kOhkWtPB5DGOfqTW3C4GlIkWzk/S1iU
 sqRZgAFD4ee3NXGCAO5qKPs2FrXLKJVJYb9OQH/wQhEEHnJLEEwt7jgum9nV5orU3/JT
 nliM/KU4Ez6vhPqpkvYiLy3CrFORydoPgeXj/nBqQWNlpI4VWUiyWk7JU3WUedbP4wBU
 XpG3Ou0KYCtvjor8csBPDky7glhPajI0jyqYvYrjcJw+pS4EfR5ezu3RkI0GLO05ylPR
 y/Mg==
X-Gm-Message-State: APjAAAVPVHEpFwDLBqzTisaB9fhsLDbbws+UWsHS7ynyPPoo2uDN/84j
 Jf4iRBqAW0hEyzbQo5s+havwgGJUz5+rJCmXUGC0sA==
X-Google-Smtp-Source: APXvYqxmRs6lJ7HKwGlRS8aZCELuJQde1hwF4eHTi+7gqbg2MG4U6I1FqT9pVpvBNES8CACWbZ7ryIYDeWs5+hYOhAQ=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr8028707otg.91.1571408109768;
 Fri, 18 Oct 2019 07:15:09 -0700 (PDT)
MIME-Version: 1.0
References: <20191017151606.GA1880840@orkuz.int.mamuti.net>
 <82ea23ea-be23-c374-3f10-65d8f6e79432@redhat.com>
 <CAFEAcA-pkD_LCh++TWoO77=Bu9mYe7HOkaeyCXjLopAmqhpi-g@mail.gmail.com>
 <20191018140219.GS4204@orkuz.int.mamuti.net>
In-Reply-To: <20191018140219.GS4204@orkuz.int.mamuti.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 15:14:57 +0100
Message-ID: <CAFEAcA-JAvQOyW8dsmf1sVzv6JvqUe2w-EtBgT3Jsx5Hgq11Pg@mail.gmail.com>
Subject: Re: Default CPU models on s390x and ppc64
To: Jiri Denemark <jdenemar@redhat.com>
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
Cc: David Gibson <dgibson@redhat.com>, David Hildenbrand <dhildenb@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 15:02, Jiri Denemark <jdenemar@redhat.com> wrote:
>
> On Thu, Oct 17, 2019 at 17:13:10 +0100, Peter Maydell wrote:
> > On Thu, 17 Oct 2019 at 17:09, David Hildenbrand <david@redhat.com> wrote:
> > > The default model under KVM is "host", under TCG it's "qemu". We should
> > > not use "qemu" under KVM, although it might work on some setups ...
> >
> > Possibly a tangent, but on Arm the approach we used to deal
> > with "'-cpu host' only works for kvm" was to define a "-cpu max"
> > meaning "best thing you can give me", which is an alias for
> > -cpu host with KVM and an alias for a CPU with all the extra
> > features we have emulation support under TCG. Then users can
> > use '-cpu max' and have something that generally will DTRT
> > regardless of accelerator.
>
> This thread is not really about a CPU model that users could universally
> use for both TCG or KVM. It's about checking what CPU model is used by
> QEMU if no CPU model is specified on the command line.

Yes, but the default CPU model if none is specified should ideally
not be one which only works with one accelerator (among other
things, that makes it more complicated to implement and to probe for
because you need to ensure it's set after the accelerator is
selected and that if you're probing that you've told QEMU what
the accelerator type is).

> BTW, I was told aarch64 is a bit different and QEMU fails to start with
> KVM unless -cpu host is explicitly specified. Is that correct?

Either -cpu host or -cpu max will work. If your host is a real
Cortex-A57 then I think -cpu cortex-a57 will work; similarly
with -cpu cortex-a53 on a host A53. (The underlying constraint
here is that the kernel doesn't support "claim to the guest
that it is running on some different CPU than the host CPU",
so you can't use command line options or defaults that would
require that.) 32-bit arm is similar. The other point to note
is that the "virt" board's default CPU is Cortex-A15 for
historical reasons, which means that in practice if you want
to use 64-bit KVM you don't want the default value.

thanks
-- PMM

