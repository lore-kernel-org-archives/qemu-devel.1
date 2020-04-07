Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41760C2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08E8B2063A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 11:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQ6c8ZHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08E8B2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLmU8-0006Iu-7i
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 07:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1jLmTB-00050b-3D
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1jLmT9-0005nE-VW
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:32:41 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:39677)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1jLmT9-0005mT-RN
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 07:32:39 -0400
Received: by mail-il1-x142.google.com with SMTP id r5so2816623ilq.6
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2020 04:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ig2mq+AH5o0UP+b5KHhG9X0qqULQtiCnJDgxb4T5GVk=;
 b=iQ6c8ZHWKobiDdIZ3BcuUVM0Xewv31lvkznxohyjVKNlwXhELtKc0lVBLTq+EkrGvX
 0PneZH0rNVtsHE9O/beClqQx0aSDvFy8T8+/Lnb3xQy3P4YtyOtfaEBCCzMB29yCUH76
 3VJflY4XMe13gSIYOlwt8gmsbZFAGgOn+p9Cif2RL5HPVbG4K1nQ6Aohgh1olbcWOR3g
 eGnvSdmsEJ6d8cM8oHht5zQCtknJJuAeH9E/2rS9d5wHwb0dOT06x1Ka526c839KAtWA
 OTu6qp8WBlp+lmgK1vJL5L2BasL/gtpRzVEF1kPHqYPmPIn+aiMnLU7Kb5w2UWQ7Holj
 /p3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ig2mq+AH5o0UP+b5KHhG9X0qqULQtiCnJDgxb4T5GVk=;
 b=mTDMvLklAMzzd0NSoHPEZq9DFv5GjeXSNKArQGFY3afkYRrZs3sdcsALKJdE6qw3zp
 RcetLa83CV2InSY3IrbDUKjxOZLcVCDaA3t0NGKqk0z9MaKR6arWMpTCKcapfljJ8C6F
 mNpoV4kXDFcIT9/0fduPNxqj1uNiy2s9DGJf+ZGI5PLRohQmqyalRuQiTvl7vn4cKVfy
 Z1FeUnP9lXX1Hy9lmBazYHKT1zXsj4+tSYTpz/FSTN2xx92mJ16i2laZXTPP2hYxp9Jl
 DGFo218ByTNoCmvDYG4ig7c+UycQhJRCcxUGNmtFvfeZ6AoXEgUeTNBZxJViU7SC7YIs
 uzxw==
X-Gm-Message-State: AGi0Puba8hRyjXQPPkgbNSv50p3yh5fe3WxCk9tJrVzP0UUwwumuR+sx
 79XkoYHITwOOOZ86Eor3lnCS1lGsZHMSkdT0YHOtvg==
X-Google-Smtp-Source: APiQypLPwRgW4x4+sMjDp/TWI4NTo7d5tYyS36ZSVaDFbxEF/D5s3AnWWgYm2v2l2t9PPVUgnprj5uycuII70QtXf4Q=
X-Received: by 2002:a92:3a8c:: with SMTP id i12mr1977302ilf.69.1586259159061; 
 Tue, 07 Apr 2020 04:32:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200323113227.3169-1-beata.michalska@linaro.org>
 <20200323113227.3169-3-beata.michalska@linaro.org>
 <20200403084435.zvfewiivn7orsnll@kamzik.brq.redhat.com>
 <CAFEAcA8fMzWhvt0R9MhXuLYb4Wo+Yz484HNC9YAE59yxz5xD0w@mail.gmail.com>
In-Reply-To: <CAFEAcA8fMzWhvt0R9MhXuLYb4Wo+Yz484HNC9YAE59yxz5xD0w@mail.gmail.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Tue, 7 Apr 2020 12:32:28 +0100
Message-ID: <CADSWDzsmpeXVKjDT7jKnx2XN18EWNOPsYJuxEUytofq8VZePww@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] target/arm: kvm: Handle potential issue with dabt
 injection
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000b2abce05a2b1bd16"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::142
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
Cc: Andrew Jones <drjones@redhat.com>,
 Christoffer Dall <Christoffer.Dall@arm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b2abce05a2b1bd16
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Apr 2020 at 12:24, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 3 Apr 2020 at 09:44, Andrew Jones <drjones@redhat.com> wrote:
> >
> > On Mon, Mar 23, 2020 at 11:32:27AM +0000, Beata Michalska wrote:
> > > Injecting external data abort through KVM might trigger
> > > an issue on kernels that do not get updated to include the KVM fix.
> > > For those and aarch32 guests, the injected abort gets misconfigured
> > > to be an implementation defined exception. This leads to the guest
> > > repeatedly re-running the faulting instruction.
> > >
> > > Add support for handling that case.
> > > [
> > >   Fixed-by: 018f22f95e8a
> > >       ('KVM: arm: Fix DFSR setting for non-LPAE aarch32 guests')
> > >   Fixed-by: 21aecdbd7f3a
> > >       ('KVM: arm: Make inject_abt32() inject an external abort
instead')
> > > ]
> > >
>
> > I'll leave the decision to take this KVM bug workaround patch at all to
Peter,
> > and I didn't actually review whether or not
kvm_arm_verify_ext_dabt_pending
> > is doing what it claims it's doing, so I'm reluctant to give an r-b on
> > this patch. But, as far as the code goes, besides the comments above, it
> > looks fine to me.
>
> I think that having the workaround for the broken kernels is
> reasonable (in fact it might have been my suggestion).
>

I will update the current version to cover the review feedback
and resend the patches soon.

Thanks a lot!

BR
Beata
> thanks
> -- PMM

--000000000000b2abce05a2b1bd16
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div><br>
<br>
On Tue, 7 Apr 2020 at 12:24, Peter Maydell &lt;<a href=3D"mailto:peter.mayd=
ell@linaro.org" target=3D"_blank">peter.maydell@linaro.org</a>&gt; wrote:<b=
r>
&gt;<br>
&gt; On Fri, 3 Apr 2020 at 09:44, Andrew Jones &lt;<a href=3D"mailto:drjone=
s@redhat.com" target=3D"_blank">drjones@redhat.com</a>&gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; On Mon, Mar 23, 2020 at 11:32:27AM +0000, Beata Michalska wrote:<=
br>
&gt; &gt; &gt; Injecting external data abort through KVM might trigger<br>
&gt; &gt; &gt; an issue on kernels that do not get updated to include the K=
VM fix.<br>
&gt; &gt; &gt; For those and aarch32 guests, the injected abort gets miscon=
figured<br>
&gt; &gt; &gt; to be an implementation defined exception. This leads to the=
 guest<br>
&gt; &gt; &gt; repeatedly re-running the faulting instruction.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Add support for handling that case.<br>
&gt; &gt; &gt; [<br>
&gt; &gt; &gt;=C2=A0 =C2=A0Fixed-by: 018f22f95e8a<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(&#39;KVM: arm: Fix DFSR setting f=
or non-LPAE aarch32 guests&#39;)<br>
&gt; &gt; &gt;=C2=A0 =C2=A0Fixed-by: 21aecdbd7f3a<br>
&gt; &gt; &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0(&#39;KVM: arm: Make inject_abt32(=
) inject an external abort instead&#39;)<br>
&gt; &gt; &gt; ]<br>
&gt; &gt; &gt;<br>
&gt;<br>
&gt; &gt; I&#39;ll leave the decision to take this KVM bug workaround patch=
 at all to Peter,<br>
&gt; &gt; and I didn&#39;t actually review whether or not kvm_arm_verify_ex=
t_dabt_pending<br>
&gt; &gt; is doing what it claims it&#39;s doing, so I&#39;m reluctant to g=
ive an r-b on<br>
&gt; &gt; this patch. But, as far as the code goes, besides the comments ab=
ove, it<br>
&gt; &gt; looks fine to me.<br>
&gt;<br>
&gt; I think that having the workaround for the broken kernels is<br>
&gt; reasonable (in fact it might have been my suggestion).<br>
&gt;<br>
<br></div><div>
I will update the current version to cover the review feedback<br>
and resend the patches soon.<br>
<br>
Thanks a lot!<br>
<br>
BR<br>
Beata<br>
&gt; thanks<br>
&gt; -- PMM<br>
</div>

--000000000000b2abce05a2b1bd16--

