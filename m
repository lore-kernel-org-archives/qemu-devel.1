Received: from eggs.gnu.org ([2001:4830:134:3::10]:35492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUCsl-000111-Fu
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:36:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUCsk-0003qu-Jr
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:36:03 -0500
Received: from mail-vk0-x22e.google.com ([2607:f8b0:400c:c05::22e]:35903)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUCsk-0003qn-Fs
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 08:36:02 -0500
Received: by mail-vk0-x22e.google.com with SMTP id t8so29411101vke.3
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 05:36:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170116165916.8575-1-pbonzini@redhat.com>
References: <20170116165916.8575-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 19 Jan 2017 13:35:41 +0000
Message-ID: <CAFEAcA8LcysFu_5ASczUEXjce+Uj71bP2ZT7kXCgMq5PPWb09w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 00/32] Misc patches for 2017-01-11
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 January 2017 at 16:58, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 2ccede18bd24fce5db83fef3674563a1f256717b:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.9-pull-request' into staging (2017-01-16 12:41:35 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 91c7e9f6b82804c6b53ecc5057d6b305b766ba49:
>
>   Revert "win32: don't run subprocess tests on Mingw32 platform" (2017-01-16 17:55:25 +0100)

Fails to build, ppc64be host:

In file included from /home/pm215/qemu/linux-headers/linux/kvm.h:13:0,
                 from /home/pm215/qemu/include/sysemu/kvm.h:23,
                 from /home/pm215/qemu/include/sysemu/hw_accel.h:16,
                 from /home/pm215/qemu/target/ppc/translate_init.c:27,
                 from /home/pm215/qemu/target/ppc/translate.c:6786:
/home/pm215/qemu/build/all/linux-headers/asm/kvm.h:320:0: error:
"KVM_INTERRUPT_SET" redefined [-Wer
ror]
 #define KVM_INTERRUPT_SET -1U
 ^
In file included from /home/pm215/qemu/target/ppc/translate_init.c:24:0,
                 from /home/pm215/qemu/target/ppc/translate.c:6786:
/home/pm215/qemu/target/ppc/kvm_ppc.h:319:0: note: this is the
location of the previous definition
 #define KVM_INTERRUPT_SET -1
 ^
In file included from /home/pm215/qemu/linux-headers/linux/kvm.h:13:0,
                 from /home/pm215/qemu/include/sysemu/kvm.h:23,
                 from /home/pm215/qemu/include/sysemu/hw_accel.h:16,
                 from /home/pm215/qemu/target/ppc/translate_init.c:27,
                 from /home/pm215/qemu/target/ppc/translate.c:6786:
/home/pm215/qemu/build/all/linux-headers/asm/kvm.h:321:0: error:
"KVM_INTERRUPT_UNSET" redefined [-Werror]
 #define KVM_INTERRUPT_UNSET -2U
 ^

thanks
-- PMM
