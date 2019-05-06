Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4876C04AAA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:44:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D6F6205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K2fiqznq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D6F6205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52764 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNZEC-0002SZ-Pe
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 04:44:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hNZCi-0001RA-TN
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:42:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hNZCh-0003VB-OK
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:42:32 -0400
Received: from mail-it1-x142.google.com ([2607:f8b0:4864:20::142]:38629)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>) id 1hNZCh-0003Uf-KE
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:42:31 -0400
Received: by mail-it1-x142.google.com with SMTP id q19so18691447itk.3
	for <qemu-devel@nongnu.org>; Mon, 06 May 2019 01:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=JLZkujPAzctk6aWUQSLVZLHCTNcDM+ZaEVoPEZhL1S4=;
	b=K2fiqznq6Grh1kIWObucm6EA5BqS8I0U5puYeJolqgZvTjfzkdfkxgjRICC3dNUGqc
	yvymyENIFAssOOXX1BpTE4oZ5JTajLrHaNUCXRUpUKvhtEv3uwYC6xAIhnbketiepZ/a
	29q5XBne3yuNyJPvyKAFSNYa5/QZ4aOQ4sM7/3ExL9yoPKrphY0AsHOGtO2jiH6kh9rW
	9LUhKeTvd3ByJJxpMinSWTI4xOnfm9Vgc95BM35WMkVVenmb20mW2zRrlrLH95O2yxCf
	iVyZcqxkZze8aO+8F3XBpxHabWropLmfXWprSfL0jml1XUi6bhpjs1HAed4N3C3HWroG
	FhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=JLZkujPAzctk6aWUQSLVZLHCTNcDM+ZaEVoPEZhL1S4=;
	b=j/T42fKQoO7NUYkhsq5TmcJOGI4aZD89tkasehABYoqaelZ5kvpnsLUIUz4CQSUEBa
	f7QjsnGdnuUNLShfUyQsGzrFb392GQ9Rp8HizI0zuEXqw2fkCFJJ0w2f/YoFyaaSi0M9
	bVEx9kZIlUyLZ4IVzm5XOshSnTQG1GjJihwlXk548Qp9TgNB9glt71JNbcBF9+tvY/7Y
	DBPTGA4n4rB7aR5L5PsAWoExr3/BVLmWg50NY4ZTHjSPIrpG3+mSC8CLrQrrobm6Lfq/
	M/QlyvDmbIrCMIQV3chnEcVjI494Fr1aTtowLexEoaUkEPeD/rUKurFLh3v4a29Ppv4Q
	/djw==
X-Gm-Message-State: APjAAAV/yRoOYktW1euRqM91RaOF+2fRwrofOBw9iXXPAXX7aMRUqilo
	d5do0M7otfchU3cUSD9ebb3QofqFxFNWewkVdnE=
X-Google-Smtp-Source: APXvYqyaSF/69U7Fvz9+YWh5eeMIE6I9KD8BjGLIza1VxSuBcEw/uwc8yoFjREjUar5hR4jYWBN3pMKh8rujljAbWQ8=
X-Received: by 2002:a24:ac11:: with SMTP id s17mr186238ite.132.1557132150318; 
	Mon, 06 May 2019 01:42:30 -0700 (PDT)
MIME-Version: 1.0
References: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
	<1557003754-26473-2-git-send-email-atar4qemu@gmail.com>
	<d28ed626-f7f8-53df-208a-cbf6c06e3cc9@ilande.co.uk>
In-Reply-To: <d28ed626-f7f8-53df-208a-cbf6c06e3cc9@ilande.co.uk>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 6 May 2019 10:42:20 +0200
Message-ID: <CACXAS8BU-OamhTL03QNuukiKvy+vpdu8VRB4gWPe2+zz2nEymA@mail.gmail.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::142
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

On Sun, May 5, 2019 at 12:43 PM Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
>
> On 04/05/2019 22:02, Artyom Tarasenko wrote:
>
> > AIX/PReP does access to the aliased IO registers of 53810.
> > Implement aliasing to make the AIX driver work.
> >
> > Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> > ---
> >  hw/scsi/lsi53c895a.c | 17 ++++++++++++++---
> >  1 file changed, 14 insertions(+), 3 deletions(-)
> >
> > diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
> > index da7239d..6b95699 100644
> > --- a/hw/scsi/lsi53c895a.c
> > +++ b/hw/scsi/lsi53c895a.c
> > @@ -2271,6 +2271,9 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
> >      LSIState *s = LSI53C895A(dev);
> >      DeviceState *d = DEVICE(dev);
> >      uint8_t *pci_conf;
> > +    uint64_t mmio_size;
> > +    MemoryRegion *mr;
> > +    uint16_t type = PCI_DEVICE_GET_CLASS(dev)->device_id;
> >
> >      pci_conf = dev->config;
> >
> > @@ -2279,13 +2282,21 @@ static void lsi_scsi_realize(PCIDevice *dev, Error **errp)
> >      /* Interrupt pin A */
> >      pci_conf[PCI_INTERRUPT_PIN] = 0x01;
> >
> > -    memory_region_init_io(&s->mmio_io, OBJECT(s), &lsi_mmio_ops, s,
> > -                          "lsi-mmio", 0x400);
> >      memory_region_init_io(&s->ram_io, OBJECT(s), &lsi_ram_ops, s,
> >                            "lsi-ram", 0x2000);
> >      memory_region_init_io(&s->io_io, OBJECT(s), &lsi_io_ops, s,
> >                            "lsi-io", 256);
> > -
> > +    if (type == PCI_DEVICE_ID_LSI_53C895A) {
> > +        mmio_size = 0x400;
> > +    } else {
> > +        mr = g_new(MemoryRegion, 1);
>
> In general these days it's worth keeping the reference to the MemoryRegion within
> LSIState since then its lifecycle is more clearly defined.

On the other hand, it's a PCI card, and can not be
hot-plugged/removed, so the lifecycle is pretty simple here.
Or am I missing something?

> > +        memory_region_init_alias(mr, OBJECT(d), "lsi-io-alias", &s->io_io,
> > +                                 0, 0x80);
> > +        memory_region_add_subregion_overlap(&s->io_io, 0x80, mr, -1);
> > +        mmio_size = 0x80;
>
> This feels a little strange - is it possible to see from the datasheets that the
> 53C895A has 0x400 bytes MMIO whilst the 53C810 has 0x80 bytes MMIO? It's not clear to
> me where the aliasing is happening.

These values are empiric. For 810 it can not be more than 0x80,
because the AIX does access the registers with the shift of 0x80.
For  895A we did already have 0x400.

> > +    }
> > +    memory_region_init_io(&s->mmio_io, OBJECT(s), &lsi_mmio_ops, s,
> > +                          "lsi-mmio", mmio_size);
> >      address_space_init(&s->pci_io_as, pci_address_space_io(dev), "lsi-pci-io");
> >      qdev_init_gpio_out(d, &s->ext_irq, 1);
> >
> >
>
>
> ATB,
>
> Mark.
>


-- 
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/qemu

