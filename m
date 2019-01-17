Received: from eggs.gnu.org ([209.51.188.92]:38399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gk6ZD-0002ar-A2
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:14:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gk6ZC-0000pf-Kx
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:14:39 -0500
Received: from mga02.intel.com ([134.134.136.20]:2576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gk6ZC-0000eV-CZ
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 07:14:38 -0500
Date: Thu, 17 Jan 2019 20:10:54 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190117121054.GH11760@yangzhon-Virtual>
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-9-yang.zhong@intel.com>
	<b566b841-df63-5b48-ae85-4cfdf3e5d129@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b566b841-df63-5b48-ae85-4cfdf3e5d129@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 08/37] hw/sh4/Makefile.objs: New
 CONFIG_* varibales created for sh4 boards and device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, sameo@linux.intel.com, =?iso-8859-1?Q?=E1kos_Kov=E1cs?= <akoskovacs@gmx.com>, pbonzini@redhat.com, ehabkost@redhat.com, Yang Zhong <yang.zhong@intel.com>

On Wed, Jan 16, 2019 at 09:48:16AM +0100, Thomas Huth wrote:

> sh7750.o and sh7750_regnames.o are "common" code of the r2d and shix
> machine, and do not define a separate machine ... not sure whether we
> need a separate CONFIG_SH7750 switch for this? I'd rather treat these
> two file like sh_pci.o instead, and always include them unconditionally,
> I think... Or do I miss something?
a>
  Thanks Thomas, exactly, r2d_init() and shix_init all call sh7750_init().

  Regards,

  Yang
>  Thomas
