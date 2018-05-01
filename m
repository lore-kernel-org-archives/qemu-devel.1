Received: from eggs.gnu.org ([2001:4830:134:3::10]:45822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fDY1c-00027s-Ho
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:21:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fDY1b-0005uG-AG
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:21:08 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:40328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1fDY1b-0005rx-2v
	for qemu-devel@nongnu.org; Tue, 01 May 2018 12:21:07 -0400
Received: by mail-wr0-x242.google.com with SMTP id v60-v6so11254008wrc.7
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 09:21:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <02284e13e9c541cda32051204e64fa66@mips.com>
References: <02284e13e9c541cda32051204e64fa66@mips.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 1 May 2018 17:21:04 +0100
Message-ID: <CAJSP0QVxfQKQeAJ0LjrXb61OidiKDacih_HDSw_ucMvLDrdtyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Introducing a nanoMIPS port for QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Matthew Fortune <Matthew.Fortune@mips.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Aleksandar Rikalo <Aleksandar.Rikalo@mips.com>, Paul Burton <Paul.Burton@mips.com>, Stefan Markovic <Stefan.Markovic@mips.com>, Dimitrije Nikolic <Dimitrije.Nikolic@mips.com>, James Hogan <James.Hogan@mips.com>, Yongbok Kim <Yongbok.Kim@mips.com>

On Tue, May 1, 2018 at 4:07 PM, Matthew Fortune
<Matthew.Fortune@mips.com> wrote:
> QEMU specific details
> ====================
>
> The nanoMIPS QEMU port borrows a significant amount of logic from the MIPS
> port. Most instructions in nanoMIPS exist in one of the other MIPS ISAs, which
> allows the new decoder to hook into existing logic. Some of the more
> interesting technical changes include:
>
> - The Unified Hosting Interface (UHI) for semihosting is supported and,
>   in-keeping with the aims of the interface, the same ABI is used with nanoMIPS
>   as MIPS
> - Linux user-mode support has been updated significantly, compared to MIPS, to
>   follow the new nanoMIPS ABI which utilizes most of the generic syscall and
>   signal infrastructure from the Linux kernel
>
> The QEMU build targets for nanoMIPS are nanomips-softmmu and
> nanomips-linux-user, rather than the existing mips targets, because nanoMIPS is
> not designed for use alongside any other MIPS ISA.
>
> QEMU contributors:
>
> - QEMU
>   Yongbok Kim, Stefan Markovic, Aleksandar Rikalo, Dimitrije Nikolic
>   Aleksandra Karadzic, Matthew Fortune, Paul Burton, James Hogan

Congratulations!  The upstreaming effort of a significant out-of-tree
project like this often takes longer than expected, but several of you
are already QEMU sub-maintainers so that will make it easier.

Please consider submitting a KVM Forum (October 24-26 in Edinburgh,
UK) presentation that highlights aspects of the architecture and how
to emulate it in QEMU:
https://events.linuxfoundation.org/events/kvm-forum-2018/

Stefan
