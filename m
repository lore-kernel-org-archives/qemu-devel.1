Received: from eggs.gnu.org ([2001:4830:134:3::10]:34023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gR4hv-0008Ps-8d
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 19:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gR4hs-0002TV-2V
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 19:24:59 -0500
Received: from steffen-goertz.de ([88.198.119.201]:38820)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1gR4hr-0002T8-SR
	for qemu-devel@nongnu.org; Sun, 25 Nov 2018 19:24:56 -0500
References: <20181112214224.31560-1-contrib@steffen-goertz.de>
	<20181112214224.31560-6-contrib@steffen-goertz.de>
	<CAFEAcA_oxGQY6K4wQ3TTz1moa8rrXd=Hd3bcjE5NM2d=omn0YQ@mail.gmail.com>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <e1e4c8d7-cb81-7f1d-ae38-a4cac5c85a48@steffen-goertz.de>
Date: Sun, 25 Nov 2018 19:24:51 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_oxGQY6K4wQ3TTz1moa8rrXd=Hd3bcjE5NM2d=omn0YQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 05/14] hw/nvram/nrf51_nvm: Add nRF51
 non-volatile memories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>

Hi Peter,

thank you for your remarks!

>> +};
>> +
>> +static uint64_t ficr_read(void *opaque, hwaddr offset
> 
>> +            value &= ~(NRF51_PAGE_SIZE - 1);
>> +            if (value < (s->flash_size - NRF51_PAGE_SIZE)) {
>> +                memset(s->storage + value / 4, 0xFF, NRF51_PAGE_SIZE);
> 
> Can the guest try to execute from the flash storage? If so
> then just updating the backing storage directly like this is
> not sufficient to ensure that QEMU discards any now-stale
> translated code blocks from the affected memory.

What else is necessary to invalidate stale blocks?


>> +
>> +static void nrf51_nvm_reset(DeviceState *dev)
>> +{
>> +    NRF51NVMState *s = NRF51_NVM(dev);
>> +
>> +    s->config = 0x00;
> 
> Shouldn't uicr_content[] and storage be reset too ?


Storage and uicr_content should be retained during a device reset. 

Best,
Steffen
