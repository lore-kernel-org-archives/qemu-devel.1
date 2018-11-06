Received: from eggs.gnu.org ([2001:4830:134:3::10]:57812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gJyAK-0007d3-4v
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:00:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1gJyAG-00082V-NN
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 05:00:56 -0500
Date: Tue, 6 Nov 2018 18:00:24 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20181106100024.GB10330@lemon.usersys.redhat.com>
References: <20181016093703.10637-1-peter.maydell@linaro.org>
	<154149783586.4748.1822263784766763922@015909e0f939>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154149783586.4748.1822263784766763922@015909e0f939>
Subject: Re: [Qemu-devel] [PATCH 0/2] target/arm: fix some ATS* bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, patches@linaro.org

On Tue, 11/06 01:50, no-reply@patchew.org wrote:
> ERROR: unknown option --with-gtkabi=3.0

Patchew is testing old series branches of which are heavily lagging behind. This
configure option in the mingw docker testing is recently dropped, so it's a
false positive.

Fam


> Try '/tmp/qemu-test/src/configure --help' for more information
> # QEMU configure log Tue Nov  6 09:50:16 UTC 2018
> # Configured with: '/tmp/qemu-test/src/configure' '--enable-werror' '--target-list=x86_64-softmmu,aarch64-softmmu' '--prefix=/tmp/qemu-test/install' '--python=/usr/bin/python3' '--cross-prefix=x86_64-w64-mingw32-' '--enable-trace-backends=simple' '--enable-gnutls' '--enable-nettle' '--enable-curl' '--enable-vnc' '--enable-bzip2' '--enable-guest-agent' '--with-sdlabi=2.0' '--with-gtkabi=3.0'
> #
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 119 608 625 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> config-temp/qemu-conf.c:2:2: error: #error __linux__ not defined
>  #error __linux__ not defined
>   ^~~~~
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 119 608 627 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 119 608 677 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> config-temp/qemu-conf.c:2:2: error: #error __i386__ not defined
>  #error __i386__ not defined
>   ^~~~~
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 119 608 679 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 119 608 680 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> config-temp/qemu-conf.c:2:2: error: #error __ILP32__ not defined
>  #error __ILP32__ not defined
>   ^~~~~
> 
> funcs: do_compiler do_cc compile_object check_include main
> lines: 92 119 616 771 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> 
> funcs: do_compiler do_cc compile_prog main
> lines: 92 125 907 0
> x86_64-w64-mingw32-gcc -mthreads -D__USE_MINGW_ANSI_STDIO=1 -DWIN32_LEAN_AND_MEAN -DWINVER=0x501 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -o config-temp/qemu-conf.exe config-temp/qemu-conf.c -g -liberty
> /usr/lib/gcc/x86_64-w64-mingw32/7.3.0/../../../../x86_64-w64-mingw32/bin/ld: cannot find -liberty
> collect2: error: ld returned 1 exit status
> Failed to run 'configure'
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 563, in <module>
>     sys.exit(main())
>   File "./tests/docker/docker.py", line 560, in main
>     return args.cmdobj.run(args, argv)
>   File "./tests/docker/docker.py", line 306, in run
>     return Docker().run(argv, args.keep, quiet=args.quiet)
>   File "./tests/docker/docker.py", line 274, in run
>     quiet=quiet)
>   File "./tests/docker/docker.py", line 181, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['sudo', '-n', 'docker', 'run', '--label', 'com.qemu.instance.uuid=5bcf7f1ce1a911e88b3152540069c830', '-u', '1000', '--security-opt', 'seccomp=unconfined', '--rm', '--net=none', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=8', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/home/patchew/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-j_cwgv70/src/docker-src.2018-11-06-04.49.59.28947:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'test-mingw']' returned non-zero exit status 1
> make[1]: *** [tests/docker/Makefile.include:217: docker-run] Error 1
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-j_cwgv70/src'
> make: *** [tests/docker/Makefile.include:251: docker-run-test-mingw@fedora] Error 2
> 
> real	0m37.093s
> user	0m5.048s
> sys	0m3.799s
> === OUTPUT END ===
> 
> Test command exited with code: 2
> 
> 
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
