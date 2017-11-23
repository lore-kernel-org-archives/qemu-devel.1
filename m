Received: from eggs.gnu.org ([2001:4830:134:3::10]:35709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eHfPi-0007WR-0N
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 19:30:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eHfPh-0003nF-3g
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 19:30:46 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:43763)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1eHfPg-0003mi-UG
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 19:30:45 -0500
Received: by mail-wr0-x243.google.com with SMTP id u40so16126031wrf.10
	for <qemu-devel@nongnu.org>; Wed, 22 Nov 2017 16:30:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8OWP=x=YCumVzc4biETn7SbUxaBDasYR3XNx71aabdmw@mail.gmail.com>
References: <20171103000109.28244-1-frasse.iglesias@gmail.com>
	<CAFEAcA8OWP=x=YCumVzc4biETn7SbUxaBDasYR3XNx71aabdmw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 22 Nov 2017 16:30:13 -0800
Message-ID: <CAKmqyKPsB_F+Z8k36Vc9FdTLE5CKHK68TN31QtkoCvjUNshYow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v7 00/13] Add support for the ZynqMP
 Generic QSPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Francisco Iglesias <frasse.iglesias@gmail.com>, Edgar Iglesias <edgari@xilinx.com>, Alistair Francis <alistai@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>, francisco.iglesias@feimtech.se, =?UTF-8?Q?Marcin_Krzemi=C5=84ski?= <mar.krzeminski@gmail.com>

On Tue, Nov 21, 2017 at 10:39 AM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 3 November 2017 at 00:00, Francisco Iglesias
> <frasse.iglesias@gmail.com> wrote:
>> Hi,
>>
>> This patch series is an attempt to add support for the ZynqMP QSPI (consisting
>> of the Generic QSPI and the legacy QSPI) to the xlnx-zcu102 board and connect
>> Numonyx n25q512a11 flashes to the QSPI. Also some functionality is added to
>> m25p80.
>>
>> The series starts by adding support in m25p80 for continous read out of status
>> registers, SST flash READ ID commands, bank address register accesses, bulk
>> erase (0x60) and two Numonyx flashes (n25q512a11 and n25q512a13). Thereafter it
>> updates the striping behaviour to be bit big endiann in the Xilinx QSPI model
>> and adds support for RX discard, zero pumping according transfer register and 4
>> byte LQSPI addresses. Finally it adds support for the ZynqMP Generic QSPI and
>> adds the ZynqMP QSPI to the xlnx-zcu102 board.
>>
>> Best regards,
>> Francisco Iglesias
>
> Hi; just a note to say that I'm assuming the Xilinx folk are going
> to review the xilinx_spips patches in this set...

Yep, we will!

Alistair

>
> thanks
> -- PMM
>
