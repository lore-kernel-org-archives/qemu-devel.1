Received: from eggs.gnu.org ([2001:4830:134:3::10]:43211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emJau-0007hJ-JG
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:29:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emJaq-00015z-F3
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 08:29:00 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180208055039.24666-1-penberg@iki.fi>
	<20180208055039.24666-4-penberg@iki.fi>
	<CAFEAcA_008TiXr0RYmPuhPcmSY9qx=Ju8CMAu_t-z+DBRruykA@mail.gmail.com>
	<9c52a265-6659-5c9c-27c7-eced8528fb63@amsat.org>
	<a3f95aa2-3a13-8a67-4fe2-b7da6eace585@amsat.org>
	<CAFEAcA8Zhih61YZNBEQQOFv_XKWknw7oN80pQbK+NgcB1mEsYQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ac100745-d5e6-13c9-a9c2-72864871469e@amsat.org>
Date: Thu, 15 Feb 2018 10:28:52 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Zhih61YZNBEQQOFv_XKWknw7oN80pQbK+NgcB1mEsYQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v1 3/3] raspi: Add "raspi3"
 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pekka Enberg <penberg@iki.fi>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 02/15/2018 10:18 AM, Peter Maydell wrote:
> On 15 February 2018 at 13:14, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>> On 02/15/2018 09:49 AM, Philippe Mathieu-Daudé wrote:
>>> On 02/15/2018 09:39 AM, Peter Maydell wrote:
>>>> On 8 February 2018 at 05:50, Pekka Enberg <penberg@iki.fi> wrote:
>>
>> Now I remember why I hesitated with this patch,
>>
>> This part {
>>
>>>>> +    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-a53");
>>>>> +    mc->max_cpus = BCM2836_NCPUS;
>>>>> +    mc->min_cpus = BCM2836_NCPUS;
>>>>> +    mc->default_cpus = BCM2836_NCPUS;
>>
>> } is the BCM2837 SoC, very similar to the BCM2836.
> 
> Yeah, we had a whole go-around about whether we should have a
> BCM2837 object or just make the BCM2836 object have a configurable
> CPU type. You could argue either way...

Since both SoCs are clocked at the same freq (and we don't model the L2
cache, the only diff) your suggestion (#ifdef TARGET_AARCH64) is the
easiest/cleaner way to go and I'm happy with it :)

A one-line comment would be worthful although.

Regards,

Phil.
