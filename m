Received: from eggs.gnu.org ([209.51.188.92]:34933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1Rd-0007Mp-7J
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gm1Rb-0002Sz-UP
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:10:45 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:42612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gm1Rb-0002Mw-LR
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:10:43 -0500
Received: by mail-ot1-x336.google.com with SMTP id v23so24656613otk.9
	for <qemu-devel@nongnu.org>; Tue, 22 Jan 2019 11:10:35 -0800 (PST)
MIME-Version: 1.0
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 22 Jan 2019 17:19:09 +0000
Message-ID: <CAFEAcA9zA3xo9h=2+LBZ4_38kk8D3CnSS1reWyexc0JpCLfcXA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/49] Misc patches for 2019-01-21
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

On Mon, 21 Jan 2019 at 18:11, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit cce871c504694cf1034adf525556e3ca3c7eebb6:
>
>   hw/block/xen: use proper format string for printing sectors (2019-01-21 14:45:49 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 6ba20c9c9515dfcf22f5e0d0b7628041b6b183f0:
>
>   docker: disable Xen on CentOS 7 (2019-01-21 18:39:47 +0100)
>
> ----------------------------------------------------------------
> * cpu-exec fixes (Emilio, Laurent)
> * high address load for linuxboot (Zhijian)
> * PVH support (Liam, Stefano)
> * Linux header update (Paolo)
> * enable vhost-net for all targets that have virtio-net (Paolo)
> * vhost-user-test cleanups (Paolo)
> * misc i386 changes (Paolo, Robert)
> * hexloader-test change to avoid O_NONBLOCK on stdin (Peter)
> * configure tweak for openpty (Thomas)
> * elf2dmp port to Windows (Viktor)
>
> ----------------------------------------------------------------

Compile failure, x86-64 clang build:

  CC      optionrom/pvh_main.o
In file included from
/home/petmay01/linaro/qemu-for-merges/pc-bios/optionrom/pvh_main.c:26:
/home/petmay01/linaro/qemu-for-merges/pc-bios/optionrom/optrom.h:79:18:
error: invalid operand f
or instruction
    asm volatile("rep insb (%%dx), %%es:(%%edi)"
                 ^
<inline asm>:1:11: note: instantiated into assembly here
        rep insb (%dx), %es:(%edi)
                 ^~~~~~

thanks
-- PMM
