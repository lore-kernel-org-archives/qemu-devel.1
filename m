Received: from eggs.gnu.org ([209.51.188.92]:54566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gqhBD-0007Lq-4D
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gqhB6-0008CY-BX
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 11:33:07 -0500
References: <154929778819.29184.14263501563008780216@ebba9967afc0>
From: David Hildenbrand <david@redhat.com>
Message-ID: <351ec816-8414-2e24-050c-08043cc49cc6@redhat.com>
Date: Mon, 4 Feb 2019 17:32:50 +0100
MIME-Version: 1.0
In-Reply-To: <154929778819.29184.14263501563008780216@ebba9967afc0>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/tcg: Don't model FP registers as
 globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: fam@euphon.net, qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com, rth@twiddle.net

On 04.02.19 17:29, no-reply@patchew.org wrote:
> Patchew URL: https://patchew.org/QEMU/20190204154406.16122-1-david@redhat.com/
> 
> 
> 
> Hi,
> 
> This series failed the docker-mingw@fedora build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
> 
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> time make docker-test-mingw@fedora SHOW_ENV=1 J=14
> === TEST SCRIPT END ===
> 
> 
> Configure options:
> --enable-werror --target-list=x86_64-softmmu,aarch64-softmmu --prefix=/tmp/qemu-test/install --python=/usr/bin/python3 --cross-prefix=x86_64-w64-mingw32- --enable-trace-backends=simple --enable-gnutls --enable-nettle --enable-curl --enable-vnc --enable-bzip2 --enable-guest-agent --with-sdlabi=2.0
> ERROR: unknown option --with-sdlabi=2.0
> Try '/tmp/qemu-test/src/configure --help' for more information
> # QEMU configure log Mon Feb  4 16:29:29 UTC 2019
> # Configured with: '/tmp/qemu-test/src/configure' '--enable-werror' '--target-list=x86_64-softmmu,aarch64-softmmu' '--prefix=/tmp/qemu-test/install' '--python=/usr/bin/python3' '--cross-prefix=x86_64-w64-mingw32-' '--enable-trace-backends=simple' '--enable-gnutls' '--enable-nettle' '--enable-curl' '--enable-vnc' '--enable-bzip2' '--enable-guest-agent' '--with-sdlabi=2.0'
> ---
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 634 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 636 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 638 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 640 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 642 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 644 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 646 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 648 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 650 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 652 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 686 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 688 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 694 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 700 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 706 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 708 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 714 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 720 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> 
> funcs: do_compiler do_cc compile_object check_define main
> lines: 92 122 617 722 0
> x86_64-w64-mingw32-gcc -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv -std=gnu99 -c -o config-temp/qemu-conf.o config-temp/qemu-conf.c
> ccache: error: Failed to create temporary file for /var/tmp/ccache/tmp/qemu-conf.stdout: Permission denied
> Failed to run 'configure'
> Traceback (most recent call last):
>   File "./tests/docker/docker.py", line 563, in <module>
> 
> 
> The full log is available at
> http://patchew.org/logs/20190204154406.16122-1-david@redhat.com/testing.docker-mingw@fedora/?type=message.
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
> 

Looks like Patchew is experiencing technical problems :)

-- 

Thanks,

David / dhildenb
