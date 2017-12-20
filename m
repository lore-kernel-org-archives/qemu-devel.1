Received: from eggs.gnu.org ([2001:4830:134:3::10]:47826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRl2I-0005h0-F8
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 15:32:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eRl2H-00075c-DL
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 15:32:18 -0500
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:39230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eRl2H-000758-9D
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 15:32:17 -0500
Received: by mail-ot0-x244.google.com with SMTP id v21so20702182oth.6
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 12:32:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171220180358.29316-1-pbonzini@redhat.com>
References: <20171220180358.29316-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 20 Dec 2017 20:31:56 +0000
Message-ID: <CAFEAcA-VXabxkEeLcvtf7OZTpM1WUD9O+XwUX1D9rBFFGf5JCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/19] Initial support for
 Hypervisor.framework
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

On 20 December 2017 at 18:03, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit f1faf2d59c91a8f1f59a0fc6339154efb749b55d:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-12-20 11:30:55 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream-hvf
>
> for you to fetch changes up to 5fd1a70fb75d53b43dfff636a9c641dbf03f949f:
>
>   i386: hvf: cleanup x86_gen.h (2017-12-20 18:39:06 +0100)
>
> ----------------------------------------------------------------
> Initial support for the HVF accelerator

Build failure, Windows:

  LINK    arm-softmmu/qemu-system-arm.exe
cpus.o: In function `qemu_hvf_cpu_thread_fn':
/home/petmay01/linaro/qemu-for-merges/cpus.c:1478: undefined reference
to `hvf_init_vcpu'
/home/petmay01/linaro/qemu-for-merges/cpus.c:1486: undefined reference
to `hvf_vcpu_exec'
/home/petmay01/linaro/qemu-for-merges/cpus.c:1494: undefined reference
to `hvf_vcpu_destroy'
collect2: error: ld returned 1 exit status

(ditto for all the other exes)

Build failure, OSX:

In file included from
/Users/pm215/src/qemu-for-merges/target/i386/hvf/x86_cpuid.c:25:
/Users/pm215/src/qemu-for-merges/target/i386/hvf/x86.h:290:5: error:
unknown type name 'target_ulong'
    target_ulong result;
    ^
/Users/pm215/src/qemu-for-merges/target/i386/hvf/x86.h:291:5: error:
unknown type name 'target_ulong'
    target_ulong auxbits;
    ^
/Users/pm215/src/qemu-for-merges/target/i386/hvf/x86.h:382:1: error:
unknown type name 'target_ulong'
target_ulong linear_addr(struct CPUState *cpu, target_ulong addr, enum
X86Seg seg);
^
/Users/pm215/src/qemu-for-merges/target/i386/hvf/x86.h:382:48: error:
unknown type name 'target_ulong'
target_ulong linear_addr(struct CPUState *cpu, target_ulong addr, enum
X86Seg seg);
                                               ^
/Users/pm215/src/qemu-for-merges/target/i386/hvf/x86.h:383:1: error:
unknown type name 'target_ulong'
target_ulong linear_addr_size(struct CPUState *cpu, target_ulong addr, int size,
^
/Users/pm215/src/qemu-for-merges/target/i386/hvf/x86.h:383:53: error:
unknown type name 'target_ulong'
target_ulong linear_addr_size(struct CPUState *cpu, target_ulong addr, int size,
                                                    ^
/Users/pm215/src/qemu-for-merges/target/i386/hvf/x86.h:385:1: error:
unknown type name 'target_ulong'
target_ulong linear_rip(struct CPUState *cpu, target_ulong rip);
^
/Users/pm215/src/qemu-for-merges/target/i386/hvf/x86.h:385:47: error:
unknown type name 'target_ulong'
target_ulong linear_rip(struct CPUState *cpu, target_ulong rip);
                                              ^

thanks
-- PMM
