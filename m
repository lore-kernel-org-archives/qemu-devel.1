Received: from eggs.gnu.org ([2001:4830:134:3::10]:56381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euP3Z-0000ju-He
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1euP3W-0002NF-Fe
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:56:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1euP3W-0002Me-8I
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 15:55:58 -0500
Date: Fri, 9 Mar 2018 17:55:54 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180309205554.GO3417@localhost.localdomain>
References: <20180309202827.12085-1-ehabkost@redhat.com>
	<152062852115.1506.16828074696833187135@bdbb90650ae5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152062852115.1506.16828074696833187135@bdbb90650ae5>
Subject: Re: [Qemu-devel] [PATCH 0/8] tests: Run device-crash-test on "make
 check"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org, thuth@redhat.com, crosa@redhat.com

On Fri, Mar 09, 2018 at 12:48:42PM -0800, no-reply@patchew.org wrote:
[...]
> /tmp/qemu-test/src/scripts/device-crash-test -q -t machine=DEFAULT accel=tcg --  x86_64-softmmu/qemu-system-x86_64  aarch64-softmmu/qemu-system-aarch64
> /usr/bin/env: python2.7: No such file or directory
> make: *** [check-device-crash-quick] Error 127
> make: *** Waiting for unfinished jobs....
> make: *** wait: No child processes.  Stop.
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 407, in <module>
>     sys.exit(main())
>   File "./tests/docker/docker.py", line 404, in main
>     return args.cmdobj.run(args, argv)
>   File "./tests/docker/docker.py", line 261, in run
>     return Docker().run(argv, args.keep, quiet=args.quiet)
>   File "./tests/docker/docker.py", line 229, in run
>     quiet=quiet)
>   File "./tests/docker/docker.py", line 147, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['docker', 'run', '--label', 'com.qemu.instance.uuid=02a6de1c23db11e8935d52540069c830', '-u', '0', '--security-opt', 'seccomp=unconfined', '--rm', '--net=none', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=8', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-i0mjl1iv/src/docker-src.2018-03-09-15.46.46.18385:/var/tmp/qemu:z,ro', 'qemu:centos6', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2
> make[1]: *** [tests/docker/Makefile.include:129: docker-run] Error 1
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-i0mjl1iv/src'
> make: *** [tests/docker/Makefile.include:163: docker-run-test-quick@centos6] Error 2

Porting device-crash-test to Python 3 is on my plans, but I don't
think this should block us from running device-crash-test on
systems using Python 2.7.  I will look for a mechanism to skip
running device-crash-test if only Python 3 is available.

-- 
Eduardo
