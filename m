Received: from eggs.gnu.org ([2001:4830:134:3::10]:55304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emTNY-0005zj-Rr
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:55:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emTNU-0005Uc-QO
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:55:52 -0500
Received: from mail-qt0-x231.google.com ([2607:f8b0:400d:c0d::231]:44405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1emTNU-0005UK-LG
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 18:55:48 -0500
Received: by mail-qt0-x231.google.com with SMTP id f18so1868915qth.11
	for <qemu-devel@nongnu.org>; Thu, 15 Feb 2018 15:55:48 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180204222356.14546-1-richard.henderson@linaro.org>
	<20180204222356.14546-3-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3edd5d86-1c7c-1a32-4203-5ea4c432ad1f@amsat.org>
Date: Thu, 15 Feb 2018 20:55:45 -0300
MIME-Version: 1.0
In-Reply-To: <20180204222356.14546-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 2/3] tests: Enable boot-serial-test for hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On 02/04/2018 07:23 PM, Richard Henderson wrote:
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/boot-serial-test.c | 1 +
>  tests/Makefile.include   | 2 ++
>  2 files changed, 3 insertions(+)
> 
> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
> index 418c5b92dc..ea87a80be7 100644
> --- a/tests/boot-serial-test.c
> +++ b/tests/boot-serial-test.c
> @@ -87,6 +87,7 @@ static testdef_t tests[] = {
>        sizeof(kernel_plml605), kernel_plml605 },
>      { "moxie", "moxiesim", "", "TT", sizeof(bios_moxiesim), 0, bios_moxiesim },
>      { "arm", "raspi2", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 },
> +    { "hppa", "hppa", "", "SeaBIOS wants SYSTEM HALT" },
>  
>      { NULL }
>  };
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index ca82e0c0cc..83def6994c 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -299,6 +299,8 @@ gcov-files-x86_64-y = $(subst i386-softmmu/,x86_64-softmmu/,$(gcov-files-i386-y)
>  
>  check-qtest-alpha-y = tests/boot-serial-test$(EXESUF)
>  
> +check-qtest-hppa-y = tests/boot-serial-test$(EXESUF)
> +
>  check-qtest-m68k-y = tests/boot-serial-test$(EXESUF)
>  
>  check-qtest-microblaze-y = tests/boot-serial-test$(EXESUF)
> 

I got this failure in 2 different branches:

  GTESTER check-qtest-hppa
**
ERROR:tests/boot-serial-test.c:137:check_guest_output: assertion failed:
(output_ok)
GTester: last random seed: R02S55e7df877597841c1b3b62962e410123
make: *** [check-qtest-hppa] Error 1
make: *** Waiting for unfinished jobs....

https://travis-ci.org/philmd/qemu/jobs/341959060
  "compiler": "gcc",
  "env": "CONFIG=\"--disable-linux-user\"",
  "dist": "trusty",
  "os": "linux"

https://travis-ci.org/philmd/qemu/jobs/341979253
  "compiler": "gcc",
  "env": "CONFIG=\"--with-coroutine=ucontext --disable-linux-user\"",
  "dist": "trusty",
  "os": "linux"
