Received: from eggs.gnu.org ([2001:4830:134:3::10]:53933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUzHK-0006Ni-Ta
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:48:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dUzHF-0004QX-Dn
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 13:48:54 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
	<1499771839-32518-2-git-send-email-peter.maydell@linaro.org>
	<CAKmqyKMO4GQB1Cgy5rZw8pJawO_kWFZ7PiLGzWPch5CqkOKp=Q@mail.gmail.com>
	<CAFEAcA9xOEX3p0H2=GfYbGXwJkfYYXkVfZH=h0GbM_-bZ4auSA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <05c9cc77-6d9c-6b29-3cbb-4146262eb1f2@amsat.org>
Date: Tue, 11 Jul 2017 14:47:44 -0300
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9xOEX3p0H2=GfYbGXwJkfYYXkVfZH=h0GbM_-bZ4auSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/7] hw/arm/mps2: Implement
 skeleton mps2-an385 and mps2-an511 board models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair23@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Patch Tracking <patches@linaro.org>

On 07/11/2017 01:35 PM, Peter Maydell wrote:
> On 11 July 2017 at 15:33, Alistair Francis <alistair23@gmail.com> wrote:
>> On Tue, Jul 11, 2017 at 1:17 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
[...]
>>> +    create_unimplemented_device("RESERVED 4", 0x40030000, 0x001D0000);
>>> +    create_unimplemented_device("Ethernet", 0x40200000, 0x00100000);
>>> +    create_unimplemented_device("VGA", 0x41000000, 0x0200000);
>>
>> I did not know this was an option, this is pretty cool.
> 
> Yeah. It's really nice for bringing up a board model because
> you can just add -d unimp to your command line and get the
> info about what devices the guest is prodding that you need
> to implement next.

For reverse engineering this is the best device ever :P
