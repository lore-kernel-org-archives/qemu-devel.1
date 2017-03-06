Received: from eggs.gnu.org ([2001:4830:134:3::10]:57183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cksmc-00061z-3V
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cksmY-0001Eb-4z
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:34:38 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170305214857.9510-1-krzk@kernel.org>
	<20170305214857.9510-3-krzk@kernel.org>
	<2130c1b2-0f81-13f6-a1f8-c0a2e294e3f0@amsat.org>
	<CAFEAcA8DOfstrMiEBLsgf6U6S9uT9ahA1ALrJdmQhcV+7K8Obw@mail.gmail.com>
	<4989d5b6-586a-de18-e8e6-6ab9e9ac131c@redhat.com>
	<CAFEAcA-6yQ=95hGdia6TDhq4C-swOJ1iZA8C+u99Dy9kfG+f0w@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5e79860e-3823-1db8-8ba7-5c8bb44046d8@amsat.org>
Date: Mon, 6 Mar 2017 10:34:29 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-6yQ=95hGdia6TDhq4C-swOJ1iZA8C+u99Dy9kfG+f0w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 3/3] hw/misc/exynos4210_pmu:
 Reorder local variables for readability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 03/06/2017 10:16 AM, Peter Maydell wrote:
> On 6 March 2017 at 13:03, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> On 06/03/2017 10:46, Peter Maydell wrote:
>>> On 6 March 2017 at 04:06, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>> your change seems OK but while you are here, 'unsigned' is considered
>>>> harmful since more than a decade.
>>>
>>> Considered harmful by who, and why?

sorry to cry wolf :)

>> It is true that unsigned has all the disadvantages of "int" (it may be
>> smaller than the size of the object" and all the disadvantages of
>> "size_t" (it doesn't optimize as well because the compiler cannot
>> exploit undefined behavior).
>>
>> I wouldn't call it harmful, but it feels like the worst of both worlds.
>
> size_t is a pretty silly choice for a variable that's looping
> through the number of registers in the device, which is a value
> that would fit in 16 bits, let alone 32. I would probably have
> written this with 'int', but use of 'unsigned' doesn't come
> very high up on my list of things to complain about.

silly would be "typeof(PMU_NUM_OF_REGISTERS) i;" :p

I got your point about the complain priority list.

> (since we use -fwrapv the compiler can't exploit undefined
> behaviour for signed loop indexes either.)

regards,

Phil.
