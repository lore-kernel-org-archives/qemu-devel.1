Return-Path: <SRS0=PWAB=4X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AB0C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A60A2072D
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2020 12:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A60A2072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jABlh-0007Au-O8
	for qemu-devel@archiver.kernel.org; Fri, 06 Mar 2020 07:07:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jABkr-0006D4-1p
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:07:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jABko-0005Jp-Te
 for qemu-devel@nongnu.org; Fri, 06 Mar 2020 07:07:00 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:30753)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jABkj-00050r-L2; Fri, 06 Mar 2020 07:06:54 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6FBF774638A;
 Fri,  6 Mar 2020 13:06:48 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4E25374637C; Fri,  6 Mar 2020 13:06:48 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 4C21F7461AE;
 Fri,  6 Mar 2020 13:06:48 +0100 (CET)
Date: Fri, 6 Mar 2020 13:06:48 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH 2/2] via-ide: Also emulate non 100% native mode
In-Reply-To: <071fff0a-e922-502d-da18-2572f73cecdf@ilande.co.uk>
Message-ID: <alpine.BSF.2.22.395.2003061221220.10004@zero.eik.bme.hu>
References: <cover.1583017348.git.balaton@eik.bme.hu>
 <bdbef976-a853-7178-8163-579e4bf9e2e0@ilande.co.uk>
 <alpine.BSF.2.22.395.2003011731130.95594@zero.eik.bme.hu>
 <57ff6676-5054-d3f6-f4fc-6ff02b09019f@ilande.co.uk>
 <alpine.BSF.2.22.395.2003011902490.28669@zero.eik.bme.hu>
 <alpine.BSF.2.22.395.2003011951370.28669@zero.eik.bme.hu>
 <38cb0f83-79fc-7021-38fc-c1e28c3c0fa0@ilande.co.uk>
 <alpine.BSF.2.22.395.2003012202330.79908@zero.eik.bme.hu>
 <9ce6d135-4169-96ae-c457-1131b4510c49@ilande.co.uk>
 <alpine.BSF.2.22.395.2003022145430.47473@zero.eik.bme.hu>
 <2a39ccab-e4d4-8172-9a1d-0bc089e0104c@ilande.co.uk>
 <alpine.BSF.2.22.395.2003032356230.41934@zero.eik.bme.hu>
 <a579c016-fd6c-ad4f-c091-2286265c9a57@ilande.co.uk>
 <alpine.BSF.2.22.395.2003042227190.70853@zero.eik.bme.hu>
 <b3bce0d3-3ab3-7fb3-ed3c-60f1f19159d6@ilande.co.uk>
 <alpine.BSF.2.22.395.2003060007040.48868@zero.eik.bme.hu>
 <071fff0a-e922-502d-da18-2572f73cecdf@ilande.co.uk>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
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

On Fri, 6 Mar 2020, Mark Cave-Ayland wrote:
> On 05/03/2020 23:35, BALATON Zoltan wrote:
>> On real hardware this may be true but in QEMU how would it otherwise raise the
>> correct interrupt line the guest expects? This probably does not matter for pegasos2
>> but I think is needed for 100% native mode used with the fulong2e so it gets the IRQ
>> it expects.
>
> That's easy - remember that both the PCI and IRQ interrupts are separate pins on the
> chip, so all that needs to be done is expose the legacy IRQ via qdev and use that to
> wire it up to your interrupt controller.

This "chip" is part of an integrated southbridge/superio/everything chip 
the also includes the two PICs and how they are internally connected is 
not known so we would be guessing here anyway. I don't see a need to make 
it more complicated than it is now by modeling internal pins but how would 
I wire up gpio to the i8259 model and where should I connect the PCI irq?

> Okay so this is interesting: I've been switching between the VT8231 and the VT82C686B
> datasheets, and there is a difference here. You are correct in what you say above in
> that the 8231 docs specify that this is set to 1, but on the 686B this is clearly not
> the case.

The 82C686B says this reg can be 0 or 1, where 0 is legacy interrupt 
routing and 1 is native mode. Given that we only model native mode of the 
chip it does not make sense to set it to anything else than 1 and setting 
it to 0 confuses MorphOS and Linux on pegasos2 while setting it to 1 works 
with everything I've tried both on pegasos2 and fulong2e even if that may 
not completely match how it's implemented in hardware.

> What is rather unusual here is that both the 8231 and 686B have exactly the same
> device and vendor ids, so I'm not sure how you'd distinguish between them?

Guests distinguish by looking at the parent device (function 0) which is 
the chip this IDE device is part of (on function 1).

Regards,
BALATON Zoltan

