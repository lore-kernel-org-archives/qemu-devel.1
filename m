Received: from eggs.gnu.org ([2001:4830:134:3::10]:57893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fWK79-00051k-Fc
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fWK78-0004Zu-G1
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 07:20:27 -0400
References: <152966617895.870.15476920444199969536@d39dc562802a>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <7180cb67-1f91-31fc-47dc-7434dcab4891@ilande.co.uk>
Date: Fri, 22 Jun 2018 12:19:59 +0100
MIME-Version: 1.0
In-Reply-To: <152966617895.870.15476920444199969536@d39dc562802a>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] ppc: minor Mac fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 22/06/18 12:16, no-reply@patchew.org wrote:

> Hi,
> 
> This series failed docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> Type: series
> Message-id: 20180622080009.5707-1-mark.cave-ayland@ilande.co.uk
> Subject: [Qemu-devel] [PATCH 0/2] ppc: minor Mac fixes

(lots cut)

>    CC      hw/acpi/core.o
>    CC      hw/acpi/piix4.o
>    CC      hw/acpi/pcihp.o
>    CC      hw/acpi/ich9.o
>    CC      hw/acpi/tco.o
>    CC      hw/acpi/cpu_hotplug.o
>    CC      hw/acpi/memory_hotplug.o
> /tmp/qemu-test/src/nbd/server.c: In function 'nbd_trip':
> /tmp/qemu-test/src/nbd/server.c:1980:19: error: 'end' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>       *length = end - offset;
>                 ~~~~^~~~~~~~
> /tmp/qemu-test/src/nbd/server.c:1940:30: note: 'end' was declared here
>       uint64_t begin = offset, end;
>                                ^~~
> cc1: all warnings being treated as errors
> make: *** [/tmp/qemu-test/src/rules.mak:69: nbd/server.o] Error 1
> make: *** Waiting for unfinished jobs....
> Traceback (most recent call last):
>    File "./tests/docker/docker.py", line 526, in <module>
>      sys.exit(main())
>    File "./tests/docker/docker.py", line 523, in main
>      return args.cmdobj.run(args, argv)
>    File "./tests/docker/docker.py", line 279, in run
>      return Docker().run(argv, args.keep, quiet=args.quiet)
>    File "./tests/docker/docker.py", line 247, in run
>      quiet=quiet)
>    File "./tests/docker/docker.py", line 154, in _do_check
>      return subprocess.check_call(self._command + cmd, **kwargs)
>    File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
>      raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['docker', 'run', '--label', 'com.qemu.instance.uuid=830b33d0760d11e888c352540069c830', '-u', '0', '--security-opt', 'seccomp=unconfined', '--rm', '--net=none', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=8', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-2s1zzq00/src/docker-src.2018-06-22-07.14.45.21922:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'test-mingw']' returned non-zero exit status 2
> make[1]: *** [tests/docker/Makefile.include:164: docker-run] Error 1
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-2s1zzq00/src'
> make: *** [tests/docker/Makefile.include:198: docker-run-test-mingw@fedora] Error 2
> 
> real	1m34.678s
> user	0m5.210s
> sys	0m3.979s

This is definitely not me - these 2 patches don't touch anything related 
to this.


ATB,

Mark.
