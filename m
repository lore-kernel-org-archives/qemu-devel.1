Received: from eggs.gnu.org ([2001:4830:134:3::10]:51014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1crK1l-0003lA-FJ
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 03:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1crK1i-0006Ua-Ah
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 03:52:53 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:33091)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1crK1i-0006UR-4T
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 03:52:50 -0400
Received: by mail-wr0-x22e.google.com with SMTP id y90so3935595wrb.0
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 00:52:49 -0700 (PDT)
References: <20170322172621.26186.61813.malonedeb@gac.canonical.com>
	<20170324062950.30507.96974.malone@soybean.canonical.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170324062950.30507.96974.malone@soybean.canonical.com>
Date: Fri, 24 Mar 2017 07:52:46 +0000
Message-ID: <878tnvxga9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Bug 1675108] Re: Cocoa UI always crashes on
 startup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1675108 <1675108@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


Brendan Shanks <brendan@bslabs.net> writes:

> Tested on 10.12.3, it doesn't crash immediately (like before) but
> crashes reliably once I send some keyboard input to qemu:
>
> $ i386-softmmu/qemu-system-i386
> **
> ERROR:/Users/pip/no_backup/qemu/translate-common.c:34:tcg_handle_interrupt: assertion failed: (qemu_mutex_iothread_locked())
> Abort trap: 6

Can you test with the suggested patch I posted yesterday? If we keep the
update under BQL this shouldn't fail.

>
>
> Thread 0 Crashed:: Dispatch queue: com.apple.main-thread
> 0   libsystem_kernel.dylib        	0x00007fffa746edd6 __pthread_kill + 10
> 1   libsystem_pthread.dylib       	0x00007fffa755a787 pthread_kill + 90
> 2   libsystem_c.dylib             	0x00007fffa73d4420 abort + 129
> 3   libglib-2.0.0.dylib           	0x00000001076aec86 g_assertion_message + 388
> 4   libglib-2.0.0.dylib           	0x00000001076aece4 g_assertion_message_expr + 94
> 5   qemu-system-i386              	0x00000001066bb1ec tcg_handle_interrupt + 156 (translate-common.c:50)
> 6   qemu-system-i386              	0x0000000106740dfc pic_irq_request + 156 (pc.c:187)
> 7   qemu-system-i386              	0x000000010673e5e4 gsi_handler + 36 (pc.c:115)
> 8   qemu-system-i386              	0x000000010685e97a kbd_update_kbd_irq + 138 (pckbd.c:180)
> 9   qemu-system-i386              	0x000000010694164a qemu_input_event_send_impl + 938 (input.c:328)
> 10  qemu-system-i386              	0x000000010694188f qemu_input_event_send_key + 239 (input.c:359)
> 11  qemu-system-i386              	0x0000000106946a00 cocoa_refresh + 272 (cocoa.m:1402)
> 12  qemu-system-i386              	0x000000010693f6a8 gui_update + 104 (console.c:1603)


--
Alex Bennée
