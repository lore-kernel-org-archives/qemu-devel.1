Received: from eggs.gnu.org ([2001:4830:134:3::10]:55950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCnxm-0002Ok-PG
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:37:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eCnxj-0000nP-Lg
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:37:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eCnxj-0000n2-DD
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:37:47 -0500
Date: Thu, 9 Nov 2017 22:37:41 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171109143604.GB29835@lemon>
References: <151023266893.360.2441014157612423993@bafd83ae6430>
	<7e42c571-7e7e-052c-cf6b-2ddd23b56cd4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e42c571-7e7e-052c-cf6b-2ddd23b56cd4@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V4] hw/pcie-pci-bridge: restrict to X86 and
 ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, patchew-devel@freelists.org

On Thu, 11/09 16:08, Marcel Apfelbaum wrote:
> > make[1]: *** No rule to make target `../hw/pci-bridge/pcie_pci_bridge.o', needed by `qemu-system-aarch64'.  Stop.
> > make[1]: *** Waiting for unfinished jobs..../tmp/qemu-test/src/target/arm/translate-a64.c: In function 'handle_shri_with_rndacc':
> > /tmp/qemu-test/src/target/arm/translate-a64.c:6390: warning: 'tcg_src_hi' may be used uninitialized in this function
> > /tmp/qemu-test/src/target/arm/translate-a64.c: In function 'disas_simd_scalar_two_reg_misc':
> > /tmp/qemu-test/src/target/arm/translate-a64.c:8117: warning: 'rmode' may be used uninitialized in this function
> > 
> > make: *** [subdir-aarch64-softmmu] Error 2
> > Traceback (most recent call last):
> >    File "./tests/docker/docker.py", line 385, in <module>
> >      sys.exit(main())
> >    File "./tests/docker/docker.py", line 382, in main
> >      return args.cmdobj.run(args, argv)
> >    File "./tests/docker/docker.py", line 239, in run
> >      return Docker().run(argv, args.keep, quiet=args.quiet)
> >    File "./tests/docker/docker.py", line 207, in run
> >      quiet=quiet)
> >    File "./tests/docker/docker.py", line 125, in _do_check
> >      return subprocess.check_call(self._command + cmd, **kwargs)
> >    File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
> >      raise CalledProcessError(retcode, cmd)
> > subprocess.CalledProcessError: Command '['docker', 'run', '--label', 'com.qemu.instance.uuid=561e8180c54e11e79bd052540069c830', '-u', '0', '--security-opt', 'seccomp=unconfined', '--rm', '--net=none', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=8', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-gp94i687/src/docker-src.2017-11-09-08.03.01.2879:/var/tmp/qemu:z,ro', 'qemu:centos6', '/var/tmp/qemu/run', 'test-quick']' returned non-zero exit status 2
> > make[1]: *** [tests/docker/Makefile.include:129: docker-run] Error 1
> > make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-gp94i687/src'
> > make: *** [tests/docker/Makefile.include:163: docker-run-test-quick@centos6] Error 2
> > 
> > real	1m28.235s
> > user	0m4.283s
> > sys	0m4.399s
> > === OUTPUT END ===
> > 
> > Test command exited with code: 2
> > 
> > 
> > ---
> > Email generated automatically by Patchew [http://patchew.org/].
> > Please send your feedback to patchew-devel@freelists.org
> > 
> 
> Hi Fam,
> 
> I can compile just fine in my workstation, can you
> please advice ?

I can see the same error with

    make docker-run-test-quick@centos6 V=1 J=8

and also a normal out-of-tree build with

    $QEMU_SRC/configure --enable-debug --target-list=x86_64-softmmu,aarch64-softmmu

Can you install docker and try it?

Fam
