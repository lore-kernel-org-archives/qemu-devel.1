Received: from eggs.gnu.org ([2001:4830:134:3::10]:44980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdtjL-00087H-Qo
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 04:47:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fdtjI-00068e-PG
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 04:47:11 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:39148)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fdtjI-00067k-Gx
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 04:47:08 -0400
Received: by mail-wr1-x42a.google.com with SMTP id h10-v6so24284800wre.6
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 01:47:08 -0700 (PDT)
References: <20180713054755.23323-1-sw@weilnetz.de>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180713054755.23323-1-sw@weilnetz.de>
Date: Fri, 13 Jul 2018 09:47:05 +0100
Message-ID: <877elzcyk6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: Fix typos in comments and help
 message (found by codespell)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>
Cc: QEMU Developer <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Fam Zheng <famz@redhat.com>


Stefan Weil <sw@weilnetz.de> writes:

> Fix also a grammar issue.
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

*blush* 5 of those are my spelling mistakes, so have an embarrassed:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/bios-tables-test.c              | 2 +-
>  tests/docker/Makefile.include         | 2 +-
>  tests/docker/docker.py                | 4 ++--
>  tests/guest-debug/test-gdbstub.py     | 2 +-
>  tests/qemu-iotests/common.qemu        | 2 +-
>  tests/tcg/Makefile.include            | 2 +-
>  tests/tcg/Makefile.probe              | 2 +-
>  tests/tcg/mips/mips64-dsp/subq_s_pw.c | 2 +-
>  8 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 4e24930c4b..af4b1fb6bd 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -390,7 +390,7 @@ try_again:
>          if (g_file_test(aml_file, G_FILE_TEST_EXISTS)) {
>              exp_sdt.aml_file =3D aml_file;
>          } else if (*ext !=3D '\0') {
> -            /* try fallback to generic (extention less) expected file */
> +            /* try fallback to generic (extension less) expected file */
>              ext =3D "";
>              g_free(aml_file);
>              goto try_again;
> diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
> index b2a7e761cc..d865dcfdaa 100644
> --- a/tests/docker/Makefile.include
> +++ b/tests/docker/Makefile.include
> @@ -37,7 +37,7 @@ docker-qemu-src: $(DOCKER_SRC_COPY)
>  docker-image: ${DOCKER_TARGETS}
>
>  # General rule for building docker images. If we are a sub-make
> -# invoked with SKIP_DOCKER_BUILD we still check the image is upto date
> +# invoked with SKIP_DOCKER_BUILD we still check the image is up to date
>  # though
>  ifdef SKIP_DOCKER_BUILD
>  docker-image-%: $(DOCKER_FILES_DIR)/%.docker
> diff --git a/tests/docker/docker.py b/tests/docker/docker.py
> index 69e7130db7..b82926596c 100755
> --- a/tests/docker/docker.py
> +++ b/tests/docker/docker.py
> @@ -99,7 +99,7 @@ def _get_so_libs(executable):
>      return libs
>
>  def _copy_binary_with_libs(src, dest_dir):
> -    """Copy a binary executable and all its dependant libraries.
> +    """Copy a binary executable and all its dependent libraries.
>
>      This does rely on the host file-system being fairly multi-arch
>      aware so the file don't clash with the guests layout."""
> @@ -261,7 +261,7 @@ class SubCommand(object):
>      name =3D None # Subcommand name
>      def shared_args(self, parser):
>          parser.add_argument("--quiet", action=3D"store_true",
> -                            help=3D"Run quietly unless an error occured")
> +                            help=3D"Run quietly unless an error occurred=
")
>
>      def args(self, parser):
>          """Setup argument parser"""
> diff --git a/tests/guest-debug/test-gdbstub.py b/tests/guest-debug/test-g=
dbstub.py
> index 474d2c5c65..0e4ac01426 100644
> --- a/tests/guest-debug/test-gdbstub.py
> +++ b/tests/guest-debug/test-gdbstub.py
> @@ -122,7 +122,7 @@ class CatchBreakpoint(gdb.Breakpoint):
>
>
>  def run_test():
> -    "Run throught the tests one by one"
> +    "Run through the tests one by one"
>
>      print ("Checking we can step the first few instructions")
>      step_ok =3D 0
> diff --git a/tests/qemu-iotests/common.qemu b/tests/qemu-iotests/common.q=
emu
> index f285484951..dadde2a266 100644
> --- a/tests/qemu-iotests/common.qemu
> +++ b/tests/qemu-iotests/common.qemu
> @@ -257,7 +257,7 @@ function _launch_qemu()
>  }
>
>
> -# Silenty kills the QEMU process
> +# Silently kills the QEMU process
>  #
>  # If $wait is set to anything other than the empty string, the process w=
ill not
>  # be killed but only waited for, and any output will be forwarded to std=
out. If
> diff --git a/tests/tcg/Makefile.include b/tests/tcg/Makefile.include
> index 57470b2a2c..c581bd6ffc 100644
> --- a/tests/tcg/Makefile.include
> +++ b/tests/tcg/Makefile.include
> @@ -2,7 +2,7 @@
>  #
>  # TCG tests (per-target rules)
>  #
> -# This Makefile fragement is included from the per-target
> +# This Makefile fragment is included from the per-target
>  # Makefile.target so will be invoked for each linux-user program we
>  # build. We have two options for compiling, either using a configured
>  # guest compiler or calling one of our docker images to do it for us.
> diff --git a/tests/tcg/Makefile.probe b/tests/tcg/Makefile.probe
> index 15c0412657..9dc654663d 100644
> --- a/tests/tcg/Makefile.probe
> +++ b/tests/tcg/Makefile.probe
> @@ -2,7 +2,7 @@
>  #
>  # TCG Compiler Probe
>  #
> -# This Makefile fragement is included multiple times in the main make
> +# This Makefile fragment is included multiple times in the main make
>  # script to probe for available compilers. This is used to build up a
>  # selection of required docker targets before we invoke a sub-make for
>  # each target.
> diff --git a/tests/tcg/mips/mips64-dsp/subq_s_pw.c b/tests/tcg/mips/mips6=
4-dsp/subq_s_pw.c
> index e8e0b0567e..4c080b785a 100644
> --- a/tests/tcg/mips/mips64-dsp/subq_s_pw.c
> +++ b/tests/tcg/mips/mips64-dsp/subq_s_pw.c
> @@ -24,7 +24,7 @@ int main(void)
>      rt =3D 0x123456789ABCDEF1;
>      rs =3D 0x123456789ABCDEF2;
>      result =3D  0x0000000000000001;
> -    /* This time we do not set dspctrl, but it setted in pre-action. */
> +    /* This time we do not set dspctrl, but set it in pre-action. */
>      dspresult =3D 0x1;
>
>      __asm


--
Alex Benn=C3=A9e
