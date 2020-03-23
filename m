Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BACC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96318206F9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 15:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96318206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGP0k-0006qx-Ne
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 11:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51980)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jGOzx-0005lS-7g
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jGOzw-0006z9-4Q
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 11:28:17 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:40872)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jGOzs-0006vt-He; Mon, 23 Mar 2020 11:28:12 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E9E6E74637E;
 Mon, 23 Mar 2020 16:28:07 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id C69747461AE; Mon, 23 Mar 2020 16:28:07 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C48DD745953;
 Mon, 23 Mar 2020 16:28:07 +0100 (CET)
Date: Mon, 23 Mar 2020 16:28:07 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Coverity CID 1421984
In-Reply-To: <CAFEAcA_R1i2L5Vgmq1frGbQQxggLtEfMwHa8V=+K2Wje2mkVVA@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2003231619510.61044@zero.eik.bme.hu>
References: <d9b7d8d8-1640-7d69-cd16-66e6d9cef3d1@redhat.com>
 <88618db3-cb48-12bd-6152-b642b25a0287@redhat.com>
 <alpine.BSF.2.22.395.2003231359420.14974@zero.eik.bme.hu>
 <CAFEAcA9+WPxGYqk5_-v=oXPK=UcvngXGaOLY3njM5iNN2CFh2g@mail.gmail.com>
 <alpine.BSF.2.22.395.2003231459410.34482@zero.eik.bme.hu>
 <CAFEAcA9Ubue9Lk2jXJyZ+OUmk0j58ZKKnER1RxMi0b05FaN4QQ@mail.gmail.com>
 <alpine.BSF.2.22.395.2003231539160.47226@zero.eik.bme.hu>
 <CAFEAcA_R1i2L5Vgmq1frGbQQxggLtEfMwHa8V=+K2Wje2mkVVA@mail.gmail.com>
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
Cc: Qemu-block <qemu-block@nongnu.org>,
 =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 23 Mar 2020, Peter Maydell wrote:
> On Mon, 23 Mar 2020 at 14:43, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>> On Mon, 23 Mar 2020, Peter Maydell wrote:
>>> On Mon, 23 Mar 2020 at 14:06, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>>> On Mon, 23 Mar 2020, Peter Maydell wrote:
>>>>> Coverity has flagged up a lot of leaks involving qemu_allocate_irqs();
>>>>> most of them I've for the moment just set as "insignificant, fix
>>>>> required" because they're in called-once functions like board init.
>>>>> If this device can't be hot-unplugged and so we will only ever call
>>>>> realize once, it would fall in that category too. Otherwise I'd
>>>>> suggest conversion to qdev_init_gpio_in(). (This allocates arrays
>>>>> of IRQs under the hood too, but the device_finalize() function will
>>>>> automatically free them for you, so it's easier to use non-leakily.)
>>>>
>>>> I think I can't do that in sii3112 becuase I need to pass irq to this func:
>>>>
>>>> void ide_init2(IDEBus *bus, qemu_irq irq);
>>>
>>> ide_init2(bus, qdev_get_gpio_in(DEVICE(dev), i);
>>>
>>> should do what you want, I think.
>>
>> I don't understand what you mean.
>
> I mean that if you allocate the IRQs with qdev_init_gpio_in()
> then the way to get a qemu_irq from within them to pass
> to another function is to call qdev_get_gpio_in(). So you
> just want to make your call to ide_init2() be the line I
> suggest above.

Is this documented anywhere? Even after this reply I did not understand 
until I saw your patch. (And even after that I'm not quite sure when and 
how to use gpios so probably this should be made a bit more clear in 
docs or somewhere.)

Problem is that there are no complete docs so people are directed to look 
at the code. But the code is full of bad examples (like ahci and cmd646 in 
this case) so can't find out what's the latest preferred way. At least a 
list of preferred vs. legacy functions/APIs should exist somewhere and the 
preferred ones should be documented. Irq handling and gpios is one of the 
mysteries that are hard to get so some info on that would help.

Thanks for fixing this.

Regards,
BALATON Zoltan

