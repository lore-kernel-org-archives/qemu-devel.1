Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46AD7C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 18:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3672177E
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 18:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3672177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41749 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTsaq-0001SN-DY
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 14:37:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aaro.koskinen@iki.fi>) id 1hTsa1-000196-QZ
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:36:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aaro.koskinen@iki.fi>) id 1hTsa0-00070m-Mn
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:36:41 -0400
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:55846)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aaro.koskinen@iki.fi>)
	id 1hTsa0-0006rd-Dd
	for qemu-devel@nongnu.org; Thu, 23 May 2019 14:36:40 -0400
Received: from darkstar.musicnaut.iki.fi (85-76-4-80-nat.elisa-mobile.fi
	[85.76.4.80])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id F02B220060;
	Thu, 23 May 2019 21:36:23 +0300 (EEST)
Date: Thu, 23 May 2019 21:36:23 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190523183623.GB5234@darkstar.musicnaut.iki.fi>
References: <20190520190533.GA28160@Red>
	<20190521232323.GD3621@darkstar.musicnaut.iki.fi>
	<20190522093341.GA32154@Red>
	<20190522181904.GE3621@darkstar.musicnaut.iki.fi>
	<8977e2bb-8d9e-f4fd-4c44-b4f67e0e7314@redhat.com>
	<c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <c2972889-fe60-7614-fb6e-e57ddf780a54@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 62.142.5.108
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
	Tony Lindgren <tony@atomide.com>, qemu-devel@nongnu.org,
	linux-kernel@vger.kernel.org, Corentin Labbe <clabbe.montjoie@gmail.com>,
	linux-omap@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Thu, May 23, 2019 at 02:00:41PM +0200, Philippe Mathieu-Daud=E9 wrote:
> On 5/23/19 1:27 PM, Thomas Huth wrote:
> > On 22/05/2019 20.19, Aaro Koskinen wrote:
> >> On Wed, May 22, 2019 at 11:33:41AM +0200, Corentin Labbe wrote:
> >>> qemu-system-arm -M help |grep OMAP
> >>> cheetah              Palm Tungsten|E aka. Cheetah PDA (OMAP310)
> >>> n800                 Nokia N800 tablet aka. RX-34 (OMAP2420)
> >>> n810                 Nokia N810 tablet aka. RX-44 (OMAP2420)
> >>> sx1                  Siemens SX1 (OMAP310) V2
> >>> sx1-v1               Siemens SX1 (OMAP310) V1
> >>>
> >>>>> The maximum I can get with omap1_defconfig is
> >>>>> qemu-system-arm -kernel zImage -nographic -machine cheetah -appen=
d 'root=3D/dev/ram0 console=3DttyO0'
> >>>>> Uncompressing Linux... done, booting the kernel.
> >>>>> then nothing more.
> >>
> >> With N800/N810 omap2plus_defconfig should be used instead. However,
> >> I don't think that works either (but haven't tried recently). Also w=
ith
> >> N800/N810 you need to append the DTB file to the kernel image.
> >=20
> > FWIW, Philippe recently posted a mail how to run older kernels on n81=
0:
> >=20
> > https://www.mail-archive.com/qemu-devel@nongnu.org/msg610653.html

So it seems the issue with N8x0 is that serial console does not work.
And we are missing the display support in the mainline kernel.

> However I can see than none of the board listed by Corentin are tested
> ... That reminder me I never succeed at using the Cheetah PDA. So the
> OMAP310 is probably bitroting in QEMU...

Cheetah works with serial console. I tried with console on display,
and it seems to boot up, and the frame buffer window gets correctly
sized but for some reason it just stays blank.

A.

