Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B0EC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 03:13:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087FC20EDD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 03:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oq+cS0qa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087FC20EDD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFqXc-0001kC-WA
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 23:13:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36416)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFqWz-0001Bd-5w
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 23:12:21 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:41785)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kFqWw-0004ws-MS
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 23:12:20 -0400
Received: by mail-io1-xd41.google.com with SMTP id z13so1629404iom.8
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 20:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yletO5DQ3uAqjd/u7Mgx8CUZLUxS9FAu0MROdwszHrY=;
 b=oq+cS0qao9CRcs7q/yMYo/4ExcoSQbtfSQQke8OBjD47vUSgKP75cZ3inYwGl03Ive
 2QvZOTalWiU3UcwWSIyuzFaTx9g81PM+1JONJLDRHPe4gS7bU+j+xf1mltWBxeLVU36/
 WbNj878UEDJo9w50G7B/jPyEeN5MmAQfehPfBHxitvnHVJhnU3zr10/2nCFAwSlMjYev
 GnWbivNvxvmnHzyuu4G5xi9/tXz46JWDSnhc/LuUzok+FnrKvx6QbGiNLu25fXGWmuda
 c43tWqn3/M3zmZeer+YhZlicwoUBgfxfYsnlj7KXB+H695h30s7iV5Uip48wOniJ5VG+
 Kfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yletO5DQ3uAqjd/u7Mgx8CUZLUxS9FAu0MROdwszHrY=;
 b=toRM0iMEOjmaQDHcYjxuKHfYaFpKmmNCNw5RXy7rkmTOZke5TvnJbrdSDljz84KgrS
 5RZ8lIqXXNLd98xLJcz4O4pZ1buCHWNXAl4oy32j+3eX4ExMzwAVD4LU78stMzrnQ+SZ
 nNpa6ylMxGOXbnufGGV1KelWFDl6VOL9is9+JjeTWi+Ve4HQtlBXtkG/1iVuJ42QSaSz
 b64gRiCGx+B6MDo69ZRWYReQ1WCAC5hl4KvSK0blhqGwlKTldVwtnDSYYgI0RJntyZXc
 N9GLM3SxdzAuhldu3qQ8DC353oiHY6+UjYGIeZ92iRS+2DBbw0oe0nZuW5C5oWoD9SaO
 bGEg==
X-Gm-Message-State: AOAM531WTgI7/nSPBVsB3IppMDV6fpvdLMHe7Hrve6MXnExH1N3tMxI1
 IjVFZ+dDCmJM5NIahAnnCLvleqp6k2ySyUCENZGx
X-Google-Smtp-Source: ABdhPJwLPE7PJ4UQLtYQYkbbhhJSW07bOT2mAvnzF2HFxDWIU0kfJgUY+vxloQ2u0lGFWjLRhrR/Kr8zTrA8DMnmwno=
X-Received: by 2002:a05:6602:2201:: with SMTP id
 n1mr1731696ion.35.1599621137242; 
 Tue, 08 Sep 2020 20:12:17 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1599549462.git.haibo.xu@linaro.org>
 <6aaa406b824d0c427acbc3f3abfbbe841f3bb93c.1599549462.git.haibo.xu@linaro.org>
 <20200908113458.2fdhbs7lpw63fvnv@kamzik.brq.redhat.com>
In-Reply-To: <20200908113458.2fdhbs7lpw63fvnv@kamzik.brq.redhat.com>
From: Haibo Xu <haibo.xu@linaro.org>
Date: Wed, 9 Sep 2020 11:12:06 +0800
Message-ID: <CAJc+Z1EoJH3KXE65LESOU_ZRcn9zdY8hbTsye8ZaM+e==s103g@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] target/arm/kvm: spe: Enable userspace irqchip
 support.
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=haibo.xu@linaro.org; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: philmd@redhat.com, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 8 Sep 2020 at 19:35, Andrew Jones <drjones@redhat.com> wrote:
>
> On Tue, Sep 08, 2020 at 08:13:29AM +0000, Haibo Xu wrote:
> > Since the current kernel patches haven't enabled the
> > userspace irqchip support, this patch is not verified yet!
> >
> > Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
> > ---
> >  linux-headers/linux/kvm.h | 1 +
> >  target/arm/kvm.c          | 5 +++++
> >  2 files changed, 6 insertions(+)
> >
> > diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> > index 8840cbb01c..35ef0ae842 100644
> > --- a/linux-headers/linux/kvm.h
> > +++ b/linux-headers/linux/kvm.h
> > @@ -1672,6 +1672,7 @@ struct kvm_assigned_msix_entry {
> >  #define KVM_ARM_DEV_EL1_VTIMER               (1 << 0)
> >  #define KVM_ARM_DEV_EL1_PTIMER               (1 << 1)
> >  #define KVM_ARM_DEV_PMU                      (1 << 2)
> > +#define KVM_ARM_DEV_SPE                      (1 << 3)
>
> kernel header changes should be separate patches
>

Will move this line to patch 01 in v3.

Thanks,
Haibo

> >
> >  struct kvm_hyperv_eventfd {
> >       __u32 conn_id;
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index 58f991e890..7950ff1d83 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -820,6 +820,11 @@ MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
> >              switched_level &= ~KVM_ARM_DEV_PMU;
> >          }
> >
> > +        if (switched_level & KVM_ARM_DEV_SPE) {
> > +            qemu_set_irq(cpu->spe_interrupt,
> > +                         !!(run->s.regs.device_irq_level & KVM_ARM_DEV_SPE));
> > +            switched_level &= ~KVM_ARM_DEV_SPE;
> > +        }
> >          if (switched_level) {
> >              qemu_log_mask(LOG_UNIMP, "%s: unhandled in-kernel device IRQ %x\n",
> >                            __func__, switched_level);
> > --
> > 2.17.1
> >
>
> Otherwise
>
> Reviewed-by: Andrew Jones <drjones@redhat.com>
>

