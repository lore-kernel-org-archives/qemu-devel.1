Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4CBC3F2CD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62E1B2076A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 14:07:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62E1B2076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGNjN-0008TF-SQ
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 10:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36652)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1jGNid-0007o0-SG
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1jGNic-0001di-8H
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 10:06:19 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:44943)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1jGNiZ-0001bQ-2f; Mon, 23 Mar 2020 10:06:15 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id A1506746381;
 Mon, 23 Mar 2020 15:06:12 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 75F757461AE; Mon, 23 Mar 2020 15:06:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 7402B745953;
 Mon, 23 Mar 2020 15:06:12 +0100 (CET)
Date: Mon, 23 Mar 2020 15:06:12 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: Coverity CID 1421984
In-Reply-To: <CAFEAcA9+WPxGYqk5_-v=oXPK=UcvngXGaOLY3njM5iNN2CFh2g@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2003231459410.34482@zero.eik.bme.hu>
References: <d9b7d8d8-1640-7d69-cd16-66e6d9cef3d1@redhat.com>
 <88618db3-cb48-12bd-6152-b642b25a0287@redhat.com>
 <alpine.BSF.2.22.395.2003231359420.14974@zero.eik.bme.hu>
 <CAFEAcA9+WPxGYqk5_-v=oXPK=UcvngXGaOLY3njM5iNN2CFh2g@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="3866299591-1962599154-1584972372=:34482"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1962599154-1584972372=:34482
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Mar 2020, Peter Maydell wrote:
> On Mon, 23 Mar 2020 at 13:12, BALATON Zoltan <balaton@eik.bme.hu> wrote=
:
>> On Mon, 23 Mar 2020, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Cc'ing qemu-ppc since this is restricted to the aCube Sam460ex board.
>>> On 3/23/20 12:46 PM, Max Reitz wrote:
>>>> Hi,
>>>>
>>>> I was triaging new Coverity block layer reports today, and one that
>>>> seemed like a real bug was CID 1421984:
>>>>
>>>> It complains about a memleak in sii3112_pci_realize() in
>>>> hw/ide/sii3112.c, specifically about @irq being leaked (it=E2=80=99s=
 allocated
>>>> by qemu_allocate_irqs(), but never put anywhere or freed).
>>>>
>>>> I=E2=80=99m not really well-versed in anything under hw/ide, so I wa=
s wondering
>>>> whether you agree it=E2=80=99s a bug and whether you know the correc=
t way to fix
>>>> it.  (I assume it=E2=80=99s just a g_free(irqs), but maybe there=E2=80=
=99s a more
>>>> specific way that=E2=80=99s applicable here.)
>>>
>>> What does other devices is hold a reference in the DeviceState
>>> (SiI3112PCIState) to make static analyzers happy.
>>
>> Other IDE devices such as ahci and cmd646 seem to free it at the end o=
f
>> the init function after calling ide_init2 with it. However it's not cl=
ear
>> to me how all this is supposed to work.
>
> Anything that uses qemu_allocate_irqs() is old pre-qom/qdev code.
> The qdev way of doing this kind of thing (ie "I am a device with
> some inbound lines and this is the handler function to call when
> the line is set") is to use qdev_init_gpio_in().
>
> Coverity has flagged up a lot of leaks involving qemu_allocate_irqs();
> most of them I've for the moment just set as "insignificant, fix
> required" because they're in called-once functions like board init.
> If this device can't be hot-unplugged and so we will only ever call
> realize once, it would fall in that category too. Otherwise I'd
> suggest conversion to qdev_init_gpio_in(). (This allocates arrays
> of IRQs under the hood too, but the device_finalize() function will
> automatically free them for you, so it's easier to use non-leakily.)

I think I can't do that in sii3112 becuase I need to pass irq to this fun=
c:

void ide_init2(IDEBus *bus, qemu_irq irq);

That's what all ide devices do so you probably mean ide emulation should=20
be qdevified in QEMU but that's way beyond fixing this Coverity warning.

> I think in the long term we should be thinking about getting rid
> of all uses of qemu_allocate_irqs(): they seem to generally be
> leaky.
>
> The right way to free something allocated with qemu_allocate_irqs()
> is to call qemu_free_irqs() on it, but that will free both the
> array and all the IRQs within it, so you can't do that until the
> device is destroyed. If the device can never be destroyed, we
> usually don't write the unrealize function for it, so it would just
> be a matter of storing the returned pointer from qemu_allocate_irqs()
> in the device struct for a theoretical unrealize to be able to use.
> If you just g_free() the pointer you got back then this leaves all
> the IRQs themselves allocated, so you still have a nominal leak,
> you've just swept it under the rug enough to stop Coverity seeing it :-=
)

That means other ide devices are likely also leaking just not noticed due=
=20
to g_free-ing the array. For sii3112 I can implement an unrealize functio=
n=20
that frees the allocated irqs which should fix it according the above.

Regards,
BALATON Zoltan
--3866299591-1962599154-1584972372=:34482--

