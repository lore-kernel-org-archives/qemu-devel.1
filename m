Received: from eggs.gnu.org ([2001:4830:134:3::10]:42873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZkzK-0007pn-Ie
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 18:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gZkzF-0007NI-Or
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 18:10:49 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45606)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gZkzF-0007Mb-7j
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 18:10:45 -0500
Received: by mail-ot1-x341.google.com with SMTP id 32so20678960ota.12
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 15:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20181219151917.3874-1-pbonzini@redhat.com>
In-Reply-To: <20181219151917.3874-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Dec 2018 23:10:30 +0000
Message-ID: <CAFEAcA_0jPh6TVOqzfp_O5eFitNocabR1GdLkwwZcv6QcW=iUQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/35] Misc patches for 2018-12-18
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

On Wed, 19 Dec 2018 at 15:21, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit e85c577158a2e8e252414959da9ef15c12eec6=
3d:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-201=
8-12-17' into staging (2018-12-18 14:31:06 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to b4e8bbb9ae50045160957e7ab66c4f1cae535ea4:
>
>   avoid TABs in files that only contain a few (2018-12-19 16:03:22 +0100)
>
> ----------------------------------------------------------------
> * HAX support for Linux hosts (Alejandro)
> * esp bugfixes (Guenter)
> * Windows build cleanup (Marc-Andr=C3=A9)
> * checkpatch logic improvements (Paolo)
> * coalesced range bugfix (Paolo)
> * switch testsuite to TAP (Paolo)
> * QTAILQ rewrite (Paolo)
> * block/iscsi.c cancellation fixes (Stefan)
> * improve selection of the default accelerator (Thomas)
>
> ----------------------------------------------------------------


I get a compile failure on my OSX system:

  CC      tests/test-crypto-pbkdf.o
/Users/pm215/src/qemu-for-merges/tests/test-crypto-pbkdf.c:444:17:
error: too few arguments to function call, single argument 'msg' was
not specified
    g_test_skip();
    ~~~~~~~~~~~ ^
/usr/local/Cellar/glib/2.58.1/include/glib-2.0/glib/gtestutils.h:209:1:
note: 'g_test_skip' declared here
GLIB_AVAILABLE_IN_2_38
^
/usr/local/Cellar/glib/2.58.1/include/glib-2.0/glib/gversionmacros.h:394:49=
:
note: expanded from macro 'GLIB_AVAILABLE_IN_2_38'
# define GLIB_AVAILABLE_IN_2_38                 _GLIB_EXTERN
                                                ^
/usr/local/Cellar/glib/2.58.1/include/glib-2.0/glib/gmacros.h:456:22:
note: expanded from macro '_GLIB_EXTERN'
#define _GLIB_EXTERN extern
                     ^
1 error generated.


I also get this splat trying to do 'make check-tcg':

make: Entering directory
'/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
  BUILD   debian9
The command '/bin/sh -c DEBIAN_FRONTEND=3Dnoninteractive eatmydata
apt install -y --no-install-recommends         bison
build-essential         ca-certificates         clang         flex
    gettext         git         libtest-harness-perl
pkg-config         psmisc         python         texinfo
$(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\
-f2)' returned a non-zero code: 100
Traceback (most recent call last):
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 563, in <module>
    sys.exit(main())
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 560, in main
    return args.cmdobj.run(args, argv)
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 376, in run
    extra_files_cksum=3Dcksum)
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 254, in build_image
    quiet=3Dquiet)
  File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
line 181, in _do_check
    return subprocess.check_call(self._command + cmd, **kwargs)
  File "/usr/lib/python2.7/subprocess.py", line 541, in check_call
    raise CalledProcessError(retcode, cmd)
subprocess.CalledProcessError: Command '['docker', 'build', '-t',
'qemu:debian9', '-f', '/tmp/docker_buildsvtS6R/tmp74LVkj.docker',
'/tmp/docker_buildsvtS6R']' returned non-zero exit status 100
/home/petmay01/linaro/qemu-for-merges/tests/docker/Makefile.include:53:
recipe for target 'docker-image-debian9' failed
make: *** [docker-image-debian9] Error 1


thanks
-- PMM
