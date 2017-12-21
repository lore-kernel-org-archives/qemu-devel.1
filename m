Received: from eggs.gnu.org ([2001:4830:134:3::10]:48219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eS7Rl-0001GJ-RG
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:28:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eS7Rh-0001Ux-28
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:28:05 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:65084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eS7Rg-0001UB-PR
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 15:28:01 -0500
References: <151388621863.99.14752373861605263949@5adcb62bf0d6>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f6153d1a-d163-a4e1-8e6c-30d3735ac5a7@vivier.eu>
Date: Thu, 21 Dec 2017 21:27:54 +0100
MIME-Version: 1.0
In-Reply-To: <151388621863.99.14752373861605263949@5adcb62bf0d6>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 0/5] M68k for 2.12 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com

Le 21/12/2017 à 20:57, no-reply@patchew.org a écrit :
> Hi,
> 
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.
> 
> Type: series
> Message-id: 20171221193640.27418-1-laurent@vivier.eu
> Subject: [Qemu-devel] [PULL 0/5] M68k for 2.12 patches
> 
...
> Configure options:
> --enable-werror --target-list=x86_64-softmmu,aarch64-softmmu --prefix=/tmp/qemu-test/install --cross-prefix=x86_64-w64-mingw32- --enable-trace-backends=simple --enable-debug --enable-gnutls --enable-nettle --enable-curl --enable-vnc --enable-bzip2 --enable-guest-agent --with-sdlabi=1.2 --with-gtkabi=2.0
...
> /tmp/qemu-test/src/hw/i386/vmport.c: In function 'vmport_ioport_read':
> /tmp/qemu-test/src/hw/i386/vmport.c:81:9: error: implicit declaration of function 'qemu_log_mask' [-Werror=implicit-function-declaration]
>          qemu_log_mask(LOG_UNIMP, "vmport: unknown command %x\n", command);
>          ^~~~~~~~~~~~~
> /tmp/qemu-test/src/hw/i386/vmport.c:81:9: error: nested extern declaration of 'qemu_log_mask' [-Werror=nested-externs]
> /tmp/qemu-test/src/hw/i386/vmport.c:81:23: error: 'LOG_UNIMP' undeclared (first use in this function)
>          qemu_log_mask(LOG_UNIMP, "vmport: unknown command %x\n", command);
>                        ^~~~~~~~~
> /tmp/qemu-test/src/hw/i386/vmport.c:81:23: note: each undeclared identifier is reported only once for each function it appears in
> cc1: all warnings being treated as errors
> make[1]: *** [hw/i386/vmport.o] Error 1
> make[1]: *** Waiting for unfinished jobs....

Looks like a patch from Paolo's pull is breaking the build:

commit 7299e1a411de99761a4260e44b4f1cf2e4e126ef
Author: Philippe Mathieu-Daudé <f4bug@amsat.org>
Date:   Fri Dec 15 00:43:55 2017 -0300

    hw/i386/vmport: replace fprintf() by trace events or LOG_UNIMP

    Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
    Message-Id: <20171215034356.4449-2-f4bug@amsat.org>
    [Replace unknown command tracepoint with LOG_UNIMP, add
     generic tracepoint for vmport commands. - Paolo]
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks,
Laurent
