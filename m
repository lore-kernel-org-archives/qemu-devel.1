Received: from eggs.gnu.org ([2001:4830:134:3::10]:39132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxYzd-0004Io-0O
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dxYzZ-0006P4-4V
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:36:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dxYzY-0006Oi-Sz
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:36:41 -0400
References: <20170913132417.24384-1-david@redhat.com>
	<20170913132417.24384-17-david@redhat.com>
	<f07c7045-7809-c008-e521-bf7aa6189c72@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <27e86935-880b-1bee-bf25-35652e5b5d1d@redhat.com>
Date: Thu, 28 Sep 2017 15:36:35 +0200
MIME-Version: 1.0
In-Reply-To: <f07c7045-7809-c008-e521-bf7aa6189c72@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 16/22] s390x: allow cpu hotplug via
 device_add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, borntraeger@de.ibm.com, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 28.09.2017 08:01, Thomas Huth wrote:
> On 13.09.2017 15:24, David Hildenbrand wrote:
>> E.g. the following now works:
>>     device_add host-s390-cpu,id=cpu1,core-id=1
> 
>  Hi David,
> 
> FYI, this introduced a possibility to crash QEMU with the none machine:
> 
> $ s390x-softmmu/qemu-system-s390x -M none -nographic
> QEMU 2.10.50 monitor - type 'help' for more information
> (qemu) device_add qemu-s390-cpu
> Segmentation fault (core dumped)
> 
>  Thomas
> 

Interestingly, this is already fixed by my patch

s390x: raise CPU hotplug irq after really hotplugged

part of the SMP series.

-- 

Thanks,

David
