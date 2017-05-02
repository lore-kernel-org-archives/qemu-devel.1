Received: from eggs.gnu.org ([2001:4830:134:3::10]:44233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5U8j-0007g7-3V
	for qemu-devel@nongnu.org; Tue, 02 May 2017 05:30:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d5U8f-00039n-KJ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 05:30:37 -0400
References: <149346893378.132.3063923710149667629@c05f1edc8ed1>
	<8874ac16-9e54-7c67-8e56-8ed92942ee58@ozlabs.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2d06864f-3c80-a1bd-1c92-b5451cfc7346@redhat.com>
Date: Tue, 2 May 2017 11:30:23 +0200
MIME-Version: 1.0
In-Reply-To: <8874ac16-9e54-7c67-8e56-8ed92942ee58@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH qemu v4] memory/iommu: QOM'fy IOMMU
 MemoryRegion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org
Cc: famz@redhat.com, f4bug@amsat.org, peterx@redhat.com, borntraeger@de.ibm.com, alex.williamson@redhat.com, qemu-ppc@nongnu.org, cornelia.huck@de.ibm.com, david@gibson.dropbear.id.au



On 29/04/2017 14:36, Alexey Kardashevskiy wrote:
>> Checking PATCH 1/1: memory/iommu: QOM'fy IOMMU MemoryRegion...
>> ERROR: spaces required around that '*' (ctx:WxO)
>> #156: FILE: hw/dma/rc4030.c:720:
>> +DeviceState *rc4030_init(rc4030_dma **dmas, IOMMUMemoryRegion **dma_mr)
> 
> What does the script really want here? I am confused.

It's confused because rc4030_dma doesn't look like a type.  It thinks
it's a multiplication and wants you to write "rc4030_dma * *dmas".

Paolo
