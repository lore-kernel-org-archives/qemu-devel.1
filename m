Received: from eggs.gnu.org ([2001:4830:134:3::10]:43759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZv97-00046M-LX
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 05:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZv92-0006Pd-52
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 05:01:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZv91-0006N8-SO
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 05:01:32 -0500
References: <20181219151917.3874-1-pbonzini@redhat.com>
	<CAFEAcA_0jPh6TVOqzfp_O5eFitNocabR1GdLkwwZcv6QcW=iUQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4aabde25-52dd-10c1-1e50-582f22e4041c@redhat.com>
Date: Thu, 20 Dec 2018 11:01:24 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_0jPh6TVOqzfp_O5eFitNocabR1GdLkwwZcv6QcW=iUQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v2 00/35] Misc patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20/12/18 00:10, Peter Maydell wrote:
> I get a compile failure on my OSX system:
> 
>   CC      tests/test-crypto-pbkdf.o
> /Users/pm215/src/qemu-for-merges/tests/test-crypto-pbkdf.c:444:17:
> error: too few arguments to function call, single argument 'msg' was
> not specified
>     g_test_skip();
>     ~~~~~~~~~~~ ^
> /usr/local/Cellar/glib/2.58.1/include/glib-2.0/glib/gtestutils.h:209:1:
> note: 'g_test_skip' declared here
> GLIB_AVAILABLE_IN_2_38
> ^
> /usr/local/Cellar/glib/2.58.1/include/glib-2.0/glib/gversionmacros.h:394:49:
> note: expanded from macro 'GLIB_AVAILABLE_IN_2_38'
> # define GLIB_AVAILABLE_IN_2_38                 _GLIB_EXTERN
>                                                 ^
> /usr/local/Cellar/glib/2.58.1/include/glib-2.0/glib/gmacros.h:456:22:
> note: expanded from macro '_GLIB_EXTERN'
> #define _GLIB_EXTERN extern
>                      ^
> 1 error generated.

Sorry, I forgot to commit the fix.

> 
> I also get this splat trying to do 'make check-tcg':
> 
> make: Entering directory
> '/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
>   BUILD   debian9
> The command '/bin/sh -c DEBIAN_FRONTEND=noninteractive eatmydata
> apt install -y --no-install-recommends         bison
> build-essential         ca-certificates         clang         flex
>     gettext         git         libtest-harness-perl
> pkg-config         psmisc         python         texinfo
> $(apt-get -s build-dep qemu | egrep ^Inst | fgrep '[all]' | cut -d\
> -f2)' returned a non-zero code: 100
> Traceback (most recent call last):
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 563, in <module>
>     sys.exit(main())
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 560, in main
>     return args.cmdobj.run(args, argv)
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 376, in run
>     extra_files_cksum=cksum)
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 254, in build_image
>     quiet=quiet)
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 181, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib/python2.7/subprocess.py", line 541, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['docker', 'build', '-t',
> 'qemu:debian9', '-f', '/tmp/docker_buildsvtS6R/tmp74LVkj.docker',
> '/tmp/docker_buildsvtS6R']' returned non-zero exit status 100
> /home/petmay01/linaro/qemu-for-merges/tests/docker/Makefile.include:53:
> recipe for target 'docker-image-debian9' failed
> make: *** [docker-image-debian9] Error 1

I'll try it too.

Paolo
