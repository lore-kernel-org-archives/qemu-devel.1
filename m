Received: from eggs.gnu.org ([209.51.188.92]:33750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmdrG-0001sy-VG
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 07:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmddi-0002mS-Uk
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:57:47 -0500
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:36172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmddi-0002kZ-OL
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:57:46 -0500
Received: by mail-ot1-x32e.google.com with SMTP id k98so4997562otk.3
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 03:57:46 -0800 (PST)
MIME-Version: 1.0
References: <1548205322-36101-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548205322-36101-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 11:57:34 +0000
Message-ID: <CAFEAcA9yfYBNdwhsVBqzw9SLoWEVjuahnDWJNPaUBVEtoG+jqw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 00/51] Misc patches for 2019-01-23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Wed, 23 Jan 2019 at 01:04, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit cce871c504694cf1034adf525556e3ca3c7eebb6:
>
>   hw/block/xen: use proper format string for printing sectors (2019-01-21 14:45:49 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 3cf01054d896fa88ea0dd31c5abb605c2e68bb29:
>
>   docker: disable Xen on CentOS 7 (2019-01-23 01:40:47 +0100)
>
> ----------------------------------------------------------------
> * cpu-exec fixes (Emilio, Laurent)
> * high address load for linuxboot (Zhijian)
> * PVH support (Liam, Stefano)
> * Linux header update (Paolo)
> * enable vhost-net for all targets that have virtio-net (Paolo)
> * vhost-user-test cleanups (Paolo)
> * misc i386 changes (Paolo, Robert)
> * hexloader-test change to avoid O_NONBLOCK on stdin (Peter)
> * configure tweak for openpty (Thomas)
> * elf2dmp port to Windows (Viktor)

I get this intermittent failure in vhost-user-test on osx host:

manooth$ QTEST_QEMU_BINARY=i386-softmmu/qemu-system-i386 ./tests/vhost-user-test
/i386/vhost-user/migrate:
(./tests/vhost-user-test:11590): GLib-WARNING **: 11:54:26.837:
poll(2) failed due to: Bad file descriptor.
Trace/BPT trap: 5

Happens about one time in five when running the test manually.

thanks
-- PMM
