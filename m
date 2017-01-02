Received: from eggs.gnu.org ([2001:4830:134:3::10]:45621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cOA64-0005r8-F3
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 16:24:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcd@tribudubois.net>) id 1cOA60-0001jL-Oe
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 16:24:48 -0500
Received: from relay5-d.mail.gandi.net ([2001:4b98:c:538::197]:34345)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcd@tribudubois.net>) id 1cOA60-0001iV-Hm
	for qemu-devel@nongnu.org; Mon, 02 Jan 2017 16:24:44 -0500
References: <20161224151113.23955-1-jcd@tribudubois.net>
	<606aedd3-2f56-fb89-b547-763baf833ed5@gmail.com>
	<5b3ba089-e218-40ff-3b72-f31ada1e4cfc@tribudubois.net>
	<a6c26a91-696c-db4b-7311-7cfc7ef9ee74@gmail.com>
	<ccab130c-3f65-e4b4-8453-b2fd0f1110ae@tribudubois.net>
	<5f1acd02-018d-0a17-105c-cd42c50a3e91@tribudubois.net>
	<d320496c-42d0-f8ae-71ea-e81073f2cf9d@gmail.com>
	<684d34f1-9107-1ed0-1115-f3034bd899f4@tribudubois.net>
	<a25f717f-28b6-959a-92c3-a7233dcf7fe2@gmail.com>
From: Jean-Christophe DUBOIS <jcd@tribudubois.net>
Message-ID: <3f17d9af-a43f-82cb-c477-e2036ab7492a@tribudubois.net>
Date: Mon, 2 Jan 2017 22:24:39 +0100
MIME-Version: 1.0
In-Reply-To: <a25f717f-28b6-959a-92c3-a7233dcf7fe2@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] [M25P80] Make sure not to overrun the
 internal data buffer.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "mar.krzeminski" <mar.krzeminski@gmail.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org

Le 30/12/2016 à 19:09, mar.krzeminski a écrit :
>>> Can you check spi controller model code?
>>
>> I'll double check.
>>
>> But why is the SPI memory/device even responding if CS is not set ?
> Looking at ssi code it should not.
> Flash (so the m25p80) is responding when CS line is low and it seem 
> that this is default.

So I fixed the CS handling in the i.MX SPI device emulator and I don't 
experience crashes anymore. Thanks for your help.

You may still want to harden the m25p80 code to make sure it doesn't 
overrun its internal buffer.

>
> Thanks,
> Marcin
>
>>
>>>
>>> Thanks,
>>> Marcin
>>>
>>>
>>
>>
>
>
