Received: from eggs.gnu.org ([209.51.188.92]:52142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghuWg-0005Mw-Ga
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ghuWf-0006nX-Is
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:58:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36848)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ghuWf-0006nG-B1
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:58:57 -0500
References: <20190110205129.22851-1-pbonzini@redhat.com>
	<CAFEAcA8V+HNGS_8da2qHTAzj_Dxi8+s5xojq6dErRCpnC8ci_g@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <832b5ca4-c671-e6ce-b0dd-0c02f8d4ed7b@redhat.com>
Date: Fri, 11 Jan 2019 11:58:50 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8V+HNGS_8da2qHTAzj_Dxi8+s5xojq6dErRCpnC8ci_g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL v7 00/35] Misc patches for 2018-12-18
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

On 11/01/19 11:51, Peter Maydell wrote:
> make: Entering directory
> '/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
>   BUILD   debian9
> The command '/bin/sh -c DEBIAN_FRONTEND=noninteractive eatmydata
> apt install -y --no-install-recommends         bison
> build-essential         ca-certificates         clang         flex
>     gettext         git         perl         pkg-config         psmisc
>         python         texinfo         $(apt-get -s build-dep qemu |
> egrep ^Inst | fgrep '[all]' | cut -d\  -f2)' returned a non-zero code:
> 100
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
> 'qemu:debian9', '-f', '/tmp/docker_buildsLHwaa/tmpXGE1LW.docker',
> '/tmp/docker_buildsLHwaa']' returned non-zero exit status 100
> /home/petmay01/linaro/qemu-for-merges/tests/docker/Makefile.include:53:
> recipe for target 'docker-image-debian9' failed
> make: *** [docker-image-debian9] Error 1
> make: Leaving directory
> '/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'

Well, this time I absolutely cannot reproduce this...  can you try "make
docker-image-debian9 V=1"?

Paolo
