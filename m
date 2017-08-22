Received: from eggs.gnu.org ([2001:4830:134:3::10]:43944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dk2ZD-0003nV-85
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 02:21:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dk2Z9-0008VF-34
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 02:21:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dk2Z8-0008V0-Po
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 02:21:31 -0400
Date: Tue, 22 Aug 2017 14:21:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170822062123.GG30356@pxdev.xzpeter.org>
References: <1503301464-27886-1-git-send-email-peterx@redhat.com>
	<150337750658.30.7791724179303558490@205a2245145f>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <150337750658.30.7791724179303558490@205a2245145f>
Subject: Re: [Qemu-devel] [RFC 0/6] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, lvivier@redhat.com, quintela@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, pbonzini@redhat.com, dgilbert@redhat.com

On Mon, Aug 21, 2017 at 09:51:47PM -0700, no-reply@patchew.org wrote:

[...]

>   TEST    tests/qapi-schema/doc-duplicated-return.out
>   TEST    tests/qapi-schema/doc-duplicated-since.out
>   TEST    tests/qapi-schema/doc-empty-arg.out
>   TEST    tests/qapi-schema/doc-empty-section.out
>   TEST    tests/qapi-schema/doc-empty-symbol.out
>   TEST    tests/qapi-schema/doc-good.out
>   TEST    tests/qapi-schema/doc-interleaved-section.out
>   TEST    tests/qapi-schema/doc-invalid-end.out
>   TEST    tests/qapi-schema/doc-invalid-end2.out
>   TEST    tests/qapi-schema/doc-invalid-return.out
>   TEST    tests/qapi-schema/doc-invalid-section.out
> Files /tmp/qemu-test/src/tests/qapi-schema/doc-good.out and tests/qapi-schema/doc-good.test.out differ
> make: *** [check-tests/qapi-schema/doc-good.json] Error 1
> make: *** Waiting for unfinished jobs....
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
> subprocess.CalledProcessError: Command '['docker', 'run', '--label', 'com.qemu.instance.uuid=579f531486f511e7961952540069c830', '-u', '0', '-t', '--rm', '--net=none', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=8', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/var/tmp/patchew-tester-tmp-vbkqrhlc/src/docker-src.2017-08-22-00.49.51.7825:/var/tmp/qemu:z,ro', '-v', '/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', 'qemu:centos6', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2
> make[1]: *** [tests/docker/Makefile.include:139: docker-run] Error 1
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-vbkqrhlc/src'
> make: *** [tests/docker/Makefile.include:168: docker-run-test-quick@centos6] Error 2

This is because I forgot to touch-up tests/qapi-schema/test-qapi.py
for its visit_command() test.  Fixed up.

-- 
Peter Xu
