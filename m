Received: from eggs.gnu.org ([2001:4830:134:3::10]:50802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXP9b-00035T-Qn
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:55:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXP9a-0007GB-NS
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:55:27 -0400
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:45325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXP9a-0007Fr-Hi
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 06:55:26 -0400
Received: by mail-ot0-x241.google.com with SMTP id k3-v6so970638otl.12
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 03:55:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c7077a71-6f01-b3f2-cc0b-4d845b967ef3@amsat.org>
References: <20180606144706.29732-1-f4bug@amsat.org>
	<1160f838-5625-b9bf-6c34-3071ed185074@redhat.com>
	<0c5018d5-7e87-bba1-7522-c8020277bde0@amsat.org>
	<c7077a71-6f01-b3f2-cc0b-4d845b967ef3@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Jun 2018 11:55:05 +0100
Message-ID: <CAFEAcA8TP5hzgFVP7z-y81vxYDdPhg1csLLrqKH4+xqy+eV5CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Adopt the Gumstix
 computers-on-module machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 22 June 2018 at 14:30, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> Hi Peter,
>
> On 06/06/2018 12:02 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 06/06/2018 11:53 AM, Thomas Huth wrote:
>>> On 06.06.2018 16:47, Philippe Mathieu-Daud=C3=A9 wrote:
>>>> These COMs are hard to find, and the companie dropped the support
>>
>> "company" :/
>>
>>>> few years ago.
>>>>
>>>> Per the "Gumstix Product Changes, Known Issues, and EOL" pdf:
>>>>
>>>> - Phasing out: PXA270-based Verdex product line
>>>>   September 2012
>>>>
>>>> - Phasing out: PXA255-based Basix & Connex
>>>>   September 2009
>>>>
>>>> However there are still booting SD card image availables, very
>>>> convenient to stress test the QEMU SD card implementation.
>>>> Therefore I volunteer to keep an eye on this file, while it
>>>> is useful for testing.
>>>>
>>>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>> ---
>>>>  MAINTAINERS | 3 ++-
>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index 41cd3736a9..1825deb762 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -491,9 +491,10 @@ F: include/hw/arm/digic.h
>>>>  F: hw/*/digic*
>>>>
>>>>  Gumstix
>>>> +M: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>>>  L: qemu-devel@nongnu.org
>>>>  L: qemu-arm@nongnu.org
>>>> -S: Orphan
>>>> +S: Odd Fixes
>>>>  F: hw/arm/gumstix.c

> Do you agree with this patch? This is mostly to avoid removing these 2
> boards in 2 releases from now. The datasheets are public so I can keep
> an eye on them.
> I already removed them from the "Future deprecated candidates" entry in
> the Wiki.

As Thomas says, whether anybody's listed in MAINTAINERS is
orthogonal to whether we choose to deprecate and remove boards.
If you want to look after these, that's cool.

I've applied this patch to target-arm.next.

thanks
-- PMM
