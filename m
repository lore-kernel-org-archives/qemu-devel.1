Received: from eggs.gnu.org ([209.51.188.92]:47843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkXYy-00076T-6v
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkXYu-0002ZW-DX
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:04:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gkXYu-0002N2-2e
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:04:08 -0500
References: <20190118112410.3010-1-yang.zhong@intel.com>
	<20190118112410.3010-30-yang.zhong@intel.com>
	<20190118113317-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <033a0646-955f-8888-381c-fa4656a2d849@redhat.com>
Date: Fri, 18 Jan 2019 18:03:46 +0100
MIME-Version: 1.0
In-Reply-To: <20190118113317-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 29/43] build: convert pci.mak to
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Yang Zhong <yang.zhong@intel.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com

On 18/01/19 17:36, Michael S. Tsirkin wrote:
>>  config PCI_GENERIC
>>      bool
>> +    select PCIE
>>
> 
> why is this?
>   

PCI_GENERIC is hw/pci-host/gpex.c, the "QEMU Generic PCI Express Bridge
Emulation".

>>  config PCI_XILINX
>>      bool
>> +    select PCIE
>>  
>>  config PCI_DESIGNWARE
>>      bool
>> +    select PCIE
> 
> 
> sure about the above?

The comments at the top of the two files say they are PCIe.

Paolo
