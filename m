Received: from eggs.gnu.org ([2001:4830:134:3::10]:40984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dbEGj-0000Oe-Pu
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dbEGi-00076E-Dm
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:02:05 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36226)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1dbEGi-00075j-5p
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 19:02:04 -0400
Received: by mail-wm0-x234.google.com with SMTP id t201so136522989wmt.1
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 16:02:03 -0700 (PDT)
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <150128145346.27.14634021385878041710@93e45bedd699>
References: <cover.1501280035.git.alistair.francis@xilinx.com>
	<150128145346.27.14634021385878041710@93e45bedd699>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Fri, 28 Jul 2017 16:01:32 -0700
Message-ID: <CAKmqyKMi4M2XMnd0rYqtbe4=OunjvrVBCRMCh=JK=2TdhpBrRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/5] More warning reporting fixed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>

On Fri, Jul 28, 2017 at 3:37 PM,  <no-reply@patchew.org> wrote:
> Hi,
>
> This series failed automatic build test. Please find the testing commands=
 and
> their output below. If you have docker installed, you can probably reprod=
uce it
> locally.
>
> Subject: [Qemu-devel] [PATCH v2 0/5]  More warning reporting fixed
> Message-id: cover.1501280035.git.alistair.francis@xilinx.com
> Type: series
>

...

>   CC      stubs/machine-init-done.o
>   CC      stubs/migr-blocker.o
>   CC      stubs/monitor.o
>   CC      stubs/notify-event.o
>   CC      stubs/qtest.o
>   CC      stubs/replay.o
>   CC      stubs/runstate-check.o
>   CC      stubs/set-fd-handler.o
> /tmp/qemu-test/src/trace/simple.c: In function 'st_init':
> /tmp/qemu-test/src/trace/simple.c:408:9: error: implicit declaration of f=
unction 'warn_report' [-Werror=3Dimplicit-function-declaration]
>          warn_report("unable to initialize simple trace backend");
>          ^~~~~~~~~~~
> /tmp/qemu-test/src/trace/simple.c:408:9: error: nested extern declaration=
 of 'warn_report' [-Werror=3Dnested-externs]

Good catch, I'll fix this in the next version.

Thanks,
Alistair

> cc1: all warnings being treated as errors
> /tmp/qemu-test/src/rules.mak:66: recipe for target 'trace/simple.o' faile=
d
> make: *** [trace/simple.o] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 382, in <module>
>     sys.exit(main())
>   File "./tests/docker/docker.py", line 379, in main
>     return args.cmdobj.run(args, argv)
>   File "./tests/docker/docker.py", line 237, in run
>     return Docker().run(argv, args.keep, quiet=3Dargs.quiet)
>   File "./tests/docker/docker.py", line 205, in run
>     quiet=3Dquiet)
>   File "./tests/docker/docker.py", line 123, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['docker', 'run', '--label', 'com=
.qemu.instance.uuid=3D3884d72473e511e7970e52540069c830', '-u', '0', '-t', '=
--rm', '--net=3Dnone', '-e', 'TARGET_LIST=3D', '-e', 'EXTRA_CONFIGURE_OPTS=
=3D', '-e', 'V=3D', '-e', 'J=3D8', '-e', 'DEBUG=3D', '-e', 'SHOW_ENV=3D1', =
'-e', 'CCACHE_DIR=3D/var/tmp/ccache', '-v', '/var/tmp/patchew-tester-tmp-wa=
i3q1k5/src/docker-src.2017-07-28-18.36.35.7058:/var/tmp/qemu:z,ro', '-v', '=
/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', 'qemu:fedora', '/var/tm=
p/qemu/run', 'test-mingw']' returned non-zero exit status 2
> make[1]: *** [tests/docker/Makefile.include:139: docker-run] Error 1
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-wai3q1k5/src'
> make: *** [tests/docker/Makefile.include:168: docker-run-test-mingw@fedor=
a] Error 2
>
> real    0m57.793s
> user    0m4.996s
> sys     0m1.037s
> =3D=3D=3D OUTPUT END =3D=3D=3D
>
> Test command exited with code: 2
>
>
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@freelists.org
