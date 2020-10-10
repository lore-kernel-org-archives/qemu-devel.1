Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D07C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 11:50:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 967C422251
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 11:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lmichel.fr header.i=@lmichel.fr header.b="OdzC12zn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 967C422251
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=lmichel.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRDOl-0004Ea-Lz
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 07:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRDNp-0003hB-O7; Sat, 10 Oct 2020 07:49:53 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74]:39466)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>)
 id 1kRDNn-0007IX-3y; Sat, 10 Oct 2020 07:49:53 -0400
Received: from localhost (sekoia-pc.home.lmichel.fr [192.168.61.100])
 by pharaoh.lmichel.fr (Postfix) with ESMTPSA id 0D64FC6011D;
 Sat, 10 Oct 2020 11:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1602330587;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=21GjTUkOaWEaXIPZ9M/Ys8QapeGMAn1D21inimEaRy4=;
 b=OdzC12zn86IFmhZFnN5p99rSnGvov3mWT1XMTnhq33iSGGa5LodtZA0nlilsisw7fLbpSV
 mD+BGgqa4r68QAT7dTaLOmAwWqvmXrtU0CETGJRDC20nzBPAfZl7l9oiN0X0PcRfXIc7Ct
 WGVBx/R1bLPgSUjoqJUsj6Y84q4vGBloMdvrUhqNsCGxdWPRwdymYCh4k5pYE9LijttvGs
 /rLY0zBW+ccl6WsGn0HPar5o5B+0jr9LcmMzgKIo5Z00qHzyEuVgofZ7daUkpRYFUGsP3H
 jzeuV7vN0Q7c8SI6OjfowC2BgD8n5dOVXrJRbBpDotsZU2c8hxTZcGZ48ufuKQ==
Date: Sat, 10 Oct 2020 13:50:47 +0200
From: Luc Michel <luc@lmichel.fr>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Subject: Re: [PATCH v2 10/15] hw/misc/bcm2835_cprman: add a clock mux
 skeleton implementation
Message-ID: <20201010115047.3aaffhhl5mzi77jc@sekoia-pc.home.lmichel.fr>
References: <20201005195612.1999165-1-luc@lmichel.fr>
 <20201005195612.1999165-11-luc@lmichel.fr>
 <ea432580-114b-3f85-b4f1-0012bfb008c0@amsat.org>
 <20201010113308.igrxc54fwizo74oh@sekoia-pc.home.lmichel.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201010113308.igrxc54fwizo74oh@sekoia-pc.home.lmichel.fr>
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr;
 s=pharaoh; t=1602330587;
 h=from:from:sender:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=21GjTUkOaWEaXIPZ9M/Ys8QapeGMAn1D21inimEaRy4=;
 b=i9ip0Ea/ltx8sTLJudgePY5qzdcP8qonZB2ehYG45x8Zptyy9Ia5hWZJJexH+xChNjvnAu
 bQn7HKJO7QMrn+ghS451DS9axPPFJ3brXMiPOhnniN6lCNBlZ5Fs0xsg8njMvssqgTmQYt
 5sLKvpC2s6eUPFMqd8vn9rgWEXKxVgHWcLZ3cm6kZ9vCSyjw3QdOjXDlNP8xicRmPbXCgl
 VbyIs3YRtqxIBpXFmequyg8tvN9CZUqFndYhd26hgZtYq1FQWE1yQqpMOsu6XRI4Fms3tD
 LokFErmqACv/G+ICt5yHntwOPl32kF3da+y2eLki+x+LQkt4PgkXV952P34DzQ==
ARC-Seal: i=1; s=pharaoh; d=lmichel.fr; t=1602330587; a=rsa-sha256; cv=none;
 b=MbnAlTCwLk5mrDUb8Ahl7qp/qZp0bm7RZhmkShHtyG8mpiNOErHLjaQ1/9U/6K0saulwRGfLgYopejWt+XmhUK3qxxXmn269gjKUrqWZ947WJPXicMzmxFlJKfcUj4XrHkgQlbMnHo6xpAMlAUA2fHXRHJiKUevRbLHeY8YyjkAf24eK8pku93KOQqCW2KXuYJo1bet0kChGk0cMwatTgbNJkOY66Kne8JGsGg5CdeYAC4akIRC225RTeGEX0f8DuzZcSEsdRM2qBkPIJGIeQ6k6JTgALb18FIArNhsH/NWfDZVgABUsiczphaHPTxVf2Ei3Oc4ukvjoldIZIIe7vg==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=sekoia smtp.mailfrom=luc@lmichel.fr
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 07:32:09
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

On 13:33 Sat 10 Oct     , Luc Michel wrote:
> On 10:40 Tue 06 Oct     , Philippe Mathieu-Daudé wrote:
> > On 10/5/20 9:56 PM, Luc Michel wrote:
> > > The clock multiplexers are the last clock stage in the CPRMAN. Each mux
> > > outputs one clock signal that goes out of the CPRMAN to the SoC
> > > peripherals.
> > > 
> > > Each mux has at most 10 sources. The sources 0 to 3 are common to all
> > > muxes. They are:
> > >    0. ground (no clock signal)
> > >    1. the main oscillator (xosc)
> > >    2. "test debug 0" clock
> > >    3. "test debug 1" clock
> > > 
> > > Test debug 0 and 1 are actual clock muxes that can be used as sources to
> > > other muxes (for debug purpose).
> > > 
> > > Sources 4 to 9 are mux specific and can be unpopulated (grounded). Those
> > > sources are fed by the PLL channels outputs.
> > > 
> > > One corner case exists for DSI0E and DSI0P muxes. They have their source
> > > number 4 connected to an intermediate multiplexer that can select
> > > between PLLA-DSI0 and PLLD-DSI0 channel. This multiplexer is called
> > > DSI0HSCK and is not a clock mux as such. It is really a simple mux from
> > > the hardware point of view (see https://elinux.org/The_Undocumented_Pi).
> > > This mux is not implemented in this commit.
> > > 
> > > Note that there is some muxes for which sources are unknown (because of
> > > a lack of documentation). For those cases all the sources are connected
> > > to ground in this implementation.
> > > 
> > > Each clock mux output is exported by the CPRMAN at the qdev level,
> > > adding the suffix '-out' to the mux name to form the output clock name.
> > > (E.g. the 'uart' mux sees its output exported as 'uart-out' at the
> > > CPRMAN level.)
> > > 
> > > Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> > > Signed-off-by: Luc Michel <luc@lmichel.fr>
> > > ---
> > >  include/hw/misc/bcm2835_cprman.h           |  84 ++++
> > >  include/hw/misc/bcm2835_cprman_internals.h | 421 +++++++++++++++++++++
> > >  hw/misc/bcm2835_cprman.c                   | 150 ++++++++
> > >  3 files changed, 655 insertions(+)
> > [...]
> > 
> > > +#define FILL_CLOCK_MUX_INIT_INFO(clock_, kind_) \
> > > +    .cm_offset = R_CM_ ## clock_ ## CTL,        \
> > > +    FILL_CLOCK_MUX_SRC_MAPPING_INIT_INFO(kind_)
> > > +
> > > +static ClockMuxInitInfo CLOCK_MUX_INIT_INFO[] = {
> > > +    [CPRMAN_CLOCK_GNRIC] = {
> > > +        .name = "gnric",
> > > +        FILL_CLOCK_MUX_INIT_INFO(GNRIC, unknown),
> > > +    },
> > [...]
> > 
> > > +static inline void update_mux_from_cm(BCM2835CprmanState *s, size_t idx)
> > > +{
> > > +    size_t i;
> > > +
> > > +    for (i = 0; i < CPRMAN_NUM_CLOCK_MUX; i++) {
> > > +        if ((CLOCK_MUX_INIT_INFO[i].cm_offset == idx) ||
> > > +            (CLOCK_MUX_INIT_INFO[i].cm_offset == idx + 4)) {
> > 
> > Maybe add a /* Matches DIV or CTL */ comment. Anyway
> > FILL_CLOCK_MUX_INIT_INFO() only uses CTL, not DIV, so
> > +4 check is not necessary.
> I'll add a comment to clarify this. The +4 check is indeed necessary.
> This comes from the fact that for all muxes, CM_CTL and CM_DIV registers are
> contiguous. So I treat CprmanClockMuxState.reg_cm as a 2 cells array (as
> I do for PLLs and the A2W_ANA regs). I'll clarify this point in the next
> re-roll.
But the +4 is actually on the wrong side of the comparison :) I'll fix
that.
> 
> > 
> > Otherwise:
> > Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Thanks!
> > 
> > > +            clock_mux_update(&s->clock_muxes[i]);
> > > +            return;
> > > +        }
> > > +    }
> > > +}
> > > +
> > >  #define CASE_PLL_A2W_REGS(pll_) \
> > >      case R_A2W_ ## pll_ ## _CTRL: \
> > >      case R_A2W_ ## pll_ ## _ANA0: \
> > >      case R_A2W_ ## pll_ ## _ANA1: \
> > >      case R_A2W_ ## pll_ ## _ANA2: \
> > > @@ -363,10 +438,19 @@ static void cprman_write(void *opaque, hwaddr offset,
> > >      case R_A2W_PLLH_RCAL:
> > >      case R_A2W_PLLH_PIX:
> > >      case R_A2W_PLLB_ARM:
> > >          update_channel_from_a2w(s, idx);
> > >          break;
> > > +
> > > +    case R_CM_GNRICCTL ... R_CM_SMIDIV:
> > > +    case R_CM_TCNTCNT ... R_CM_VECDIV:
> > > +    case R_CM_PULSECTL ... R_CM_PULSEDIV:
> > > +    case R_CM_SDCCTL ... R_CM_ARMCTL:
> > > +    case R_CM_AVEOCTL ... R_CM_EMMCDIV:
> > > +    case R_CM_EMMC2CTL ... R_CM_EMMC2DIV:
> > > +        update_mux_from_cm(s, idx);
> > > +        break;
> > >      }
> > >  }
> > [...]
> 
> -- 

-- 

