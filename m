Received: from eggs.gnu.org ([2001:4830:134:3::10]:46109)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cefcl-0005MD-Pd
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 05:18:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cefck-0007Ea-Ng
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 05:18:47 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35109)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cefck-0007E7-IX
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 05:18:46 -0500
Received: by mail-wm0-x236.google.com with SMTP id v186so10450699wmd.0
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 02:18:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e19aed34-77c2-f588-351d-2daa8a099ae9@redhat.com>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<e19aed34-77c2-f588-351d-2daa8a099ae9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 10:18:24 +0000
Message-ID: <CAFEAcA-3TkmaJXpG2RpzBPKmj+JKGK5EBwPvXWkwR=Qkobq-Sg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Chad Joan <chadjoan@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>

On 17 February 2017 at 08:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
> So I do think that if musl wants to support _GNU_SOURCE, it should also auto-define;
> however it doesn't, see https://git.musl-libc.org/cgit/musl/tree/include/features.h.

Yes, I agree that this looks like a musl bug. I spoke to a musl
developer I happen to know, and he agreed to submit a patch to
see what the other musl devs think.

In the meantime, we should probably work around this system
bug for the benefit of the existing musl installs in the field.

Defining _XOPEN_SOURCE is easy enough, and I think we should
do it unconditionally. We should check what effect this has
on the BSD hosts though I guess. (You could argue that we
should be defining _XOPEN_SOURCE anyway for the benefit of
the non-glibc BSD/Solaris/etc platforms.)

thanks
-- PMM
