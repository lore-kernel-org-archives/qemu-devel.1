Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847A8C10F14
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 07:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BEDB217D4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 07:53:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KUvRxMmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BEDB217D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43432 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEUWy-0005CZ-5Z
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 03:53:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hEUW5-0004sP-PD
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:53:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hEUW3-0000HP-VX
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:53:01 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:36104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hEUW3-0000FP-FD
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 03:52:59 -0400
Received: by mail-oi1-x232.google.com with SMTP id l203so4132220oia.3
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 00:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Lx5CbrZPH3PhO2G2A0aso1rFAgFLrTfZ/PDJi8WQL1E=;
	b=KUvRxMmY77JK09Hne8iJjwcdBCbN0g3yaFgFxJObQFGdCcJnykHaaoZNOmKAuZx6N9
	neLQ/RyGzMNbW26s9lRE1jCI0/vCyhqn5hatkBp6tUYCggJqSeCjwYpxgpCYkILakSs/
	ORQjRWXBef750OO/DRKAkOOKaXCpESwOqV+fERpAZVkaz+GiGIPufR/qWBCSVsiVOxDU
	KVPHhGipRBuytoZ5SP0LRF6Q+xiZqebhNByDlr7aeVhMnPrv/GXVqJWO8wsZeG237ayS
	iz/BEJDlprS9IQE3RygEbBRiPM8n7/qpoIFAL9NUcP8fvPix7g2gqsPdVMxfSvkLMs/0
	aDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Lx5CbrZPH3PhO2G2A0aso1rFAgFLrTfZ/PDJi8WQL1E=;
	b=G9Oyp1vDsP0hS6OhGOHFDqf7scOTC7KG3PHb5mZZsET6KZVlU0YfBXp1ZmBcClS3fK
	u8tRHIrOF61hLBE2G0FdAO42hUt/2TQGYxk8j4a3ZQSMZDS2kjTTBoJCmLhMZKctNlFN
	cTJqqSuNx/63wz71s4wTOWOgoab/H2rAPXNzPyx4mHhPFR3XML42BSCrkkWJyuUbGU+n
	hxjDf6+k8s8T9ggeEakzM/IcVv8GHAMwlPeUJwPKx1OVdEtPPZr325Kn95HZ4kBQd4rI
	ykybZLQ/j0aP1bNxaUXDuGU1eLOEAD1gBAO3F8xsUKidmb8zl0flkFZQ0tLsDbQk/98U
	8fFQ==
X-Gm-Message-State: APjAAAW6eV74iA3LqnQg72t1s9HjPdvE/GsqmP9xmTBwVrqaulBXKzKC
	houDu86HvsFhgbx+P+YFxh0Cp7m2OeKe+QaH0X8=
X-Google-Smtp-Source: APXvYqz7JLMzyPjC9LJWSASna/TE2JzehgOEMKlePKCH47kk58EuUBaHqqs4iauvTrIF7/qvTtSLSkektdEIoZ8uM6E=
X-Received: by 2002:aca:d88b:: with SMTP id p133mr5465133oig.56.1554969178106; 
	Thu, 11 Apr 2019 00:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <5CADFEB7.01C57B.25694@m12-14.163.com>
	<e7a59573-5252-71b7-210b-5a8335f5a5c1@redhat.com>
	<CAKXe6S+w4A6YubgQib5H2QXE=eLFLWFQE-mOHYBM5PTXKaYAOA@mail.gmail.com>
	<e5f15cd9-c34c-737d-4fa2-2aee7c5f0ad9@redhat.com>
In-Reply-To: <e5f15cd9-c34c-737d-4fa2-2aee7c5f0ad9@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 11 Apr 2019 15:52:22 +0800
Message-ID:
 <CAKXe6SLRaxmRy-sraaee-Z04KLgwB8_rRz7ejSu_vDm+7RETPw@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: Li Qiang <liq3ea@163.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mst@redhat.com" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411075222.ZXGAlGwcLTiXk79VWH6IZjHpp2QXfpHUykh9PWe0PWU@z>

Paolo Bonzini <pbonzini@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8811=E6=
=97=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=883:44=E5=86=99=E9=81=93=EF=BC=9A

> On 11/04/19 02:57, Li Qiang wrote:
> >
> >
> > Paolo Bonzini <pbonzini@redhat.com <mailto:pbonzini@redhat.com>> =E4=BA=
=8E2019
> > =E5=B9=B44=E6=9C=8810=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8811:5=
5=E5=86=99=E9=81=93=EF=BC=9A
> >
> >     On 10/04/19 16:33, Li Qiang wrote:
> >     > Hi all,
> >     >
> >     >
> >     >
> >     > I see the link device =E2=80=98_PRS=E2=80=99  uses irq line 5, 10=
, 11 in
> >     > =E2=80=98build_link_dev=E2=80=99 function.
> >     >
> >     > But I never see the 5 lines uses in the guest, just uses 10 and 1=
1.
> >     >
> >     > Why this happen?  Maybe related with the guest?
> >
> >     Because the MADT table tells the guest to only use lines 10 and 11.
> The
> >     BIOS configures the chipset that way.
> >
> >
> > Hi Paolo,
> >
> > I read the MADT spec, and found that it may related with 'Entry Type 2 =
:
> > Interrupt Source Override'.
> > However, in build_madt function, I found following code when fill
> > interrupt source overide.
> >
> > #define ACPI_BUILD_PCI_IRQS ((1<<5) | (1<<9) | (1<<10) | (1<<11))
> >         if (!(ACPI_BUILD_PCI_IRQS & (1 << i))) {
> >             /* No need for a INT source override structure. */
> >             continue;
> >         }
> >
> > Seems the madt doesn't play a role?
> >
> > Also in the seabios code, I see the pci interrupt linking device is
> > routed hard-coded by pci_irqs.
> > So this means the seabios doesn't use the madt/dsdt table to configure
> > PCI interrupt routing?
>
> Yeah, the MADT doesn't matter, I got confused.  It's just the firmware's
> definition of pci_irqs that affects the behavior you're seeing.
>
>
Hello Paolo,

Thanks so much for your confirmation! I appreciate it.
I'm confused by the massive acpi table/concepts recently.

Thanks,
Li Qiang






> Paolo
>
