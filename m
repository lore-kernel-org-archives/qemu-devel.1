Received: from eggs.gnu.org ([2001:4830:134:3::10]:32929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXimc-0002mx-II
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:48:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dXimY-0002a6-Ah
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:48:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dXimY-0002Zg-0n
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 02:48:26 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <150040682777.87.414629183259475192@5d477a5b5989>
	(no-reply@patchew.org's message of "Tue, 18 Jul 2017 12:40:28 -0700
	(PDT)")
References: <150040682777.87.414629183259475192@5d477a5b5989>
Reply-To: quintela@redhat.com
Date: Wed, 19 Jul 2017 08:48:19 +0200
Message-ID: <87379skjm4.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PULL 00/16] Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: qemu-devel@nongnu.org, famz@redhat.com, lvivier@redhat.com, dgilbert@redhat.com, peterx@redhat.com

no-reply@patchew.org wrote:
> Hi,
>
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.

> cc: unrecognized option '-no-integrated-as'
> cc: unrecognized option '-no-integrated-as'

I hope this is not my fault
   GTESTER tests/test-vmstate

> Failed to load simple/primitive:b_1
> Failed to load simple/primitive:i64_2
> Failed to load simple/primitive:i32_1
> Failed to load simple/primitive:i32_1
> Failed to load test/with_tmp:a
> Failed to load test/tmp_child_parent:f
> Failed to load test/tmp_child:parent
> Failed to load test/with_tmp:tmp
> Failed to load test/tmp_child:diff
> Failed to load test/with_tmp:tmp
> Failed to load test/tmp_child:diff
> Failed to load test/with_tmp:tmp


Dave, any good clue?


> ERROR:/tmp/qemu-test/src/tests/test-qga.c:78:fixture_setup: assertion failed (fixture->fd != -1): (-1 != -1)
> GTester: last random seed: R02Sf37f37a8c5f8ed60d31dbaff962d3c9c
> make: *** [check-tests/test-qga] Error 1
> make: *** Waiting for unfinished jobs....
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Could not access KVM kernel module: No such file or directory
> failed to initialize KVM: No such file or directory
> Back to tcg accelerator.
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 382, in <module>
>     sys.exit(main())
>   File "./tests/docker/docker.py", line 379, in main
>     return args.cmdobj.run(args, argv)
>   File "./tests/docker/docker.py", line 237, in run
>     return Docker().run(argv, args.keep, quiet=args.quiet)
>   File "./tests/docker/docker.py", line 205, in run
>     quiet=quiet)
>   File "./tests/docker/docker.py", line 123, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['docker', 'run', '--label', 'com.qemu.instance.uuid=656d0ada6bee11e794aa525400c803e1', '-u', '0', '-t', '--rm', '--net=none', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=8', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/var/tmp/patchew-tester-tmp-uic4vhqy/src/docker-src.2017-07-18-15.22.06.26333:/var/tmp/qemu:z,ro', '-v', '/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', 'qemu:centos6', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2
> tests/docker/Makefile.include:124: recipe for target 'docker-run' failed
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-uic4vhqy/src'
> tests/docker/Makefile.include:156: recipe for target 'docker-run-test-quick@centos6' failed
> make: *** [docker-run-test-quick@centos6] Error 2

I am pretty sure that this should be a problem somewhere else, not this
patch, no?

Thanks, Juan.
