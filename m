Received: from eggs.gnu.org ([2001:4830:134:3::10]:47489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fb7ux-0006Sm-Jy
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:19:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fb7ut-0003hO-Ls
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:19:43 -0400
Received: from steffen-goertz.de ([88.198.119.201]:54438)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fb7ut-0003h0-AL
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:19:39 -0400
References: <20180627073351.856-1-contrib@steffen-goertz.de>
	<20180627073351.856-6-contrib@steffen-goertz.de>
	<CAFEAcA-RRh3Y4vXz4h3DUaXtnoH97gW1v1bTQbLCSF=qT4KizA@mail.gmail.com>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <b1132a02-623e-6f85-6274-3e6b73f7c4d9@steffen-goertz.de>
Date: Thu, 5 Jul 2018 19:19:34 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-RRh3Y4vXz4h3DUaXtnoH97gW1v1bTQbLCSF=qT4KizA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 5/8] arm: Add NRF51 random number generator
 peripheral
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Joel Stanley <joel@jms.id.au>

Hi Peter,

> Hi -- a couple of general notes about device modelling
> which might apply to other devices in this series as well:
> 
>> +static void nrf51_rng_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc = DEVICE_CLASS(klass);
>> +
>> +    dc->props = nrf51_rng_properties;
> 
> In general, every device that has any modifiable state needs:
>  * a reset function
>  * a vmstate struct that defines its state for migration
> 
> These get set up in the class init function by setting
> dc->vmsd and dc->reset.
> 
> For devices that don't have any modifiable state, a comment
> in the init function to say so helps to reassure readers
> that the issue has been considered :-)

Thank you for your remarks!
I will add the missing handler/structure. I will have to revise the
other devices i have pending for comments as well!

> 
>> +}
> 
> 
>> +    struct {
>> +        uint32_t active:1;
>> +        uint32_t event_valrdy:1;
>> +        uint32_t shortcut_stop_on_valrdy:1;
>> +        uint32_t interrupt_enabled:1;
>> +        uint32_t filter_enabled:1;
>> +    } state;
> 
> Prefer to avoid bitfields.

Will do!

Steffen
