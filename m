Received: from eggs.gnu.org ([2001:4830:134:3::10]:35857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rh6-0000VN-JD
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:08:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rh4-0007Kc-W4
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:08:28 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:38983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7rh4-0007KD-RZ
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 20:08:26 -0400
Received: by mail-qk0-x242.google.com with SMTP id j73so14833415qke.6
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 17:08:26 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-12-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <0f3a18c4-123b-4809-6c28-22901d9c6e79@amsat.org>
Date: Sun, 15 Apr 2018 21:08:23 -0300
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 11/24] tests/tcg: move i386 specific
 tests into subdir
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: famz@redhat.com, cota@braap.org

On 04/10/2018 04:39 PM, Alex Bennée wrote:
> These only need to be built for i386 guests. This includes a stub
> tests/tcg/i386/Makfile.target which absorbs some of what was in

Mak[e]file

> tests/tcg/Makefile.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/tcg/README                        |  39 --------------------------------
>  tests/tcg/i386/Makefile.target          |  10 ++++++++
>  tests/tcg/i386/README                   |  38 +++++++++++++++++++++++++++++++
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
>  14 files changed, 48 insertions(+), 39 deletions(-)
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
> index 0000000000..7dbb7992e7
> --- /dev/null
> +++ b/tests/tcg/i386/Makefile.target
> @@ -0,0 +1,10 @@
> +# i386 cross compile notes
> +
> +# If we are using a cross compiler config-target.mak may have also
> +# defined some CFLAGs to use.
> +
> +ifeq ($(CC), $(CROSS_CC_GUEST))
> +ifdef CROSS_CC_GUEST_CFLAGS
> +CFLAGS+=$(CROSS_CC_GUEST_CFLAGS)
> +endif
> +endif
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
> +
> +test-mmap
> +---------
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
