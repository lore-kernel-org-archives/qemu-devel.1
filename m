Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDDBC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 22:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 863B1207BC
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 22:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPf6Qz7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 863B1207BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB3Wb-0005vq-Ku
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 18:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kB3Vt-0005FE-J8
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 18:03:25 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:36136)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kB3Vr-0007t4-T0
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 18:03:25 -0400
Received: by mail-io1-xd44.google.com with SMTP id i10so3810158iow.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 15:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cl+yM5r8pZIqw2GLdxvWoRLvfREiU9fHJRpNwyfImE8=;
 b=SPf6Qz7m037CsYaG9B37QMmuF0fljnEcUk6raByssBVlmGOH988YtAfem2DjjpwviR
 ZCx854FMgNY8bIMvS0uh5251897rgAbWa/CnOEB0NCQFYN0lBCp4ZXacuwzjnQOFEOCo
 aAGKy4GpvqchUWeoBNxU4aviKA7wlRm5v8jt6AWMkMLl+hbYqKQQ1pi4gwX+A0SN1QuR
 GF3a+Pkd5qUDJnV8947K5EnYMJDNmHM1YGdY+j6gAKc/lNz3TVmvPwHXnwTuP5pTzCSO
 lSdyfJwT8wgrE3dGeET9QsBiwsb2IqywXQA5eslQ16PTykT3R0lJ6m64iJNiNrbwF+1+
 rfSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cl+yM5r8pZIqw2GLdxvWoRLvfREiU9fHJRpNwyfImE8=;
 b=mDCA7GnTYSPLivYKDhktQUWergxpCM/KEMIW3SARPzY+myVG7ut7LpXmwRlvFWXckp
 Yq9HIxW1TgURhKki4X+n2APgCoRnutOjTxE39xkHaC8QlZ/s1erwf7pCinrWiecIeGrb
 1hLECSUEJqFyGjEb+RciTlg7e8rFosaugjsLLlDnRFs2ds4l0S1txLiDoQgRHNiU9DcK
 hs7WpID/22Fh4SzyN65bNMzw6/iAVN7siQbMiKIFlR4cMbNYj0nxtnVSkFQ5RilGrG4u
 R9hFA5HZQ5UR6ZuwGqF2lcK8mIGwCIeLXI35UfXae6FVaeEJ31TrDxMA59ZSJw7aBWgy
 BXUQ==
X-Gm-Message-State: AOAM530983FGLNruI5aJi6+7BMU+Y0/sC7cotBoG6v3Kdoxq4lu8wWBD
 duegS3cuvibc4qMpwCdjr2S0Gtd9Zd0iNPehi0s=
X-Google-Smtp-Source: ABdhPJzgKbRvtdFhRll4z6InefE8kN4g/0qVsGTkrbPHFLYiug7Z0BZAw1/JjaDR0MXz0F2T7mtRn5U+v5eSq9in478=
X-Received: by 2002:a5e:c309:: with SMTP id a9mr14966532iok.105.1598479402340; 
 Wed, 26 Aug 2020 15:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <4cf1beb7dafb9143c261d266557d3173bf160524.1598376594.git.alistair.francis@wdc.com>
 <20200826194918.GG642093@habkost.net>
In-Reply-To: <20200826194918.GG642093@habkost.net>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Aug 2020 14:52:37 -0700
Message-ID: <CAKmqyKNX+_2JW9BX2dhciRwD+5SjWb3iozwuzUi_P-JjC-g+jw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] core/register: Specify instance_size in the
 TypeInfo
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 12:49 PM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Tue, Aug 25, 2020 at 10:30:59AM -0700, Alistair Francis wrote:
> > Reported-by: Eduardo Habkost <ehabkost@redhat.com>
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/core/register.c | 31 +++++++++++++------------------
> >  1 file changed, 13 insertions(+), 18 deletions(-)
> >
> > diff --git a/hw/core/register.c b/hw/core/register.c
> > index ddf91eb445..31038bd7cc 100644
> > --- a/hw/core/register.c
> > +++ b/hw/core/register.c
> > @@ -176,17 +176,6 @@ void register_reset(RegisterInfo *reg)
> >      }
> >  }
> >
> > -void register_init(RegisterInfo *reg)
> > -{
> > -    assert(reg);
> > -
> > -    if (!reg->data || !reg->access) {
> > -        return;
> > -    }
> > -
> > -    object_initialize((void *)reg, sizeof(*reg), TYPE_REGISTER);
> > -}
> > -
> >  void register_write_memory(void *opaque, hwaddr addr,
> >                             uint64_t value, unsigned size)
> >  {
> > @@ -269,13 +258,18 @@ static RegisterInfoArray *register_init_block(DeviceState *owner,
> >          int index = rae[i].addr / data_size;
> >          RegisterInfo *r = &ri[index];
> >
> > -        *r = (RegisterInfo) {
> > -            .data = data + data_size * index,
> > -            .data_size = data_size,
> > -            .access = &rae[i],
> > -            .opaque = owner,
> > -        };
> > -        register_init(r);
> > +        if (data + data_size * index == 0 || !&rae[i]) {
>
> Do you know what's the goal of this check?
>
> Can `data` or `rae` be NULL?  If not, it seems impossible for
> this condition to be true.  If they can, this seems to be a weird
> and fragile way of checking for NULL arguments.

I think the idea is that some sections in rae could be NULL or parts
of the data array could be NULL and we are checking for that here.

It seems unlikely that will be the case but I don't think the check
really hurts us.

Alistair

>
> > +            continue;
> > +        }
> > +
> > +        /* Init the register, this will zero it. */
> > +        object_initialize((void *)r, sizeof(*r), TYPE_REGISTER);
> > +
> > +        /* Set the properties of the register */
> > +        r->data = data + data_size * index;
> > +        r->data_size = data_size;
> > +        r->access = &rae[i];
> > +        r->opaque = owner;
> >
> >          r_array->r[i] = r;
> >      }
> > @@ -329,6 +323,7 @@ static const TypeInfo register_info = {
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
>
> --
> Eduardo
>

