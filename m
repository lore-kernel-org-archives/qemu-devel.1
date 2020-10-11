Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93124C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 18:26:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28A9A2222A
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 18:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="Bmc6iPmh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28A9A2222A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRg2u-0002cB-CB
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 14:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36394)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRg1y-0001zY-DF; Sun, 11 Oct 2020 14:25:14 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:33970)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRg1u-0007Mt-F8; Sun, 11 Oct 2020 14:25:13 -0400
Received: from localhost (sekoia-pc.home.lmichel.fr [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id 48A96C6011D;
 Sun, 11 Oct 2020 18:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1602440706;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mDJpyqcqK4VkDLMKvT1byR1sd552eetZo9rZ1Ms4q/g=;
 b=Bmc6iPmhX4SJxenQVlSQXnfloT4TppeW7nVcOsJeN5hLTAjXoetxVte6cfkRLPkrrnFz2l
 aVts73LIqpctQKNawNyKw3RI+OkwUVxOtR73rAXRtPOBlpVbKX6+vph/zkTS2mjAGArV3j
 fR1ovdSMSvGEwDRBmS3W9s8YH1OuJx0/7DWJWG50JXQZQ/ftbX0h2SNw6hzEWz7xPHsHM3
 685BNSuSvHsxxIbS9UYOPcgR1Iu/gErpzY/9Ij0tvRDlA8nbN/AgkRsAeTUljINr1Qceo+
 uOxwJxIXtGjjOEuhFcQ0LHr3L2t46AoXAvenvi953PSKMje2TI6sq1zMvD15Eg==
Date: Sun, 11 Oct 2020 20:26:08 +0200
From: Luc Michel <luc@lmichel.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v3 13/15] hw/misc/bcm2835_cprman: add sane reset values
 to the registers
Message-ID: <20201011182608.gfmfvdioiyyaxrfq@sekoia-pc.home.lmichel.fr>
References: <20201010135759.437903-1-luc@lmichel.fr>
 <20201010135759.437903-14-luc@lmichel.fr>
 <48280560-3642-5367-a46e-53548e77c748@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <48280560-3642-5367-a46e-53548e77c748@amsat.org>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1602440706;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mDJpyqcqK4VkDLMKvT1byR1sd552eetZo9rZ1Ms4q/g=;
 b=EhyO9H2LeLtFu2QEXL7za40oUEsoL6cNUIoBCzJc/y/pgUaorGMjKlO0Q9PVvN55Qggem4
 NNNx0ffDriFV2FjQtxQ+RB7fNJp6x7R1vtWhibNz88p0pXImeOmIDDjjIIcLqYe/qPAud5
 ZZezZRfPgDExKikmHFGuC49Md2yNdLas5nVuHpkya5SjIEdSNv+rLAgeWSm9+ePTaio1j3
 0tlUtNtABBHpkRpYToMksjUfzGF+JSwm8601sVcAvvjnBiA/r7HAV+KayHEyJ7hdncYm1/
 IKz5rjklzpP7Dca5AsRNoCuGL8Rr8Vr7ChTgDZGBH9Y6rvXoq7McU4NtlTYmPQ==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1602440706; a=rsa-sha256; cv=none;
 b=gBtOqd/strzpbn6TakATCYNDqpG8FVMDi0x7lZRGgj04CWKF8uXglte/2T3ShXz2SapsVlGSYiuJiBSW2JSQMO59BzTnDQ5eMch0W89P0Ix1iZeD+tOGJrMpii+WpcWZouJUifbSJGm2hzGlJUvzZp0x4j5QkyEJ6ARAH+dQlhVMs3jt3jubjJ4OLUUJ+0be6hLkQvywBYnDaE2clhkx0AJabGHmalmQMseEYNxqF6CT3mdHVTIdMM6eTt3CIDssCXRaFfqm4juobcUfvWC6fgge08cF2mT0kMOSozlZnmE4AHQZ2sU7ylC7fIATQrcYGvj9QAXlgKRAEO1EEpVGsw==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=sekoia smtp.mailfrom=luc@lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 14:25:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org,
 Havard Skinnemoen <hskinnemoen@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18:18 Sat 10 Oct     , Philippe Mathieu-Daudé wrote:
> On 10/10/20 3:57 PM, Luc Michel wrote:
> > Those reset values have been extracted from a Raspberry Pi 3 model B
> > v1.2, using the 2020-08-20 version of raspios. The dump was done using
> > the debugfs interface of the CPRMAN driver in Linux (under
> > '/sys/kernel/debug/clk'). Each exposed clock tree stage (PLLs, channels
> > and muxes) can be observed by reading the 'regdump' file (e.g.
> > 'plla/regdump').
> > 
> > Those values are set by the Raspberry Pi firmware at boot time (Linux
> > expects them to be set when it boots up).
> > 
> > Some stages are not exposed by the Linux driver (e.g. the PLL B). For
> > those, the reset values are unknown and left to 0 which implies a
> > disabled output.
> > 
> > Once booted in QEMU, the final clock tree is very similar to the one
> > visible on real hardware. The differences come from some unimplemented
> > devices for which the driver simply disable the corresponding clock.
> > 
> > Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> > Signed-off-by: Luc Michel <luc@lmichel.fr>
> > ---
> >   include/hw/misc/bcm2835_cprman_internals.h | 269 +++++++++++++++++++++
> >   hw/misc/bcm2835_cprman.c                   |  31 +++
> >   2 files changed, 300 insertions(+)
> > 
> > diff --git a/include/hw/misc/bcm2835_cprman_internals.h b/include/hw/misc/bcm2835_cprman_internals.h
> > index a6e799075f..339759b307 100644
> > --- a/include/hw/misc/bcm2835_cprman_internals.h
> > +++ b/include/hw/misc/bcm2835_cprman_internals.h
> > @@ -745,6 +745,275 @@ static inline void set_clock_mux_init_info(BCM2835CprmanState *s,
> >       mux->reg_div = &s->regs[CLOCK_MUX_INIT_INFO[id].cm_offset + 1];
> >       mux->int_bits = CLOCK_MUX_INIT_INFO[id].int_bits;
> >       mux->frac_bits = CLOCK_MUX_INIT_INFO[id].frac_bits;
> >   }
> > +
> > +/*
> > + * Object reset info
> > + * Those values have been dumped from a Raspberry Pi 3 Model B v1.2 using the
> > + * clk debugfs interface in Linux.
> > + */
> > +typedef struct PLLResetInfo {
> > +    uint32_t cm;
> > +    uint32_t a2w_ctrl;
> > +    uint32_t a2w_ana[4];
> > +    uint32_t a2w_frac;
> > +} PLLResetInfo;
> > +
> > +static const PLLResetInfo PLL_RESET_INFO[] = {
> > +    [CPRMAN_PLLA] = {
> > +        .cm = 0x0000008a,
> > +        .a2w_ctrl = 0x0002103a,
> > +        .a2w_frac = 0x00098000,
> > +        .a2w_ana = { 0x00000000, 0x00144000, 0x00000000, 0x00000100 }
> > +    },
> > +
> > +    [CPRMAN_PLLC] = {
> > +        .cm = 0x00000228,
> > +        .a2w_ctrl = 0x0002103e,
> > +        .a2w_frac = 0x00080000,
> > +        .a2w_ana = { 0x00000000, 0x00144000, 0x00000000, 0x00000100 }
> > +    },
> > +
> > +    [CPRMAN_PLLD] = {
> > +        .cm = 0x0000020a,
> > +        .a2w_ctrl = 0x00021034,
> > +        .a2w_frac = 0x00015556,
> > +        .a2w_ana = { 0x00000000, 0x00144000, 0x00000000, 0x00000100 }
> > +    },
> > +
> > +    [CPRMAN_PLLH] = {
> > +        .cm = 0x00000000,
> > +        .a2w_ctrl = 0x0002102d,
> > +        .a2w_frac = 0x00000000,
> > +        .a2w_ana = { 0x00900000, 0x0000000c, 0x00000000, 0x00000000 }
> > +    },
> > +
> > +    [CPRMAN_PLLB] = {
> > +        /* unknown */
> > +        .cm = 0x00000000,
> > +        .a2w_ctrl = 0x00000000,
> > +        .a2w_frac = 0x00000000,
> > +        .a2w_ana = { 0x00000000, 0x00000000, 0x00000000, 0x00000000 }
> > +    }
> > +};
> > +
> > +typedef struct PLLChannelResetInfo {
> > +    /*
> > +     * Even though a PLL channel has a CM register, it shares it with its
> > +     * parent PLL. The parent already takes care of the reset value.
> > +     */
> > +    uint32_t a2w_ctrl;
> > +} PLLChannelResetInfo;
> > +
> > +static const PLLChannelResetInfo PLL_CHANNEL_RESET_INFO[] = {
> > +    [CPRMAN_PLLA_CHANNEL_DSI0] = { .a2w_ctrl = 0x00000100 },
> > +    [CPRMAN_PLLA_CHANNEL_CORE] = { .a2w_ctrl = 0x00000003 },
> > +    [CPRMAN_PLLA_CHANNEL_PER] = { .a2w_ctrl = 0x00000000 }, /* unknown */
> > +    [CPRMAN_PLLA_CHANNEL_CCP2] = { .a2w_ctrl = 0x00000100 },
> > +
> > +    [CPRMAN_PLLC_CHANNEL_CORE2] = { .a2w_ctrl = 0x00000100 },
> > +    [CPRMAN_PLLC_CHANNEL_CORE1] = { .a2w_ctrl = 0x00000100 },
> > +    [CPRMAN_PLLC_CHANNEL_PER] = { .a2w_ctrl = 0x00000002 },
> > +    [CPRMAN_PLLC_CHANNEL_CORE0] = { .a2w_ctrl = 0x00000002 },
> > +
> > +    [CPRMAN_PLLD_CHANNEL_DSI0] = { .a2w_ctrl = 0x00000100 },
> > +    [CPRMAN_PLLD_CHANNEL_CORE] = { .a2w_ctrl = 0x00000004 },
> > +    [CPRMAN_PLLD_CHANNEL_PER] = { .a2w_ctrl = 0x00000004 },
> > +    [CPRMAN_PLLD_CHANNEL_DSI1] = { .a2w_ctrl = 0x00000100 },
> > +
> > +    [CPRMAN_PLLH_CHANNEL_AUX] = { .a2w_ctrl = 0x00000004 },
> > +    [CPRMAN_PLLH_CHANNEL_RCAL] = { .a2w_ctrl = 0x00000000 },
> > +    [CPRMAN_PLLH_CHANNEL_PIX] = { .a2w_ctrl = 0x00000000 },
> > +
> > +    [CPRMAN_PLLB_CHANNEL_ARM] = { .a2w_ctrl = 0x00000000 }, /* unknown */
> > +};
> > +
> > +typedef struct ClockMuxResetInfo {
> > +    uint32_t cm_ctl;
> > +    uint32_t cm_div;
> > +} ClockMuxResetInfo;
> > +
> > +static const ClockMuxResetInfo CLOCK_MUX_RESET_INFO[] = {
> > +    [CPRMAN_CLOCK_GNRIC] = {
> > +        .cm_ctl = 0, /* unknown */
> > +        .cm_div = 0
> > +    },
> > +
> [...]
> > +};
> > +
> >   #endif
> > diff --git a/hw/misc/bcm2835_cprman.c b/hw/misc/bcm2835_cprman.c
> > index 7a7401963d..7e415a017c 100644
> > --- a/hw/misc/bcm2835_cprman.c
> > +++ b/hw/misc/bcm2835_cprman.c
> > @@ -51,10 +51,21 @@
> >   #include "hw/misc/bcm2835_cprman_internals.h"
> >   #include "trace.h"
> >   /* PLL */
> > +static void pll_reset(DeviceState *dev)
> > +{
> > +    CprmanPllState *s = CPRMAN_PLL(dev);
> > +    const PLLResetInfo *info = &PLL_RESET_INFO[s->id];
> 
> Hmm so we overwrite various values from PLL_INIT_INFO.
> > +
> > +    *s->reg_cm = info->cm;
> > +    *s->reg_a2w_ctrl = info->a2w_ctrl;
> > +    memcpy(s->reg_a2w_ana, info->a2w_ana, sizeof(info->a2w_ana));
> > +    *s->reg_a2w_frac = info->a2w_frac;
> 
> set_pll_init_info() can be simplified as:
> 
>     pll->id = id;
>     pll->prediv_mask = PLL_INIT_INFO[id].prediv_mask;
> 
> Or directly in cprman_init():
> 
>     &s->plls[i]->id = i;
>     &s->plls[i]->prediv_mask = PLL_INIT_INFO[i].prediv_mask;
> 
> And the rest directly implemented in pll_reset().
> 
> Maybe not, but having pll_reset() added in patch #8/15
> "bcm2835_cprman: add a PLL channel skeleton implementation"
> would make this patch review easier ;)

Hi Phil,

I think there is a misunderstanding here:
  - set_xxx_init_info functions set (among others) register pointers
    to alias the common register array "regs" in BCM2835CprmanState.
    This is really an initialization step (in the sense of the QOM
    object). Those pointers won't move during the object's lifetime.
  - xxx_reset however (like e.g. xxx_update) _dereferences_ those
    pointers to access the registers data (in this case to set their
    reset values).

Doing so greatly decreases code complexity because:
  - read/write functions can directly access the common "regs" array
    without further decoding.
  - Each PLL shares a register with all its channels (A2W_CTRL). With
    this scheme, they simply all have a pointer aliasing the same data.
  - A lot a registers are unknown/unimplemented.

Thanks !

-- 
Luc

> 
> > +}
> > +
> >   static bool pll_is_locked(const CprmanPllState *pll)
> >   {
> >       return !FIELD_EX32(*pll->reg_a2w_ctrl, A2W_PLLx_CTRL, PWRDN)
> >           && !FIELD_EX32(*pll->reg_cm, CM_PLLx, ANARST);
> >   }
> > @@ -121,10 +132,11 @@ static const VMStateDescription pll_vmstate = {
> >   static void pll_class_init(ObjectClass *klass, void *data)
> >   {
> >       DeviceClass *dc = DEVICE_CLASS(klass);
> > +    dc->reset = pll_reset;
> >       dc->vmsd = &pll_vmstate;
> >   }
> [...]
> Similarly, implement clock_mux_reset() in patch #10/15
> "bcm2835_cprman: add a clock mux skeleton implementation".
> 
> Regards,
> 
> Phil.

-- 

