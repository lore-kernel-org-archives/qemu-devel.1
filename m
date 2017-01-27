Received: from eggs.gnu.org ([2001:4830:134:3::10]:47821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cXBf6-00089W-U4
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 13:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cXBf6-0003EK-81
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 13:54:17 -0500
Received: from mail-ua0-x233.google.com ([2607:f8b0:400c:c08::233]:36187)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cXBf6-0003E2-2V
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 13:54:16 -0500
Received: by mail-ua0-x233.google.com with SMTP id 96so211499626uaq.3
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 10:54:14 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170127183131.6868-1-andrew.smirnov@gmail.com>
References: <20170127183131.6868-1-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Jan 2017 18:53:53 +0000
Message-ID: <CAFEAcA9sQ4W2SMUgoNYLnG-NiHCaf+fsKe+A-yqQt64+iYst0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] util/path: Always translate
 /etc/ld.so.cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 27 January 2017 at 18:31, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Always translate /etc/ld.so.cache to point somwhere inside of guest's
> filesystem tree pointed to by 'prefix'. This prevents guest's libc from
> reading /etc/ld.so.cache of the host and potentialy failing. One of the
> manifestation of the problem could be easily reproduced by executing and
> simple application compiled for PowerPC on a x86 host using
> linux-use/qemu-ppc emulation.
>
> Anything as simple as:
>
>          qemu-ppc -L <prefix> <prefix>/bin/ls
>
> should trigger the problem.
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Have you tested that this doesn't cause execution inside a chroot
to behave wrongly (in a chroot, the host fs /etc/ld.so.cache is
definitely the one you want to use) ?

(glibc really ought to fix their ld.so.cache reading bugs.)

thanks
-- PMM
