Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D210C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:09:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0553220862
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 15:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0553220862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55993 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUBpG-0006LR-Pv
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 11:09:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaro.koskinen@iki.fi>) id 1hUBna-00057i-1n
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaro.koskinen@iki.fi>) id 1hUBgJ-0003fJ-0t
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:00:31 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:54786)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aaro.koskinen@iki.fi>)
	id 1hUBgI-0003dZ-3p
	for qemu-devel@nongnu.org; Fri, 24 May 2019 11:00:26 -0400
Received: from t60.musicnaut.iki.fi (85-76-86-221-nat.elisa-mobile.fi
	[85.76.86.221])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 443BD20035;
	Fri, 24 May 2019 18:00:20 +0300 (EEST)
Date: Fri, 24 May 2019 18:00:18 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Peter Maydell <peter.maydell@linaro.org>,
	Thomas Huth <thuth@redhat.com>
Message-ID: <20190524150018.GA3156@t60.musicnaut.iki.fi>
References: <20190520190533.GA28160@Red>
	<20190521232323.GD3621@darkstar.musicnaut.iki.fi>
	<20190522093341.GA32154@Red>
	<20190522181904.GE3621@darkstar.musicnaut.iki.fi>
	<8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>
	<c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
	<20190523183623.GB5234@darkstar.musicnaut.iki.fi>
	<CAFEAcA8C0WN5FwaW2kfWiRm1T8wML_fWXDKqRXP-Lv_P7ysy8A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8C0WN5FwaW2kfWiRm1T8wML_fWXDKqRXP-Lv_P7ysy8A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 62.142.5.107
Subject: Re: [Qemu-devel] Running linux on qemu omap
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Tony Lindgren <tony@atomide.com>, QEMU Developers <qemu-devel@nongnu.org>,
	lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Fri, May 24, 2019 at 10:08:09AM +0100, Peter Maydell wrote:
> On Thu, 23 May 2019 at 19:36, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> > Cheetah works with serial console. I tried with console on display,
> > and it seems to boot up, and the frame buffer window gets correctly
> > sized but for some reason it just stays blank.
> 
> As a general question, when you're doing these tests are you
> using a kernel image that is known to work on real hardware?

With Cheetah (I wonder where that name comes from?), yes, same for
N8x0. SX1 I don't have, but the SoC is the same as on Palm TE.

> One problem we have with some of these older QEMU platforms
> is that it turns out that QEMU is only tested with the kernel,
> and the kernel support for the platform is only tested with
> QEMU, and so you get equal and opposite bugs in QEMU and the
> kernel that cancel each other out and don't get noticed...
>
> (On the QEMU side these platforms are all basically orphaned:
> if somebody submits patches to fix bugs we'll review them,
> but they're unlikely to get a great deal of attention otherwise.
> They're also quite near the top of the "maybe we'll just
> deprecate and then delete these" list, since we have not
> historically had any working guest images to test against.
> If there's a real userbase that wants them to continue to
> exist that's a different matter, of course.)

Please don't delete OMAP boards quite yet :) In the mainline kernel
they are not orphaned, they frequently get tested using actual hardware,
and QEMU would help in additional testing. I'll try to get N8x0 boot to
work with the minimal kernel I use on real HW.

Regarding N8x0 and bluetooth (mentioned in one of the linked threads), I
guess the removal of the bluetooth subsystem can be done without removing
the whole machine: just don't pass the OMAP BT TAG to the kernel anymore,
and it should ignore the BT hardware (just an idea based on quick read
of vendor kernel sources, the mainline kernel does not support BT on
this board).

A.

