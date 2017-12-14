Received: from eggs.gnu.org ([2001:4830:134:3::10]:53835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePVV0-0000YN-QQ
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:32:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ePVUx-0005Kx-FW
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 10:32:38 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171211213007.7353-1-andrew.smirnov@gmail.com>
	<20171211213007.7353-13-andrew.smirnov@gmail.com>
	<CAFEAcA_6R61208pZ5rchSG0Oy4c_2eSGD+dO-LQs3Dncjnpf-Q@mail.gmail.com>
	<CAHQ1cqHhN=hLun2mzqvg0N3NkxEbPpBU1iEf5-mAdnHqEs3KYg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <d56f5ba0-29d9-d5b4-7137-28e312e15a02@amsat.org>
Date: Thu, 14 Dec 2017 12:32:30 -0300
MIME-Version: 1.0
In-Reply-To: <CAHQ1cqHhN=hLun2mzqvg0N3NkxEbPpBU1iEf5-mAdnHqEs3KYg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Andrey Smirnov <andrew.smirnov@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

Hi Andrey,

On 12/14/2017 11:03 AM, Andrey Smirnov wrote:
> On Tue, Dec 12, 2017 at 9:52 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
>> On 11 December 2017 at 21:30, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
[...]
>>> +    case ESDHC_DLL_CTRL:
>>> +    case ESDHC_TUNE_CTRL_STATUS:
>>> +    case 0x6c:
>>
>> Isn't there a name we can give 0x6c ?
>>
> 
> Unfortunately, not that I know of. It's a mystery register not listed
> in RM and the only place I can found it being mentioned is in Linux
> driver as a part of errata ESDHC_FLAG_ERR004536 fix, where it is used
> nameless as well.

This sets the SD CLK/RCLK frequency (10-bit) for the 104MB/sec bus speed
(UHS-I mode).

The "Sampling Clock Tuning Procedure" figure in the Spec v3 is helpful.

In my tree (where I work on UHS-I/II) I have:

#define SDHC_PRESET_SDR104              0x6c
FIELD(SDHC_PRESET_SDR104, CLKFREQ,           0, 10); /* since v3 */
FIELD(SDHC_PRESET_SDR104, CLKGEN,           10,  1); /* since v3 */
FIELD(SDHC_PRESET_SDR104, DRIVE_STRENGTH,   14,  2); /* since v3 (UHS-I
only) */

Regards,

Phil.
