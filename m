Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C58BC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 21:39:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E34EF2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 21:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin-edu.20150623.gappssmtp.com header.i=@oberlin-edu.20150623.gappssmtp.com header.b="iY8mz6KA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E34EF2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38200 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEKwG-0005oH-C7
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 17:39:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hEKrf-0003Gd-TO
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 17:34:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stephen.checkoway@oberlin.edu>) id 1hEKgQ-00076g-F1
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 17:23:04 -0400
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:38736)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
	id 1hEKgM-00070k-Kc
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 17:23:02 -0400
Received: by mail-it1-x141.google.com with SMTP id f22so5980791ita.3
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 14:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=oberlin-edu.20150623.gappssmtp.com; s=20150623;
	h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
	:references; bh=oX/6YdDoDVg7CojU7LrvJTpsZ1sNTog7DBtEGTrGq4I=;
	b=iY8mz6KAGFvrXJ0PgJX1tH2I54fZ70f+wvwN8+tJTkt8Thdm0R7jTUEA1uONfV6LtT
	d1hmy51iEysFYgrC+6ncsy/6qfuUM1dFJcNtv9k3a522IMAIN+bvfWpW9TVHA7DVfy/M
	aOv3hcs+wOi3Ohcr3cFHPo86O7sImEtihLkkqYlPqAi/4fkDKCYg/OtBqfhnwx1Afmaf
	52EQnuIAf7HFus7ryj+cDSMPeytnjiZPEuQRIxOpZqt604IkHzRRBqGO0BpC65wpVMHg
	t7Q8IWpcE99apmXCWtncwbhhpAu9ROzd2YGEnHvJl/qNy3w++/bY4lEIja8vmPoiI1ZW
	proA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:message-id:mime-version:subject:date
	:in-reply-to:cc:to:references;
	bh=oX/6YdDoDVg7CojU7LrvJTpsZ1sNTog7DBtEGTrGq4I=;
	b=KfTX5h3f+Lc7sgaucCzCWBe4SaaIjyIvEiiyy7n8OsrODC3QNvpdsceRDsIsX7WWd2
	x7fiFryKgyodBK36np3/oo0skK9cBtsNFoAm4qbigx1OWppwqqKxLq/F1fJylHgfMq6a
	zQrHPY/G9w28W0ae7aIagGE2IrQ6TAAYJOAXLVGS7wEw5M84zkDXfOu1pPa4MUsXfl/i
	RFKGu7HkILhDmo7hQHkZpjECGGcRRZ4wpppu1hh4H3t6PofG3a+dEQXH3Hb+XuS4G1a6
	rtpjKTeEKA5NCae13Ab8H26fGKjc2MNhR7gKim/ZJJydnnPt5k9bR9wPbxXU+AnkoxJ8
	3SWg==
X-Gm-Message-State: APjAAAWuElYqp7907nSuPkGak5E5iJsl83rUNKM0LZFXYRKLRrvS9i66
	GR2GSxr8AxBvypTJ06XplAHYZg==
X-Google-Smtp-Source: APXvYqyUjqMqAEqbzpP6Ft3IJQ6lZal3UJCwKspMw/6pd5T6O2qr1dKX8IMGrFYdYfna/Hzh00YaZQ==
X-Received: by 2002:a24:2509:: with SMTP id g9mr5082518itg.149.1554931372791; 
	Wed, 10 Apr 2019 14:22:52 -0700 (PDT)
Received: from ?IPv6:2600:380:a55d:99f0:c406:ea61:ae88:5e28?
	([2600:380:a55d:99f0:c406:ea61:ae88:5e28])
	by smtp.gmail.com with ESMTPSA id
	y22sm14015106ioa.47.2019.04.10.14.22.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 10 Apr 2019 14:22:52 -0700 (PDT)
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
Message-Id: <437475C9-2835-4CBC-8A38-FF95E29569FA@oberlin.edu>
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Date: Wed, 10 Apr 2019 17:22:45 -0400
In-Reply-To: <1328f591-897f-8762-d324-cccb5f63a360@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190305051007.56009-1-stephen.checkoway@oberlin.edu>
	<52a82d3a-3b79-c61d-93fa-f087af45f6fb@redhat.com>
	<1328f591-897f-8762-d324-cccb5f63a360@redhat.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::141
X-Mailman-Approved-At: Wed, 10 Apr 2019 17:38:17 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] hw/char/escc: Lower irq when transmit
 buffer is filled
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
Cc: qemu-trivial@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Laurent Vivier <laurent@vivier.eu>,
	=?utf-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190410212245.MG3KJaXkkHTnhxdc_jlIct48gfmvQSoa_rLOqY_lSlo@z>



On Apr 10, 2019, at 16:01, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:

> On 3/6/19 12:01 PM, Paolo Bonzini wrote:
>> On 05/03/19 06:10, Stephen Checkoway wrote:
>>> The SCC/ESCC will briefly stop asserting an interrupt when the
>>> transmit FIFO is filled.
>>>=20
>>> This code doesn't model the transmit FIFO/shift register so the
>>> pending transmit interrupt is never deasserted which means that an
>>> edge-triggered interrupt controller will never see the low-to-high
>>> transition it needs to raise another interrupt. The practical
>>> consequence of this is that guest firmware with an interrupt service
>>> routine for the ESCC that does not send all of the data it has
>>> immediately will stop sending data if the following sequence of
>>> events occurs:
>>> 1. Disable processor interrupts
>>> 2. Write a character to the ESCC
>>> 3. Add additional characters to a buffer which is drained by the ISR
>>> 4. Enable processor interrupts
>>>=20
>>> In this case, the first character will be sent, the interrupt will
>>> fire and the ISR will output the second character. Since the pending
>>> transmit interrupt remains asserted, no additional interrupts will
>>> ever fire.
>>>=20
>>> This fixes that situation by explicitly lowering the IRQ when a
>>> character is written to the buffer.
>>>=20
>>> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
>>=20
>> Looks good but I would like Mark to give his ack as well.
>>=20
>> Mark, could you also add hw/char/escc.c to both SPARC and Mac =
sections
>> of MAINTAINERS?
>=20
> Cc'ing Artyom who also made some changes in this file, and Laurent.
>=20
>=20
> Stephen, which particular chipset are you using?

I'm away from the hardware, but my notes say Z80C30. I've included the =
image from the board if you want to try to decipher the rest of the part =
number. My best guess is it's a Z85C3008VEC. If it's important, I can =
ask someone who is a few thousand km closer to the hardware than I =
currently am to take a look.



> This file models various types. I had a talk with Mark or Laurent at
> last KVM forum about this device. IIRC, while the sun4m machines use a
> real chipset, the MacIO embeds an slighly modified IP core.
>=20
> I can't find what you describe in the Z85C30 doc, however in the ESCC
> datasheet referenced in escc.c (which happens to be a 85MiB pdf!!!) I =
found:

(This chip is ridiculously configurable, I honestly found it much easier =
to write a driver by reverse engineering existing firmware than by =
reading the part sheet.)

>=20
>  Transmit Interrupts and Transmit Buffer Empty Bit on the NMOS/CMOS
>=20
>  The TxIP is reset either by writing data to the transmit buffer or
>  by issuing the Reset Tx Int command in WR0.
>=20
> I understand the NMOS/CMOS desc. matches the Z85C30 (no FIFO used).

It has been a little while since I was last looking at this, but my =
recollection was the SCC has a 1-byte transmit buffer and the ESCC has a =
small (4 maybe?) byte transmit buffer. But in either case writing data =
to the transmit buffer should clear the interrupt.

> So your description and patch makes sens.
> What worries me is the controller could have other pending IRQs to
> deliver and you are clearing them. Shouldn't we only clear the
> INTR_TXINT bit, and call escc_update_irq() which should lower the IRQ =
if
> no bits are pending?
>=20
> Maybe as:
>=20
>    s->wregs[W_INTR] &=3D ~INTR_TXINT;
>    escc_update_irq(s);

Ah, I think I see. In this case, escc_update_irq() will lower the IRQ if =
no other interrupts are pending and the set_txint() will raise it again. =
Otherwise, it'll remain raised. I can give this a shot and see how it =
goes. (I think this should be R_INTR instead of W_INTR, but I'll double =
check once I have an opportunity to dig into this again.)

Thanks for looking at this!

Steve


--=20
Stephen Checkoway





