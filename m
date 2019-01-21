Received: from eggs.gnu.org ([209.51.188.92]:39606)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1glX1d-00075u-Ci
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:41:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1glWmO-0000NA-IQ
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:26:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1glWmO-0000M3-9b
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 05:26:08 -0500
References: <20190118112410.3010-1-yang.zhong@intel.com>
	<20190118112410.3010-29-yang.zhong@intel.com>
	<20190118113051-mutt-send-email-mst@kernel.org>
	<CABgObfZEGtdxGqGCRawW9Cd6c3NO0efwYWZCv3k4VvAJsm8-vw@mail.gmail.com>
	<20190118142758-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <154d7fa7-6941-2943-6338-a7440487b399@redhat.com>
Date: Mon, 21 Jan 2019 11:25:57 +0100
MIME-Version: 1.0
In-Reply-To: <20190118142758-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, "Maydell, Peter" <peter.maydell@linaro.org>, thuth@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org, sameo@linux.intel.com

On 18/01/19 20:28, Michael S. Tsirkin wrote:
> OK, and I also think we should rename it PCIE -> PCI_EXPRESS_, this way
> everything PCI starts with PCI.

I have no preference for PCIE vs. PCI_EXPRESS (PCIE is universally known
and shorter, but it's okay either way), but I agree it makes sense to
rename everything that selects PCIE so that it starts with either PCIE
or PCI_EXPRESS.  Yang, can you place a patch to do that before your
series to do the rename?

Thanks,

Paolo
