Received: from eggs.gnu.org ([2001:4830:134:3::10]:37457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEBMR-0005nc-BD
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:49:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEBMP-0005R7-Ek
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 04:48:59 -0500
References: <151056619347.390.15270351875314848925@bafd83ae6430>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <0241ad8e-dd22-a029-5918-62ed4c49cf47@redhat.com>
Date: Mon, 13 Nov 2017 10:48:43 +0100
MIME-Version: 1.0
In-Reply-To: <151056619347.390.15270351875314848925@bafd83ae6430>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scripts/make-release: No need to delete
 pixman/.git anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, famz@redhat.com
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org

On 13.11.2017 10:43, no-reply@patchew.org wrote:
> Hi,
> 
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
> 
> Subject: [Qemu-devel] [PATCH] scripts/make-release: No need to delete pixman/.git anymore
> Type: series
> Message-id: 1510564905-6185-1-git-send-email-thuth@redhat.com
[...]
> QEMU          -- "/tmp/qemu-test/build/x86_64-softmmu/qemu-system-x86_64" -nodefaults -machine accel=qtest
> QEMU_IMG      -- "/tmp/qemu-test/build/qemu-img" 
> QEMU_IO       -- "/tmp/qemu-test/build/qemu-io"  --cache writeback -f raw
> QEMU_NBD      -- "/tmp/qemu-test/build/qemu-nbd" 
> IMGFMT        -- raw
> IMGPROTO      -- file
> PLATFORM      -- Linux/x86_64 fe9889ba94a0 4.11.10-300.fc26.x86_64
> TEST_DIR      -- /tmp/qemu-test
> SOCKET_SCM_HELPER -- /tmp/qemu-test/build/tests/qemu-iotests/socket_scm_helper
> 
> 001        
> 002        
> 004        
> 005        
> 008        
> 009        
> 010        
> 011        
> 012        
> 017         [not run] not suitable for this image format: raw
> 018         [not run] not suitable for this image format: raw
> 019         [not run] not suitable for this image format: raw
> 020         [not run] not suitable for this image format: raw
> 021        
> 024         [not run] not suitable for this image format: raw
> 025        
> 027         [not run] not suitable for this image format: raw
> 028         [not run] not suitable for this image format: raw
> 029         [not run] not suitable for this image format: raw
> 031         [not run] not suitable for this image format: raw
> 032        
> 033        
> 034         [not run] not suitable for this image format: raw
> 035         [not run] not suitable for this image format: raw
> 036         [not run] not suitable for this image format: raw
> 037         [not run] not suitable for this image format: raw
> 038         [not run] not suitable for this image format: raw
> 039         [not run] not suitable for this image format: raw
> 042         [not run] not suitable for this image format: raw
> 045        
> 046         [not run] not suitable for this image format: raw
> 047         [not run] not suitable for this image format: raw
> 048        
> 050         [not run] not suitable for this image format: raw
> 052        
> 053         [not run] not suitable for this image format: raw
> 054         [not run] not suitable for this image format: raw
> 058         [not run] not suitable for this image format: raw
> 059         [not run] not suitable for this image format: raw
> 060         [not run] not suitable for this image format: raw
> 062         [not run] not suitable for this image format: raw
> 063        
> 064         [not run] not suitable for this image format: raw
> 065         [not run] not suitable for this image format: raw
> 066         [not run] not suitable for this image format: raw
> 067         [not run] not suitable for this image format: raw
> 068         [not run] not suitable for this image format: raw
> 069         [not run] not suitable for this image format: raw
> 070         [not run] not suitable for this image format: raw
> 071         [not run] not suitable for this image format: raw
> 072         [not run] not suitable for this image format: raw
> 073         [not run] not suitable for this image format: raw
> 074         [not run] not suitable for this image format: raw
> 075         [not run] not suitable for this image format: raw
> 077         - output mismatch (see 077.out.bad)
> --- /tmp/qemu-test/src/tests/qemu-iotests/077.out	2017-11-13 09:38:59.000000000 +0000
> +++ /tmp/qemu-test/build/tests/qemu-iotests/077.out.bad	2017-11-13 09:41:20.601278693 +0000
> @@ -56,9 +56,9 @@
>  wrote XXX/XXX bytes at offset XXX
>  XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  blkdebug: Resuming request 'B'
> +blkdebug: Resuming request 'A'
>  wrote XXX/XXX bytes at offset XXX
>  XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -blkdebug: Resuming request 'A'
>  wrote XXX/XXX bytes at offset XXX
>  XXX bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  wrote XXX/XXX bytes at offset XXX
> 078         [not run] not suitable for this image format: raw
> 081        
> 082         [not run] not suitable for this image format: raw
> 084         [not run] not suitable for this image format: raw
> 086        
> 087         [not run] not suitable for this image format: raw
> 088         [not run] not suitable for this image format: raw
> 089         [not run] not suitable for this image format: raw
> 090         [not run] not suitable for this image format: raw
> 092         [not run] not suitable for this image format: raw
> 094         [not run] not suitable for this image protocol: file
> 095         [not run] not suitable for this image format: raw
> 096         [not run] not suitable for this image format: raw
> 098         [not run] not suitable for this image format: raw
> 099         [not run] not suitable for this image format: raw
> 101        
> 102         [not run] not suitable for this image format: raw
> 103         [not run] not suitable for this image format: raw
> 105         [not run] not suitable for this image format: raw
> 106        
> 107         [not run] not suitable for this image format: raw
> 108         [not run] not suitable for this image format: raw
> 110         [not run] not suitable for this image format: raw
> 111         [not run] not suitable for this image format: raw
> 113         [not run] not suitable for this image format: raw
> 114         [not run] not suitable for this image format: raw
> 116         [not run] not suitable for this image format: raw
> 119         [not run] not suitable for this image protocol: file
> 120        
> 123         [not run] not suitable for this image protocol: file
> 127         [not run] not suitable for this image format: raw
> 128         [not run] root privileges required to run dmsetup
> 129         [not run] not suitable for this image format: raw
> 130         [not run] not suitable for this image format: raw
> 131         [not run] not suitable for this image format: raw
> 132        
> 133         [not run] not suitable for this image format: raw
> 134         [not run] not suitable for this image format: raw
> 138         [not run] not suitable for this image format: raw
> 139         [not run] not suitable for this image format: raw
> 140        
> 141         [not run] not suitable for this image format: raw
> 143        
> 144         [not run] not suitable for this image format: raw
> 145        
> 146         [not run] not suitable for this image format: raw
> 148        
> 150        
> 152        
> 153         [not run] not suitable for this image format: raw
> 154         [not run] not suitable for this image format: raw
> 156         [not run] not suitable for this image format: raw
> 158         [not run] not suitable for this image format: raw
> 159        
> 160        
> 162         [not run] ssh support required
> 163        
> 165         [not run] not suitable for this image format: raw
> 170        
> 171        
> 175        
> 177         [not run] not suitable for this image format: raw
> 179         [not run] not suitable for this image format: raw
> 182         [not run] not suitable for this image format: raw
> 184         [not run] not suitable for this image format: raw
> 188         [not run] not suitable for this image format: raw
> 190         [not run] not suitable for this image format: raw
> 192        
> 194        
> 195         [not run] not suitable for this image format: raw
> 197         [not run] Insufficent memory to run test
> Not run: 017 018 019 020 024 027 028 029 031 034 035 036 037 038 039 042 046 047 050 053 054 058 059 060 062 064 065 066 067 068 069 070 071 072 073 074 075 078 082 084 087 088 089 090 092 094 095 096 098 099 102 103 105 107 108 110 111 113 114 116 119 123 127 128 129 130 131 133 134 138 139 141 144 146 153 154 156 158 162 165 177 179 182 184 188 190 195 197
> Failures: 077
> Failed 1 of 38 tests
> Test failed: iotests raw
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 385, in <module>
>     sys.exit(main())
>   File "./tests/docker/docker.py", line 382, in main
>     return args.cmdobj.run(args, argv)
>   File "./tests/docker/docker.py", line 239, in run
>     return Docker().run(argv, args.keep, quiet=args.quiet)
>   File "./tests/docker/docker.py", line 207, in run
>     quiet=quiet)
>   File "./tests/docker/docker.py", line 125, in _do_check
>     return subprocess.check_call(self._command + cmd, **kwargs)
>   File "/usr/lib64/python2.7/subprocess.py", line 186, in check_call
>     raise CalledProcessError(retcode, cmd)
> subprocess.CalledProcessError: Command '['docker', 'run', '--label', 'com.qemu.instance.uuid=7dfed654c85611e7bbf852540069c830', '-u', '0', '--security-opt', 'seccomp=unconfined', '--rm', '--net=none', '-e', 'TARGET_LIST=', '-e', 'EXTRA_CONFIGURE_OPTS=', '-e', 'V=', '-e', 'J=8', '-e', 'DEBUG=', '-e', 'SHOW_ENV=1', '-e', 'CCACHE_DIR=/var/tmp/ccache', '-v', '/root/.cache/qemu-docker-ccache:/var/tmp/ccache:z', '-v', '/var/tmp/patchew-tester-tmp-_mdptim7/src/docker-src.2017-11-13-04.38.56.12495:/var/tmp/qemu:z,ro', 'qemu:fedora', '/var/tmp/qemu/run', 'test-block']' returned non-zero exit status 1
> make[1]: *** [tests/docker/Makefile.include:129: docker-run] Error 1
> make[1]: Leaving directory '/var/tmp/patchew-tester-tmp-_mdptim7/src'
> make: *** [tests/docker/Makefile.include:163: docker-run-test-block@fedora] Error 2
> 
> real	4m15.336s
> user	0m4.489s
> sys	0m4.537s
> === OUTPUT END ===
> 
> Test command exited with code: 2

That's certainly *not* caused by my patch. Is this already a known
problem? Otherwise, Fam, could you please have a look at this?

 Thomas
