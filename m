Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C10C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE5820656
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 17:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HtmpVxtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE5820656
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jAGxf-0005s8-CH
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 12:40:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1jAGoe-0004jf-7b
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1jAGoc-0003ia-Bq
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:31:15 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:38737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1jAGoa-0003eG-LI
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 12:31:13 -0500
Received: by mail-pl1-x641.google.com with SMTP id w3so1135273plz.5
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2020 09:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=UygXtcOquP2uukbvmDPtogXvWNDERxgs47LKEBGVpuM=;
 b=HtmpVxtXBu3s2SvVO1xTXufD//yEf3iSUGLoHJIoG4H9Yb/6hfBjd316S4JUUpeTD+
 y/te8aR1QUYTmo88SFNHAMA70YFBNDXVPy3GzUSIsbP+qhq3G2f7M0oQpsYkmKsB40pu
 HbavdHJBOOLxhl6idIfOdGmDKvVuTItmQ9X07SyNx/S5jhXN42u6+MfzeU73zwuM7qhb
 0Rmg/LF+nR4UafazVAviL3EaYH0iqBwrdR0qzsb+pqXjsxQBltPAi2lXca8Fx/6Uu3f9
 WVWQd+lwMSK71PcUfljfz8UdcXA0g35Q3Dvf++jkWSDErePJso0QgIptvoRO58bBzSxA
 l/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=UygXtcOquP2uukbvmDPtogXvWNDERxgs47LKEBGVpuM=;
 b=Oqgd7OHqg57kWeK7xG22dq7fB/XTOfRrOnAyTxxtcHkbry3L8rC66YLoG08uITIota
 Tu+hSuJfnoOVrFFpn9zfDDR17KOd1SDlUHfjsaMgob78bmnoPUjEbxYD5Wkvh+WeBRHe
 7GO0auls+kYb+HG1LUmBZ6xdC9x3H/n8/7QGzMgZ5/3yDX0CQMcOa0hyeVi6tFOmb39L
 Dy703QrHb0M2fTvNbnt6zLzF2LpoTZ0kZrOVEAVq/gROOZwH4ISWVGbuyljykhhjUlO9
 18ReGC+Vp9HelIf4NUwZixdiz7GZpl1EIyZYpnhFeFnvuqKcLx2bLMaZuHOnHhqNZe5v
 0k3A==
X-Gm-Message-State: ANhLgQ0dlM/ejA05Go8uGZzQUYnQwqqF9ui9hMpUuls9qUZXFNy20uyt
 WeTy/KAHBh5ZFhoQ1kG8posGzw==
X-Google-Smtp-Source: ADFU+vumMQk9seVGom+SQkz8SLHJHP4r/sBiSaGD3PvX50CI6YaRXuXsCCDA7xcrJq6Zro3KEvKE/Q==
X-Received: by 2002:a17:90a:d101:: with SMTP id
 l1mr4874944pju.130.1583515869863; 
 Fri, 06 Mar 2020 09:31:09 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id i5sm10206907pju.42.2020.03.06.09.31.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2020 09:31:08 -0800 (PST)
Date: Fri, 06 Mar 2020 09:31:08 -0800 (PST)
X-Google-Original-Date: Fri, 06 Mar 2020 09:30:47 PST (-0800)
Subject: Re: [PATCH 1/1] target/riscv: Fix VS mode interrupts forwarding.
In-Reply-To: <CAKmqyKMDPXLig4E4VJvqwvd7O7DtFD0PmWD44zoGDY-izJLsHQ@mail.gmail.com>
CC: rajnesh.kanwal49@gmail.com, josemartins90@gmail.com, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org
From: Palmer Dabbelt <palmerdabbelt@google.com>
To: alistair23@gmail.com
Message-ID: <mhng-4a8f061d-5e72-44e7-a2a2-b72cd52332a3@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 09:55:34 PST (-0800), alistair23@gmail.com wrote:
> On Wed, Feb 26, 2020 at 12:54 AM Rajnesh Kanwal
> <rajnesh.kanwal49@gmail.com> wrote:
>>
>> Here is the link to the patch
>> https://lists.nongnu.org/archive/html/qemu-riscv/2020-01/msg00191.html
>
> Ah, it doesn't look like it made it to the QEMU-devel list. Can you
> re-send it to QEMU-devel?

I can't find the older patch in my inbox, so I'm just taking this one.

>
> Alistair
>
>>
>> -Rajnesh
>>
>> On Tue, Feb 25, 2020 at 12:06 AM Alistair Francis <alistair23@gmail.com> wrote:
>>>
>>> On Sun, Feb 23, 2020 at 11:23 AM Jose Martins <josemartins90@gmail.com> wrote:
>>> >
>>> > Hello rajnesh,
>>> >
>>> > I had already submitted almost this exact patch a few weeks ago.
>>>
>>> To QEMU? I don't see the patch.
>>>
>>> Alistair
>>>
>>> >
>>> > Jose
>>> >
>>> > On Sun, 23 Feb 2020 at 13:51, <rajnesh.kanwal49@gmail.com> wrote:
>>> > >
>>> > > From: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
>>> > >
>>> > > Currently riscv_cpu_local_irq_pending is used to find out pending
>>> > > interrupt and VS mode interrupts are being shifted to represent
>>> > > S mode interrupts in this function. So when the cause returned by
>>> > > this function is passed to riscv_cpu_do_interrupt to actually
>>> > > forward the interrupt, the VS mode forwarding check does not work
>>> > > as intended and interrupt is actually forwarded to hypervisor. This
>>> > > patch fixes this issue.
>>> > >
>>> > > Signed-off-by: Rajnesh Kanwal <rajnesh.kanwal49@gmail.com>
>>> > > ---
>>> > >  target/riscv/cpu_helper.c | 9 ++++++++-
>>> > >  1 file changed, 8 insertions(+), 1 deletion(-)
>>> > >
>>> > > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
>>> > > index b9e90dfd9a..59535ecba6 100644
>>> > > --- a/target/riscv/cpu_helper.c
>>> > > +++ b/target/riscv/cpu_helper.c
>>> > > @@ -46,7 +46,7 @@ static int riscv_cpu_local_irq_pending(CPURISCVState *env)
>>> > >      target_ulong pending = env->mip & env->mie &
>>> > >                                 ~(MIP_VSSIP | MIP_VSTIP | MIP_VSEIP);
>>> > >      target_ulong vspending = (env->mip & env->mie &
>>> > > -                              (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP)) >> 1;
>>> > > +                              (MIP_VSSIP | MIP_VSTIP | MIP_VSEIP));
>>> > >
>>> > >      target_ulong mie    = env->priv < PRV_M ||
>>> > >                            (env->priv == PRV_M && mstatus_mie);
>>> > > @@ -900,6 +900,13 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>>> > >
>>> > >              if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
>>> > >                  !force_hs_execp) {
>>> > > +                /*
>>> > > +                 * See if we need to adjust cause. Yes if its VS mode interrupt
>>> > > +                 * no if hypervisor has delegated one of hs mode's interrupt
>>> > > +                 */
>>> > > +                if (cause == IRQ_VS_TIMER || cause == IRQ_VS_SOFT ||
>>> > > +                    cause == IRQ_VS_EXT)
>>> > > +                    cause = cause - 1;
>>> > >                  /* Trap to VS mode */
>>> > >              } else if (riscv_cpu_virt_enabled(env)) {
>>> > >                  /* Trap into HS mode, from virt */
>>> > > --
>>> > > 2.17.1
>>> > >
>>> > >
>>> >

