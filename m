Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE5EC54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:53:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31C4A20706
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 12:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wqxIct9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31C4A20706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRxpG-0004UW-Bq
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 08:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39540)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRxoB-0003Kx-El
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:51:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jRxoA-0006ET-Hw
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:51:54 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:34128)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jRxoA-000643-0E
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:51:54 -0400
Received: by mail-ot1-x342.google.com with SMTP id 72so12157706otu.1
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2020 05:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BsEj32339N9txHinFeBr5Cb+eAcnXuu4GyaJJlDL5Xs=;
 b=wqxIct9Vdjf7GbHCvxT1MiYpyTH0iAANjm65ib62bdKmXkUFNwoH2Qatz7paLYpEO6
 c8ejTE1n7IOdE0xpR1JZ964Wruoe4AnvsicWutEUYnYyXvBPd5VQJU27WIB4DvbiNola
 tOM73Fbegx5pg82i/NIfns4e8hHRtQPQ/GwRtkdcOOS7RzrjyWCH8+DvFVum3qwN+DSo
 dTj+8o+oBPvoRwzU27lj7r7bmSkFdomSepa92imc2kjiWvj/JQ+dKmXYoQ59r0MJ9JOq
 QaFwmXR/aq8u6x8OPS3EPk8Y5nigIYZ1Y/A0EXvIr/ixnBJ8FFCwgcZzIzfwmJrSrvtu
 zS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BsEj32339N9txHinFeBr5Cb+eAcnXuu4GyaJJlDL5Xs=;
 b=au36xvhQi231yZCMxIKDcK864NK9+OzEdM9qE2xo09hVzLfTEKNzZfUJ/pSFNai+bP
 NDyUO7PbpbbmckRSwb3PPTyVyRCGhgfPwI/PXb7Yl/EgbM2UqpYAFnRUbuVIEg8+VJ6e
 ivvahxms7wu3+tKcUAMP8dpht9kUstjk6PeRTG0LxZOnpEVLnDnk0zOQiW9DxdwQfc9L
 Bf9WCdC34XzIVZKLQ8+OVX0l82Pnq1dCKj8g/nUHgiE97BH/witanjPPEGmU9or4JFiy
 p7eDUjIRto685+E2+VEYRvY95UYzFEKKReESQftOcZDa8d4YSZ3HGeeLAemEl9VXwXFL
 3B6A==
X-Gm-Message-State: AGi0Pub33q71u7lgUpZDze64flT6U1nEwNF0JMwINLFwWjsWtC16CS7F
 tlprh4Ri+9jJ+rYgaz4aUO7FyVUHDcRIcznYqZWO7g==
X-Google-Smtp-Source: APiQypKVnLFNwVY5t00WPhM8z2bI07Ju/0ZayiLrA0S2LuuZ0G6FoJm2Y+qAfl22SkFy5bl1uyAiEYaOFIvxHt3Z4Ps=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr7769127otb.135.1587732712601; 
 Fri, 24 Apr 2020 05:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200323113227.3169-1-beata.michalska@linaro.org>
 <20200323113227.3169-2-beata.michalska@linaro.org>
 <CAFEAcA_uWS+cVRk=BKra8AhsD+B1syVzhXeCMttSKwQDdo=j3w@mail.gmail.com>
 <20200417131032.lcyunbjwofsn2nzz@kamzik.brq.redhat.com>
 <20200424121633.GF3106@work-vm>
In-Reply-To: <20200424121633.GF3106@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Apr 2020 13:51:41 +0100
Message-ID: <CAFEAcA9055qMOMDubpRf+XS4RwtbYEVFqQf-nhPd8T087aCdHg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] target/arm: kvm: Handle DABT with no valid ISS
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::342
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
 Beata Michalska <beata.michalska@linaro.org>,
 Juan Quintela <quintela@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Apr 2020 at 13:17, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Andrew Jones (drjones@redhat.com) wrote:
> > On Fri, Apr 17, 2020 at 11:39:25AM +0100, Peter Maydell wrote:
> > > I was trying to work out whether we need to migrate this state,
> > > and I'm not sure. Andrew, do you know? I think this comes down
> > > to "at what points in QEMU's kvm run loop can migration kick in",
> > > and specifically if we get a KVM_EXIT_ARM_NISV do we definitely
> > > go round the loop and KVM_RUN again without ever checking
> > > to see if we should do a migration ?
> > >
> >
> > I'd prefer a migration expert confirm this, so I've CC'ed David and Juan,
> > but afaict there's no way to break out of the KVM_RUN loop after a
> > successful (ret=0) call to kvm_arch_handle_exit() until after the next
> > KVM_RUN ioctl. This is because even if migration kicks the vcpus between
> > kvm_arch_handle_exit() and the next run, the signal won't do anything
> > other than prepare the vcpu for an immediate exit.
>
> This is a level I've not looked at I'm afraid.
> However, the point at which we're saving the vCPU state is when the
> vCPUs are stopped; so as long as your state that you save is everything
> you need to restart and you migrate that then you should be OK; but in
> the end fromt he migration point of view we just stop the VM and ask for
> each devices state.

Yeah, but I think the question is "at what point in the main loop
do we check 'is the VM stopping'". It sounds from what Andrew
says that the answer is that it can't happen at this point in
time, though.

thanks
-- PMM

