Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B493C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 12:06:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6216E20818
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 12:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MIxgf5MJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6216E20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58697 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEBzp-0008Il-J1
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 08:06:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <skrtbhtngr@gmail.com>) id 1hEBz0-0007hB-Ds
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:05:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <skrtbhtngr@gmail.com>) id 1hEByz-0002kL-6Z
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:05:38 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <skrtbhtngr@gmail.com>)
	id 1hEByy-0002iy-SH
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 08:05:37 -0400
Received: by mail-wm1-x343.google.com with SMTP id 4so2332693wmf.1
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 05:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=H6arAZUCJAqn8Gp1x2euzhy3Wv5NCJO/Q1GzgeVPfNY=;
	b=MIxgf5MJ/U8K/voLn19+yuo4iMUIYFhwLRPtuERRfMJMkU5La/A+6FfsDTQsIwPKVl
	aODos8fjeEebOa/AsLxSj06SEFSBki6oOSxnAYmWdo7OybI1BHkDMU5fz/DP4bOckF7Q
	HUeVCJukZJ5UkKhi67IZKynOpovLn46URqfchHT5rQCOFnBcWXQJMEI84QyU9SEPrJEf
	6hP5NYvbIasdAQnHqr8hHGla2oHkadbucFMkZjvgZeuzLIXfK8WsoNzG69DWuVUaSIAJ
	L3JzMe9PlCYCrFh2HgE3lhIdKHA2VZ2JoFjhZO9cEzVmhHF+LZARRR9RER/DZF3Q4iTO
	GucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=H6arAZUCJAqn8Gp1x2euzhy3Wv5NCJO/Q1GzgeVPfNY=;
	b=mHCty+VEDiwNjaByEqS1OE2mX897CyYSDYzr+MakRdETegG8qtCuy8/ZUT+6FqMxsH
	xMldzK4MgFgPhvO4UILmxsUng7ORRLaUolxhZUf3lsMYul/QtvLhs7IFdUTp3xSEBYzm
	C64mSzkR7TBVo1Lapbd2wx56zFOPMh4hwdkj2qMJuikJBPMmskBZNNocMmJRvPV0Fx0Y
	ixZ+zGAd7sCB7dV90BvN/eRJsoHNiWQAdhUDwhkwZEJFaC4BVLz6jAcyXAAg4XGWfO2k
	ZphXq/Rbp5huF99a3lCHMBlFB1eNzehEEHiPLFsRVWWMUAvub89ZW6yiQ4grrXMhUm7/
	SA7g==
X-Gm-Message-State: APjAAAUFOShAstAOpN7UGhIi9BJr3FOovXrR7u94490bmHoseDFY0ms5
	rf0T6qw2vPB0pjLF2JFBaVY/D2I/FKfAtmlPvbU=
X-Google-Smtp-Source: APXvYqxbkX2aPNX2n6kkEacQftcWrY5PYBce7aYqEbpY3zoFJaEpSg94F4TFmslQ9qdqYfnr76miexiDzFxdKbC1u/c=
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr2410256wmg.56.1554897935175; 
	Wed, 10 Apr 2019 05:05:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190407115839.25054-1-skrtbhtngr@gmail.com>
	<20190407115839.25054-3-skrtbhtngr@gmail.com>
	<20190410115001.56bbbelcmxwcqp7v@SPB-NB-133.local>
In-Reply-To: <20190410115001.56bbbelcmxwcqp7v@SPB-NB-133.local>
From: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
Date: Wed, 10 Apr 2019 17:35:23 +0530
Message-ID:
 <CAMzgYoMqE20=L+n+tjt8Nb10Tidxr0C6OumQ8vvQ423xJxnN=w@mail.gmail.com>
To: Roman Bolshakov <r.bolshakov@yadro.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [PATCH RESEND v2 2/2] cpus: move
 hvf_cpu_synchronize* calls to cpu_synchronize* functions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
	Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410120523.F74M2urtHYiIu_8Wo3Gz6xSjjO7SY2EtV3-9pz6_XdY@z>

On Wed, 10 Apr 2019 at 17:20, Roman Bolshakov <r.bolshakov@yadro.com> wrote:
>
> On Sun, Apr 07, 2019 at 05:28:39PM +0530, Sukrit Bhatnagar wrote:
> > Keep the calls made to synchronize cpu by all hypervisors in one place
> > inside cpu_synchronize_* functions in include/sysemu/hw_accel.h
> >
> > Cc: Richard Henderson <rth@twiddle.net>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Sukrit Bhatnagar <skrtbhtngr@gmail.com>
> > ---
> >  cpus.c                    | 12 ------------
> >  include/sysemu/hw_accel.h | 10 ++++++++++
> >  2 files changed, 10 insertions(+), 12 deletions(-)
> >
> > diff --git a/cpus.c b/cpus.c
> > index e83f72b48b..026df0dc5f 100644
> > --- a/cpus.c
> > +++ b/cpus.c
> > @@ -1021,10 +1021,6 @@ void cpu_synchronize_all_states(void)
> >
> >      CPU_FOREACH(cpu) {
> >          cpu_synchronize_state(cpu);
> > -        /* TODO: move to cpu_synchronize_state() */
> > -        if (hvf_enabled()) {
> > -            hvf_cpu_synchronize_state(cpu);
> > -        }
> >      }
> >  }
> >
> > @@ -1034,10 +1030,6 @@ void cpu_synchronize_all_post_reset(void)
> >
> >      CPU_FOREACH(cpu) {
> >          cpu_synchronize_post_reset(cpu);
> > -        /* TODO: move to cpu_synchronize_post_reset() */
> > -        if (hvf_enabled()) {
> > -            hvf_cpu_synchronize_post_reset(cpu);
> > -        }
> >      }
> >  }
> >
> > @@ -1047,10 +1039,6 @@ void cpu_synchronize_all_post_init(void)
> >
> >      CPU_FOREACH(cpu) {
> >          cpu_synchronize_post_init(cpu);
> > -        /* TODO: move to cpu_synchronize_post_init() */
> > -        if (hvf_enabled()) {
> > -            hvf_cpu_synchronize_post_init(cpu);
> > -        }
> >      }
> >  }
> >
> > diff --git a/include/sysemu/hw_accel.h b/include/sysemu/hw_accel.h
> > index d2ddfb5ad0..bf081b4026 100644
> > --- a/include/sysemu/hw_accel.h
> > +++ b/include/sysemu/hw_accel.h
> > @@ -15,6 +15,7 @@
> >  #include "sysemu/hax.h"
> >  #include "sysemu/kvm.h"
> >  #include "sysemu/whpx.h"
> > +#include "sysemu/hvf.h"
> >
> >  static inline void cpu_synchronize_state(CPUState *cpu)
> >  {
> > @@ -27,6 +28,9 @@ static inline void cpu_synchronize_state(CPUState *cpu)
> >      if (whpx_enabled()) {
> >          whpx_cpu_synchronize_state(cpu);
> >      }
> > +    if (hvf_enabled()) {
> > +        hvf_cpu_synchronize_state(cpu);
> > +    }
> >  }
> >
> >  static inline void cpu_synchronize_post_reset(CPUState *cpu)
> > @@ -40,6 +44,9 @@ static inline void cpu_synchronize_post_reset(CPUState *cpu)
> >      if (whpx_enabled()) {
> >          whpx_cpu_synchronize_post_reset(cpu);
> >      }
> > +    if (hvf_enabled()) {
> > +        hvf_cpu_synchronize_post_reset(cpu);
> > +    }
> >  }
> >
> >  static inline void cpu_synchronize_post_init(CPUState *cpu)
> > @@ -53,6 +60,9 @@ static inline void cpu_synchronize_post_init(CPUState *cpu)
> >      if (whpx_enabled()) {
> >          whpx_cpu_synchronize_post_init(cpu);
> >      }
> > +    if (hvf_enabled()) {
> > +        hvf_cpu_synchronize_post_init(cpu);
> > +    }
> >  }
> >
> >  static inline void cpu_synchronize_pre_loadvm(CPUState *cpu)
> > --
> > 2.20.1
> >
> >
>
> Hi Sukrit,
>
> The commit itself looks sane but qemu starts to hang during BIOS boot
> after I've applied it if I run it with hvf accel.

Hi Roman,
Thanks for reviewing the patches.
If this is happening, then I assume patches are not ready
to be merged into qemu-stable.
Do you have any idea why the problem is not detected
during tests, but rather at runtime?
I am not really sure if this patch (2/2) has anything to do with
the problem but the previous patch (1/2) might.

> Thanks,
> Roman

