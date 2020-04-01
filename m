Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DDDC43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:24:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1990D2080C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 11:24:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1990D2080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJbUC-000452-9F
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 07:24:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33879)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1jJbTX-0003G3-Uh
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:24:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1jJbTW-00084J-5W
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:24:03 -0400
Received: from 12.mo5.mail-out.ovh.net ([46.105.39.65]:40660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1jJbTV-0007ya-T9
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 07:24:02 -0400
Received: from player796.ha.ovh.net (unknown [10.110.115.182])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id 8C1D7277BAB
 for <qemu-devel@nongnu.org>; Wed,  1 Apr 2020 13:23:58 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player796.ha.ovh.net (Postfix) with ESMTPSA id 5295910F2AB0F;
 Wed,  1 Apr 2020 11:23:49 +0000 (UTC)
Subject: Re: [PATCH v1] usb: Add read support for HCIVERSION register to XHCI
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Cameron Esfahani <dirty@apple.com>
References: <20200330214444.43494-1-dirty@apple.com>
 <71ec6105-b2f7-4805-c235-645c25a0b201@redhat.com>
 <C89783E6-965B-4C0B-BB2F-6CB52D47F625@apple.com>
 <ad609899-d544-f660-6784-5fe5cdc2bf21@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2c04ba56-436d-354b-512e-50c9d995b702@kaod.org>
Date: Wed, 1 Apr 2020 13:23:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <ad609899-d544-f660-6784-5fe5cdc2bf21@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 8776952724324191147
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrtddvgdeflecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuffhomhgrihhnpehmrghilhdqrghrtghhihhvvgdrtghomhdpghhithhhuhgsrdgtohhmpdhlrghunhgthhhprggurdhnvghtnecukfhppedtrddtrddtrddtpdekvddrieegrddvhedtrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeliedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.39.65
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
Cc: Robert Mustacchi <rm@fingolfin.org>, Paul Menzel <pmenzel@molgen.mpg.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani via <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>,
 kraxel@redhat.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On 3/31/20 1:02 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/31/20 11:57 AM, Cameron Esfahani wrote:
>> Philippe -
>> =C2=A0From what I've seen, access size has nothing to do with alignmen=
t.
>=20
> Yes, I was wondering if you were using unaligned accesses.
>=20
> I *think* the correct fix is in the "memory: Support unaligned accesses=
 on aligned-only models" patch from Andrew Jeffery:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg461247.html

Here is an updated version I have been keeping since :=20

	https://github.com/legoater/qemu/commit/d57ac950c4be47a2bafd6c6a96dec292=
2c2ecd65

which breaks qtest :

	microbit-test.c:307:test_nrf51_gpio: assertion failed (actual =3D=3D 0x0=
1): (0 =3D=3D 1)

I haven't had time to look at this closely but it would be nice to get th=
is=20
patch merged. It's a requirement for the Aspeed ADC model.

Thanks,

c.=20

>>
>> What the code in access_with_adjusted_size() will do is make sure that=
 "size" is >=3D min_access_size and <=3D max_access_size.
>>
>> So reading 2-bytes from address 2 turns into reading 4-bytes from addr=
ess 2: xhci_cap_read() is called with reg 2, size 4.
>>
>> But, due to the fact our change to support reg 2 only returns back 2-b=
ytes, and how the loops work in access_with_adjusted_size(), we only call=
 xhci_cap_read() once.
>>
>> It seems like we should also change impl.min_access_size for xhci_cap_=
ops to be 2.
>>
>> But, after that, to support people doing strange things like reading t=
raditionally 4-byte values as 2 2-byte values, we probably need to change=
 xhci_cap_read() to handle every memory range in steps of 2-bytes.
>>
>> But I'll defer to Gerd on this...
>>
>> Cameron Esfahani
>> dirty@apple.com
>>
>> "Americans are very skilled at creating a custom meaning from somethin=
g that's mass-produced."
>>
>> Ann Powers
>>
>>
>>> On Mar 31, 2020, at 12:52 AM, Philippe Mathieu-Daud=C3=A9 <philmd@red=
hat.com> wrote:
>>>
>>> On 3/30/20 11:44 PM, Cameron Esfahani via wrote:
>>>> macOS will read HCIVERSION separate from CAPLENGTH.=C2=A0 Add a dist=
inct
>>>> handler for that register.
>>>
>>> Apparently a fix for https://bugs.launchpad.net/qemu/+bug/1693050.
>>>
>>>> Signed-off-by: Cameron Esfahani <dirty@apple.com>
>>>> ---
>>>> =C2=A0 hw/usb/hcd-xhci.c | 3 +++
>>>> =C2=A0 1 file changed, 3 insertions(+)
>>>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>>>> index b330e36fe6..061f8438de 100644
>>>> --- a/hw/usb/hcd-xhci.c
>>>> +++ b/hw/usb/hcd-xhci.c
>>>> @@ -2739,6 +2739,9 @@ static uint64_t xhci_cap_read(void *ptr, hwadd=
r reg, unsigned size)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0x00: /* HCIVERSION, CAPLENGTH *=
/
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0x010=
00000 | LEN_CAP;
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>> +=C2=A0=C2=A0=C2=A0 case 0x02: /* HCIVERSION */
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0x0100;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
>>>
>>> But we have:
>>>
>>> static const MemoryRegionOps xhci_cap_ops =3D {
>>> =C2=A0=C2=A0=C2=A0 .read =3D xhci_cap_read,
>>> =C2=A0=C2=A0=C2=A0 .write =3D xhci_cap_write,
>>> =C2=A0=C2=A0=C2=A0 .valid.min_access_size =3D 1,
>>> =C2=A0=C2=A0=C2=A0 .valid.max_access_size =3D 4,
>>> =C2=A0=C2=A0=C2=A0 .impl.min_access_size =3D 4,
>>> =C2=A0=C2=A0=C2=A0 .impl.max_access_size =3D 4,
>>> =C2=A0=C2=A0=C2=A0 .endianness =3D DEVICE_LITTLE_ENDIAN,
>>> };
>>>
>>> IIUC ".impl.min_access_size =3D 4" means the case 'reg =3D=3D 2' can =
not happen. It seems we have a bug in memory.c elsewhere.
>>>
>>> How can we reproduce?
>>>
>>> If not easy, can you share the backtrace of:
>>>
>>> -- >8 --
>>> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
>>> index b330e36fe6..d021129f3f 100644
>>> --- a/hw/usb/hcd-xhci.c
>>> +++ b/hw/usb/hcd-xhci.c
>>> @@ -2735,6 +2735,7 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr=
 reg, unsigned size)
>>> =C2=A0=C2=A0=C2=A0=C2=A0 XHCIState *xhci =3D ptr;
>>> =C2=A0=C2=A0=C2=A0=C2=A0 uint32_t ret;
>>>
>>> +=C2=A0=C2=A0=C2=A0 assert(reg !=3D 2);
>>> =C2=A0=C2=A0=C2=A0=C2=A0 switch (reg) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0 case 0x00: /* HCIVERSION, CAPLENGTH */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D 0x01000000 |=
 LEN_CAP;
>>> ---
>>>
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case 0x04: /* HCSPARAMS 1 */
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D ((xhc=
i->numports_2+xhci->numports_3)<<24)
>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | (xhci->numintrs<<8) | xhci->numslots;
>>
>=20


