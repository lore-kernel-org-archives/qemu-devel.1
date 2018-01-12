Received: from eggs.gnu.org ([2001:4830:134:3::10]:37560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZzQt-00031c-DG
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:31:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eZzQs-0000ss-Ea
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:31:43 -0500
Received: from mail-oi0-x229.google.com ([2607:f8b0:4003:c06::229]:32994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eZzQs-0000s1-9i
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 08:31:42 -0500
Received: by mail-oi0-x229.google.com with SMTP id y141so3939151oia.0
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 05:31:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515759853-20360-1-git-send-email-pbonzini@redhat.com>
References: <1515759853-20360-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Jan 2018 13:31:21 +0000
Message-ID: <CAFEAcA_0uFXKY8Xg-FN+AgqVGoL+SJa-FPC8vyw-wLHazu6JEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/52] Misc patches for 2017-01-12
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

On 12 January 2018 at 12:24, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 997eba28a3ed5400a80f754bf3a1c8044b75b9=
ff:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-201=
80111' into staging (2018-01-11 14:34:41 +0000)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to a88ae3be7bf0550adf877f5422c837dbf4bf4a39:
>
>   scripts/analyse-locks-simpletrace.py: script to analyse lock times (201=
8-01-12 13:22:05 +0100)
>
> ----------------------------------------------------------------
> * QemuMutex tracing improvements (Alex)
> * ram_addr_t optimization (David)
> * SCSI fixes (Fam, Stefan, me)
> * do {} while (0) fixes (Eric)
> * KVM fix for PMU (Jan)
> * memory leak fixes from ASAN (Marc-Andr=C3=A9)
> * migration fix for HPET, icount, loadvm (Maria, Pavel)
> * hflags fixes (me, Tao)
> * block/iscsi uninitialized variable (Peter L.)
> * full support for GMainContexts in character devices (Peter Xu)
> * more boot-serial-test (Thomas)
> * Memory leak fix (Zhecheng)
>
> ----------------------------------------------------------------

This fails to build on x86-64 Linux, with an --enable-debug build, using
gcc (Ubuntu 5.4.0-6ubuntu1~16.04.5) 5.4.0 20160609

  CC      util/coroutine-ucontext.o
/home/petmay01/linaro/qemu-for-merges/util/coroutine-ucontext.c: In
function =E2=80=98finish_switch_fiber=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/util/coroutine-ucontext.c:75:5:
error: implicit declaration of function
=E2=80=98__sanitizer_finish_switch_fiber=E2=80=99
[-Werror=3Dimplicit-function-declaration]
     __sanitizer_finish_switch_fiber(fake_stack_save, &bottom_old, &size_ol=
d);
     ^
/home/petmay01/linaro/qemu-for-merges/util/coroutine-ucontext.c:75:5:
error: nested extern declaration of =E2=80=98__sanitizer_finish_switch_fibe=
r=E2=80=99
[-Werror=3Dnested-externs]
/home/petmay01/linaro/qemu-for-merges/util/coroutine-ucontext.c: In
function =E2=80=98start_switch_fiber=E2=80=99:
/home/petmay01/linaro/qemu-for-merges/util/coroutine-ucontext.c:88:5:
error: implicit declaration of function
=E2=80=98__sanitizer_start_switch_fiber=E2=80=99
[-Werror=3Dimplicit-function-declaration]
     __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
     ^
/home/petmay01/linaro/qemu-for-merges/util/coroutine-ucontext.c:88:5:
error: nested extern declaration of =E2=80=98__sanitizer_start_switch_fiber=
=E2=80=99
[-Werror=3Dnested-externs]


It looks like older versions of gcc and the sanitizer don't
provide those switch_fiber functions.

thanks
-- PMM
