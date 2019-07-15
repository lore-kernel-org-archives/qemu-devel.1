Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFDCC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:57:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90A3C206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90A3C206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmyff-00074M-Qq
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 06:57:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42843)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1hmyfT-0006QG-TT
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1hmyfS-00081i-St
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:57:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37200)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>)
 id 1hmyfQ-000805-Qa; Mon, 15 Jul 2019 06:57:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 14ECB307CDD1;
 Mon, 15 Jul 2019 10:57:11 +0000 (UTC)
Received: from gondolin (dhcp-192-232.str.redhat.com [10.33.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 363555D9D2;
 Mon, 15 Jul 2019 10:56:56 +0000 (UTC)
Date: Mon, 15 Jul 2019 12:56:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Message-ID: <20190715125653.6e65d575.cohuck@redhat.com>
In-Reply-To: <6d69e8ad-d720-ce04-20f2-a03193903078@redhat.com>
References: <20190715095545.28545-1-philmd@redhat.com>
 <20190715095545.28545-2-philmd@redhat.com>
 <ca528cdc-6118-0b2f-c1b8-30b06875dde8@redhat.com>
 <CAFEAcA-wgTVfj0TUJ=piP0wEgLGiNpOYia5DK2GQAO4Q7gNaWg@mail.gmail.com>
 <6d69e8ad-d720-ce04-20f2-a03193903078@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 15 Jul 2019 10:57:11 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [qemu-s390x] [RFC PATCH 1/3] hw/Kconfig: PCI bus
 implies PCI_DEVICES
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Collin Walling <walling@linux.ibm.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Palmer Dabbelt <palmer@sifive.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Helge Deller <deller@gmx.de>, David Gibson <david@gibson.dropbear.id.au>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "open list:S390" <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jul 2019 12:48:55 +0200
Thomas Huth <thuth@redhat.com> wrote:

> On 15/07/2019 12.19, Peter Maydell wrote:
> > On Mon, 15 Jul 2019 at 11:15, Thomas Huth <thuth@redhat.com> wrote: =20
> >>
> >> On 15/07/2019 11.55, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >>> If a controller device provides a PCI bus, we can plug any PCI
> >>> daughter card on it.
> >>>
> >>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >>> --- =20
> >  =20
> >>> diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
> >>> index 77f8b005ff..0f7267db35 100644
> >>> --- a/hw/pci/Kconfig
> >>> +++ b/hw/pci/Kconfig
> >>> @@ -1,5 +1,6 @@
> >>>  config PCI
> >>>      bool
> >>> +    imply PCI_DEVICES =20
> >>
> >> No, please don't change this. This was done on purpose, since almost a=
ll
> >> PCI_DEVICES do not work on s390x (so s390x does *not* imply PCI_DEVICE=
S). =20
> >=20
> > But that means that every board that provides PCI has to have an
> > "imply PCI_DEVICES" line, which is pretty clunky just to work
> > around an s390x limitation.
> >=20
> > Is there some way in the Kconfig syntax for s390x to say
> > "no PCI_DEVICES" so we can have the corner-case be handled
> > by the s390x Kconfig in one place rather than in 20 places
> > affecting everywhere except s390x? =20
>=20
> IIRC the problem on s390x are the legacy IRQs. s390x has only MSIs. So I
> guess the correct way to fix this would be to introduce some
> PCI_LEGACY_IRQ switch and let all old devices that do not work with MSI
> depend on it.

s/MSI/MSI-X/, IIRC. Not sure how far 'legacy' would stretch.

cc:ing Collin in case there's something else.

