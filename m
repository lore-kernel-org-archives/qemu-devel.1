Received: from eggs.gnu.org ([2001:4830:134:3::10]:34648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFOmq-0005yp-Ih
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:16:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cFOmm-0006XV-19
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:16:44 -0500
Received: from mail-wj0-f169.google.com ([209.85.210.169]:34877)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cFOml-0006X6-Rg
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 12:16:39 -0500
Received: by mail-wj0-f169.google.com with SMTP id v7so19907268wjy.2
	for <qemu-devel@nongnu.org>; Fri, 09 Dec 2016 09:16:39 -0800 (PST)
References: <20161201051433.17168-1-bobby.prani@gmail.com>
	<20161201051433.17168-5-bobby.prani@gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20161201051433.17168-5-bobby.prani@gmail.com>
Date: Fri, 09 Dec 2016 17:15:37 +0000
Message-ID: <87k2b9xbuu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/19] tests/tcg: comment unused code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pranith Kumar <bobby.prani@gmail.com>
Cc: qemu-devel@nongnu.org, rth@twiddle.net, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>


Pranith Kumar <bobby.prani@gmail.com> writes:

> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>
> I didn't remove it, as suggest by checkpatch, because it looks like it
> may eventually be restored back.

I'm not so sure, especially with having full source control. Either fix
it or delete it please.

>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
> ---
>  tests/tcg/linux-test.c      | 8 ++++++--
>  tests/tcg/test-i386-fprem.c | 4 ++++
>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/tests/tcg/linux-test.c b/tests/tcg/linux-test.c
> index 5070d31..38d163c 100644
> --- a/tests/tcg/linux-test.c
> +++ b/tests/tcg/linux-test.c
> @@ -350,6 +350,7 @@ void test_socket(void)
>
>  #define WCOUNT_MAX 512
>
> +#if 0
>  void test_pipe(void)
>  {
>      fd_set rfds, wfds;
> @@ -421,11 +422,13 @@ void test_clone(void)
>
>      stack1 = malloc(STACK_SIZE);
>      pid1 = chk_error(clone(thread1_func, stack1 + STACK_SIZE,
> -                           CLONE_VM | CLONE_FS | CLONE_FILES | SIGCHLD, "hello1"));
> +                           CLONE_VM | CLONE_FS | CLONE_FILES |
> +                           SIGCHLD, (void *)"hello1"));
>
>      stack2 = malloc(STACK_SIZE);
>      pid2 = chk_error(clone(thread2_func, stack2 + STACK_SIZE,
> -                           CLONE_VM | CLONE_FS | CLONE_FILES | SIGCHLD, "hello2"));
> +                           CLONE_VM | CLONE_FS | CLONE_FILES | SIGCHLD,
> +                           (void *)"hello2"));
>
>      while (waitpid(pid1, &status1, 0) != pid1);
>      free(stack1);
> @@ -435,6 +438,7 @@ void test_clone(void)
>          thread2_res != 6)
>          error("clone");
>  }
> +#endif
>
>  /***********************************/
>
> diff --git a/tests/tcg/test-i386-fprem.c b/tests/tcg/test-i386-fprem.c
> index 1a71623..1a2b144 100644
> --- a/tests/tcg/test-i386-fprem.c
> +++ b/tests/tcg/test-i386-fprem.c
> @@ -54,6 +54,7 @@ union float80u {
>
>  #define IEEE854_LONG_DOUBLE_BIAS 0x3fff
>
> +#if 0
>  static const union float80u q_nan = {
>      .ieee_nan.negative = 0,  /* X */
>      .ieee_nan.exponent = 0x7fff,
> @@ -61,6 +62,7 @@ static const union float80u q_nan = {
>      .ieee_nan.quiet_nan = 1,
>      .ieee_nan.mantissa = 0,
>  };
> +#endif
>
>  static const union float80u s_nan = {
>      .ieee_nan.negative = 0,  /* X */
> @@ -91,12 +93,14 @@ static const union float80u pos_denorm = {
>      .ieee.mantissa = 1,
>  };
>
> +#if 0
>  static const union float80u smallest_positive_norm = {
>      .ieee.negative = 0,
>      .ieee.exponent = 1,
>      .ieee.one = 1,
>      .ieee.mantissa = 0,
>  };
> +#endif
>
>  static void fninit()
>  {


--
Alex Bennée
