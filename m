Received: from eggs.gnu.org ([209.51.188.92]:45698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmrDl-0003ZX-KS
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 21:27:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmr7w-0007Gc-9f
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 21:21:53 -0500
Received: from mga18.intel.com ([134.134.136.126]:54211)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmr7w-0007GF-0f
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 21:21:52 -0500
Date: Fri, 25 Jan 2019 10:18:09 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190125021809.GB26802@yangzhon-Virtual>
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<20190123065618.3520-27-yang.zhong@intel.com>
	<50df8f61-e649-2fac-ab0b-72f9ef60bd39@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50df8f61-e649-2fac-ab0b-72f9ef60bd39@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v4 26/44] kconfig: introduce kconfig
 files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com

On Thu, Jan 24, 2019 at 03:06:01PM +0100, Thomas Huth wrote:
> On 2019-01-23 07:56, Yang Zhong wrote:
> > From: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > The Kconfig files were generated mostly with this script:
> > 
> >   for i in `grep -ho CONFIG_[A-Z0-9_]* default-configs/* | sort -u`; do
> >     set fnord `git grep -lw $i -- 'hw/*/Makefile.objs' `
> >     shift
> >     if test $# = 1; then
> >       cat >> $(dirname $1)/Kconfig << EOF
> > config ${i#CONFIG_}
> >     bool
> > 
> > EOF
> >       git add $(dirname $1)/Kconfig
> >     else
> >       echo $i $*
> >     fi
> >   done
> >   sed -i '$d' hw/*/Kconfig
> >   for i in hw/*; do
> >     if test -d $i && ! test -f $i/Kconfig; then
> >       touch $i/Kconfig
> >       git add $i/Kconfig
> >     fi
> >   done
> > 
> > Whenever a symbol is referenced from multiple subdirectories, the
> > script prints the list of directories that reference the symbol.
> > These symbols have to be added manually to the Kconfig files.
> > 
> > Kconfig.host and hw/Kconfig were created manually.
> > 
> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> > ---
> [...]
> > diff --git a/hw/cris/Kconfig b/hw/cris/Kconfig
> > new file mode 100644
> > index 0000000000..c2c26e5150
> > --- /dev/null
> > +++ b/hw/cris/Kconfig
> > @@ -0,0 +1,2 @@
> > +config AXIS
> > +    bool
> 
> Please also add here:
> 
> config ETRAXFS
>     bool
>
  Yes, i will add this, thanks, Yang. 
> > diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> > new file mode 100644
> > index 0000000000..1a3e8b0e02
> > --- /dev/null
> > +++ b/hw/riscv/Kconfig
> > @@ -0,0 +1,14 @@
> > +config HTIF
> > +    bool
> > +
> > +config HART
> > +    bool
> > +
> > +config SIFIVE
> > +    bool
> > +
> > +config SPIKE
> > +    bool
> > +
> > +config RISCV_VIRTIO
> > +    bool
> 
> Please rename the RISCV_VIRTIO to RISCV_VIRT.
> 
> We also additionally need these two here:
> 
> config SIFIVE_E
>     bool
> 
> config SIFIVE_U
>     bool
> 
  Wow, this is my mistake, i omitted this, thanks for reminder!

  Regards,

  Yang
>  Thanks,
>   Thomas
