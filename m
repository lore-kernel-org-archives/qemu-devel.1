Return-Path: <SRS0=CqNf=4L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E674DC35671
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 19:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB68420656
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2020 19:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYH8lfaI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB68420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5wqj-0003hM-QJ
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 14:23:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56303)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <josemartins90@gmail.com>) id 1j5tMa-0006SU-ER
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 10:40:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <josemartins90@gmail.com>) id 1j5tMZ-0005Mc-6r
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 10:40:12 -0500
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:44066)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <josemartins90@gmail.com>)
 id 1j5tMW-0005Je-8H; Sun, 23 Feb 2020 10:40:08 -0500
Received: by mail-io1-xd44.google.com with SMTP id z16so7664657iod.11;
 Sun, 23 Feb 2020 07:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K8Hv9GUp7dxD6mg6UJYGxLf2r43Yt5MQ4e/2gMps8bM=;
 b=YYH8lfaIH374rhgFhmyC9nuRLbBeQDLQMXHqWbeBkcVaqzSFHg2H9IxkHIOrv/2Otv
 8k2viEkpSsP0JXKjBJTtpoBmk9Yg5skj7/3hj/LERPwWkWsjEabsz7ZX8hmeohwLRpqe
 tOtyMx6DT2WNJjUPOT2/dhc8ljUP8pkyuB51fZkJCKUx21cK8nYX6AnAeLJyt02wlHFD
 U0kVPhARhJAmxz2NBMYlZ0LXt36DGbOsweoQjVP5dvRb7iDuCQj69jgZrJ0+JrA/eAHv
 0TUPhv3+xOo8SULGWCOWWnnpU8siQJ1dhqesUPDg5k2TcCp+aWy3/OYsQyyUooEx9B4p
 1cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K8Hv9GUp7dxD6mg6UJYGxLf2r43Yt5MQ4e/2gMps8bM=;
 b=C7iBfGeJKXvBQv3dCb46RmpZpabnR7Z54c2EYcphZnOobMgonkCMKvnsXqZ5pW3jRC
 5sPTVh34fKbGInaZ30UJqvCYSJKOt0uo3WlmWdegYHbo0LO9wsn6s9jns+3YpzOYO75o
 syvar6U8fFTYG1bAv5DVY6wdRqPoVVnZ4DzWLwAC1hVhUtAqlhijNHQ9Z7hoE5xVZxaQ
 Il6jvEw1qU9tGO4JJn5MtPkVZGdyMuCiyb+Wpz1rTAI/EMgr3thBy4N1bJm4Mvq23jBD
 PQaO4HklUwqsmSEVjtcqwUdykEhpm/WASgWwYAkkg03siBYD7Tn/1PTbKP883sr8vT32
 iaTQ==
X-Gm-Message-State: APjAAAUyAgXp9lQI+sAb6zZazD98gKVJvGcH5FggSUSH3sdq5JJBtJ5F
 QffQmdUOGTXhzVZe/OV/e3rn9eu/r5Gm8xd/yYg=
X-Google-Smtp-Source: APXvYqyYo+IzuLnepjxY2rt2SNbTBHeDztt6Q/V4d649BZ1zvS/vPF4p3ZHvGSpYYRe0febExfBFEHWvljDiil5Gw5k=
X-Received: by 2002:a02:5489:: with SMTP id t131mr44988857jaa.40.1582472407333; 
 Sun, 23 Feb 2020 07:40:07 -0800 (PST)
MIME-Version: 1.0
References: <0c4859f90948ba392da456c9e1daf8fde8f5b22e.1582453384.git.rajnesh.kanwal49@gmail.com>
 <CAC41xo0PWCZw4mrcEfRq9fv+b3mSk9sN0mWhFXPwgdD6LR8xnQ@mail.gmail.com>
 <CAHfcQ+GGCXj6f+PMMvqNhg=Lzpi1Ke+OaEO6-pb5gjSngm3Upg@mail.gmail.com>
In-Reply-To: <CAHfcQ+GGCXj6f+PMMvqNhg=Lzpi1Ke+OaEO6-pb5gjSngm3Upg@mail.gmail.com>
From: Jose Martins <josemartins90@gmail.com>
Date: Sun, 23 Feb 2020 15:39:55 +0000
Message-ID: <CAC41xo0V_F4ExJjoYx4AWQXViX-WwgfFx219EyCb8mk-okKUAQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: Fix VS mode interrupts forwarding.
To: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
X-Mailman-Approved-At: Sun, 23 Feb 2020 14:22:51 -0500
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
Cc: alistair.francis@wdc.com, palmerdabbelt@google.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

No problem. But I'm failing to see what you mean. My reasoning was:
the specification mandates that only VS mode interrupt bits are
writable in hideleg, all the others must be hardwired to zero. This
means the hypervisor can't really delegate S mode interrupts as you
are saying. So, if this is implemented correctly, you will never get
inside that if condition because of an HS interrupt. And all
delegatable asynchronous exception values must be decremented. So,
checking if this is an async exception should do the job.

Jose

On Sun, 23 Feb 2020 at 15:10, Rajnesh Kanwal <rajnesh.kanwal49@gmail.com> wrote:
>
> Hello Jose,
>
> Sorry I didn't see that as it hadn't became a part of the port. I don't know how
> they proceed with same patches.
>
> Just to add, there is a minor problem with your patch. The cause value should
> only be decremented by one for VS mode interrupts. In case if hypervisor has
> delegated S mode interrupts then we should not decrement cause for those
> interrupts.
>
> Regards,
> Rajnesh
>
>
> On Sun, Feb 23, 2020 at 7:41 PM Jose Martins <josemartins90@gmail.com> wrote:
>>
>> Hello rajnesh,
>>
>> I had already submitted almost this exact patch a few weeks ago.
>>
>> Jose
>>
>> On Sun, 23 Feb 2020 at 13:51, <rajnesh.kanwal49@gmail.com> wrote:
>> >
>> > From: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
>> >
>> > Currently riscv_cpu_local_irq_pending is used to find out pending
>> > interrupt and VS mode interrupts are being shifted to represent
>> > S mode interrupts in this function. So when the cause returned by
>> > this function is passed to riscv_cpu_do_interrupt to actually
>> > forward the interrupt, the VS mode forwarding check does not work
>> > as intended and interrupt is actually forwarded to hypervisor. This
>> > patch fixes this issue.
>> >
>> > Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
>> > ---
>> >  target/riscv/cpu_helper.c | 9 ++++++++-
>> >  1 file changed, 8 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>> > index b9e90dfd9a..59535ecba6 100644
>> > --- a/target/riscv/cpu_helper.c
>> > +++ b/target/riscv/cpu_helper.c
>> > @@ -46,7 +46,7 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>> >      target_ulong pending = env->mip & env->mie &
>> >                                 ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
>> >      target_ulong vspending = (env->mip & env->mie &
>> > -                              (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP)) >> 1;
>> > +                              (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP));
>> >
>> >      target_ulong mie    = env->priv < PRV_M ||
>> >                            (env->priv == PRV_M && mstatus_mie);
>> > @@ -900,6 +900,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>> >
>> >              if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
>> >                  !force_hs_execp) {
>> > +                /*
>> > +                 * See if we need to adjust cause. Yes if its VS mode interrupt
>> > +                 * no if hypervisor has delegated one of hs mode's interrupt
>> > +                 */
>> > +                if (cause == IRQ_VS_TIMER || cause == IRQ_VS_SOFT ||
>> > +                    cause == IRQ_VS_EXT)
>> > +                    cause = cause - 1;
>> >                  /* Trap to VS mode */
>> >              } else if (riscv_cpu_virt_enabled(env)) {
>> >                  /* Trap into HS mode, from virt */
>> > --
>> > 2.17.1
>> >
>> >

