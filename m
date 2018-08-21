Received: from eggs.gnu.org ([2001:4830:134:3::10]:49086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fs7ZL-0008EN-0p
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fs7ZH-0006O5-F0
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:23:38 -0400
Received: from steffen-goertz.de ([88.198.119.201]:43628)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@steffen-goertz.de>) id 1fs7ZH-0006M9-12
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 10:23:35 -0400
References: <20180806100114.21410-1-contrib@steffen-goertz.de>
	<20180806100114.21410-3-contrib@steffen-goertz.de>
	<CAFEAcA8qVuawNP5nOQ=Yg8PopkVbCL2+4hzw9kCEW8qht=pMiA@mail.gmail.com>
From: =?UTF-8?Q?Steffen_G=c3=b6rtz?= <mail@steffen-goertz.de>
Message-ID: <ce052c6b-7adf-669e-7649-db2885097c1f@steffen-goertz.de>
Date: Tue, 21 Aug 2018 10:31:01 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8qVuawNP5nOQ=Yg8PopkVbCL2+4hzw9kCEW8qht=pMiA@mail.gmail.com>
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
To: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Thomas Huth <thuth@redhat.com>

Hi Peter,

>> +
>> +static Property nrf51_nvm_properties[] = {
>> +    DEFINE_PROP_UINT16("page_size", Nrf51NVMState, page_size, 0x400),
> 
> Do the different NRF51 variants really have different NAND page sizes ?
> 

it seems that is not the case at least for the NRF51 Series. I removed the property in favor for a nrf51.h-wide constant. I think this is NOR flash btw, because it is single-byte writable, which is usually a sign that it is NOR flash. But i could be wrong and the datasheet does not state anything.
Thank you for your remarks!

Steffen
