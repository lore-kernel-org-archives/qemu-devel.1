Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6C4CC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 06:32:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC8F120838
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 06:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FcvFpXz+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC8F120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32944 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izaiA-0004Vy-SE
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 01:32:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33143)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1izahE-0003ys-QL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 01:31:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1izahD-0000s2-PP
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 01:31:28 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51676
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1izahD-0000ly-Jr
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 01:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580970686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=G7kcbzVEebMo2i0XxQ83pMWMLjDxvitXoeAjQwY2L0M=;
 b=FcvFpXz+RonF750eJhwhnhHvVa2Fdupuv0ZvCa49VWeiyOgJYNdeohul8JF2ZAyXMLi4Qy
 bDvUXFE3s5TVcTPMI0HkO+SvsaF+w1518KpHWVeHIkt6Zxw6e0w+HQTr8cjSKBcAF8MI8i
 NeGKN4/doo7hGQH0lEmR45kVyeGH6W4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-T-PdMHZOOC6n4_cj4K81dw-1; Thu, 06 Feb 2020 01:31:24 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C2F478010D6;
 Thu,  6 Feb 2020 06:31:22 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-151.ams2.redhat.com [10.36.116.151])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EEA6389A83;
 Thu,  6 Feb 2020 06:31:20 +0000 (UTC)
Subject: Re: [PATCH 2/2] ppc/pnv: Fix PCI_EXPRESS dependency
To: Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>
References: <20200205204115.555212-1-lvivier@redhat.com>
 <20200205204115.555212-3-lvivier@redhat.com>
 <20200205222052.1a5cdea5@bahia.lan>
 <05908e90-caab-23d8-fca2-41dd9fe5a235@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <38f97c60-2f7f-df61-dbcb-8cbb1664c3d8@redhat.com>
Date: Thu, 6 Feb 2020 07:31:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <05908e90-caab-23d8-fca2-41dd9fe5a235@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: T-PdMHZOOC6n4_cj4K81dw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/02/2020 00.17, Laurent Vivier wrote:
> On 05/02/2020 22:20, Greg Kurz wrote:
>> On Wed,  5 Feb 2020 21:41:15 +0100
>> Laurent Vivier <lvivier@redhat.com> wrote:
>>
>>> When PHB4 bridge has been added, the dependencies to PCIE_PORT has been
>>> added to XIVE_SPAPR and indirectly to PSERIES.
>>> The build of the PowerNV machine is fine while we also build the PSERIES
>>> machine.
>>> If we disable the PSERIES machine, the PowerNV build fails because the
>>> PCI Express files are not built:
>>>
>>> /usr/bin/ld: hw/ppc/pnv.o: in function `pnv_chip_power8_pic_print_info':
>>> .../hw/ppc/pnv.c:623: undefined reference to `pnv_phb3_msi_pic_print_info'
>>> /usr/bin/ld: hw/ppc/pnv.o: in function `pnv_chip_power9_pic_print_info':
>>> .../hw/ppc/pnv.c:639: undefined reference to `pnv_phb4_pic_print_info'
>>> /usr/bin/ld: ../hw/usb/hcd-ehci-pci.o: in function `usb_ehci_pci_write_config':
>>> .../hw/usb/hcd-ehci-pci.c:129: undefined reference to `pci_default_write_config'
>>> /usr/bin/ld: ../hw/usb/hcd-ehci-pci.o: in function `usb_ehci_pci_realize':
>>> .../hw/usb/hcd-ehci-pci.c:68: undefined reference to `pci_allocate_irq'
>>> /usr/bin/ld: .../hw/usb/hcd-ehci-pci.c:72: undefined reference to `pci_register_bar'
>>> /usr/bin/ld: ../hw/usb/hcd-ehci-pci.o:(.data.rel+0x50): undefined reference to `vmstate_pci_device'
>>>
>>> This patch fixes the problem by adding needed dependencies to POWERNV.
>>>
>>> Fixes: 4f9924c4d4cf ("ppc/pnv: Add models for POWER9 PHB4 PCIe Host bridge")
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>> ---
>>>  hw/ppc/Kconfig | 6 ++++--
>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
>>> index 354828bf132f..3e11d0b53e11 100644
>>> --- a/hw/ppc/Kconfig
>>> +++ b/hw/ppc/Kconfig
>>> @@ -29,6 +29,10 @@ config POWERNV
>>>      select XICS
>>>      select XIVE
>>>      select FDT_PPC
>>> +    select PCI
>>
>> Is it needed since PCI_EXPRESS already selects PCI in hw/pci/Kconfig ?
>>
> 
> You are right, and PCIE_PORT is not needed too, because
> PCIE_PORT is default to 'y' if PCI_DEVICES.

If it's a hard requirement for linking, then it is needed here. Try to
compile after running "configure --without-default-devices" to see
whether you've got all dependencies really right.

 Thomas


