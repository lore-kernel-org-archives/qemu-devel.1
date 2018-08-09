Received: from eggs.gnu.org ([2001:4830:134:3::10]:52101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fnkqf-0005jT-Op
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <e.emanuelegiuseppe@gmail.com>) id 1fnkqb-0000Lv-MA
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:19:29 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:41185)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <e.emanuelegiuseppe@gmail.com>)
	id 1fnkqb-0000LS-DR
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 09:19:25 -0400
Received: by mail-ed1-x541.google.com with SMTP id s24-v6so2852444edr.8
	for <qemu-devel@nongnu.org>; Thu, 09 Aug 2018 06:19:25 -0700 (PDT)
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-10-e.emanuelegiuseppe@gmail.com>
	<cb63d852-df80-a894-9290-9147a55554ab@redhat.com>
From: Emanuele <e.emanuelegiuseppe@gmail.com>
Message-ID: <cf50d581-dea3-ebc6-8bf6-f3f4cfb1aa21@gmail.com>
Date: Thu, 9 Aug 2018 15:19:17 +0200
MIME-Version: 1.0
In-Reply-To: <cb63d852-df80-a894-9290-9147a55554ab@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v2 09/34] tests/qgraph: pci-spapr driver
 and interface nodes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>



On 08/09/2018 03:02 PM, Laurent Vivier wrote:
> On 06/08/2018 16:33, Emanuele Giuseppe Esposito wrote:
>> +void qpci_init_spapr(QPCIBusSPAPR *ret, QTestState *qts, QGuestAllocator *alloc)
>> +{
>>       assert(qts);
>>   
>> +    /* tests cannot use spapr, needs to be fixed first */
>> +    ret->bus.has_buggy_msi = TRUE;
>> +
> Perhaps you can revert the logic and call that "msi_is_available"?
> It's more generic than "buggy". It says if we can or not use MSI.
This name was suggested by Paolo, I honestly don't know which is better, 
maybe it's better to ask him for this.
> Thanks,
> Laurent
