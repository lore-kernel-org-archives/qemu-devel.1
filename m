Received: from eggs.gnu.org ([2001:4830:134:3::10]:47929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXjoE-00021Z-L7
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:54:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXjoA-00052o-Kx
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:54:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55236)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dXjoA-00050u-B1
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:54:10 -0400
Date: Wed, 19 Jul 2017 09:54:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170719095402.1b6f4559@gondolin>
In-Reply-To: <150040553571.87.18375020437747123393@5d477a5b5989>
References: <20170718142455.32676-1-cohuck@redhat.com>
	<150040553571.87.18375020437747123393@5d477a5b5989>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 0/9] s390x: zPCI detangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: no-reply@patchew.org
Cc: qemu-devel@nongnu.org, famz@redhat.com, thuth@redhat.com, zyimin@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, borntraeger@de.ibm.com

On Tue, 18 Jul 2017 12:18:56 -0700 (PDT)
no-reply@patchew.org wrote:

> Hi,
> 
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
> 
> Subject: [Qemu-devel] [PATCH RFC v2 0/9] s390x: zPCI detangling
> Message-id: 20170718142455.32676-1-cohuck@redhat.com
> Type: series

(...)

> **
> ERROR:/tmp/qemu-test/src/tests/test-qga.c:78:fixture_setup: assertion failed (fixture->fd != -1): (-1 != -1)
> GTester: last random seed: R02S145bd3c9638ff255618113bf40a4288a
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
> subprocess.CalledProcessError: Command '['docker', 'run', '--label', 'com.qemu.instance.uuid=79b610ca6beb11e79abf525400c803e1', '-u', '0', '-t', '--rm', '--net=none', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=8', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/var/tmp/patchew-tester-tmp-4gcxi1vj/src/docker-src.2017-07-18-15.01.12.14950:/var/tmp/qemu:z,ro', '-v', '/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', 'qemu:centos6', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2
> tests/docker/Makefile.include:124: recipe for target 'docker-run' failed
> make[1]: *** [docker-run] Error 1
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-4gcxi1vj/src'
> tests/docker/Makefile.include:156: recipe for target 'docker-run-test-quick@centos6' failed
> make: *** [docker-run-test-quick@centos6] Error 2
> === OUTPUT END ===
> 
> Test command exited with code: 2

This looks like an unrelated failure which seems to have happened for
various serieses that had been posted.
