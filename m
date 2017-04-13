Received: from eggs.gnu.org ([2001:4830:134:3::10]:32892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cyYmK-0000iK-Rr
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 03:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1cyYmG-0002IK-Ku
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 03:02:52 -0400
Received: from mail-vk0-f41.google.com ([209.85.213.41]:36512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1cyYmG-0002I1-G1
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 03:02:48 -0400
Received: by mail-vk0-f41.google.com with SMTP id x65so14157606vkx.3
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 00:02:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8a7bf9dbac4c6db5b7e8dd5c968cacae@ispras.ru>
References: <8a7bf9dbac4c6db5b7e8dd5c968cacae@ispras.ru>
From: Ladi Prosek <lprosek@redhat.com>
Date: Thu, 13 Apr 2017 09:02:45 +0200
Message-ID: <CABdb734AjdU7kQOUzmmnhEdd0wmJWM4-2Fop=8jZ588uZX3M-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] WinDbg module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>

Hi,

On Wed, Apr 12, 2017 at 4:05 PM, Mihail Abakumov
<mikhail.abakumov@ispras.ru> wrote:
> Hello.
>
> We made the debugger module WinDbg (like GDB) for QEMU. This is the
> replacement of the remote stub in Windows kernel. Used for remote Windows
> kernel debugging without debugging mode.

This is awesome!

> The latest build and instructions for the launch can be found here:
> https://github.com/ispras/qemu/releases/tag/v2.7.50-windbg
>
> Currently only one ways to create a remote debugging connection is
> supported: using COM port with named pipe.

The linked v2.7.50-windbg seems to be a Windows release. Does it also
work on Linux hosts with KVM?

Also,

  #ifdef TARGET_X86_64 // Unimplemented yet
  #error Unsupported Architecture
  #endif

can you estimate the amount of work to support 64-bit?

Thanks!
Ladi

> Should I prepare patches for inclusion in the master branch? Or is it too
> specific module and it is not needed?
>
> --
> Thanks,
> Mihail Abakumov
>
