Received: from eggs.gnu.org ([209.51.188.92]:35140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ghbJ2-0001tL-Gr
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:27:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ghbJ0-0004jR-NO
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:27:36 -0500
Received: from mail-yw1-f47.google.com ([209.85.161.47]:44519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ghbJ0-0004ce-FH
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:27:34 -0500
Received: by mail-yw1-f47.google.com with SMTP id b63so4430085ywc.11
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 06:27:25 -0800 (PST)
MIME-Version: 1.0
References: <20190109220942.23822-1-pbonzini@redhat.com>
	<CAFEAcA9v3v3k_cFZCwvD5WD4FmiuFT=0UAjCBHEwpO+LuQWjAw@mail.gmail.com>
In-Reply-To: <CAFEAcA9v3v3k_cFZCwvD5WD4FmiuFT=0UAjCBHEwpO+LuQWjAw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 10 Jan 2019 15:27:12 +0100
Message-ID: <CAAdtpL5cuJdVgfgoo1oNfEpTZFkybLRn5MWqLna7osTUT=MCbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v6 00/35] Misc patches for 2018-12-18
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

Le jeu. 10 janv. 2019 15:21, Peter Maydell <peter.maydell@linaro.org> a
=C3=A9crit :

> On Wed, 9 Jan 2019 at 22:23, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit
> c102d9471f8f02d9fbea72ec4505d7089173f470:
> >
> >   Merge remote-tracking branch
> 'remotes/pmaydell/tags/pull-target-arm-20190107' into staging (2019-01-07
> 16:56:33 +0000)
> >
> > are available in the Git repository at:
> >
> >   git://github.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 5eddc84292736dc57db341f9724395a29d3614f7=
:
> >
> >   avoid TABs in files that only contain a few (2019-01-09 23:01:14 +010=
0)
> >
> > ----------------------------------------------------------------
> > * HAX support for Linux hosts (Alejandro)
> > * esp bugfixes (Guenter)
> > * Windows build cleanup (Marc-Andr=C3=A9)
> > * checkpatch logic improvements (Paolo)
> > * coalesced range bugfix (Paolo)
> > * switch testsuite to TAP (Paolo)
> > * QTAILQ rewrite (Paolo)
> > * block/iscsi.c cancellation fixes (Stefan)
> > * improve selection of the default accelerator (Thomas)
> >
> > ----------------------------------------------------------------
>
> This almost all works fine (there are some annoying intermittents
> which mean that most of my full test runs fail somewhere for some
> reason, but they aren't issues with this pullreq as far as I can
> see[*]), but...
>
> ...'make check-tcg' fails:
>
> e104462:xenial:all-linux-static$ make check-tcg
>   BUILD   debian9
> The command '/bin/sh -c DEBIAN_FRONTEND=3Dnoninteractive eatmydata
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
>     extra_files_cksum=3Dcksum)
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 254, in build_image
>     quiet=3Dquiet)
>   File "/home/petmay01/linaro/qemu-for-merges/tests/docker/docker.py",
> line 181, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib/python2.7/subprocess.py", line 541, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['docker', 'build', '-t',
> 'qemu:debian9', '-f', '/tmp/docker_build_cViZ6/tmpsvY3Oz.docker',
> '/tmp/docker_build_cViZ6']' returned non-zero exit status 100
> /home/petmay01/linaro/qemu-for-merges/tests/docker/Makefile.include:53:
> recipe for target 'docker-image-debian9' failed
> make: *** [docker-image-debian9] Error 1
>

This should work fine if you retry this PR after having merged Fam's PR
which contains the fix.


> This seems to happen reliably with this pullreq merged
> in, but master is OK.
>

I guess Travis is using a cached image.


> [*] intermittents I've seen recently (ie over the last
> month or two):
>  + failures in the rcu torture-test
>  + the netbsd VM sometimes fails to start and the "wait 300
>    seconds while trying to ssh into it" timeout expires;
>    this might be load-related but it is always netbsd that
>    fails like this, never the openbsd or freebsd VMs
>  + test-filter-mirror sometimes seems to hang
>  + the migration test hangs sometimes with TCG
>
> thanks
> -- PMM
>
>
