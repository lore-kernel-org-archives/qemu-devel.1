Received: from eggs.gnu.org ([2001:4830:134:3::10]:51968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePWCM-0001Xu-32
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:17:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePWCL-0005Ek-40
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 11:17:26 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAHQ1cqEA1_OP4+Y4Y1B25UsmWU9EoR6uFvJTKmAj494q7HskoQ@mail.gmail.com>
References: <20171211213007.7353-1-andrew.smirnov@gmail.com>
	<20171211213007.7353-13-andrew.smirnov@gmail.com>
	<CAFEAcA_6R61208pZ5rchSG0Oy4c_2eSGD+dO-LQs3Dncjnpf-Q@mail.gmail.com>
	<CAHQ1cqHhN=hLun2mzqvg0N3NkxEbPpBU1iEf5-mAdnHqEs3KYg@mail.gmail.com>
	<d56f5ba0-29d9-d5b4-7137-28e312e15a02@amsat.org>
	<CAHQ1cqEA1_OP4+Y4Y1B25UsmWU9EoR6uFvJTKmAj494q7HskoQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 14 Dec 2017 13:17:21 -0300
Message-ID: <CAAdtpL4iUEu1xqbj3Ep0=GNP3K2QZicHVEZBGhRvXsbfyoH9Ww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 12/13] sdhci: Add i.MX specific subtype of
 SDHCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Thu, Dec 14, 2017 at 1:05 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> On Thu, Dec 14, 2017 at 7:32 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org> wrote:
>> [...]
>>>>> +    case ESDHC_DLL_CTRL:
>>>>> +    case ESDHC_TUNE_CTRL_STATUS:
>>>>> +    case 0x6c:
>>>>
>>>> Isn't there a name we can give 0x6c ?
>>>>
>>>
>>> Unfortunately, not that I know of. It's a mystery register not listed
>>> in RM and the only place I can found it being mentioned is in Linux
>>> driver as a part of errata ESDHC_FLAG_ERR004536 fix, where it is used
>>> nameless as well.
>>
>> This sets the SD CLK/RCLK frequency (10-bit) for the 104MB/sec bus speed
>> (UHS-I mode).
>>
>> The "Sampling Clock Tuning Procedure" figure in the Spec v3 is helpful.
>>
>
> I am a bit hesitant to agree that this is indeed the case. ERR004536
> errata's title is "uSDHC: ADMA Length Mismatch Error may occur for
> longer read latencies" and recommented workaround is "Use SDMA (or
> ADMA1) in case the AHB latency is larger than the =E2=80=9Cminimal time f=
or
> one block=E2=80=9D. On top of that corresponding code in Linux
> (https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
drivers/mmc/host/sdhci-esdhc-imx.c?h=3Dv4.15-rc3#n1061)
> doesn't seem to use it as a 10-bit frequency field, treating it more
> like a single-bit flag.

Ok, I'll have a better look when applying these SD patches on top of
my current SD tree.

Regards,

Phil.
