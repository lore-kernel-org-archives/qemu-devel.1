Received: from eggs.gnu.org ([209.51.188.92]:56197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gkZor-0002f1-BO
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 14:28:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gkZoq-0003Ok-JF
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 14:28:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gkZoq-0003BS-D6
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 14:28:44 -0500
Date: Fri, 18 Jan 2019 14:28:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190118142758-mutt-send-email-mst@kernel.org>
References: <20190118112410.3010-1-yang.zhong@intel.com>
	<20190118112410.3010-29-yang.zhong@intel.com>
	<20190118113051-mutt-send-email-mst@kernel.org>
	<CABgObfZEGtdxGqGCRawW9Cd6c3NO0efwYWZCv3k4VvAJsm8-vw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABgObfZEGtdxGqGCRawW9Cd6c3NO0efwYWZCv3k4VvAJsm8-vw@mail.gmail.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, "Maydell, Peter" <peter.maydell@linaro.org>, thuth@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org, sameo@linux.intel.com

On Fri, Jan 18, 2019 at 06:28:37PM +0100, Paolo Bonzini wrote:
> 
> 
>     I think PCIE should depend on PCI or something like this.
>     That's because there are places in code that test CONFIG_PCI,
>     you want PCIE to enable them as well.
> 
> 
> I agree, it should select PCI, so that PCIe bridges only need to select PCIE
> (the model in QEMU is that you enable boards and pluggable devices; everything
> else, especially buses, is then selected automatically based on whether any
> controllers/bridges are enabled for those buses).
> 
> Paolo
> 

OK, and I also think we should rename it PCIE -> PCI_EXPRESS_, this way
everything PCI starts with PCI.

-- 
MST
