Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83240C35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:02:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A981214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 22:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vjE/8XjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A981214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46975 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izpEc-0003qM-Ea
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 17:02:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <beata.michalska@linaro.org>) id 1izotn-0006SE-SV
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:41:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <beata.michalska@linaro.org>) id 1izotm-0002SP-BZ
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:41:23 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46702)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <beata.michalska@linaro.org>)
 id 1izotm-0002Ot-5y
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 16:41:22 -0500
Received: by mail-io1-xd43.google.com with SMTP id t26so7907921ioi.13
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 13:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kvVxq0r49Mqq4asBVI4NCDYI19hcfdO7wI2SNt5QJ9A=;
 b=vjE/8XjLWPicwX3CFGOsQ5nQfZDB9lS8l3stAVjyHSX8MRXbbJI/amrcU3tHU4Ncps
 cl45EDIGEtj2/UFLWMZCUhFXtjepvTsqql0gZ5VjYzm1iclCwBeb6UxtlkD5taX4JsAQ
 BmVIZOvjZs8kY+WubZYYJJ3c9DPHocNPaHwlV7o4J3uoBPDC+nHPgzdIC7f+0y0Db74l
 HnNWsNIIJjBB92rBK3mZtnlVYxpFAQ9b5SCkFEhfq9vXcclk1MIsqKKZPnvyRUHaEK1v
 GFuk4WluePJbRl4cqniAephhkFK5Cgn3woOhCxnZoSZbQV6Jebx6jVaRVFGH1U0TYGP4
 wZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kvVxq0r49Mqq4asBVI4NCDYI19hcfdO7wI2SNt5QJ9A=;
 b=Kc1QAIMLraYlJBnpSqSqkzWfCaAJodkglTbtD6GEV9FmQOZWC/saIzNTqh5Q8WOsoU
 k1TNQ8KCAIiJXSspJ0zHtsSw15WeM26wkdWCH7NnjAc8VWPrTas+xSmzcYTTlBKKifoQ
 Rk8LEZ6CM5/LC43bTn8HYE6CWe+BMT+8Xl6Cgjj0PO6xArN+QUMQYOsDeynfb1WfwIEJ
 5Wrmi1TwH/YYzUPke+jStUd7LFPMZ0ScyjwwggLCc2noxj26GhNmdodl+wkPfdIjERoG
 kPTve2mwe5+rjxaE6eQp9OBHmlnPKwVMj4icayOjO3+kfs430CSvL6T6aBXBOlx/paFx
 lTrw==
X-Gm-Message-State: APjAAAVTcyd2jPkfLpKTbgjJbUwkRu2Py7id9Ft/IoN/21v7YqRrAq0h
 kkMiUyiE5IEtHyX3oiMWkLjfBOl2dWj5b3fmDY1QGg==
X-Google-Smtp-Source: APXvYqyQCDWRRpkhqSVdBthGBigb1aUxsXt/uKE8cjGefkWSNZ4y57QZWPFq81DWzm7nnWwQEmDdLQcVncVKiCGHbaI=
X-Received: by 2002:a5d:9255:: with SMTP id e21mr280183iol.260.1581025280987; 
 Thu, 06 Feb 2020 13:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20200129202441.12745-1-beata.michalska@linaro.org>
 <20200129202441.12745-2-beata.michalska@linaro.org>
 <20200204103447.naw26xl2y2zbyrqb@kamzik.brq.redhat.com>
In-Reply-To: <20200204103447.naw26xl2y2zbyrqb@kamzik.brq.redhat.com>
From: Beata Michalska <beata.michalska@linaro.org>
Date: Thu, 6 Feb 2020 21:41:10 +0000
Message-ID: <CADSWDzuQvZThaoFbeYM2QrDbwRPrZuiyDrVJV=jxiSMTW9O-rg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/arm: kvm: Inject events at the last stage
 of sync
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
 Christoffer Dall <Christoffer.Dall@arm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Feb 2020 at 10:34, Andrew Jones <drjones@redhat.com> wrote:
>
> On Wed, Jan 29, 2020 at 08:24:40PM +0000, Beata Michalska wrote:
> > KVM_SET_VCPU_EVENTS might actually lead to vcpu registers being modified.
> > As such this should be the last step of sync to avoid potential overwriting
> > of whatever changes KVM might have done.
> >
> > Signed-off-by: Beata Michalska <beata.michalska@linaro.org>
> > ---
> >  target/arm/kvm32.c | 20 ++++++++++----------
> >  target/arm/kvm64.c | 20 ++++++++++----------
> >  2 files changed, 20 insertions(+), 20 deletions(-)
> >
> > diff --git a/target/arm/kvm32.c b/target/arm/kvm32.c
> > index 32bf8d6..cf2b47f 100644
> > --- a/target/arm/kvm32.c
> > +++ b/target/arm/kvm32.c
> > @@ -386,17 +386,17 @@ int kvm_arch_put_registers(CPUState *cs, int level)
> >          return ret;
> >      }
> >
> > -    ret = kvm_put_vcpu_events(cpu);
> > -    if (ret) {
> > -        return ret;
> > -    }
> > -
> >      write_cpustate_to_list(cpu, true);
> >
> >      if (!write_list_to_kvmstate(cpu, level)) {
> >          return EINVAL;
> >      }
> >
> > +    ret = kvm_put_vcpu_events(cpu);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
>
> I think we should put a comment above this that says basically the same
> thing as the commit message in order to explain why kvm_put_vcpu_events()
> *must* be after write_list_to_kvmstate().
>
Will do that.

> >      kvm_arm_sync_mpstate_to_kvm(cpu);
> >
> >      return ret;
> > @@ -462,11 +462,6 @@ int kvm_arch_get_registers(CPUState *cs)
> >      }
> >      vfp_set_fpscr(env, fpscr);
> >
> > -    ret = kvm_get_vcpu_events(cpu);
> > -    if (ret) {
> > -        return ret;
> > -    }
> > -
> >      if (!write_kvmstate_to_list(cpu)) {
> >          return EINVAL;
> >      }
> > @@ -475,6 +470,11 @@ int kvm_arch_get_registers(CPUState *cs)
> >       */
> >      write_list_to_cpustate(cpu);
> >
> > +    ret = kvm_get_vcpu_events(cpu);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
>
> Why are we moving kvm_get_vcpu_events()?

This is only to make things consistent with put_registeres.
There is no functional change per se.

BR

Beata

> >      kvm_arm_sync_mpstate_to_qemu(cpu);
> >
> >      return 0;
> > diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
> > index 6344113..d06fd32 100644
> > --- a/target/arm/kvm64.c
> > +++ b/target/arm/kvm64.c
> > @@ -1043,17 +1043,17 @@ int kvm_arch_put_registers(CPUState *cs, int level)
> >          return ret;
> >      }
> >
> > -    ret = kvm_put_vcpu_events(cpu);
> > -    if (ret) {
> > -        return ret;
> > -    }
> > -
> >      write_cpustate_to_list(cpu, true);
> >
> >      if (!write_list_to_kvmstate(cpu, level)) {
> >          return -EINVAL;
> >      }
> >
> > +    ret = kvm_put_vcpu_events(cpu);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> >      kvm_arm_sync_mpstate_to_kvm(cpu);
> >
> >      return ret;
> > @@ -1251,11 +1251,6 @@ int kvm_arch_get_registers(CPUState *cs)
> >      }
> >      vfp_set_fpcr(env, fpr);
> >
> > -    ret = kvm_get_vcpu_events(cpu);
> > -    if (ret) {
> > -        return ret;
> > -    }
> > -
> >      if (!write_kvmstate_to_list(cpu)) {
> >          return -EINVAL;
> >      }
> > @@ -1264,6 +1259,11 @@ int kvm_arch_get_registers(CPUState *cs)
> >       */
> >      write_list_to_cpustate(cpu);
> >
> > +    ret = kvm_get_vcpu_events(cpu);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> >      kvm_arm_sync_mpstate_to_qemu(cpu);
> >
> >      /* TODO: other registers */
> > --
> > 2.7.4
> >
> >
>
> Same comments for kvm64.c as for kvm32.c
>
> Thanks,
> drew
>

