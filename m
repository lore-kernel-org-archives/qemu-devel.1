Received: from eggs.gnu.org ([2001:4830:134:3::10]:57364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fo1dK-0003vi-Gh
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 03:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fo1dH-0003kF-CI
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 03:14:50 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:32782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fo1dH-0003ih-2p
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 03:14:47 -0400
Received: by mail-wr1-x443.google.com with SMTP id g6-v6so7367865wrp.0
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 00:14:46 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180806143412.27722-1-e.emanuelegiuseppe@gmail.com>
	<20180806143412.27722-10-e.emanuelegiuseppe@gmail.com>
	<cb63d852-df80-a894-9290-9147a55554ab@redhat.com>
	<cf50d581-dea3-ebc6-8bf6-f3f4cfb1aa21@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c8169c0b-2338-3c3b-d25f-2ff6398c9696@redhat.com>
Date: Fri, 10 Aug 2018 09:14:44 +0200
MIME-Version: 1.0
In-Reply-To: <cf50d581-dea3-ebc6-8bf6-f3f4cfb1aa21@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Emanuele <e.emanuelegiuseppe@gmail.com>, Laurent Vivier <lvivier@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@gmail.com>

On 09/08/2018 15:19, Emanuele wrote:
> 
> 
> On 08/09/2018 03:02 PM, Laurent Vivier wrote:
>> On 06/08/2018 16:33, Emanuele Giuseppe Esposito wrote:
>>> +void qpci_init_spapr(QPCIBusSPAPR *ret, QTestState *qts,
>>> QGuestAllocator *alloc)
>>> +{
>>>       assert(qts);
>>>   +    /* tests cannot use spapr, needs to be fixed first */
>>> +    ret->bus.has_buggy_msi = TRUE;
>>> +
>> Perhaps you can revert the logic and call that "msi_is_available"?
>> It's more generic than "buggy". It says if we can or not use MSI.
> This name was suggested by Paolo, I honestly don't know which is better,
> maybe it's better to ask him for this.

The MSIs here are not interrupts, they are just random memory writes.
Even if it's not clear if the bug is in libqos or QEMU, there is no
reason why they shouldn't work.

Paolo
