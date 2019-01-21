Received: from eggs.gnu.org ([209.51.188.92]:56987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1glYHq-0001wB-NB
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 07:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1glYAQ-0002sL-DO
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:55:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59934)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1glYAQ-0002qp-2f
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:55:02 -0500
References: <20190118112410.3010-1-yang.zhong@intel.com>
	<20190118112410.3010-29-yang.zhong@intel.com>
	<20190118113051-mutt-send-email-mst@kernel.org>
	<CABgObfZEGtdxGqGCRawW9Cd6c3NO0efwYWZCv3k4VvAJsm8-vw@mail.gmail.com>
	<20190118142758-mutt-send-email-mst@kernel.org>
	<154d7fa7-6941-2943-6338-a7440487b399@redhat.com>
	<20190121112651.GA19350@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ccfff9f3-e3db-d6a8-dbeb-b5fbda731393@redhat.com>
Date: Mon, 21 Jan 2019 12:54:53 +0100
MIME-Version: 1.0
In-Reply-To: <20190121112651.GA19350@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v3 28/43] hw/pci/Makefile.objs: make
 pcie configurable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Maydell, Peter" <peter.maydell@linaro.org>, thuth@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org, sameo@linux.intel.com

On 21/01/19 12:26, Yang Zhong wrote:
> On Mon, Jan 21, 2019 at 11:25:57AM +0100, Paolo Bonzini wrote:
>> On 18/01/19 20:28, Michael S. Tsirkin wrote:
>>> OK, and I also think we should rename it PCIE -> PCI_EXPRESS_, this way
>>> everything PCI starts with PCI.
>>
>> I have no preference for PCIE vs. PCI_EXPRESS (PCIE is universally known
>> and shorter, but it's okay either way), but I agree it makes sense to
>> rename everything that selects PCIE so that it starts with either PCIE
>> or PCI_EXPRESS.  Yang, can you place a patch to do that before your
>> series to do the rename?
>>
>   Hello Paolo,
> 
>   Yes, i can change PCIE to PCI_EXPRESS per Michael's comments. How can i share
>   this patch ?, or i will send this patches with another changes(patch 41) in v4 ?  thanks!

You can place it as patch 1 in v4.

Paolo
