Received: from eggs.gnu.org ([2001:4830:134:3::10]:45549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eqEMR-00032v-L4
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:42:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eqEMO-000173-He
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:42:15 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:47069)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eqEMO-00016f-81
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 03:42:12 -0500
References: <151958242968.1084.2218238388995207361@bdbb90650ae5>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a24e7696-e3ac-3047-4838-093eb7feb5d3@vivier.eu>
Date: Mon, 26 Feb 2018 09:41:58 +0100
MIME-Version: 1.0
In-Reply-To: <151958242968.1084.2218238388995207361@bdbb90650ae5>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 0/4] Linux user for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: famz@redhat.com
Cc: qemu-devel@nongnu.org, riku.voipio@iki.fi

Le 25/02/2018 à 19:13, no-reply@patchew.org a écrit :
> Hi,
> 
> This series failed build test on s390x host. Please find the details below.
> 
> Type: series
> Message-id: 20180225175928.13101-1-laurent@vivier.eu
> Subject: [Qemu-devel] [PULL 0/4] Linux user for 2.12 patches
> 
...
> === TEST BEGIN ===
> Using CC: /home/fam/bin/cc
> Install prefix    /var/tmp/patchew-tester-tmp-193tvn22/src/install
> BIOS directory    /var/tmp/patchew-tester-tmp-193tvn22/src/install/share/qemu
> firmware path     /var/tmp/patchew-tester-tmp-193tvn22/src/install/share/qemu-firmware
> binary directory  /var/tmp/patchew-tester-tmp-193tvn22/src/install/bin
> library directory /var/tmp/patchew-tester-tmp-193tvn22/src/install/lib
> module directory  /var/tmp/patchew-tester-tmp-193tvn22/src/install/lib/qemu
> libexec directory /var/tmp/patchew-tester-tmp-193tvn22/src/install/libexec
> include directory /var/tmp/patchew-tester-tmp-193tvn22/src/install/include
> config directory  /var/tmp/patchew-tester-tmp-193tvn22/src/install/etc
> local state directory   /var/tmp/patchew-tester-tmp-193tvn22/src/install/var
> Manual directory  /var/tmp/patchew-tester-tmp-193tvn22/src/install/share/man
> ELF interp prefix /usr/gnemul/qemu-%M
> Source path       /var/tmp/patchew-tester-tmp-193tvn22/src
> GIT binary        git
> GIT submodules    ui/keycodemapdb capstone
> C compiler        /home/fam/bin/cc
> Host C compiler   cc
> C++ compiler      c++
> Objective-C compiler /home/fam/bin/cc
> ARFLAGS           rv
> CFLAGS            -O2 -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=2 -g 
> QEMU_CFLAGS       -I/usr/include/pixman-1   -Werror -DHAS_LIBSSH2_SFTP_FSYNC -pthread -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include  -DNCURSES_WIDECHAR -D_GNU_SOURCE -D_DEFAULT_SOURCE  -m64 -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -Wstrict-prototypes -Wredundant-decls -Wall -Wundef -Wwrite-strings -Wmissing-prototypes -fno-strict-aliasing -fno-common -fwrapv  -Wexpansion-to-defined -Wendif-labels -Wno-shift-negative-value -Wno-missing-include-dirs -Wempty-body -Wnested-externs -Wformat-security -Wformat-y2k -Winit-self -Wignored-qualifiers -Wold-style-declaration -Wold-style-definition -Wtype-limits -fstack-protector-strong -I/usr/include/p11-kit-1     -I/usr/include/libpng16  -I/usr/include/libdrm   -I$(SRC_PATH)/capstone/include
> LDFLAGS           -Wl,--warn-common -m64 -g 
> make              make
> install           install
> python            python -B
> smbd              /usr/sbin/smbd
> module support    no
> host CPU          s390x
...
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:193: qemu-system-mips64] Error 1
> make: *** [Makefile:404: subdir-mips64-softmmu] Error 2
> make: *** Waiting for unfinished jobs....
...
> make[1]: *** [/var/tmp/patchew-tester-tmp-193tvn22/src/rules.mak:66: hw/arm/aspeed.o] Error 1
> make[1]: *** Waiting for unfinished jobs....
> make: *** [Makefile:404: subdir-aarch64-softmmu] Error 2
> === OUTPUT END ===
> 
> Test command exited with code: 2
> 

It looks like a problem with s390x host.

Thanks,
Laurent
