Received: from eggs.gnu.org ([2001:4830:134:3::10]:38574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ebqM8-0005um-SP
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:14:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ebqM5-0003Hd-Lp
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 11:14:28 -0500
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-10-andrew.smirnov@gmail.com>
	<CAFEAcA-hEgWp58nte89Vs6nZnp4wA6_f8-Vaovm2hiJe9SWwHQ@mail.gmail.com>
	<b9661e65-5fb2-46b5-b082-6e768afff7bc@zoho.com>
	<CAFEAcA8Ei8vgOspvy9hBbwQya+gjDq3V8o2NbV8cxvCsw6kycQ@mail.gmail.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <63726933-be7f-3dd7-9e14-fa02863cfb75@redhat.com>
Date: Wed, 17 Jan 2018 18:12:51 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Ei8vgOspvy9hBbwQya+gjDq3V8o2NbV8cxvCsw6kycQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 17/01/2018 17:35, Peter Maydell wrote:
> On 17 January 2018 at 15:23, Marcel Apfelbaum <marcel.apfelbaum@zoho.com> wrote:
>>
>> On 16/01/2018 16:34, Peter Maydell wrote:
>>> On 16 January 2018 at 01:37, Andrey Smirnov <andrew.smirnov@gmail.com>
>>> I'm not familiar enough with our PCI code to be able to review
>>> this, I'm afraid. MST and Marcel are our PCI subsystem maintainers --
>>> could one of you have a look at whether this seems to be a correct
>>> implementation of a pcie host controller ?
>>
>>
>> Sadly PCI Host bridges do not have a standard, each HW vendor
>> can do pretty much what they want.
>>
>> That being said, if Andrey can point me to the PCI spec for the Designware
>> PCI host bridge and what parts they implemented for it I can have a look,
>> sure.
> 
> I'm not so worried about whether it's implementing the spec for
> the hardware (I trust Andrey has done enough testing for that
> side of things), but whether the code seems to be structured
> the way we expect a QEMU pcie host controller to be structured,
> is using the right APIs, and so on.
> 

Got it, I'll review in a week.

Thanks,
Marcel

> thanks
> -- PMM
> 
