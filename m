Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131F4C4363C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:36:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C317207EA
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 10:36:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C317207EA
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ6oH-0001Q5-46
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 06:36:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kQ6nC-000089-Qw; Wed, 07 Oct 2020 06:35:30 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:52606)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kQ6n9-0007ym-Rb; Wed, 07 Oct 2020 06:35:30 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 66635747DFA;
 Wed,  7 Oct 2020 12:35:15 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3EA28747871; Wed,  7 Oct 2020 12:35:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 3C6C97475FA;
 Wed,  7 Oct 2020 12:35:15 +0200 (CEST)
Date: Wed, 7 Oct 2020 12:35:15 +0200 (CEST)
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: Purpose of QOM properties registered at realize time?
In-Reply-To: <20201006220647.GR7303@habkost.net>
Message-ID: <98c7534-cdc4-579-3dee-47f75b69961e@eik.bme.hu>
References: <20201006220647.GR7303@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 06:35:15
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

On Tue, 6 Oct 2020, Eduardo Habkost wrote:
> Hi,
>
> While trying to understand how QOM properties are used in QEMU, I
> stumbled upon multiple cases where alias properties are added at
> realize time.
>
> Now, I don't understand why those properties exist.  As the
> properties are added at realize time, I assume they aren't
> supposed to be touched by the user at all.  If they are not
> supposed to be touched by the user, what exactly is the purpose
> of those QOM properties?
>
> For reference, these are the cases I've found:
>
> $ git grep -nwpE 'object_property_add_alias|qdev_pass_gpios|qdev_alias_all_properties' | grep -A1 realize
> hw/arm/allwinner-a10.c=71=static void aw_a10_realize(DeviceState *dev, Error **errp)
> hw/arm/allwinner-a10.c:89:    qdev_pass_gpios(DEVICE(&s->intc), dev, NULL);
> --
> hw/arm/allwinner-h3.c=232=static void allwinner_h3_realize(DeviceState *dev, Error **errp)
> hw/arm/allwinner-h3.c:359:    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->mmc0),
> --
> hw/arm/armsse.c=429=static void armsse_realize(DeviceState *dev, Error **errp)
> hw/arm/armsse.c:1092:    qdev_pass_gpios(dev_secctl, dev, "mscexp_status");
> --
> hw/arm/armv7m.c=149=static void armv7m_realize(DeviceState *dev, Error **errp)
> hw/arm/armv7m.c:219:    qdev_pass_gpios(DEVICE(&s->nvic), dev, NULL);
> --
> hw/arm/bcm2835_peripherals.c=128=static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
> hw/arm/bcm2835_peripherals.c:322:    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus");
> --
> hw/arm/bcm2836.c=69=static void bcm2836_realize(DeviceState *dev, Error **errp)
> hw/arm/bcm2836.c:87:    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->peripherals),
> hw/arm/msf2-soc.c=79=static void m2sxxx_soc_realize(DeviceState *dev_soc, Error **errp)
> hw/arm/msf2-soc.c:170:        object_property_add_alias(OBJECT(s), bus_name,
> --
> hw/arm/nrf51_soc.c=58=static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
> hw/arm/nrf51_soc.c:138:    qdev_pass_gpios(DEVICE(&s->gpio), dev_soc, NULL);
> --
> hw/arm/xlnx-zynqmp.c=276=static void xlnx_zynqmp_realize(DeviceState *dev, Error **errp)
> hw/arm/xlnx-zynqmp.c:522:        object_property_add_alias(OBJECT(s), bus_name, sdhci, "sd-bus");
> --
> hw/misc/mac_via.c=1011=static void mac_via_realize(DeviceState *dev, Error **errp)
> hw/misc/mac_via.c:1028:    object_property_add_alias(OBJECT(dev), "irq[0]", OBJECT(ms),

Mark likely knows this one. I think he mentioned once that it may be used 
for storing reference to some object that needs to be accessed later but I 
could be wrong, haven't checked actual code only recalling from memory.

Regards,
BALATON Zoltan

> --
> hw/ppc/spapr_drc.c=511=static void realize(DeviceState *d, Error **errp)
> hw/ppc/spapr_drc.c:530:    object_property_add_alias(root_container, link_name,
> hw/riscv/sifive_e.c=186=static void sifive_e_soc_realize(DeviceState *dev, Error **errp)
> hw/riscv/sifive_e.c:233:    qdev_pass_gpios(DEVICE(&s->gpio), dev, NULL);
> hw/riscv/sifive_u.c=651=static void sifive_u_soc_realize(DeviceState *dev, Error **errp)
> hw/riscv/sifive_u.c:743:    qdev_pass_gpios(DEVICE(&s->gpio), dev, NULL);
>
>

