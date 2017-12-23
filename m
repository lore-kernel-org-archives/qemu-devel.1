Received: from eggs.gnu.org ([2001:4830:134:3::10]:44862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eSkuO-0001Od-Mj
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 09:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eSkuL-0006KK-B1
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 09:36:16 -0500
Received: from mail-pf0-x232.google.com ([2607:f8b0:400e:c00::232]:42908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eSkuL-0006JZ-55
	for qemu-devel@nongnu.org; Sat, 23 Dec 2017 09:36:13 -0500
Received: by mail-pf0-x232.google.com with SMTP id d23so16388650pfe.9
	for <qemu-devel@nongnu.org>; Sat, 23 Dec 2017 06:36:12 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
Reply-To: minyard@acm.org
References: <151389782710.99.6783851039862691089@5adcb62bf0d6>
From: Corey Minyard <minyard@acm.org>
Message-ID: <fa552f1c-d4ba-87a3-ded8-3fd67e6a4511@acm.org>
Date: Sat, 23 Dec 2017 08:36:07 -0600
MIME-Version: 1.0
In-Reply-To: <151389782710.99.6783851039862691089@5adcb62bf0d6>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH 0/8] Small IPMI (and other) fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, minyard@acm.org
Cc: famz@redhat.com

On 12/21/2017 05:10 PM, no-reply@patchew.org wrote:
> Hi,
>
> This series failed automatic build test. Please find the testing commands and
> their output below. If you have docker installed, you can probably reproduce it
> locally.

The error here doesn't seem to have anything to do with these patches:


>    CC      aarch64-softmmu/hw/virtio/virtio.o
>    CC      aarch64-softmmu/hw/virtio/virtio-balloon.o
> /tmp/qemu-test/src/hw/i386/vmport.c: In function 'vmport_ioport_read':
> /tmp/qemu-test/src/hw/i386/vmport.c:81:9: error: implicit declaration of function 'qemu_log_mask' [-Werror=implicit-function-declaration]
>           qemu_log_mask(LOG_UNIMP, "vmport: unknown command %x\n", command);
>           ^~~~~~~~~~~~~
> /tmp/qemu-test/src/hw/i386/vmport.c:81:9: error: nested extern declaration of 'qemu_log_mask' [-Werror=nested-externs]
> /tmp/qemu-test/src/hw/i386/vmport.c:81:23: error: 'LOG_UNIMP' undeclared (first use in this function)
>           qemu_log_mask(LOG_UNIMP, "vmport: unknown command %x\n", command);
>                         ^~~~~~~~~
> /tmp/qemu-test/src/hw/i386/vmport.c:81:23: note: each undeclared identifier is reported only once for each function it appears in
> cc1: all warnings being treated as errors
> make[1]: *** [hw/i386/vmport.o] Error 1
> make: *** [subdir-x86_64-softmmu] Error 2
> make: *** Waiting for unfinished jobs....
> /tmp/qemu-test/src/rules.mak:66: recipe for target 'hw/i386/vmport.o' failed
> Makefile:387: recipe for target 'subdir-x86_64-softmmu' failed

Am I missing something here?

-corey
