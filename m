Received: from eggs.gnu.org ([209.51.188.92]:50709)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghuPo-0002A8-Pr
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ghuPn-00041R-G8
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:51:52 -0500
Received: from mail-oi1-x22d.google.com ([2607:f8b0:4864:20::22d]:36802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ghuPn-000419-Af
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:51:51 -0500
Received: by mail-oi1-x22d.google.com with SMTP id x23so11860966oix.3
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 02:51:51 -0800 (PST)
MIME-Version: 1.0
References: <20190110205129.22851-1-pbonzini@redhat.com>
In-Reply-To: <20190110205129.22851-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Jan 2019 10:51:39 +0000
Message-ID: <CAFEAcA8V+HNGS_8da2qHTAzj_Dxi8+s5xojq6dErRCpnC8ci_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v7 00/35] Misc patches for 2018-12-18
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

On Thu, 10 Jan 2019 at 20:52, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 147923b1a901a0370f83a0f4c58ec1baffef22=
f0:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20190108-pull-req=
uest' into staging (2019-01-08 16:07:32 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 019a186d24f9f5763fc1f5731c9bc342293ec2fb:
>
>   avoid TABs in files that only contain a few (2019-01-10 15:41:31 +0100)
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
>
> v6->v7: fix Debian dockerfiles to use perl instead of libtest-harness-per=
l

make check-tcg still fails :-(

make: Entering directory
'/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'
  BUILD   debian9
The command '/bin/sh -c DEBIAN_FRONTEND=3Dnoninteractive eatmydata
apt install -y --no-install-recommends         bison
build-essential         ca-certificates         clang         flex
    gettext         git         perl         pkg-config         psmisc
        python         texinfo         $(apt-get -s build-dep qemu |
egrep ^Inst | fgrep '[all]' | cut -d\  -f2)' returned a non-zero code:
100
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
'qemu:debian9', '-f', '/tmp/docker_buildsLHwaa/tmpXGE1LW.docker',
'/tmp/docker_buildsLHwaa']' returned non-zero exit status 100
/home/petmay01/linaro/qemu-for-merges/tests/docker/Makefile.include:53:
recipe for target 'docker-image-debian9' failed
make: *** [docker-image-debian9] Error 1
make: Leaving directory
'/home/petmay01/linaro/qemu-for-merges/build/all-linux-static'

thanks
-- PMM
