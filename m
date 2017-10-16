Received: from eggs.gnu.org ([2001:4830:134:3::10]:58207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4434-00057R-5a
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e4430-0000Sm-5L
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:59:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45080)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e442z-0000SI-UL
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 07:59:06 -0400
References: <1508144183-30844-1-git-send-email-yang.zhong@intel.com>
	<ebb88add-3173-78b9-397e-53a364ca0d53@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <0ea87d45-f1c9-21c5-ddc3-c1d5bd0c6df8@redhat.com>
Date: Mon, 16 Oct 2017 13:58:59 +0200
MIME-Version: 1.0
In-Reply-To: <ebb88add-3173-78b9-397e-53a364ca0d53@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] add "nopin" option in the
 memory-backend-file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, alex.williamson@redhat.com, anthony.xu@intel.com

On 16/10/2017 12:20, Xiao Guangrong wrote:
> 
>> Qemu does not need pin NVDIMM memory for VFIO device during VFIO
>> hotplug, what's more, if there is no NVDIMM hw in the test machine,
>> the VFIO hotplug operation will need at least 10 minutes to pin RAM
>> as the NVDIMM, this time is not accepted. So we add "nopin=on" option
>> in the memory-backed-file, which can avoid to pin RAM memory for NVDIMM.
> 
> No.
> 
> memory-backed-file does not dedicate for nvdimm only, it can be mapped
> as normal memory as well. Rather more, this is no way to stop guest to
> use it as DMA.

Right, so a better name for the object property could be "dma" rather
than "nopin".  I'll let others comment on whether MemoryBackend (not
just memory-backend-file) is the right place for the option.

I am also not sure whether VFIO is not the right place for the "other
side" of the hook.  If you add the memory region to the CPU address
space and not the PCI address space, you can hide it from all PCI devices.

Paolo
