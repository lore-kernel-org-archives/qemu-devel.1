Received: from eggs.gnu.org ([2001:4830:134:3::10]:39086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eybat-0004DT-AA
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:07:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eybaq-000763-2L
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:07:47 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:33856)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eybap-00075n-Rj
	for qemu-devel@nongnu.org; Wed, 21 Mar 2018 07:07:43 -0400
Received: by mail-wr0-f178.google.com with SMTP id o8so4754638wra.1
	for <qemu-devel@nongnu.org>; Wed, 21 Mar 2018 04:07:43 -0700 (PDT)
References: <CABLmASFYSu4zQ_35WJLJ6izNGdyn-JuLTzgVm_Bxc3MOkkGo6w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fc09dac9-edbb-cd35-d02a-8db797879363@redhat.com>
Date: Wed, 21 Mar 2018 12:07:40 +0100
MIME-Version: 1.0
In-Reply-To: <CABLmASFYSu4zQ_35WJLJ6izNGdyn-JuLTzgVm_Bxc3MOkkGo6w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Bug AioContext polling is not implemented on
 Windows with qemu-system-ppc.exe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Howard Spoelstra <hsp.cat7@gmail.com>, qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 20/03/2018 18:11, Howard Spoelstra wrote:
> Hi,
> 
> I just built qemu-system-ppc.exe for windows using a fully up-to-date Fedora 27.
> Command line for build:
> 
> ./configure --cross-prefix=x86_64-w64-mingw32-
> --target-list="ppc-softmmu ppc64-softmmu" --enable-gtk
> --with-gtkabi=3.0 --enable-sdl --with-sdlabi=2.0
> 
> Command line to invoke Qemu:
> C:\qemu-master>qemu-system-ppc.exe -L pc-bios -boot c -m 256 -M mac99
> -prom-env "boot-args=-v" -prom-env "auto-boot?=true" -prom-env
> "vga-ndrv?=true"  -drive
> file=c:\Mac-disks\9.1.img,format=raw,media=disk -netdev
> user,id=network01 -device
> sungem,netdev=network01,mac=52:54:00:12:34:66 -sdl -device usb-kbd
> -device usb-mouse
> 
> Error:
> Unexpected error in aio_context_set_poll_params() at util/aio-win32.c:413:
> qemu-system-ppc.exe: AioContext polling is not implemented on Windows

Can you get a backtrace on the Windows system?  Perhaps by putting a
breakpoint in aio_context_set_poll_params.

Paolo
