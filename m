Received: from eggs.gnu.org ([2001:4830:134:3::10]:46231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBB5j-0000dA-HK
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBB5g-00055w-A6
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:27:35 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43743)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBB5g-00055s-4N
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:27:32 -0400
Received: by mail-qt0-x242.google.com with SMTP id l11-v6so25094179qtj.10
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 20:27:32 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-17-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3c43fe14-58a6-3b49-a4e3-34122bdb1a08@amsat.org>
Date: Wed, 25 Apr 2018 00:27:25 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-17-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 16/46] tests/tcg: move i386 specific
 tests into subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 12:23 PM, Alex Bennée wrote:
> These only need to be built for i386 guests. This includes a stub
> tests/tcg/i386/Makfile.target which absorbs some of what was in
> tests/tcg/Makefile.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2
>   - move VPATH and TESTs setup into i386/Makefile.target
>   - set CFLAGS+=-m32 for cross building
> ---
>  tests/tcg/README                        |  39 ------------------------
>  tests/tcg/i386/Makefile.target          |  30 ++++++++++++++++++
>  tests/tcg/i386/README                   |  38 +++++++++++++++++++++++
>  tests/tcg/{ => i386}/hello-i386.c       |   0
>  tests/tcg/{ => i386}/pi_10.com          | Bin
>  tests/tcg/{ => i386}/runcom.c           |   0
>  tests/tcg/{ => i386}/test-i386-code16.S |   0
>  tests/tcg/{ => i386}/test-i386-fprem.c  |   0
>  tests/tcg/{ => i386}/test-i386-muldiv.h |   0
>  tests/tcg/{ => i386}/test-i386-shift.h  |   0
>  tests/tcg/{ => i386}/test-i386-ssse3.c  |   0
>  tests/tcg/{ => i386}/test-i386-vm86.S   |   0
>  tests/tcg/{ => i386}/test-i386.c        |   0
>  tests/tcg/{ => i386}/test-i386.h        |   0
>  14 files changed, 68 insertions(+), 39 deletions(-)
>  create mode 100644 tests/tcg/i386/Makefile.target
>  create mode 100644 tests/tcg/i386/README
>  rename tests/tcg/{ => i386}/hello-i386.c (100%)
>  rename tests/tcg/{ => i386}/pi_10.com (100%)
>  rename tests/tcg/{ => i386}/runcom.c (100%)
>  rename tests/tcg/{ => i386}/test-i386-code16.S (100%)
>  rename tests/tcg/{ => i386}/test-i386-fprem.c (100%)
>  rename tests/tcg/{ => i386}/test-i386-muldiv.h (100%)
>  rename tests/tcg/{ => i386}/test-i386-shift.h (100%)
>  rename tests/tcg/{ => i386}/test-i386-ssse3.c (100%)
>  rename tests/tcg/{ => i386}/test-i386-vm86.S (100%)
>  rename tests/tcg/{ => i386}/test-i386.c (100%)
>  rename tests/tcg/{ => i386}/test-i386.h (100%)
> 
> diff --git a/tests/tcg/README b/tests/tcg/README
> index 0890044cf0..469504c4cb 100644
> --- a/tests/tcg/README
> +++ b/tests/tcg/README
> @@ -3,45 +3,6 @@ regression testing. Tests are either multi-arch, meaning they can be
>  built for all guest architectures that support linux-user executable,
>  or they are architecture specific.
>  
> -i386
> -====
> -
> -test-i386
> ----------
> -
> -This program executes most of the 16 bit and 32 bit x86 instructions and
> -generates a text output, for comparison with the output obtained with
> -a real CPU or another emulator.
> -
> -The Linux system call modify_ldt() is used to create x86 selectors
> -to test some 16 bit addressing and 32 bit with segmentation cases.
> -
> -The Linux system call vm86() is used to test vm86 emulation.
> -
> -Various exceptions are raised to test most of the x86 user space
> -exception reporting.
> -
> -linux-test
> -----------
> -
> -This program tests various Linux system calls. It is used to verify
> -that the system call parameters are correctly converted between target
> -and host CPUs.
> -
> -test-i386-fprem
> ----------------
> -
> -runcom
> -------
> -
> -test-mmap
> ----------
> -
> -sha1
> -----
> -
> -hello-i386
> -----------
>  
>  
>  ARM
> diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
> new file mode 100644
> index 0000000000..2f27b65e2d
> --- /dev/null
> +++ b/tests/tcg/i386/Makefile.target
> @@ -0,0 +1,30 @@
> +# i386 cross compile notes
> +
> +I386_SRC=$(SRC_PATH)/tests/tcg/i386
> +
> +# Set search path for all sources
> +VPATH 		+= $(I386_SRC)
> +
> +I386_SRCS=$(notdir $(wildcard $(I386_SRC)/*.c))
> +I386_TESTS=$(I386_SRCS:.c=)
> +
> +# Update TESTS
> +TESTS+=$(I386_TESTS)
> +
> +ifneq ($(TARGET_NAME),x86_64)
> +CFLAGS+=-m32
> +endif
> +
> +#
> +# hello-i386 is a barebones app
> +#
> +hello-i386: CFLAGS+=-ffreestanding
> +hello-i386: LDFLAGS+=-nostdlib
> +
> +#
> +# test-386 includes a couple of additional objects that need to be linked together
> +#
> +
> +test-i386: test-i386.c test-i386-code16.S test-i386-vm86.S test-i386.h test-i386-shift.h test-i386-muldiv.h
> +	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
> +	   $(<D)/test-i386.c $(<D)/test-i386-code16.S $(<D)/test-i386-vm86.S -lm
> diff --git a/tests/tcg/i386/README b/tests/tcg/i386/README
> new file mode 100644
> index 0000000000..7a0a47bf27
> --- /dev/null
> +++ b/tests/tcg/i386/README
> @@ -0,0 +1,38 @@
> +These are i386 specific guest programs
> +
> +test-i386
> +---------
> +
> +This program executes most of the 16 bit and 32 bit x86 instructions and
> +generates a text output, for comparison with the output obtained with
> +a real CPU or another emulator.
> +
> +The Linux system call modify_ldt() is used to create x86 selectors
> +to test some 16 bit addressing and 32 bit with segmentation cases.
> +
> +The Linux system call vm86() is used to test vm86 emulation.
> +
> +Various exceptions are raised to test most of the x86 user space
> +exception reporting.

So I suppose this is expected:

$ make -j1 run-tcg-tests-i386-linux-user
  BUILD   fedora-i386-cross
  [...]
  TEST    test-i386 on i386
ASAN:DEADLYSIGNAL
=================================================================
==8721==ERROR: AddressSanitizer: SEGV on unknown address 0x7fe768f01234
(pc 0x5560b3382e2d bp 0x000000001234 sp 0x7ffcb44a7ef0 T0)
==8721==The signal is caused by a WRITE memory access.
    #0 0x5560b3382e2c in static_code_gen_buffer
(/source/qemu/build/full/i386-linux-user/qemu-i386+0xf64e2c)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV
(/source/qemu/build/full/i386-linux-user/qemu-i386+0xf64e2c) in
static_code_gen_buffer
==8721==ABORTING
make[2]: *** [/source/qemu/tests/tcg/Makefile:64: run-test-i386] Error 1
  TEST    hello-i386 on i386
  SLOW TEST test-i386-fprem SKIPPED on i386

> +
> +linux-test
> +----------
> +
> +This program tests various Linux system calls. It is used to verify
> +that the system call parameters are correctly converted between target
> +and host CPUs.
> +
> +test-i386-fprem
> +---------------
> +
> +runcom
> +------

Also expected:

$ make -j1 run-tcg-tests-i386-linux-user -k
  BUILD   fedora-i386-cross
  [...]
  TEST    runcom on i386
ASAN:DEADLYSIGNAL
=================================================================
==8730==ERROR: AddressSanitizer: SEGV on unknown address 0x7f7d0a8108fe
(pc 0x562c94475f23 bp 0x0000000108fe sp 0x7ffd036dd590 T0)
==8730==The signal is caused by a WRITE memory access.
    #0 0x562c94475f22 in static_code_gen_buffer
(/source/qemu/build/full/i386-linux-user/qemu-i386+0xe5ff22)

AddressSanitizer can not provide additional info.
SUMMARY: AddressSanitizer: SEGV
(/source/qemu/build/full/i386-linux-user/qemu-i386+0xe5ff22) in
static_code_gen_buffer
==8730==ABORTING
make[2]: *** [/source/qemu/tests/tcg/i386/Makefile.target:38:
run-runcom] Error 1
make[2]: Target 'run' not remade because of errors.
make[1]: *** [/source/qemu/tests/tcg/Makefile.include:69:
run-guest-tests] Error 2

> +
> +test-mmap
> +---------

Any idea how to remove this "ignoring old recipe" warning?

$ make -j1 run-tcg-tests-i386-linux-user -k
  BUILD   fedora-i386-cross
  CROSS-BUILD i386 guest-tests with docker qemu:fedora-i386-cross
/source/qemu/tests/tcg/i386/Makefile.target:50: warning: overriding
recipe for target 'run-test-mmap'
/source/qemu/tests/tcg/multiarch/Makefile.target:26: warning: ignoring
old recipe for target 'run-test-mmap'
  BUILD   fedora-i386-cross
  CROSS-BUILD i386 guest-tests with docker qemu:fedora-i386-cross
/source/qemu/tests/tcg/i386/Makefile.target:50: warning: overriding
recipe for target 'run-test-mmap'
/source/qemu/tests/tcg/multiarch/Makefile.target:26: warning: ignoring
old recipe for target 'run-test-mmap'
  RUN-TESTS for i386
/source/qemu/tests/tcg/i386/Makefile.target:50: warning: overriding
recipe for target 'run-test-mmap'
/source/qemu/tests/tcg/multiarch/Makefile.target:26: warning: ignoring
old recipe for target 'run-test-mmap'
  TEST    test-mmap (default) on i386

> +
> +sha1
> +----
> +
> +hello-i386
> +----------
> diff --git a/tests/tcg/hello-i386.c b/tests/tcg/i386/hello-i386.c
> similarity index 100%
> rename from tests/tcg/hello-i386.c
> rename to tests/tcg/i386/hello-i386.c
> diff --git a/tests/tcg/pi_10.com b/tests/tcg/i386/pi_10.com
> similarity index 100%
> rename from tests/tcg/pi_10.com
> rename to tests/tcg/i386/pi_10.com
> diff --git a/tests/tcg/runcom.c b/tests/tcg/i386/runcom.c
> similarity index 100%
> rename from tests/tcg/runcom.c
> rename to tests/tcg/i386/runcom.c
> diff --git a/tests/tcg/test-i386-code16.S b/tests/tcg/i386/test-i386-code16.S
> similarity index 100%
> rename from tests/tcg/test-i386-code16.S
> rename to tests/tcg/i386/test-i386-code16.S
> diff --git a/tests/tcg/test-i386-fprem.c b/tests/tcg/i386/test-i386-fprem.c
> similarity index 100%
> rename from tests/tcg/test-i386-fprem.c
> rename to tests/tcg/i386/test-i386-fprem.c
> diff --git a/tests/tcg/test-i386-muldiv.h b/tests/tcg/i386/test-i386-muldiv.h
> similarity index 100%
> rename from tests/tcg/test-i386-muldiv.h
> rename to tests/tcg/i386/test-i386-muldiv.h
> diff --git a/tests/tcg/test-i386-shift.h b/tests/tcg/i386/test-i386-shift.h
> similarity index 100%
> rename from tests/tcg/test-i386-shift.h
> rename to tests/tcg/i386/test-i386-shift.h
> diff --git a/tests/tcg/test-i386-ssse3.c b/tests/tcg/i386/test-i386-ssse3.c
> similarity index 100%
> rename from tests/tcg/test-i386-ssse3.c
> rename to tests/tcg/i386/test-i386-ssse3.c
> diff --git a/tests/tcg/test-i386-vm86.S b/tests/tcg/i386/test-i386-vm86.S
> similarity index 100%
> rename from tests/tcg/test-i386-vm86.S
> rename to tests/tcg/i386/test-i386-vm86.S
> diff --git a/tests/tcg/test-i386.c b/tests/tcg/i386/test-i386.c
> similarity index 100%
> rename from tests/tcg/test-i386.c
> rename to tests/tcg/i386/test-i386.c
> diff --git a/tests/tcg/test-i386.h b/tests/tcg/i386/test-i386.h
> similarity index 100%
> rename from tests/tcg/test-i386.h
> rename to tests/tcg/i386/test-i386.h
> 
