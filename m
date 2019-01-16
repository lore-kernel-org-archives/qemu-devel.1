Received: from eggs.gnu.org ([209.51.188.92]:34939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjkgk-0006BA-Nt
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:53:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gjkgj-0003pV-MN
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:52:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gjkgj-0003j9-DR
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 07:52:57 -0500
References: <20190115141108.934-1-yang.zhong@intel.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <a63e244c-cd69-ac1a-b0da-59452928872d@redhat.com>
Date: Wed, 16 Jan 2019 13:52:53 +0100
MIME-Version: 1.0
In-Reply-To: <20190115141108.934-1-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: peter.maydell@linaro.org, sameo@linux.intel.com, pbonzini@redhat.com, ehabkost@redhat.com

On 2019-01-15 15:10, Yang Zhong wrote:
> This Kconfig implementation is rebased from Paolo's branch
> https://github.com/bonzini/qemu/commits/kconfig
>=20
> I rebased most of patches except other ARCHs board definitions
> this time.
> https://github.com/yangzhon/qemu/commits/topic/upstream/Kconfig
>=20
> The current RFC patches only support
> (*) x86_64 platform build
>     Once design is fixed, we can do other archs.
>=20
> (*) defconfig
>     "randconfig" build has some issues, which are mostly related
>     with CONFIG* in Kconfig.host abd configure. In randconfig mode,
>     some CONFIG* has different setting value in config-host.mak and
>     %/config-device.mak, which make QEMU build failure.
>=20
> (*) Kconfig in hw/ directory
>=20
> The current configure and build command are same with previous
> commands and if we want to disable or enable some features, like
> "tcg", we still need add "--enable/--disable-tcg" in configure
> command line. If we want to disable one emulation device, we can
> disable this in related Kconfig file in hw/ directory.
>=20
> The current build command:
> (*) ./configure --target-list=3Dx86_64-softmmu
> (*) make -j8
>=20
> Since the Kconfig language replace traditional CONFIG_* in
> default-config/%-softmmu.mak, the %-softmmu.mak file only
> define embeded boards or machines, like 440fx and Q35 in x86_64
> platform. The Kconfig has already defined dependency topology
> between different Kconfig files, but there are still some issues
>=20
> (*) Kconfig for configure(config-host.mak)
>     Some CONFIG* in configure  need some logic to generate, those
>     are hard to input this CONFIG* in Kconfig.host or Kconfig* file.
>=20
> (*) Kconfig for %config-target.mak
>     The CONFIG* in %/config-target.mak file, this is still related
>     with configure.
>=20
> (*) randconfig support issue.
>=20
> Before this RFC patches, we have talked Kconfig in another thread
> http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg02827.html
>=20
> Please give your comments on this RFC thread, many thanks!

I just gave your series a try and compared the
x86_64-softmmu/config-devices.mak before applying the patches and
afterwards. Looks pretty good so far, there were just two settings that
suddenly changed:

CONFIG_IPMI_EXTERN=3Dy
CONFIG_IPMI_LOCAL=3Dy

changed to:

CONFIG_IPMI_EXTERN=3Dn
CONFIG_IPMI_LOCAL=3Dn

I guess these switches still need to be selected by the machines?

 Thomas
