Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B1EC10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E6B21D7E
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 18:37:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E6B21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBjl4-0004RH-8p
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 14:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jBjkG-0003T7-8w
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jBjkF-0003lU-63
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 14:36:48 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:17296)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jBjk9-0003a5-Km; Tue, 10 Mar 2020 14:36:44 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 4CF7A746381;
 Tue, 10 Mar 2020 19:36:40 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 26FE574637D; Tue, 10 Mar 2020 19:36:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 25575745953;
 Tue, 10 Mar 2020 19:36:40 +0100 (CET)
Date: Tue, 10 Mar 2020 19:36:40 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v3 0/3] Implement "non 100% native mode" in via-ide
In-Reply-To: <9b16aa01-9220-86a8-f0ae-dd297dc0254e@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2003101935120.30321@zero.eik.bme.hu>
References: <cover.1583781493.git.balaton@eik.bme.hu>
 <9b16aa01-9220-86a8-f0ae-dd297dc0254e@ilande.co.uk>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: qemu-block@nongnu.org, philmd@redhat.com, qemu-devel@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>, John Snow <jsnow@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 10 Mar 2020, Mark Cave-Ayland wrote:
> On 09/03/2020 19:18, BALATON Zoltan wrote:
>> This small series implements "non-100% native mode" of via-ide found
>> at least on pegasos2 where io addresses come from PCI BARs but
>> interrupts are hard coded to legacy IRQ14 and 15. This is needed for
>> guests that expect it and activate work arounds on that platform and
>> don't work unless this is emulated. (Symptom is missing IDE IRQs after
>> enabling BMDMA and boot freezes waiting for interrupt.)
>>
>> We need a flag to turn this mode on or off so the first patch
>> repurposes the last remaining CMD646 specific field in PCIIDEState to
>> allow more flags and make room for the new legacy-irq flag there. (The
>> CMD646 may need similar mode or something else may need more flags in
>> the future.) Boards using CMD646 and VIA IDE are updated for the above
>> changes. Second patch fixes up PCI reset to not clear value set by
>> device emulation on bus reset when wmask does not allow that.
>>
>> Tested with Linux and MorphOS on pegasos2 and a Gentoo live CD kernel
>> for mips_fulong2e that's the only one I could find but being beta not
>> sure if that fully works on real hardware. (The mips_fulong2e also
>> seems to have problems with pci devices so to boot Linux you need
>> -net none -vga none and use serial console otherwise the kernel panics.)
>>
>> Regards,
>> BALATON Zoltan
>>
>> BALATON Zoltan (3):
>>   ide: Make room for flags in PCIIDEState and add one for legacy IRQ
>>     routing
>>   pci: Honour wmask when resetting PCI_INTERRUPT_LINE
>>   via-ide: Also emulate non 100% native mode
>>
>>  hw/alpha/dp264.c        |  2 +-
>>  hw/ide/cmd646.c         | 12 ++++++------
>>  hw/ide/via.c            | 37 +++++++++++++++++++++++++++++--------
>>  hw/mips/mips_fulong2e.c |  2 +-
>>  hw/pci/pci.c            |  4 +++-
>>  hw/sparc64/sun4u.c      |  9 ++-------
>>  include/hw/ide.h        |  7 ++++---
>>  include/hw/ide/pci.h    |  7 ++++++-
>>  8 files changed, 52 insertions(+), 28 deletions(-)
>
> To summarise what has been quite a long thread, I don't believe the approach of
> introducing a feature flag for legacy IRQ routing is the correct solution here. It
> seems to me that qdev can do all the work: provide qdev gpio connectors for 2 IRQ
> sets: a named "legacy-irq" array and a standard ("irq") qdev connector and then let
> the boards wire up the ones as they need.
>
> With this in place it is simple to always fallback to the legacy IRQs if no PCI IRQ
> is connected regardless of mode, and this also allows the deprecated isa_get_irq()
> function to be removed.

You have to provide an example patch to show how this would work because I 
can't implement this. I don't see how it could work so to me this just a 
vague idea not something I can make a patch from.

Regards,
BALATON Zoltan

