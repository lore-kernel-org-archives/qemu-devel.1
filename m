Received: from eggs.gnu.org ([209.51.188.92]:60945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkQ4E-0004Rg-E1
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:03:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gkQ4D-0006VR-IZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:03:58 -0500
Received: from mga05.intel.com ([192.55.52.43]:53177)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gkQ4D-0006TW-8j
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:03:57 -0500
Date: Fri, 18 Jan 2019 17:00:14 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190118090014.GC13961@yangzhon-Virtual>
References: <20190115141108.934-1-yang.zhong@intel.com>
	<20190115141108.934-36-yang.zhong@intel.com>
	<fb502f25-0307-b52f-2810-26bb3cf72dd6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb502f25-0307-b52f-2810-26bb3cf72dd6@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 35/37] i386-softmmu.mak: remove all
 CONFIG_* except boards definitions
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

On Thu, Jan 17, 2019 at 12:03:34PM +0100, Thomas Huth wrote:
> > --- a/hw/mem/Kconfig
> > +++ b/hw/mem/Kconfig
> > @@ -6,3 +6,5 @@ config MEM_DEVICE
> >  
> >  config NVDIMM
> >      bool
> > +    default y
> > +    depends on I440FX && Q35
> 
> I440FX || Q35 ?
> 
  Thanks Thomas, "I440FX || Q35" is right, i will change these one by one, Yang.

> (FWIW: it's also used by mips-softmmu.mak, so we need to add this here
> later, too)
> 
>  Thomas
