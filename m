Received: from eggs.gnu.org ([2001:4830:134:3::10]:57079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRyNA-0004FU-VZ
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:42:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRyN9-0001rU-Uo
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:42:13 -0500
Received: from mail-ua0-x22f.google.com ([2607:f8b0:400c:c08::22f]:34401)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cRyN9-0001qt-Gw
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 04:42:11 -0500
Received: by mail-ua0-x22f.google.com with SMTP id 35so33230183uak.1
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 01:42:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
References: <1484163327-111841-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jan 2017 09:41:50 +0000
Message-ID: <CAFEAcA8pgXG5SjQJG+p=1xwN+fmyS+i=pwuDHcFYfKtwjq_O-g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/33] Misc patches for 2017-01-11
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

On 11 January 2017 at 19:34, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 41a0e54756a9ae6b60be34bb33302a7e085fdb=
07:
>
>   Merge remote-tracking branch 'remotes/mst/tags/for_upstream' into stagi=
ng (2017-01-10 10:46:21 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to af89d1b204f03e10ade3b61365c7e5c06805caee:
>
>   Revert "win32: don't run subprocess tests on Mingw32 platform" (2017-01=
-11 20:13:12 +0100)
>
> ----------------------------------------------------------------
> * QOM interface fix (Eduardo)
> * RTC fixes (Gaohuai, Igor)
> * Memory leak fixes (Li Qiang, me)
> * Ctrl-a b regression (Marc-Andr=C3=A9)
> * Stubs cleanups and fixes (Leif, me)
> * hxtool tweak (me)
> * HAX support (Vincent)
> * QemuThread, exec.c, target-i386 and SCSI fixes (Roman, Xinhua, me)
>
> ----------------------------------------------------------------

This failed to build on ppc64be:

/home/pm215/qemu/target/ppc/kvm.c: In function =E2=80=98kvm_handle_debug=E2=
=80=99:
/home/pm215/qemu/target/ppc/kvm.c:1724:9: error: implicit declaration
of function =E2=80=98cpu_synchronize_s
tate=E2=80=99 [-Werror=3Dimplicit-function-declaration]
         cpu_synchronize_state(cs);
         ^

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
In file included from /home/pm215/qemu/target/ppc/translate_init.c:24:0,
                 from /home/pm215/qemu/target/ppc/translate.c:6786:
/home/pm215/qemu/target/ppc/kvm_ppc.h:323:0: note: this is the
location of the previous definition
 #define KVM_INTERRUPT_UNSET -2
 ^
In file included from /home/pm215/qemu/linux-headers/linux/kvm.h:13:0,
                 from /home/pm215/qemu/include/sysemu/kvm.h:23,
                 from /home/pm215/qemu/include/sysemu/hw_accel.h:16,
                 from /home/pm215/qemu/target/ppc/translate_init.c:27,
                 from /home/pm215/qemu/target/ppc/translate.c:6786:
/home/pm215/qemu/build/all/linux-headers/asm/kvm.h:322:0: error:
"KVM_INTERRUPT_SET_LEVEL" redefined [-Werror]
 #define KVM_INTERRUPT_SET_LEVEL -3U
 ^
In file included from /home/pm215/qemu/target/ppc/translate_init.c:24:0,
                 from /home/pm215/qemu/target/ppc/translate.c:6786:
/home/pm215/qemu/target/ppc/kvm_ppc.h:327:0: note: this is the
location of the previous definition
 #define KVM_INTERRUPT_SET_LEVEL -3
 ^


thanks
-- PMM
