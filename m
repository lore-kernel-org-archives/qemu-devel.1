Received: from eggs.gnu.org ([2001:4830:134:3::10]:50938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebqpz-0000tD-Tp
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:45:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebqpv-0000Pt-SG
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:45:19 -0500
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <CAHQ1cqFknfW0NmiD-3GFJRedgVE-9bacKhm-pYx0ycviRsmucQ@mail.gmail.com>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-10-andrew.smirnov@gmail.com>
	<CAFEAcA-hEgWp58nte89Vs6nZnp4wA6_f8-Vaovm2hiJe9SWwHQ@mail.gmail.com>
	<b9661e65-5fb2-46b5-b082-6e768afff7bc@zoho.com>
	<CAHQ1cqFknfW0NmiD-3GFJRedgVE-9bacKhm-pYx0ycviRsmucQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Wed, 17 Jan 2018 13:45:13 -0300
Message-ID: <CAAdtpL65QPW9uW8ppnz1Lz0aaCtHokJqpdHXe48G-chz-T167A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 09/14] pci: Add support for Designware
 IP block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

Hi Andrey,

On Wed, Jan 17, 2018 at 1:12 PM, Andrey Smirnov
<andrew.smirnov@gmail.com> wrote:
> On Wed, Jan 17, 2018 at 7:23 AM, Marcel Apfelbaum
> <marcel.apfelbaum@zoho.com> wrote:
>> That being said, if Andrey can point me to the PCI spec for the Designware
>> PCI host bridge and what parts they implemented for it I can have a look,
>> sure.
>> (I will not be available for a week or so, but right after)
>>
>
> Just in case you still want this:
>
> To the best of my knowledge, Synposys does not provide specification
> for their PCIe IP to general public and I am in no way affiliated with
> them, so I don't have any backchannels to get it any other way.
>
> The next best thing to an actual spec, that I found to be pretty
> useful, is PCIe chapter of i.MX6Q Reference Manual
> (https://www.nxp.com/docs/en/reference-manual/IMX6DQRM.pdf   page
> 4049), which is what I used to implement the code in question.

Please add a comment about it in your respin, such:

Based on "i.MX6 Applications Processor Reference Manual" (Document
Number: IMX6DQRM Rev. 4)

> Last, and probably the most important, "source of truth" was actual
> Linux PCIe driver for i.MX/Designware which I used as a sort of
> inverse reference implementation.

Same here:

Reversed from Linux v4.9 drivers/pci/host/pcie-designware.c
