Received: from eggs.gnu.org ([209.51.188.92]:60511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3DfE-0005dB-1P
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 01:39:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1h3DfC-0001Fx-UP
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 01:39:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:33485)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1h3DfC-0001C6-5s
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 01:39:50 -0400
Date: Mon, 11 Mar 2019 13:39:19 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190311053919.GA21347@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190311013016.14411-1-richardw.yang@linux.intel.com>
	<155228009288.31099.6432699798418072895@6acff2cf482b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155228009288.31099.6432699798418072895@6acff2cf482b>
Subject: Re: [Qemu-devel] [PATCH v2] exec.c: refactor function
 flatview_add_to_dispatch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: richardw.yang@linux.intel.com, fam@euphon.net, pbonzini@redhat.com, rth@twiddle.net

On Sun, Mar 10, 2019 at 09:54:54PM -0700, no-reply@patchew.org wrote:
>Patchew URL: https://patchew.org/QEMU/20190311013016.14411-1-richardw.yang@linux.intel.com/
>
>
>
>Hi,
>
>This series failed the docker-mingw@fedora build test. Please find the testing commands and
>their output below. If you have Docker installed, you can probably reproduce it
>locally.
>
>=== TEST SCRIPT BEGIN ===
>#!/bin/bash
>time make docker-test-mingw@fedora SHOW_ENV=1 J=14 NETWORK=1
>=== TEST SCRIPT END ===
>
>  CC      x86_64-softmmu/accel/tcg/tcg-runtime.o
>  CC      aarch64-softmmu/hw/cpu/realview_mpcore.o
>/tmp/qemu-test/src/exec.c: In function 'flatview_add_to_dispatch':
>/tmp/qemu-test/src/exec.c:1644:32: error: incompatible type for argument 2 of 'int128_gt'
>     if (int128_gt(remain.size, 0)) {
>                                ^
>In file included from /tmp/qemu-test/src/include/exec/memory.h:24,
>---
>  CC      aarch64-softmmu/hw/display/vga.o
>  CC      aarch64-softmmu/hw/display/bcm2835_fb.o
>/tmp/qemu-test/src/exec.c: In function 'flatview_add_to_dispatch':
>/tmp/qemu-test/src/exec.c:1644:32: error: incompatible type for argument 2 of 'int128_gt'
>     if (int128_gt(remain.size, 0)) {
>                                ^

Not sure why this works at my side.

Fixed this with 

      if (int128_gt(remain.size, int128_make64(0))) {

>In file included from /tmp/qemu-test/src/include/exec/memory.h:24,
>
>
>The full log is available at
>http://patchew.org/logs/20190311013016.14411-1-richardw.yang@linux.intel.com/testing.docker-mingw@fedora/?type=message.
>---
>Email generated automatically by Patchew [http://patchew.org/].
>Please send your feedback to patchew-devel@redhat.com

-- 
Wei Yang
Help you, Help me
