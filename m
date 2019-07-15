Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B293BC7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 16:09:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1CD2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 16:09:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1CD2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn3XK-0001Vu-NU
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 12:09:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56994)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hn3XA-00011d-6R
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 12:09:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hn3X9-0000l9-0I
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 12:09:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32776)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>)
 id 1hn3X6-0000im-B1; Mon, 15 Jul 2019 12:08:56 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D89EA3082135;
 Mon, 15 Jul 2019 16:08:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-111.ams2.redhat.com
 [10.36.116.111])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2D2460BEC;
 Mon, 15 Jul 2019 16:08:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7EE8911386A0; Mon, 15 Jul 2019 18:08:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
References: <20190715095545.28545-1-philmd@redhat.com>
 <20190715095545.28545-2-philmd@redhat.com>
 <ca528cdc-6118-0b2f-c1b8-30b06875dde8@redhat.com>
 <CAFEAcA-wgTVfj0TUJ=piP0wEgLGiNpOYia5DK2GQAO4Q7gNaWg@mail.gmail.com>
 <6d69e8ad-d720-ce04-20f2-a03193903078@redhat.com>
 <20190715125653.6e65d575.cohuck@redhat.com>
 <c1c68faf-0424-6c7c-e39f-42159457c3ee@redhat.com>
 <20190715130955.4a117388.cohuck@redhat.com>
 <13fce62f-234c-1b13-595f-5910c066bc4f@redhat.com>
 <6c39a198-e951-c0bd-1ddc-5d227afe72ff@redhat.com>
Date: Mon, 15 Jul 2019 18:08:45 +0200
In-Reply-To: <6c39a198-e951-c0bd-1ddc-5d227afe72ff@redhat.com> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 15 Jul 2019 15:38:12
 +0200")
Message-ID: <87a7dfth4i.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 15 Jul 2019 16:08:55 +0000 (UTC)
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
 Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "open list:S390" <qemu-s390x@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Cornelia Huck <cohuck@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 7/15/19 3:19 PM, Thomas Huth wrote:
>> On 15/07/2019 13.09, Cornelia Huck wrote:
>>> On Mon, 15 Jul 2019 13:04:28 +0200
>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
>>>
>>>> On 7/15/19 12:56 PM, Cornelia Huck wrote:
>>>>> On Mon, 15 Jul 2019 12:48:55 +0200
>>>>> Thomas Huth <thuth@redhat.com> wrote:
>>>>>=20=20=20
>>>>>> On 15/07/2019 12.19, Peter Maydell wrote:=20=20
>>>>>>> On Mon, 15 Jul 2019 at 11:15, Thomas Huth <thuth@redhat.com> wrote:=
=20=20=20=20
>>>>>>>>
>>>>>>>> On 15/07/2019 11.55, Philippe Mathieu-Daud=C3=A9 wrote:=20=20=20=20
>>>>>>>>> If a controller device provides a PCI bus, we can plug any PCI
>>>>>>>>> daughter card on it.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>>>>>>>>> ---=20=20=20=20
>>>>>>>=20=20=20=20=20
>>>>>>>>> diff --git a/hw/pci/Kconfig b/hw/pci/Kconfig
>>>>>>>>> index 77f8b005ff..0f7267db35 100644
>>>>>>>>> --- a/hw/pci/Kconfig
>>>>>>>>> +++ b/hw/pci/Kconfig
>>>>>>>>> @@ -1,5 +1,6 @@
>>>>>>>>>  config PCI
>>>>>>>>>      bool
>>>>>>>>> +    imply PCI_DEVICES=20=20=20=20
>>>>>>>>
>>>>>>>> No, please don't change this. This was done on purpose, since almo=
st all
>>>>>>>> PCI_DEVICES do not work on s390x (so s390x does *not* imply PCI_DE=
VICES).=20=20=20=20
>>>>>>>
>>>>>>> But that means that every board that provides PCI has to have an
>>>>>>> "imply PCI_DEVICES" line, which is pretty clunky just to work
>>>>>>> around an s390x limitation.
>>>>>>>
>>>>>>> Is there some way in the Kconfig syntax for s390x to say
>>>>>>> "no PCI_DEVICES" so we can have the corner-case be handled
>>>>>>> by the s390x Kconfig in one place rather than in 20 places
>>>>>>> affecting everywhere except s390x?=20=20=20=20
>>>>>>
>>>>>> IIRC the problem on s390x are the legacy IRQs. s390x has only MSIs. =
So I
>>>>>> guess the correct way to fix this would be to introduce some
>>>>>> PCI_LEGACY_IRQ switch and let all old devices that do not work with =
MSI
>>>>>> depend on it.=20=20
>>>>>
>>>>> s/MSI/MSI-X/, IIRC. Not sure how far 'legacy' would stretch.=20=20
>>>>
>>>> Maybe we can have something like PCI_LEGACY_DEVICES and PCI_MSI_DEVICE=
S?
>>>>
>>>> So if s390x only selects PCI_LEGACY (not PCI_MSI) bus, then it only get
>>>> legacy devices?
>>>
>>> Wrong way around? We need MSI-X for s390x, not plain MSI or
>>> 'legacy' (whatever that is).
>>=20
>> With "legacy" I meant the old level-triggered interrupts from the early
>> PCI (non-express) days. Sorry for being imprecise here.
>>=20
>> So maybe we need two new switches, PCI_CLASSIC (or so) and PCI_MSIX, and
>> then the PCI devices should be marked with "default y if PCI_CLASSIC" if
>> they do not have MSIX support, and with "default y if PCI_MSIX" if they
>> have MSI-X support?
>
> Something like that :)
>
> Per Wikipedia:
>
>   Conventional PCI and PCI-X are sometimes called Parallel PCI
>   in order to distinguish them technologically from their more
>   recent successor PCI Express, which adopted a serial,
>   lane-based architecture.
>
>   The PCI-SIG introduced the serial PCI Express in c.=E2=80=892004. At
>   the same time, they renamed PCI as Conventional PCI.
>
>   PCI Express does not have physical interrupt lines at all.
>   It uses message-signaled interrupts exclusively.
>
> What about PCI_CONVENTIONAL then?

What kinds of PCI devices are we trying to name?

Is it INTx vs. MSI vs. MSI-X?

Is it Conventional PCI vs. PCI Express?

