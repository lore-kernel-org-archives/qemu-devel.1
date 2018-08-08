Received: from eggs.gnu.org ([2001:4830:134:3::10]:53179)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fnLEU-0007wE-Ex
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:58:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fnLEQ-000752-J3
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:58:22 -0400
Received: from steffen-goertz.de ([88.198.119.201]:33842)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fnLEQ-00072o-Cg
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 05:58:18 -0400
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
	<20180806100114.21410-3-contrib@steffen-goertz.de>
	<CAJSP0QUPZziWN8U292UAXa3T2NLe3BbEAPSSnM9Pa5MAqcGrxA@mail.gmail.com>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <63ee36b0-96ea-5d87-1d2b-efa06085d48c@steffen-goertz.de>
Date: Wed, 8 Aug 2018 11:58:15 +0200
MIME-Version: 1.0
In-Reply-To: <CAJSP0QUPZziWN8U292UAXa3T2NLe3BbEAPSSnM9Pa5MAqcGrxA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] hw/nvram/nrf51_nvm: Add nRF51
 non-volatile memories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>

Hi Stefan,

thank you for your review!

> 
> There is asymmetry here: uicr_read() doesn't check offset before
> indexing the array but uicr_write() does.  Either the check is
> necessary or it's not.
> 
> I think this check isn't necessary since the memory region is sized
> appropriately:
> 
>   memory_region_init_io(&s->uicr, NULL, &uicr_ops, s, "nrf51_soc.uicr",
>           sizeof(s->uicr_content));
> 
>> +static void nrf51_nvm_reset(DeviceState *dev)
>> +{
>> +    Nrf51NVMState *s = NRF51_NVM(dev);
>> +
>> +    memset(s->empty_page, 0xFF, s->page_size);
>> +}
> 
> Can this be done in ->realize()?  Nothing changes the contents of
> empty_page, so a ->reset() function seems unnecessary.
> 

Addressed in next revision of this patch.

Steffen
