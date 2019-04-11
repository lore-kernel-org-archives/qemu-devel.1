Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F559C10F11
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 00:58:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF54B20850
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 00:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GggCpXFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF54B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39768 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEO3G-0004WI-TG
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 20:58:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hEO2X-0004DS-6R
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 20:58:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hEO2V-0003ZA-7W
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 20:58:05 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:45713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hEO2T-0003Wc-7D
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 20:58:01 -0400
Received: by mail-oi1-x22b.google.com with SMTP id y84so3435209oia.12
	for <qemu-devel@nongnu.org>; Wed, 10 Apr 2019 17:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=mCc519botKiEHmlh/j3Cx6TrbqfgEEJ/SMUJRaHwo9k=;
	b=GggCpXFUW/hFCAvF82RJpP1FjpfGdBEP2pp1L0KOB/0aaYic/hPfOU4/cD2QfoqOyw
	7YOYVJE76hC7SpEzD8Cuk5MS/C6xa9FE4jr0jkZlqy77EqVEaf+dbFlhIuGS2gQkHAF2
	G4pkdlFsMAhA0aLIArFij590CdAyervh9yoqoH8XHZxfxl3z3770XMRoBZZGl6cfelY8
	p9i7UG675RwV+UsWLqScJT1FfYkXWLiz0OqPJO2yWBJXlcG+wLE8HpdW0PNjoZmF+WJJ
	ch7Zpjyp3EQ6acHqgrcMZX1uPHVANoOKMPN+KKw51nLx/ZwVQ8fzVFQ4W8UYOeHqKPUB
	UF0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=mCc519botKiEHmlh/j3Cx6TrbqfgEEJ/SMUJRaHwo9k=;
	b=rdnRu8neRqnQNErvkiecWDpBTZS/Qp3gTszv1bF+BRwJaZvprIgirIESqgwXyxmCQ7
	OO/kXQ4xL+ODFf3QssEktV/aZ0unn9MYVRL+drRhMcl0f8sakbGDwa0YRtr/BqBWZhoP
	LM5HrJOl3tHPtRCZ7RkXLjwpVAnfXVmM+cHVJBdLSgHI2jrgRDVpyKooQKGd1wtcGkZl
	stT/HH/lKn6HcXTBb0XejISwhjG2xluYifNjEDePP0R2NNf5ho0qSeuV5GDCB/kAonsR
	0thukW0MRilokCsa4PDd5WeOhCsCv8jEgXK9Q5eL3hTV/qYLAWKnVk+WbC/Icz9j6eJ/
	RsVg==
X-Gm-Message-State: APjAAAXF8QdrY4JidhnDg5LSJsBk9u3ZYM2HpBY3oD4q6lXI5SJZSDel
	ESVlQ4ThihWAgeSE9vePkqgb9usnHT16DGVdOn0=
X-Google-Smtp-Source: APXvYqySVajPBqknpzej4ITi1dTf6IgOetg02zimHVND67Wuf0AWtvoKQmTRqfVwjw0P6rzzYQEPN0XZvlSqoNi8td8=
X-Received: by 2002:aca:fdc6:: with SMTP id b189mr4758639oii.97.1554944278644; 
	Wed, 10 Apr 2019 17:57:58 -0700 (PDT)
MIME-Version: 1.0
References: <5CADFEB7.01C57B.25694@m12-14.163.com>
	<e7a59573-5252-71b7-210b-5a8335f5a5c1@redhat.com>
In-Reply-To: <e7a59573-5252-71b7-210b-5a8335f5a5c1@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 11 Apr 2019 08:57:22 +0800
Message-ID:
 <CAKXe6S+w4A6YubgQib5H2QXE=eLFLWFQE-mOHYBM5PTXKaYAOA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::22b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] 
	=?utf-8?q?Questions_about_acpi_interrupt_link_devic?=
	=?utf-8?b?ZSdzIOKAmF9QUlMnIGZpZWxk?=
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
Cc: "liq3ea@gmail.com" <liq3ea@gmail.com>, Li Qiang <liq3ea@163.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411005722.6PwG__cXqjhUBdHy2rdhtkUUzst1ioLnUMF0kcvrAcw@z>

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8810=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:55=E5=86=99=E9=81=93=EF=BC=9A

> On 10/04/19 16:33, Li Qiang wrote:
> > Hi all,
> >
> >
> >
> > I see the link device =E2=80=98_PRS=E2=80=99  uses irq line 5, 10, 11 i=
n
> > =E2=80=98build_link_dev=E2=80=99 function.
> >
> > But I never see the 5 lines uses in the guest, just uses 10 and 11.
> >
> > Why this happen?  Maybe related with the guest?
>
> Because the MADT table tells the guest to only use lines 10 and 11.  The
> BIOS configures the chipset that way.
>
>
Hi Paolo,

I read the MADT spec, and found that it may related with 'Entry Type 2 :
Interrupt Source Override'.
However, in build_madt function, I found following code when fill interrupt
source overide.

#define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
        if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
            /* No need for a INT source override structure. */
            continue;
        }

Seems the madt doesn't play a role?

Also in the seabios code, I see the pci interrupt linking device is routed
hard-coded by pci_irqs.
So this means the seabios doesn't use the madt/dsdt table to configure PCI
interrupt routing?

Thanks,
Li Qiang

const u8 pci_irqs[4] =3D {
    10, 10, 11, 11
};

static void piix_isa_bridge_setup(struct pci_device *pci, void *arg)
{
    int i, irq;
    u8 elcr[2];

    elcr[0] =3D 0x00;
    elcr[1] =3D 0x00;
    for (i =3D 0; i < 4; i++) {
        irq =3D pci_irqs[i];
        /* set to trigger level */
        elcr[irq >> 3] |=3D (1 << (irq & 7));
        /* activate irq remapping in PIIX */
        pci_config_writeb(pci->bdf, 0x60 + i, irq);
    }
    outb(elcr[0], PIIX_PORT_ELCR1);
    outb(elcr[1], PIIX_PORT_ELCR2);
    dprintf(1, "PIIX3/PIIX4 init: elcr=3D%02x %02x\n", elcr[0], elcr[1]);
}

Paolo
>
>
