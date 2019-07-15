Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52535C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:55:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E2F206B8
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 10:55:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E2F206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmyda-0005IQ-BZ
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 06:55:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42124)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hmydM-0004WR-KL
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hmydL-000705-BV
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 06:55:04 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:56909)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1hmydI-0006rd-V5; Mon, 15 Jul 2019 06:55:01 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1A1387456CC;
 Mon, 15 Jul 2019 12:54:52 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id EF6987456B4; Mon, 15 Jul 2019 12:54:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id EB19674569D;
 Mon, 15 Jul 2019 12:54:51 +0200 (CEST)
Date: Mon, 15 Jul 2019 12:54:51 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
In-Reply-To: <20190715095545.28545-3-philmd@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1907151251210.6546@zero.eik.bme.hu>
References: <20190715095545.28545-1-philmd@redhat.com>
 <20190715095545.28545-3-philmd@redhat.com>
User-Agent: Alpine 2.21.9999 (BSF 287 2018-06-16)
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH-for-4.2 2/3] hw/usb/Kconfig: Add
 CONFIG_USB_EHCI_PCI
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-riscv@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Helge Deller <deller@gmx.de>, Palmer Dabbelt <palmer@sifive.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jul 2019, Philippe Mathieu-Daud=C3=A9 wrote:
> The USB_EHCI entry currently include PCI code. Since the EHCI
> implementation is already split in sysbus/PCI, add a new
> USB_EHCI_PCI. There are no logical changes, but the Kconfig
> dependencies tree is cleaner.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> hw/usb/Kconfig       | 9 ++++++---
> hw/usb/Makefile.objs | 5 +++--
> 2 files changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
> index 564305e283..495c6f2d48 100644
> --- a/hw/usb/Kconfig
> +++ b/hw/usb/Kconfig
> @@ -19,13 +19,16 @@ config USB_OHCI_PCI
>
> config USB_EHCI
>     bool
> -    default y if PCI_DEVICES
> -    depends on PCI
>     select USB
>
> +config USB_EHCI_PCI
> +    bool
> +    default y if PCI_DEVICES
> +    select USB_EHCI
> +
> config USB_EHCI_SYSBUS
>     bool
> -    select USB
> +    select USB_EHCI

Isn't this making USB_EHCI effectively the same as USB so maybe you don't=
=20
need to keep that around any more. Can you just add select USB to=20
USB_EHCI_PCI and USB_EHCI_SYSBUS and delete USB_EHCI?

Regards,
BALATON Zoltan
