Received: from eggs.gnu.org ([209.51.188.92]:56386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggT9Z-0001sW-1w
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:33:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1ggT9Y-0004b5-9J
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:33:09 -0500
Received: from mga18.intel.com ([134.134.136.126]:55182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1ggT9Y-0004QG-0m
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 06:33:08 -0500
Date: Mon, 7 Jan 2019 19:29:29 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190107112929.GA26045@yangzhon-Virtual>
References: <20181227063419.12981-1-yang.zhong@intel.com>
	<20181227063419.12981-2-yang.zhong@intel.com>
	<5bd93d20-08a3-e382-94a1-bf6529a5944c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bd93d20-08a3-e382-94a1-bf6529a5944c@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 01/25] build: actually use CONFIG_PAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org, "Daniel P. Berrange" <berrange@redhat.com>, yang.zhong@intel.com

On Thu, Jan 03, 2019 at 03:15:44PM +0100, Thomas Huth wrote:
>  Hi,
> 
> On 2018-12-27 07:33, Yang Zhong wrote:
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > Do not link it unconditionally into all binaries.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > ---
> >  hw/pci-host/Makefile.objs | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
> > index 6d6597c065..9d7e7cd1b8 100644
> > --- a/hw/pci-host/Makefile.objs
> > +++ b/hw/pci-host/Makefile.objs
> > @@ -1,4 +1,4 @@
> > -common-obj-y += pam.o
> > +common-obj-$(CONFIG_PAM) += pam.o
> 
> CONFIG_PAM has been removed in the default-configs with commit
> 
>   a3b6e2bb71e6495a44f24e2296ab4feb4b6d4818
>    default-configs: remove CONFIG_PAM
> 
> ... so if you want to use it now, you've got to revert that commit, too.
> 
>  Thomas

   Thanks Thomas for your reminder!
   Since default-configs/x86_64-softmmu.mak has only include i386-softmmu.mak file now,
   It's is hard to directly revert this patch, i will merge CONFIG_PAM=y into i386-softmmu.mak
   with this patch. thanks!

   Regards,

   Yang
