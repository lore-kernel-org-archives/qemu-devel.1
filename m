Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3197AC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:41:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0376E2076C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 17:41:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqeKajzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0376E2076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAcwj-0001zj-9U
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 13:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41514)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAcvr-00015L-JC
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 13:40:27 -0400
Received: from mail-il1-x142.google.com ([2607:f8b0:4864:20::142]:36932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kAcvp-00017K-Rx
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 13:40:27 -0400
Received: by mail-il1-x142.google.com with SMTP id v2so11153784ilq.4
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=i1UX9gkEqTCNVBmRSj7rrtA21I63htnwUdQZV06gX2M=;
 b=PqeKajzKgR42Q+BVuSizWKlvMIcpK96On3xxvwFPkTrjRhr/dPBQTIwb3YcLs/sY3v
 RuQ4PjWfgZ7yGcNVGHMFqZ33PBsztNCf0si7kMYyTpa8pHL+Lke7IRjH5SJVcakdIm/E
 yl2ttGxtl+R5DpyuAAhJwQK8hs4Wi+VPw4aWsqwwFnQc54tqOWZK6abz7WWUNm4/XNvB
 jCUuUPtKS/AyHzi2RnGE6PfoDADIaxhLomyonwA+szC38Qla26GyErC3o4lJpc7Xkumf
 BW5x0dfkdKa4qczfaAawLdpAmF5fMcWc6ppYQtsmLuLZ5Vw1rrWf4hTAE6pCKKGt6IVw
 yFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i1UX9gkEqTCNVBmRSj7rrtA21I63htnwUdQZV06gX2M=;
 b=mrMU6+3pjwBOTBc4voCHer6WmZayVlOipjC2zXFGuM9feJRJXXLN4tID1FcX4TAfUP
 BBfzV0FzR41p3avo05nz/VQ/AilgaJOznBlsDH6WseOKlg/gShWwUlsTo36i307fKRXD
 ZSDnF0vhmIQavXV/pYNsWi8JyjbrqpE9nzRn0NdWMpFoXPfW6kbx+L1OrMgQA8CMco8j
 Fe0dYpONxsy2BGGqTCOT13yxsxv2Wswh9KCMQ9MhgPo08WZRbN1vf5+MRjJxPhnLMcJN
 mAviY2bXiUv2RsvDl5fKLfoFE2EaXG2JR17omGEQZcyr4vZ5aYqBK1Yh5kA4jEj7t39e
 /k4A==
X-Gm-Message-State: AOAM531YPQf6mA+AXNXTNI/ilOJ+1I4s/SP/mf6Z9s6KXzDx3Ry2ScmT
 IMDlvqxyG4RyishvugAfh40+hkt0V6CVJwXmQ80=
X-Google-Smtp-Source: ABdhPJwhvvtfd5CbI7W421kHrBLZVHxls1Pu8l+qiDIACnjvj9jHJKVEjq2hj5ytQpvBrSnWqNYF8+i+fPaKPwC+EjY=
X-Received: by 2002:a92:c7d4:: with SMTP id g20mr10248966ilk.40.1598377224805; 
 Tue, 25 Aug 2020 10:40:24 -0700 (PDT)
MIME-Version: 1.0
References: <87a2da602785bce972a6a6b4502769f4fee58a2d.1598074333.git.alistair.francis@wdc.com>
 <20200824203540.GR642093@habkost.net>
In-Reply-To: <20200824203540.GR642093@habkost.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Aug 2020 10:29:42 -0700
Message-ID: <CAKmqyKMmQro2mFwMHUtwPHFS__6LvtBygOWPv4WNLj06ji8jsg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] core/register: Specify instance_size in the
 TypeInfo
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::142;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x142.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 24, 2020 at 2:59 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Fri, Aug 21, 2020 at 10:33:06PM -0700, Alistair Francis wrote:
> > Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/core/register.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >
> > diff --git a/hw/core/register.c b/hw/core/register.c
> > index ddf91eb445..5e8e8199d0 100644
> > --- a/hw/core/register.c
> > +++ b/hw/core/register.c
> > @@ -180,11 +180,7 @@ void register_init(RegisterInfo *reg)
> >  {
> >      assert(reg);
> >
> > -    if (!reg->data || !reg->access) {
> > -        return;
> > -    }
> >
> > -    object_initialize((void *)reg, sizeof(*reg), TYPE_REGISTER);
> >  }
> >
> >  void register_write_memory(void *opaque, hwaddr addr,
> > @@ -269,13 +265,20 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
> >          int index = rae[i].addr / data_size;
> >          RegisterInfo *r = &ri[index];
> >
> > +        if (data + data_size * index == 0 || !&rae[i]) {
> > +            continue;
> > +        }
> > +
> > +        /* Init the register, this will zero it. */
> > +        object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
> > +
> > +        /* Set the properties of the register */
> >          *r = (RegisterInfo) {
> >              .data = data + data_size * index,
> >              .data_size = data_size,
> >              .access = &rae[i],
> >              .opaque = owner,
> >          };
>
> This doesn't look right.  Won't this wipe out all DeviceState
> data in r->parent_obj?

Yep, it will. Fixed in v2.

Alistair

>
> > -        register_init(r);
> >
> >          r_array->r[i] = r;
> >      }
> > @@ -329,6 +332,7 @@ static const TypeInfo register_info = {
> >      .name  = TYPE_REGISTER,
> >      .parent = TYPE_DEVICE,
> >      .class_init = register_class_init,
> > +    .instance_size = sizeof(RegisterInfo),
> >  };
> >
> >  static void register_register_types(void)
> > --
> > 2.28.0
> >
> >
>
> --
> Eduardo
>

