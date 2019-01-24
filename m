Received: from eggs.gnu.org ([209.51.188.92]:45645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmUbW-0003Ho-Q1
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmUN1-0005j2-TL
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:03:57 -0500
Received: from mga04.intel.com ([192.55.52.120]:28041)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmUN1-0005eR-IH
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 21:03:55 -0500
Date: Thu, 24 Jan 2019 10:00:08 +0800
From: Yang Zhong <yang.zhong@intel.com>
Message-ID: <20190124020008.GA24604@yangzhon-Virtual>
References: <20190123065618.3520-1-yang.zhong@intel.com>
	<ab10ffce-c591-a08c-3ecf-145f1ef0cd07@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab10ffce-c591-a08c-3ecf-145f1ef0cd07@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v4 00/44] Support Kconfig in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com

On Thu, Jan 24, 2019 at 02:09:25AM +0100, Paolo Bonzini wrote:
> On 23/01/19 07:55, Yang Zhong wrote:
> > This Kconfig implementation is rebased from Paolo's branch
> > https://github.com/bonzini/qemu/commits/kconfig
> > 
> > I rebased most of patches except non-x86 ARCHs dependency definitions
> > this time.
> > https://github.com/yangzhon/qemu/commits/topic/upstream/Kconfig
> > 
> > The current RFC patches only support
> > (*) x86_64 platform build
> >     Once design is fixed, we can do other archs.
> > 
> > (*) defconfig
> >     "randconfig" build has some issues, which are mostly related
> >     with CONFIG* in Kconfig.host abd configure. In randconfig mode,
> >     some CONFIG* has different setting value in config-host.mak and
> >     %/config-device.mak, which make QEMU build failure.
> > 
> > (*) Kconfig in hw/ directory
> > 
> > The current configure and build command are same with previous
> > commands and if we want to disable or enable some features, like
> > "tcg", we still need add "--enable/--disable-tcg" in configure
> > command line. If we want to disable one emulation device, we can
> > disable this in related Kconfig file in hw/ directory.
> > 
> > The current build command:
> > (*) ./configure --target-list=x86_64-softmmu
> > (*) make -j8
> > 
> > Since the Kconfig language replace traditional CONFIG_* in
> > default-config/%-softmmu.mak, the %-softmmu.mak file only
> > define embeded boards or machines, like 440fx and Q35 in x86_64
> > platform. The Kconfig has already defined dependency topology
> > between different Kconfig files, but there are still some issues
> > 
> > (*) Kconfig for configure(config-host.mak)
> >     Some CONFIG* in configure  need some logic to generate, those
> >     are hard to input this CONFIG* in Kconfig.host or Kconfig* file.
> > 
> > (*) Kconfig for %config-target.mak
> >     The CONFIG* in %/config-target.mak file, this is still related
> >     with configure.
> > 
> > (*) randconfig support issue.
> > 
> > Before this RFC patches, we have talked Kconfig in another thread
> > http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02827.html
> > 
> > Please give your comments on this RFC thread, many thanks!
> 
> I started looking at this, and found two bugs in current code
> (unreachable devices that shouldn't be there - SERIAL_ISA for ARM,
> ACPI_NVDIMM for MIPS).  There are a few issues in that the script is not
> Python 3-enabled and only x86 compiles, but they are easily fixed.  A
> slightly bigger thing is to make VFIO configuration more fine-grained
> and express it with kconfig dependencies, but it's just a couple patches
> in the same spirit as these ones.  I'll look at randconfig next.
> 
  Yes, thanks Paolo. The v4 patches have gotten new comments from other
  maintainers, and i will send v5 patches in next week. 

  Regards,

  Yang

> Paolo
