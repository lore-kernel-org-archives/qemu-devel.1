Received: from eggs.gnu.org ([209.51.188.92]:39550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmfi4-0001xE-JU
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gmfi3-0004A1-VQ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:10:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gmfi3-00047I-LN
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 09:10:23 -0500
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-42-yang.zhong@intel.com>
	<fa45d1f5-4bc4-827a-321d-7df073c97861@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <219c193e-5ba5-c749-b974-e19616bb5e8f@redhat.com>
Date: Thu, 24 Jan 2019 15:10:17 +0100
MIME-Version: 1.0
In-Reply-To: <fa45d1f5-4bc4-827a-321d-7df073c97861@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v4 41/44] virtio: make virtio
 dependencies with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com

On 24/01/19 13:51, Thomas Huth wrote:
> not fully converted yet:
> 
> Exception: contradiction between clauses when setting VIRTIO_MMIO
> make: *** No rule to make target `aarch64-softmmu/config-devices.mak',
> needed by `config-all-devices.mak'.  Stop.
> 
> I think you temporarily have not to set CONFIG_VIRTIO=y in
> default-configs/arm-softmmu.mak (and likely also in the riscv and s390x
> configs), until they are finally converted completely?

No, VIRTIO_MMIO must select virtio.  I have fixed this in my tree.

Paolo
