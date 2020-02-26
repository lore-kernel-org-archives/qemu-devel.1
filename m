Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFB7C4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:04:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B426020732
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 18:04:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTgtGFTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B426020732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j712Y-0001VF-RO
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 13:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j711j-0000nR-Sr
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:03:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j711i-000459-1A
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 13:03:19 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:46511)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j711e-00042Y-HV; Wed, 26 Feb 2020 13:03:14 -0500
Received: by mail-lf1-x141.google.com with SMTP id v6so1735036lfo.13;
 Wed, 26 Feb 2020 10:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=McGgSaZlcFv8eVYrlkvr8E4Xon69cH6tZoFAdSnivCA=;
 b=VTgtGFTAbvKQyaDfGjLWd3L7nP0vZQJpr6ssfQ82kte19n9pSF6CnqUwi0t6+ay5Lj
 0czsCLvAKRABgbLdAY/nNQ3OWGQu8N+pg9LxqrxV2Wz0J4mUQFQdFhscbYk0yQwaViZl
 DfUdJ+y9mLNOimObhpTaU97pufZwjj16RErkQJiM7OkxDz0nRY87RGKmmhxQToUtUGIA
 b15Mq3hGU+oOYE9haCvt1xIbhL2Cb5oMkWkliwBF8thIsV81EMZEuW29HO9hzSXMvlp3
 tO2CbpQP2O5UzUbImuLiKnBxmDjetaiiF1/gdhOxw+FfhVKW2ZG4bhmB+HTL725skHV7
 mtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=McGgSaZlcFv8eVYrlkvr8E4Xon69cH6tZoFAdSnivCA=;
 b=c6jSFonUk2DuIOxPX11MOTDf9MYs4A0pzlua8/IBkjUN5x9dKvpm3n5EgXgb3Wa3+i
 Tlw18vObnxZ5mpoUYKNhOhidFiF+OrJPJhj0u4Y+2TUOhK2URlGCD6mkXY7NsRA2KlMN
 V5p0QgIWxy927NaHSySze6n3XOeYHeUj3dT3oABdEYCvlngRpSC+nr91vavJRP54rumI
 22dOH2QECejBkDt3cvDpDsaqBjxWRIiPdwlC294kC4ubbRdKD3l97QFH8tRQ2vYoAl+z
 ZffDSArJ9V0C2TwIooPUOWdZIjqqKRCgDfKcboWd/sNMfosExWj0G/226fH++PEKUGMC
 N5wg==
X-Gm-Message-State: APjAAAVHjW8npbo6/wei3Rb9FeEYDdApjJZNEntLb7n+UhWmLXp7lPoX
 erPams72c3fDHklh6M3jXDnW1r4pvjW7ggujc8o=
X-Google-Smtp-Source: APXvYqwzsKnBJfHFKrPyPl+BlL5qgDsM1htqXS96QNVIeQZhpA3Y5eipP3y1FcxaaWW0UWuCIv0IPTi7yERK/8CXPLU=
X-Received: by 2002:a19:4a:: with SMTP id 71mr3222313lfa.50.1582740192820;
 Wed, 26 Feb 2020 10:03:12 -0800 (PST)
MIME-Version: 1.0
References: <0c4859f90948ba392da456c9e1daf8fde8f5b22e.1582453384.git.rajnesh.kanwal49@gmail.com>
 <CAC41xo0PWCZw4mrcEfRq9fv+b3mSk9sN0mWhFXPwgdD6LR8xnQ@mail.gmail.com>
 <CAKmqyKNn8V0yWA8t7dQeMwxcnmywDJoGKag9vQzwFruaygKL7Q@mail.gmail.com>
 <CAHfcQ+HiNB+Tch2_EVS74_ii-NhUEXMFYCf1R_0nrRfvuRxqgQ@mail.gmail.com>
In-Reply-To: <CAHfcQ+HiNB+Tch2_EVS74_ii-NhUEXMFYCf1R_0nrRfvuRxqgQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Feb 2020 09:55:34 -0800
Message-ID: <CAKmqyKMDPXLig4E4VJvqwvd7O7DtFD0PmWD44zoGDY-izJLsHQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: Fix VS mode interrupts forwarding.
To: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
Cc: Jose Martins <josemartins90@gmail.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmerdabbelt@google.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Feb 26, 2020 at 12:54 AM Rajnesh Kanwal
<rajnesh.kanwal49@gmail.com> wrote:
>
> Here is the link to the patch
> https://lists.nongnu.org/archive/html/qemu-riscv/2020-01/msg00191.html

Ah, it doesn't look like it made it to the QEMU-devel list. Can you
re-send it to QEMU-devel?

Alistair

>
> -Rajnesh
>
> On Tue, Feb 25, 2020 at 12:06 AM Alistair Francis <alistair23@gmail.com> wrote:
>>
>> On Sun, Feb 23, 2020 at 11:23 AM Jose Martins <josemartins90@gmail.com> wrote:
>> >
>> > Hello rajnesh,
>> >
>> > I had already submitted almost this exact patch a few weeks ago.
>>
>> To QEMU? I don't see the patch.
>>
>> Alistair
>>
>> >
>> > Jose
>> >
>> > On Sun, 23 Feb 2020 at 13:51, <rajnesh.kanwal49@gmail.com> wrote:
>> > >
>> > > From: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
>> > >
>> > > Currently riscv_cpu_local_irq_pending is used to find out pending
>> > > interrupt and VS mode interrupts are being shifted to represent
>> > > S mode interrupts in this function. So when the cause returned by
>> > > this function is passed to riscv_cpu_do_interrupt to actually
>> > > forward the interrupt, the VS mode forwarding check does not work
>> > > as intended and interrupt is actually forwarded to hypervisor. This
>> > > patch fixes this issue.
>> > >
>> > > Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
>> > > ---
>> > >  target/riscv/cpu_helper.c | 9 ++++++++-
>> > >  1 file changed, 8 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> > > index b9e90dfd9a..59535ecba6 100644
>> > > --- a/target/riscv/cpu_helper.c
>> > > +++ b/target/riscv/cpu_helper.c
>> > > @@ -46,7 +46,7 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>> > >      target_ulong pending = env->mip & env->mie &
>> > >                                 ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
>> > >      target_ulong vspending = (env->mip & env->mie &
>> > > -                              (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP)) >> 1;
>> > > +                              (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP));
>> > >
>> > >      target_ulong mie    = env->priv < PRV_M ||
>> > >                            (env->priv == PRV_M && mstatus_mie);
>> > > @@ -900,6 +900,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>> > >
>> > >              if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
>> > >                  !force_hs_execp) {
>> > > +                /*
>> > > +                 * See if we need to adjust cause. Yes if its VS mode interrupt
>> > > +                 * no if hypervisor has delegated one of hs mode's interrupt
>> > > +                 */
>> > > +                if (cause == IRQ_VS_TIMER || cause == IRQ_VS_SOFT ||
>> > > +                    cause == IRQ_VS_EXT)
>> > > +                    cause = cause - 1;
>> > >                  /* Trap to VS mode */
>> > >              } else if (riscv_cpu_virt_enabled(env)) {
>> > >                  /* Trap into HS mode, from virt */
>> > > --
>> > > 2.17.1
>> > >
>> > >
>> >

