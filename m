Received: from eggs.gnu.org ([209.51.188.92]:55462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shirley17fei@gmail.com>) id 1ggUHD-0001LI-KR
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shirley17fei@gmail.com>) id 1ggUHC-0003Sq-El
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:45:07 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:43175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <shirley17fei@gmail.com>)
	id 1ggUHC-0003OM-8q
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 07:45:06 -0500
Received: by mail-pf1-x443.google.com with SMTP id w73so98436pfk.10
	for <qemu-devel@nongnu.org>; Mon, 07 Jan 2019 04:45:05 -0800 (PST)
References: <154643680857.9907.2563926974140301260@02a1dbf831e2>
From: Fei Li <shirley17fei@gmail.com>
Message-ID: <d38d46fb-67f0-bf39-2e13-6305e5e115a1@gmail.com>
Date: Mon, 7 Jan 2019 20:44:01 +0800
MIME-Version: 1.0
In-Reply-To: <154643680857.9907.2563926974140301260@02a1dbf831e2>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v9 00/16] qemu_thread_create:
 propagate the error to callers to handle
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, fli@suse.com
Cc: fam@euphon.net, lifei1214@126.com

Hi all,

Sorry for the mistakenly deleted " include "qapi/error.h" " for
[PATCH for-4.0 v9 11/16] qemu_thread: supplement error handling for 
emulated_realize,
will add this #include back in next version.


Have a nice day, and again sorry for the trouble.
Fei


在 2019/1/2 下午9:46, no-reply@patchew.org 写道:
> Patchew URL: https://patchew.org/QEMU/20181225140449.15786-1-fli@suse.com/
>
>
>
> Hi,
>
> This series failed the docker-quick@centos7 build test. Please find the testing commands and
> their output below. If you have Docker installed, you can probably reproduce it
> locally.
>
> === TEST SCRIPT BEGIN ===
> #!/bin/bash
> time make docker-test-quick@centos7 SHOW_ENV=1 J=8
> === TEST SCRIPT END ===
>
> libpmem support   no
> libudev           no
>
> WARNING: Use of SDL 1.2 is deprecated and will be removed in
> WARNING: future releases. Please switch to using SDL 2.0
>
> NOTE: cross-compilers enabled:  'cc'
>    GEN     x86_64-softmmu/config-devices.mak.tmp
> ---
>    CC      hw/usb/host-stub.o
>    CC      hw/virtio/virtio-bus.o
> /tmp/qemu-test/src/hw/usb/ccid-card-emulated.c: In function 'init_event_notifier':
> /tmp/qemu-test/src/hw/usb/ccid-card-emulated.c:404:9: error: implicit declaration of function 'error_setg' [-Werror=implicit-function-declaration]
>           error_setg(errp, "ccid-card-emul: event notifier creation failed");
>           ^
> /tmp/qemu-test/src/hw/usb/ccid-card-emulated.c:404:9: error: nested extern declaration of 'error_setg' [-Werror=nested-externs]
> /tmp/qemu-test/src/hw/usb/ccid-card-emulated.c: In function 'emulated_realize':
> /tmp/qemu-test/src/hw/usb/ccid-card-emulated.c:513:13: error: implicit declaration of function 'error_append_hint' [-Werror=implicit-function-declaration]
>               error_append_hint(errp, "%s\n", ptable->name);
>               ^
> /tmp/qemu-test/src/hw/usb/ccid-card-emulated.c:513:13: error: nested extern declaration of 'error_append_hint' [-Werror=nested-externs]
> /tmp/qemu-test/src/hw/usb/ccid-card-emulated.c: At top level:
> cc1: error: unrecognized command line option "-Wno-format-truncation" [-Werror]
> cc1: all warnings being treated as errors
> make: *** [hw/usb/ccid-card-emulated.o] Error 1
> make: *** Waiting for unfinished jobs....
>
>
> The full log is available at
> http://patchew.org/logs/20181225140449.15786-1-fli@suse.com/testing.docker-quick@centos7/?type=message.
> ---
> Email generated automatically by Patchew [http://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com
