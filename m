Received: from eggs.gnu.org ([2001:4830:134:3::10]:59921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fdJI7-0006ea-4u
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 13:52:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fdJI2-0004Dn-96
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 13:52:39 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:34417)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fdJI2-0004Dg-1G
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 13:52:34 -0400
Received: by mail-ed1-x541.google.com with SMTP id d3-v6so19846485edi.1
	for <qemu-devel@nongnu.org>; Wed, 11 Jul 2018 10:52:33 -0700 (PDT)
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-8-e.emanuelegiuseppe@gmail.com>
	<20180711151544.GQ31228@stefanha-x1.localdomain>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <a1639665-a8a4-5f74-19c8-48189f6a0dea@gmail.com>
Date: Wed, 11 Jul 2018 19:52:30 +0200
MIME-Version: 1.0
In-Reply-To: <20180711151544.GQ31228@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 7/7] tests/qgraph: sdhci test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 07/11/2018 05:15 PM, Stefan Hajnoczi wrote:

> On Mon, Jul 09, 2018 at 11:11:36AM +0200, Emanuele Giuseppe Esposito wrote:
>> +/**
>> + * Old sdhci_t structure:
> Do you intend to delete this comment before this series is merged?  It
> seems like a TODO that doesn't need to be kept around.
Paolo suggested me to put it there, because there still are some devices 
that need to be implemented.
>
>> +    qos_add_test("sdhci-test", "sdhci", test_machine);
> How does this work for tests that need access to more than 1 device?
> Can they request a driver instance via the API?
Uhm accessing more than one device is something I did not take into 
account. It is possible to add additional command line to the test, with 
qos_add_test_args(), but no multiple devices. I'll add it as TODO in my 
list, thanks
