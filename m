Received: from eggs.gnu.org ([209.51.188.92]:57686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkXwq-0001UN-3e
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gkXwp-0007o2-CD
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:28:52 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34118)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gkXwp-0007nd-67
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 12:28:51 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so11813064ede.1
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 09:28:51 -0800 (PST)
MIME-Version: 1.0
References: <20190118112410.3010-1-yang.zhong@intel.com>
	<20190118112410.3010-29-yang.zhong@intel.com>
	<20190118113051-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190118113051-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 18 Jan 2019 18:28:37 +0100
Message-ID: <CABgObfZEGtdxGqGCRawW9Cd6c3NO0efwYWZCv3k4VvAJsm8-vw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "S. Tsirkin, Michael" <mst@redhat.com>
Cc: Yang Zhong <yang.zhong@intel.com>, "Maydell,
	Peter" <peter.maydell@linaro.org>, thuth@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org, sameo@linux.intel.com

>
>
>
> I think PCIE should depend on PCI or something like this.
> That's because there are places in code that test CONFIG_PCI,
> you want PCIE to enable them as well.
>

I agree, it should select PCI, so that PCIe bridges only need to select
PCIE (the model in QEMU is that you enable boards and pluggable devices;
everything else, especially buses, is then selected automatically based on
whether any controllers/bridges are enabled for those buses).

Paolo

>
