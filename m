Received: from eggs.gnu.org ([2001:4830:134:3::10]:59405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cegaG-0007Vt-0d
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 06:20:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cegaB-0004P7-0Z
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 06:20:16 -0500
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<e19aed34-77c2-f588-351d-2daa8a099ae9@redhat.com>
	<CAFEAcA-3TkmaJXpG2RpzBPKmj+JKGK5EBwPvXWkwR=Qkobq-Sg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7c4d6c25-3b1c-61ec-1eda-6c5e7cee8755@redhat.com>
Date: Fri, 17 Feb 2017 12:20:10 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-3TkmaJXpG2RpzBPKmj+JKGK5EBwPvXWkwR=Qkobq-Sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>, Chad Joan <chadjoan@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>



On 17/02/2017 11:18, Peter Maydell wrote:
> Defining _XOPEN_SOURCE is easy enough, and I think we should
> do it unconditionally. We should check what effect this has
> on the BSD hosts though I guess. (You could argue that we
> should be defining _XOPEN_SOURCE anyway for the benefit of
> the non-glibc BSD/Solaris/etc platforms.)

Sounds good, then I think we should define it to 700 just like glibc does.

Paolo
