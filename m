Received: from eggs.gnu.org ([2001:4830:134:3::10]:59701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3BWX-0004Ae-JV
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 22:18:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1f3BWT-0006gQ-6W
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 22:18:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45922 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1f3BWS-0006fc-V2
	for qemu-devel@nongnu.org; Mon, 02 Apr 2018 22:18:09 -0400
Date: Tue, 3 Apr 2018 10:18:00 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180403021800.GB6839@lemon.usersys.redhat.com>
References: <152248010946.861.11797909277921857391@71c20359a636>
	<a017f198-a05e-8a60-ca87-fcb6e88b28a6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a017f198-a05e-8a60-ca87-fcb6e88b28a6@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/2] Ide patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On Mon, 04/02 12:34, John Snow wrote:
> 
> 
> On 03/31/2018 03:08 AM, no-reply@patchew.org wrote:
> > Hi,
> > 
> > This series failed docker-build@min-glib build test. Please find the testing commands and
> > their output below. If you have Docker installed, you can probably reproduce it
> > locally.
> > 
> > Type: series
> > Message-id: 20180327045646.21112-1-jsnow@redhat.com
> > Subject: [Qemu-devel] [PULL 0/2] Ide patches
> > 
> > === TEST SCRIPT BEGIN ===
> > #!/bin/bash
> > set -e
> > git submodule update --init dtc
> > # Let docker tests dump environment info
> > export SHOW_ENV=1
> > export J=8
> > time make docker-test-build@min-glib
> > === TEST SCRIPT END ===
> > 
> > Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> > Switched to a new branch 'test'
> > 49a0f26939 Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20180328' into staging
> > a60769352d tcg: Mark muluh_i64 and mulsh_i64 as 64-bit ops
> > 
> > === OUTPUT BEGIN ===
> > Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
> > Cloning into '/var/tmp/patchew-tester-tmp-vi1_8690/src/dtc'...
> > Submodule path 'dtc': checked out 'e54388015af1fb4bf04d0bca99caba1074d9cc42'
> >   BUILD   min-glib
> > make[1]: Entering directory '/var/tmp/patchew-tester-tmp-vi1_8690/src'
> >   GEN     /var/tmp/patchew-tester-tmp-vi1_8690/src/docker-src.2018-03-31-03.07.40.30023/qemu.tar
> > Cloning into '/var/tmp/patchew-tester-tmp-vi1_8690/src/docker-src.2018-03-31-03.07.40.30023/qemu.tar.vroot'...
> > done.
> > Your branch is up-to-date with 'origin/test'.
> > Submodule 'dtc' (git://git.qemu-project.org/dtc.git) registered for path 'dtc'
> > Cloning into '/var/tmp/patchew-tester-tmp-vi1_8690/src/docker-src.2018-03-31-03.07.40.30023/qemu.tar.vroot/dtc'...
> > Submodule path 'dtc': checked out 'e54388015af1fb4bf04d0bca99caba1074d9cc42'
> > Submodule 'ui/keycodemapdb' (git://git.qemu.org/keycodemapdb.git) registered for path 'ui/keycodemapdb'
> > Cloning into '/var/tmp/patchew-tester-tmp-vi1_8690/src/docker-src.2018-03-31-03.07.40.30023/qemu.tar.vroot/ui/keycodemapdb'...
> > Submodule path 'ui/keycodemapdb': checked out '6b3d716e2b6472eb7189d3220552280ef3d832ce'
> > tar: /var/tmp/patchew-tester-tmp-vi1_8690/src/docker-src.2018-03-31-03.07.40.30023/qemu.tar: Wrote only 2048 of 10240 bytes
> > tar: Error is not recoverable: exiting now
> > failed to create tar file
> >   COPY    RUNNER
> >     RUN test-build in qemu:min-glib 
> > tar: Unexpected EOF in archive
> > tar: Unexpected EOF in archive
> > tar: Error is not recoverable: exiting now
> > /var/tmp/qemu/run: line 32: prep_fail: command not found
> > Environment variables:
> > HOSTNAME=d3de5b81f6a8
> > MAKEFLAGS= -j8
> > J=8
> > CCACHE_DIR=/var/tmp/ccache
> > EXTRA_CONFIGURE_OPTS=
> > V=
> > SHOW_ENV=1
> > PATH=/usr/lib/ccache:/usr/lib64/ccache:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
> > PWD=/
> > TARGET_LIST=
> > SHLVL=1
> > HOME=/root
> > TEST_DIR=/tmp/qemu-test
> > FEATURES= dtc
> > DEBUG=
> > _=/usr/bin/env
> > 
> > Configure options:
> > --enable-werror --target-list=x86_64-softmmu,aarch64-softmmu --prefix=/tmp/qemu-test/install
> > 
> > ERROR: DTC (libfdt) version >= 1.4.2 not present.
> >        Please install the DTC (libfdt) devel package
> > 
> 
> Environment problems?
> 
> > Traceback (most recent call last):
> >   File "./tests/docker/docker.py", line 407, in <module>
> >     sys.exit(main())
> >   File "./tests/docker/docker.py", line 404, in main
> >     return args.cmdobj.run(args, argv)
> >   File "./tests/docker/docker.py", line 261, in run
> >     return Docker().run(argv, args.keep, quiet=args.quiet)
> >   File "./tests/docker/docker.py", line 229, in run
> >     quiet=quiet)
> >   File "./tests/docker/docker.py", line 147, in _do_check
> >     return subprocess.check_call(self._command + cmd, **kwargs)
> >   File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
> >     raise CalledProcessError(retcode, cmd)
> > subprocess.CalledProcessError: Command '['docker', 'run', '--label', 'com.qemu.instance.uuid=3f76e41234b211e8813a52540069c830', '-u', '0', '--security-opt', 'seccomp=unconfined', '--rm', '--net=none', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=8', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-vi1_8690/src/docker-src.2018-03-31-03.07.40.30023:/var/tmp/qemu:z,ro', 'qemu:min-glib', '/var/tmp/qemu/run', 'test-build']' returned non-zero exit status 1
> > make[1]: *** [tests/docker/Makefile.include:129: docker-run] Error 1
> > make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-vi1_8690/src'
> > make: *** [tests/docker/Makefile.include:163: docker-run-test-build@min-glib] Error 2
> > 
> > real	0m51.988s
> > user	0m9.352s
> > sys	0m6.949s
> > === OUTPUT END ===
> > 
> > Test command exited with code: 2
> > 
> > 
> > ---
> > Email generated automatically by Patchew [http://patchew.org/].
> > Please send your feedback to patchew-devel@redhat.com
> > 
> 
> Unrelated to the patch as far as I can tell.

Yes, -ENOSPC on the machine. The tester is having hard time cleaning up some
hanging docker instances. I should resume working on the switching to VM based
tests.

Fam
