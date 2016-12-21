Received: from eggs.gnu.org ([2001:4830:134:3::10]:42471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cJcW3-0001Sx-Mz
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cJcW0-0001PY-L4
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:44:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cJcW0-0001PF-Eq
	for qemu-devel@nongnu.org; Wed, 21 Dec 2016 03:44:48 -0500
References: <1482255793-19057-1-git-send-email-ehabkost@redhat.com>
	<1482255793-19057-5-git-send-email-ehabkost@redhat.com>
	<584d77b6-f7dc-4a96-d7ee-fe8cba9cedea@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <8ed18bc4-00f5-3553-edd0-5f1ac3293b41@redhat.com>
Date: Wed, 21 Dec 2016 09:44:44 +0100
MIME-Version: 1.0
In-Reply-To: <584d77b6-f7dc-4a96-d7ee-fe8cba9cedea@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 4/7] kvm: Include kvm-stub.o only on
 CONFIG_SOFTMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org


>>  obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/decContext.o
>>  obj-$(CONFIG_LIBDECNUMBER) += libdecnumber/decNumber.o
>> @@ -138,6 +137,7 @@ obj-y += arch_init.o cpus.o monitor.o gdbstub.o balloon.o ioport.o numa.o
>>  obj-y += qtest.o bootdevice.o
>>  obj-y += hw/
>>  obj-$(CONFIG_KVM) += kvm-all.o
>> +obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
>>  obj-y += memory.o cputlb.o
>>  obj-y += memory_mapping.o
>>  obj-y += dump.o
>
> <bikeshedding>
> IMHO you could also squash this change into the next patch (and just
> mention it in the commit description).
> </bikeshedding>

+1

-- 

David
