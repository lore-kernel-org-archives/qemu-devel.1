Received: from eggs.gnu.org ([209.51.188.92]:46931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ghmWm-000760-Bm
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 21:26:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ghmWl-000608-LN
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 21:26:32 -0500
Received: from mga06.intel.com ([134.134.136.31]:62034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1ghmWi-0005vm-VB
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 21:26:30 -0500
Date: Fri, 11 Jan 2019 10:22:44 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190111022244.GA634@yangzhon-Virtual>
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-23-yang.zhong@intel.com>
	<1f94070a-d9df-9fb9-66e8-77e576aeb229@redhat.com>
	<20190108105306.GH27840@yangzhon-Virtual>
	<7037326c-a4ec-03b9-5018-4321af68ead9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7037326c-a4ec-03b9-5018-4321af68ead9@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 22/25] i386-softmmu.mak: remove all
 CONFIG_* except boards definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com, yang.zhong@intel.com

On Tue, Jan 08, 2019 at 12:48:47PM +0100, Paolo Bonzini wrote:
> On 08/01/19 11:53, Yang Zhong wrote:
> > Thanks for detailed comments, i will change this one by one.
> > The previous plan put all "selects" into hw/i386/Kconfig file, which
> > can easily config board if we want to optimize i440fx or q35 platform.
> 
> The selects are for mandatory devices, so if you remove them the machine
> will not start.
> 
> If you want to reduce the platform by omitting non-mandatory devices,
> you can use default-configs, because non-mandatory devices will be
> "default y" (or "default y if PC/PCI/SCSI/I2C"/whatever).
> 
> Paolo
> 
  Thanks Paolo, it's clear now! Yang.

> > The new solution will spread "selects" into detailed hw/*/Kconfig file.
