Received: from eggs.gnu.org ([2001:4830:134:3::10]:36086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cePOg-00083U-6x
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:59:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cePOb-0000J4-Bk
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:59:10 -0500
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1933406e-2576-e687-3545-a72f3b999310@redhat.com>
Date: Thu, 16 Feb 2017 17:58:55 +0100
MIME-Version: 1.0
In-Reply-To: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
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
To: Chad Joan <chadjoan@gmail.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org



On 16/02/2017 17:30, Chad Joan wrote:
> Hello,
> 
> This is a one-line patch to the configure script that will allow QEMU to be
> built on musl-libc based Linux systems.  This problem is only noticeable
> when QEMU is built with --enable-curses.
> 
> Detailed reading material if you want to know where this came from:
> https://bugs.gentoo.org/show_bug.cgi?id=609364

Hi,

can you explain exactly which function is missing without
-D_XOPEN_SOURCE=500?  If it is curses' wide-char functions, why does it
fail with musl but not with glibc?  Is _XOPEN_SOURCE always defined by
glibc if you have _D_GNU_SOURCE?

Paolo
