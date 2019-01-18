Received: from eggs.gnu.org ([209.51.188.92]:33632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkTWq-0002wj-Hk
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:45:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkTWp-0007Di-KM
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:45:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44980)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gkTWp-00079h-Bu
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 07:45:43 -0500
References: <1547576349-13337-1-git-send-email-pbonzini@redhat.com>
	<1547576349-13337-3-git-send-email-pbonzini@redhat.com>
	<2e5a5fec-3ba7-7bd6-6ffc-c9dfc7079e52@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <86aa40e4-ba32-d3d6-9164-7484086dad1a@redhat.com>
Date: Fri, 18 Jan 2019 13:45:39 +0100
MIME-Version: 1.0
In-Reply-To: <2e5a5fec-3ba7-7bd6-6ffc-c9dfc7079e52@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/5] tests/libqos: rename qpci_init_pc and
 qpci_init_spapr functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: lvivier@redhat.com, Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>

On 18/01/19 13:23, Thomas Huth wrote:
>> diff --git a/tests/libqos/pci-pc.h b/tests/libqos/pci-pc.h
>> index 491eeac..84cc300 100644
>> --- a/tests/libqos/pci-pc.h
>> +++ b/tests/libqos/pci-pc.h
>> @@ -16,7 +16,14 @@
>>  #include "libqos/pci.h"
>>  #include "libqos/malloc.h"
>>  
>> -QPCIBus *qpci_init_pc(QTestState *qts, QGuestAllocator *alloc);
>> +/* qpci_new_pc():
>> +* this function creates a new QPCIBusPC object,
> 
> Hmm, you did not notice my previous review, did you? See:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg01417.html

No, I missed it.

> I'd also be fine if we keep "init" instead
> of "new"... it's quite a bit of code churn ...

It matches QOM's object_new vs. object_initialize.

Paolo
