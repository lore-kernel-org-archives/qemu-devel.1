Received: from eggs.gnu.org ([2001:4830:134:3::10]:38087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gXR1p-0006qC-UL
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gXR1l-0002Em-La
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:27:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gXR1l-0002DF-8r
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 08:27:45 -0500
References: <7c2b477e-bdac-c887-2510-82fe04acdcfe@redhat.com>
	<87b22690-e39c-3b46-dcb4-f6abc3213142@redhat.com>
	<CAFEAcA8yHb4MdtsJuXcswQp93DN5tSeN9dn8AWWL9se0DKvdcg@mail.gmail.com>
	<41ceda53-467e-32a1-8fa6-13f0f9c08ad1@redhat.com>
	<CAFEAcA9oCs+Y1fnY8dOR16n_Hn7PaHziL7K0HZK6=BAd_Gyecg@mail.gmail.com>
	<e496287e-f8ba-3608-42e1-efb697cfc784@redhat.com>
	<20181107154114.GC27585@caravaggio>
	<dd68d3e8-6448-3a67-3212-fd3d3bfba2e2@redhat.com>
	<20181107192414.GH12503@habkost.net>
	<20181108110650.GB32519@caravaggio>
	<20181213115023.GA15355@yangzhon-Virtual>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f550da1d-1f1b-e36d-55a0-d67a33550b0e@redhat.com>
Date: Thu, 13 Dec 2018 14:27:39 +0100
MIME-Version: 1.0
In-Reply-To: <20181213115023.GA15355@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] QEMU and Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 13/12/18 12:50, Yang Zhong wrote:
> Hello Paolo and all,
> 
> The Kconfig has been completed the porting from your repo and
> now i can sucessfully build x86_64-softmmu binary. But there
> are still some issues:
>    1) Only support x86_64 platform.
>       Other platform, especially for ARM platforms, it's hard for me to define 
>       detailed boards like pc or q35 in x86.

No problem, Philippe can look at least at ARM and MIPS.

>    2) Only support "defconfig". 
>       "randconfig" build has some issues, which are mostly related with CONFIG* in Kconfig.host, 
>       some CONFIG* has different setting value in config-host.mak and %/config-device.mak. like
>       CONFIG_OPENGL=y in %/config-device.mak and CONFIG_OPENGL=n in config-host.mak, which result
>       in build failure.

This is probably a bug or missing features in minikconf; values from
config-host.mak and config-target.mak should not be included in
config-devices.mak.

> The current configure and build command are almost same with before and if we want to disable or enable
> some features, like "tcg", we still need add "--enable/--disable-tcg" in configure command line. If we want
> to disable one emulation device, we can disable this in related Kconfig file in hw/ directory.

Yes, this is expected.

> There are still some left issues
>    a) How to replace the CONFIG* in configure, Some CONFIG* need some logic to generate, 
>       those are hard to input this CONFIG* in Kconfig.host or Kconfig* file.
> 
>    b) The CONFIG* in %/config-target.mak file, this is still related with configure. 
>         
>    c) If a) and b) can be fixed, randconfig is not critical issue.
> 
> I will send RFC patches to QEMU community and please all give some comments. many thanks!

Great, this way people can experiment it and we can finalize the design
before continuing the work.

Thanks,

Paolo
