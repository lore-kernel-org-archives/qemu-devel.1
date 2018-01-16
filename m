Received: from eggs.gnu.org ([2001:4830:134:3::10]:37975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ebPsb-0003De-Us
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ebPsa-0006hu-Hf
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:58:14 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:42260)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ebPsa-0006h8-7I
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 06:58:12 -0500
Received: by mail-wr0-x242.google.com with SMTP id e41so14544773wre.9
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 03:58:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-wnvhRfOAQySLXWqvwtPXwj+r+wn_sRGM5ti6wWe_c-Q@mail.gmail.com>
References: <1516059302-7169-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA-wnvhRfOAQySLXWqvwtPXwj+r+wn_sRGM5ti6wWe_c-Q@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 16 Jan 2018 12:58:10 +0100
Message-ID: <CAJ+F1CLzuv4CevvT+gM_ZOnC67_=-3EpRiQBoQXqNYDiFLBw+A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v3 00/53] Misc changes for 2017-01-12
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi

On Tue, Jan 16, 2018 at 12:25 PM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 15 January 2018 at 23:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> The following changes since commit 997eba28a3ed5400a80f754bf3a1c8044b75b=
9ff:
>>
>>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20=
180111' into staging (2018-01-11 14:34:41 +0000)
>>
>> are available in the git repository at:
>>
>>
>>   git://github.com/bonzini/qemu.git tags/for-upstream
>>
>> for you to fetch changes up to ff9adba50bf8a4c080b8aee9be2314ef179a7b5f:
>>
>>   ucontext: annotate coroutine stack for ASAN (2018-01-12 15:21:14 +0100=
)
>>
>> ----------------------------------------------------------------
>> * QemuMutex tracing improvements (Alex)
>> * ram_addr_t optimization (David)
>> * SCSI fixes (Fam, Stefan, me)
>> * do {} while (0) fixes (Eric)
>> * KVM fix for PMU (Jan)
>> * memory leak fixes from ASAN (Marc-Andr=C3=A9)
>> * migration fix for HPET, icount, loadvm (Maria, Pavel)
>> * hflags fixes (me, Tao)
>> * block/iscsi uninitialized variable (Peter L.)
>> * full support for GMainContexts in character devices (Peter Xu)
>> * more boot-serial-test (Thomas)
>> * Memory leak fix (Zhecheng)
>
> Various build failures, I'm afraid:
>

damn, sorry..

> x86-64/Linux/gcc:
>
> configure produces an error message:
>
> ERROR: ASAN build enabled, but ASAN header is too old.
>        Without code annotation, the report may be inferior.
>
> even though this configure did not explicitly request ASAN.
> Then configure seems to exit successfully anyway, since the
> build proceeds.

ASAN is enabled by default if available when --enable-debug. We could
add more flags if that helps.

> For some reason the build creates config-target.h a lot:
>
> make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/alld=
bg'
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
>   GEN     config-target.h
> [snip more lines]
>   GEN     config-target.h
>   GEN     config-target.h
> make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all=
'
>   GIT     ui/keycodemapdb dtc capstone
> make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/all'
> make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/all=
'
>   GEN     qapi-event.h
> [etc]

One per target no? (the build should be more silent than before)

>
> Then it runs configure again, this time without the ERROR message,
> and eventually fails with:
>
>   CC      hw/display/exynos4210_fimd.o
> /home/petmay01/linaro/qemu-for-merges/hw/display/exynos4210_fimd.c: In
> function =E2=80=98fimd_get_buffer_id=E2=80=99:
> /home/petmay01/linaro/qemu-for-merges/hw/display/exynos4210_fimd.c:1105:5=
:
> error: case label does not reduce to an integer constant
>      case FIMD_WINCON_BUF2_STAT:

never saw that error, hmm interesting. This is related to
-fsanitize=3Daddress ? Is this on Debian stable?

>      ^
>
> On sparc64 host configure fails:
>
> config-host.mak is out-of-date, running configure
>
> ERROR: configure test passed without -Werror but failed with -Werror.
>        This is probably a bug in the configure script. The failing comman=
d
>        will be at the bottom of config.log.
>        You can run configure with --disable-werror to bypass this check.
>
> The bottom of config.log is:
>
> cc -DHAS_LIBSSH2_SFTP_FSYNC -pthread -I/usr/include/glib-2.0
> -I/usr/lib/sparc64-linux-gnu/glib-2.0/include -DNCURSES_WIDECHAR
> -D_GNU_SOURCE -D_DEFAULT_SOURCE -I/usr/include/ncursesw -m64
> -mcpu=3Dultrasparc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64
> -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall
> -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing
> -fno-common -fwrapv -Wexpansion-to-defined -Wendif-labels
> -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body
> -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self
> -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition
> -Wtype-limits -fstack-protector-strong -I/usr/include/p11-kit-1
> -I/usr/include/libpng16 -I$(SRC_PATH)/capstone/include
> -fsanitize=3Daddress -o config-temp/qemu-conf.exe
> config-temp/qemu-conf.c -m64 -g
> cc1: warning: -fsanitize=3Daddress not supported for this target
> cc -Werror -DHAS_LIBSSH2_SFTP_FSYNC -pthread -I/usr/include/glib-2.0
> -I/usr/lib/sparc64-linux-gnu/glib-2.0/include -DNCURSES_WIDECHAR
> -D_GNU_SOURCE -D_DEFAULT_SOURCE -I/usr/include/ncursesw -m64
> -mcpu=3Dultrasparc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=3D64
> -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall
> -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing
> -fno-common -fwrapv -Wexpansion-to-defined -Wendif-labels
> -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body
> -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self
> -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition
> -Wtype-limits -fstack-protector-strong -I/usr/include/p11-kit-1
> -I/usr/include/libpng16 -I$(SRC_PATH)/capstone/include
> -fsanitize=3Daddress -o config-temp/qemu-conf.exe
> config-temp/qemu-conf.c -m64 -g
> cc1: error: -fsanitize=3Daddress not supported for this target [-Werror]


Hmm, I guess the check -fsanitize=3Daddress doesn't return an error
unless -Werror is given. Perhaps it needs:

diff --git a/configure b/configure
index f5550f3289..ba68c550c9 100755
--- a/configure
+++ b/configure
@@ -5190,7 +5190,7 @@ fi

 have_asan=3Dno
 write_c_skeleton
-if compile_prog "-fsanitize=3Daddress" ""; then
+if compile_prog "-Werror -fsanitize=3Daddress" ""; then
     have_asan=3Dyes
 fi

@@ -5207,7 +5207,7 @@ int main(void) {
   return 0;
 }
 EOF
-if compile_prog "-fsanitize=3Daddress" "" ; then
+if compile_prog "-Werror -fsanitize=3Daddress" "" ; then
     have_asan_iface_fiber=3Dyes
 fi



--=20
Marc-Andr=C3=A9 Lureau
