Return-Path: <SRS0=hbhd=3T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20BCBC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:28:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF54020707
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2020 15:28:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="Y+bevn6Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF54020707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixBkW-0005C9-3A
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 10:28:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56177)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anup@brainfault.org>) id 1ixBjc-0004a6-5A
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:28:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anup@brainfault.org>) id 1ixBjb-0000sr-63
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:28:00 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54998)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <anup@brainfault.org>) id 1ixBja-0000oq-PX
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 10:27:59 -0500
Received: by mail-wm1-x344.google.com with SMTP id g1so4206923wmh.4
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 07:27:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XNr//a8sPPOFMad0JXNigPx1xjtUzd0UPgS5DzpF3NY=;
 b=Y+bevn6QKWF3Lspiq/y7+KGk+KYxsAmPB3335p+D7hWA5gcnnjzqACEiit5VTyfSfR
 vz0B8qqXL+NsADWQu7tVIooerzEsK+5VHe87x0p0jbHNkQnGEJaCEt/NZ6DSbV15RVaH
 8eLtZvedFfci/+0czFa6gAfiyijUZKkFniQvK6plnPhpbIgTympSy8W6loZylTM7Wjaj
 PxHvd7zymnoBEPyoKspE67D13xIokC+stDYdLbBQ68nG+P5NHxc/ZVEYh8deH+NfGLXF
 UV0+2qGV1/7RZ0/LRV81r1CIvbsILNw4cGx+8mLuUhpQnaybGPVbUObjGwsZi2iyD3hv
 Mc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XNr//a8sPPOFMad0JXNigPx1xjtUzd0UPgS5DzpF3NY=;
 b=bDQqIPu4yKUl9xAU9/hpSsDH5pjG98jkY+ejP3DGp8eMOuE+XSjLPBa7uh7/To5Qej
 LzKxDglj8GxNvGbZhMILYEAY7Njir7yIJ8ebrFubyIZeeUBrQmjP5S9ReSApNyTD0Yo7
 h8ocJQ9oy3DabaQLkSazSkdvNTU5VeN59yLQZ434rcAy1CDmLUI6XlOeGuNlLm0vgo0o
 roAT9tNfactnet0f0kM/BOVVXB7IacJdU02a3dpjyZ7LbkzjSEL3bv3dKDXbl3LIUsbp
 qNRiu6hA1MNEEC5SXY5+JEBhXjjejaVaplpLY1ZbVu9V8XrVIbTjzuUl3DxLuq4thhZM
 dyZg==
X-Gm-Message-State: APjAAAV+Vpz6BBUDAHxzTga7bQkkS0EEZu2oxf8Mcg/7NZGYWWtmXjTX
 hmZZxsF/ODFoXFBzR40W7FaTfnzW9cl70yWC1+TANg==
X-Google-Smtp-Source: APXvYqwKPfz9NyRn2oF9MWDRb468vWEVEVSpAJhAMlWa7UIAcvwsMUBqa1T9/kHfALiM8Hy9YxCbimbvaVKBifHLEWg=
X-Received: by 2002:a1c:6246:: with SMTP id w67mr6109478wmb.141.1580398077208; 
 Thu, 30 Jan 2020 07:27:57 -0800 (PST)
MIME-Version: 1.0
References: <20200122112952.94284-1-anup.patel@wdc.com>
 <20200122112952.94284-3-anup.patel@wdc.com>
 <mhng-89da94b9-64c1-43e7-ae24-5a21ffc6d695@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-89da94b9-64c1-43e7-ae24-5a21ffc6d695@palmerdabbelt-glaptop1>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 30 Jan 2020 20:57:45 +0530
Message-ID: <CAAhSdy24G9WTN42J65DfbsFXTf2vVyO8oinHD2ZoeZU311P_ng@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] hw/riscv: Provide rdtime callback for TCG in CLINT
 emulation
To: Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <Anup.Patel@wdc.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 30, 2020 at 8:19 PM Palmer Dabbelt <palmerdabbelt@google.com> wrote:
>
> On Wed, 22 Jan 2020 11:30:36 GMT (+0000), Anup Patel wrote:
> > This patch extends CLINT emulation to provide rdtime callback for
> > TCG. This rdtime callback will be called wheneven TIME CSRs are
> > read in privileged modes.
> >
> > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > ---
> >  hw/riscv/sifive_clint.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/hw/riscv/sifive_clint.c b/hw/riscv/sifive_clint.c
> > index e5a8f75cee..805503dc27 100644
> > --- a/hw/riscv/sifive_clint.c
> > +++ b/hw/riscv/sifive_clint.c
> > @@ -236,6 +236,7 @@ DeviceState *sifive_clint_create(hwaddr addr, hwaddr size, uint32_t num_harts,
> >          if (!env) {
> >              continue;
> >          }
> > +        riscv_cpu_set_rdtime_fn(env, cpu_riscv_read_rtc);
> >          env->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL,
> >                                    &sifive_clint_timer_cb, cpu);
> >          env->timecmp = 0;
> > --
> > 2.17.1
>
> Can you make this optional?  Ideally via a command-line argument, but at a
> minimum as via the board configuration files.  As it stands this will enable
> the direct rdtime implemnetation everywhere, and while that's sensible for the
> virt board I'd prefer to avoid changing the behavior of the sifive_u board in
> ways that differ from the hardware when that's easy.

Command-line will unnecessary make things complicated for users.

I think the better option is to make it board specific so that we can
emulate exact HW behaviour in QEMU. This way since real-world
SiFive unleashed board does not have TIME CSR even QEMU will
not emulate TIME CSR for "sifive_u" machine. For now, we should
definitely emulate TIME CSR for virt machine because of the
performance improvement.

Regards,
Anup

