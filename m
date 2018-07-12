Received: from eggs.gnu.org ([2001:4830:134:3::10]:33628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdaOE-00044y-DX
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fdaOB-0003Q1-23
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:08:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fdaOA-0003OY-R9
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 08:08:02 -0400
Received: by mail-wr1-f68.google.com with SMTP id e7-v6so1895157wrs.9
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 05:08:02 -0700 (PDT)
References: <20180709091136.28849-1-e.emanuelegiuseppe@gmail.com>
	<20180709091136.28849-8-e.emanuelegiuseppe@gmail.com>
	<20180711151544.GQ31228@stefanha-x1.localdomain>
	<a1639665-a8a4-5f74-19c8-48189f6a0dea@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6f489456-53e9-ad3d-31f3-cfb92d5d5ab7@redhat.com>
Date: Thu, 12 Jul 2018 14:07:54 +0200
MIME-Version: 1.0
In-Reply-To: <a1639665-a8a4-5f74-19c8-48189f6a0dea@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 7/7] tests/qgraph: sdhci test node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Emanuele <e.emanuelegiuseppe@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On 11/07/2018 19:52, Emanuele wrote:
>>>
>> Do you intend to delete this comment before this series is merged?  It
>> seems like a TODO that doesn't need to be kept around.
> Paolo suggested me to put it there, because there still are some devices
> that need to be implemented.
>>
>>> +    qos_add_test("sdhci-test", "sdhci", test_machine);
>> How does this work for tests that need access to more than 1 device?
>> Can they request a driver instance via the API?
>
> Uhm accessing more than one device is something I did not take into
> account. It is possible to add additional command line to the test, with
> qos_add_test_args(), but no multiple devices. I'll add it as TODO in my
> list, thanks

Note that there is only one test that requires multiple devices on the
same bus, namely usb-hcd-ehci-test.c which instantiates the EHCI
controller under test together with three companion UHCI controllers.

One possibility is to define a driver which contains all of the devices
you need in the test, and make the test depend on the driver.  Maybe
there is a better way to do it, the above is just what came to my mind.

Paolo
