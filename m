Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF5AC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:25:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C78D32051A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EbXmjYLX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C78D32051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmMI-0001Mq-TF
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51736)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jLmLa-0000in-Ke
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jLmLZ-0006QX-HW
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:24:50 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jLmLZ-0006Pi-BJ
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:24:49 -0400
Received: by mail-ot1-x344.google.com with SMTP id t28so2700746ott.5
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 04:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vnASXYJpk92WfwXwrbznymfvmBuY/sr1MK3eKQbxoXM=;
 b=EbXmjYLXGFUiUbEFtAJaqtqhT8nbqdKnXm7EOymQju+AN8pQQ7Ef53P0WOOAz16/PG
 Dwd+qvFdFskuTztzBDkxAQ8oIOAUb5IOCREHuwCc6T1J6BjZ3E83XY0BC0gbQA7anguE
 7equgXH3Dlk69uqnIdhQCFtIory02zJbM6DSdr6koV4uIad58tXvm86vsgIhf4svgyaA
 ct+y1lHmlF399tLELCzzLxND8iNu7DFOfzbTskxZSIXqWJqXMRTa9gSt+hJrbMpNbFCX
 8E7wC/KDBPfnUiuIg3eBSQ1K7PfcTt+X8u5cOccwt+9o5HveC1KRIzcSuC4dwrz32k8j
 gnug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vnASXYJpk92WfwXwrbznymfvmBuY/sr1MK3eKQbxoXM=;
 b=O7OUufCMKzFisp2IkJEWACrD6bYGfcvvo9mT2jHPToLaWXPoYouVl2vi13aSJAX5tx
 1X8Ae1v5/MWn8Vi4YR9CruCGm5HHO1MLjBZ2yk1qBgAbyQyIBaSB/K6YmTjNgw7SCFWg
 EPeDWNbzdgeOSP4DZE9wtf0CqpeQCbVYocqWlGEvsXme5HzgDvcRDje+1WP6kNKoRWIi
 bYTPhZsHxWrI4htEWtAyYbg9PG9XjLUcTe4rdWQozsObLdrbvsC/T7FfhDa4TYxUtzmm
 aqg0wcSoXLQYjWE1ofOeiTKiu+P4dHczY0wilneUIjFuRbc/ogeAL8ZbXncUMzOkLdwi
 Bb9A==
X-Gm-Message-State: AGi0PuZCXEbuKe2P6xVAiP+Z0Hs/RmQINf42oeSNdTlTpDgAOaefhkXg
 LiqMf1l3UghqMC0jQApGqmj7M7n1UoMFNZyQEyu+4g==
X-Google-Smtp-Source: APiQypLWArKPOw0PZD0smR06050zJ9zXEwIyOsNwy140j1L7le0lK5rWjGL3mSPfonZ9BgjeU4/rxN8//gDG9fPJWLw=
X-Received: by 2002:a4a:2a09:: with SMTP id k9mr1439312oof.64.1586258688530;
 Tue, 07 Apr 2020 04:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200323113227.3169-1-beata.michalska@linaro.org>
 <20200323113227.3169-3-beata.michalska@linaro.org>
 <20200403084435.zvfewiivn7orsnll@kamzik.brq.redhat.com>
In-Reply-To: <20200403084435.zvfewiivn7orsnll@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Apr 2020 12:24:37 +0100
Message-ID: <CAFEAcA8fMzWhvt0R9MhXuLYb4Wo+Yz484HNC9YAE59yxz5xD0w@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] target/arm: kvm: Handle potential issue with dabt
 injection
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Beata Michalska <beata.michalska@linaro.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Apr 2020 at 09:44, Andrew Jones <drjones@redhat.com> wrote:
>
> On Mon, Mar 23, 2020 at 11:32:27AM +0000, Beata Michalska wrote:
> > Injecting external data abort through KVM might trigger
> > an issue on kernels that do not get updated to include the KVM fix.
> > For those and aarch32 guests, the injected abort gets misconfigured
> > to be an implementation defined exception. This leads to the guest
> > repeatedly re-running the faulting instruction.
> >
> > Add support for handling that case.
> > [
> >   Fixed-by: 018f22f95e8a
> >       ('KVM: arm: Fix DFSR setting for non-LPAE aarch32 guests')
> >   Fixed-by: 21aecdbd7f3a
> >       ('KVM: arm: Make inject_abt32() inject an external abort instead')
> > ]
> >

> I'll leave the decision to take this KVM bug workaround patch at all to Peter,
> and I didn't actually review whether or not kvm_arm_verify_ext_dabt_pending
> is doing what it claims it's doing, so I'm reluctant to give an r-b on
> this patch. But, as far as the code goes, besides the comments above, it
> looks fine to me.

I think that having the workaround for the broken kernels is
reasonable (in fact it might have been my suggestion).

thanks
-- PMM

