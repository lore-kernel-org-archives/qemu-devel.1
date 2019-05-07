Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920E0C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C05620578
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmfN0Kgp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C05620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48264 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO1fe-0008B7-G1
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:06:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hO1dZ-0006X2-M8
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:04:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hO1dY-00046F-9N
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:04:09 -0400
Received: from mail-it1-x143.google.com ([2607:f8b0:4864:20::143]:34894)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1hO1dY-00045R-2P
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:04:08 -0400
Received: by mail-it1-x143.google.com with SMTP id l140so26268735itb.0
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 08:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Qk+BUUuOsQX6n5dqHox1f5kCJ4tKpfjXdtkDP7Xlmwg=;
	b=PmfN0KgpOuA5x6aehIgIxXNqi+jRcTq3kq5BWgBqDpLd4nFj3HUJxsD9PES7ExRLy8
	R8bFjM84CpwPnOqPJa16WZXZ4qWpYZtYZw+PyBKC2h0Le6zZqjcFfzGFeIbHJhEe7z0N
	Ql6tkAhRjI4Ip67oY5O0todQl6aRkt15uGEEDWRAcrCwPDzpQxp9APdv7Wri/RyPi0ab
	27/Q1/y2xcBFy0Er/Gllqp77HJmqyAP2Zi2eIMXi08VWIvKLDCdRlgW8ZboPgi5yDSng
	OywdWePrIABOTMt39I0Pme/oHt3S0qhntvOMhugj22Qtcv6Qky7Gti2hBjZ4YsSeEL3U
	a6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Qk+BUUuOsQX6n5dqHox1f5kCJ4tKpfjXdtkDP7Xlmwg=;
	b=snZ5FiYMr945iEI/xDNv3T1TA0rpzbONp634rheHcIRkPfZzxvJmiVhVDK3A4ju9St
	LLQ61tt/5XzOOhk3ShRCbBpIhZ+AFeiuzBwH1+NMTbWcM9502qq4fxL4je/qT/p9qMwB
	3yTYWa8r1/cQvFGanwlJ7iO1pKuS7FAtKZooTSFRMLe0s9cVypiHKt5IHvHQpA1dpyXG
	xLaw9xWyqHZnZP6/HOzJXJe4wS0ahpkkpxHWc7Onj+V7i6Y2r9CqYxSfC7u1x392NKYS
	W4U1oO2aByqWfMHLijt9H3lwrntP98QCgfL9hy8+r8NIosRmWT6lMDKopbejI1x/ipsD
	ZXBA==
X-Gm-Message-State: APjAAAWr3wJZlDDCoEwflXvRKQB3T2VQxXCXGuIYUgKV+mSHM7VsjDvt
	27TFJVGudJyIsWw8cEzM8Cl6fYtLuwKxkniyW7U=
X-Google-Smtp-Source: APXvYqz8yCQG0LaYshoryNriPZPUME7Iw1WDHmuY9EVMP3PMEz0unX/stKDADi7XJLvXJ/fwVXvw6FqCwG5n9lLpKtw=
X-Received: by 2002:a24:7c9:: with SMTP id f192mr23697268itf.97.1557241446283; 
	Tue, 07 May 2019 08:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
	<1557003754-26473-2-git-send-email-atar4qemu@gmail.com>
	<d28ed626-f7f8-53df-208a-cbf6c06e3cc9@ilande.co.uk>
	<CACXAS8BU-OamhTL03QNuukiKvy+vpdu8VRB4gWPe2+zz2nEymA@mail.gmail.com>
	<5306bcc1-e308-05eb-9ce5-79553cee3a23@ilande.co.uk>
In-Reply-To: <5306bcc1-e308-05eb-9ce5-79553cee3a23@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Tue, 7 May 2019 17:03:56 +0200
Message-ID: <CACXAS8AAXTy1xiQp2ftjEqhkXkbn-QG6Z=6AfKFCqJhT7eDF7Q@mail.gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::143
Subject: Re: [Qemu-devel] [PATCH v2 1/3] lsi53c895a: hide 53c895a registers
 in 53c810
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
	qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 6, 2019 at 4:27 PM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 06/05/2019 09:42, Artyom Tarasenko wrote:
>
> > On Sun, May 5, 2019 at 12:43 PM Mark Cave-Ayland
> > <mark.cave-ayland@ilande.co.uk> wrote:
> >>
> >> On 04/05/2019 22:02, Artyom Tarasenko wrote:
> >>
> >>> AIX/PReP does access to the aliased IO registers of 53810.
> >>> Implement aliasing to make the AIX driver work.
> >>>
> >>> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> >>> ---
> >>>  hw/scsi/lsi53c895a.c | 17 ++++++++++++++---
> >>>  1 file changed, 14 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> >>> index da7239d..6b95699 100644
> >>> --- a/hw/scsi/lsi53c895a.c
> >>> +++ b/hw/scsi/lsi53c895a.c
> >>> @@ -2271,6 +2271,9 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
> >>>      LSIState *s = LSI53C895A(dev);
> >>>      DeviceState *d = DEVICE(dev);
> >>>      uint8_t *pci_conf;
> >>> +    uint64_t mmio_size;
> >>> +    MemoryRegion *mr;
> >>> +    uint16_t type = PCI_DEVICE_GET_CLASS(dev)->device_id;
> >>>
> >>>      pci_conf = dev->config;
> >>>
> >>> @@ -2279,13 +2282,21 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
> >>>      /* Interrupt pin A */
> >>>      pci_conf[PCI_INTERRUPT_PIN] = 0x01;
> >>>
> >>> -    memory_region_init_io(&s->mmio_io, OBJECT(s), &lsi_mmio_ops, s,
> >>> -                          "lsi-mmio", 0x400);
> >>>      memory_region_init_io(&s->ram_io, OBJECT(s), &lsi_ram_ops, s,
> >>>                            "lsi-ram", 0x2000);
> >>>      memory_region_init_io(&s->io_io, OBJECT(s), &lsi_io_ops, s,
> >>>                            "lsi-io", 256);
> >>> -
> >>> +    if (type == PCI_DEVICE_ID_LSI_53C895A) {
> >>> +        mmio_size = 0x400;
> >>> +    } else {
> >>> +        mr = g_new(MemoryRegion, 1);
> >>
> >> In general these days it's worth keeping the reference to the MemoryRegion within
> >> LSIState since then its lifecycle is more clearly defined.
> >
> > On the other hand, it's a PCI card, and can not be
> > hot-plugged/removed, so the lifecycle is pretty simple here.
> > Or am I missing something?
>
> Well Thomas has been working on a set of tests that for each machine will plug and
> unplug each device via the monitor to make sure that init/realize/unrealize work
> correctly so it would be good to ensure that these tests don't leak.

Makes sense, indeed.

> However...
>
> >>> +        memory_region_init_alias(mr, OBJECT(d), "lsi-io-alias", &s->io_io,
> >>> +                                 0, 0x80);
> >>> +        memory_region_add_subregion_overlap(&s->io_io, 0x80, mr, -1);
> >>> +        mmio_size = 0x80;
> >>
> >> This feels a little strange - is it possible to see from the datasheets that the
> >> 53C895A has 0x400 bytes MMIO whilst the 53C810 has 0x80 bytes MMIO? It's not clear to
> >> me where the aliasing is happening.
> >
> > These values are empiric. For 810 it can not be more than 0x80,
> > because the AIX does access the registers with the shift of 0x80.
> > For  895A we did already have 0x400.
>
> After a bit of searching I managed to locate an 810 datasheet and in Chapter 5 it
> clearly describes the IO space (s->io_io) as being 256 bytes in size which is the
> same as the 895A, but with 0x80-0xff aliased onto 0x00 - 0x7f.
>
> It feels to me that rather than complicate things with an additional alias
> MemoryRegion, the simplest solution would be to simply change the mask in
> lsi_io_read() and lsi_io_write() to be 0x7f rather than 0xff if we've instantiated a
> 810 rather than an 895A.

Initially I implemented it exactly as you suggest, via mask. But then
I thought that memory_region_init_alias makes aliasing more obvious.
I don't have a strong opinion on this one though.

@Paolo, what do you think?

-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu

