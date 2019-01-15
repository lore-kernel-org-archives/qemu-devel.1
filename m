Received: from eggs.gnu.org ([209.51.188.92]:55039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjY0f-0006Ns-Gb
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gjY0b-00026s-KR
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:20:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gjY0Z-0001tx-Bs
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:20:35 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3e50059f-3b7e-b9f7-baeb-e8b8bc6893a0@redhat.com>
Date: Wed, 16 Jan 2019 00:20:12 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-1-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 00/37] Support Kconfig in QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, peter.maydell@linaro.org, sameo@linux.intel.com, ehabkost@redhat.com

On 15/01/19 15:10, Yang Zhong wrote:
> This Kconfig implementation is rebased from Paolo's branch
> https://github.com/bonzini/qemu/commits/kconfig
> 
> I rebased most of patches except other ARCHs board definitions
> this time.
> https://github.com/yangzhon/qemu/commits/topic/upstream/Kconfig
> 
> The current RFC patches only support
> (*) x86_64 platform build
>     Once design is fixed, we can do other archs.
> 
> (*) defconfig
>     "randconfig" build has some issues, which are mostly related
>     with CONFIG* in Kconfig.host abd configure. In randconfig mode,
>     some CONFIG* has different setting value in config-host.mak and
>     %/config-device.mak, which make QEMU build failure.
> 
> (*) Kconfig in hw/ directory
> 
> The current configure and build command are same with previous
> commands and if we want to disable or enable some features, like
> "tcg", we still need add "--enable/--disable-tcg" in configure
> command line. If we want to disable one emulation device, we can
> disable this in related Kconfig file in hw/ directory.
> 
> The current build command:
> (*) ./configure --target-list=x86_64-softmmu
> (*) make -j8
> 
> Since the Kconfig language replace traditional CONFIG_* in
> default-config/%-softmmu.mak, the %-softmmu.mak file only
> define embeded boards or machines, like 440fx and Q35 in x86_64
> platform. The Kconfig has already defined dependency topology
> between different Kconfig files, but there are still some issues
> 
> (*) Kconfig for configure(config-host.mak)
>     Some CONFIG* in configure  need some logic to generate, those
>     are hard to input this CONFIG* in Kconfig.host or Kconfig* file.
> 
> (*) Kconfig for %config-target.mak
>     The CONFIG* in %/config-target.mak file, this is still related
>     with configure.
> 
> (*) randconfig support issue.
> 
> Before this RFC patches, we have talked Kconfig in another thread
> http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02827.html
> 
> Please give your comments on this RFC thread, many thanks!

Generally looks good.  I'll let Thomas do another pass, in the meanwhile
I'll find some time to look at the randconfig issue.

Paolo
