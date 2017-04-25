Received: from eggs.gnu.org ([2001:4830:134:3::10]:55231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2wPN-00028J-29
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1d2wPM-0003ri-4g
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:05:17 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:36152)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1d2wPL-0003qE-UG
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 05:05:16 -0400
Received: by mail-wr0-x22d.google.com with SMTP id l50so31132333wrc.3
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 02:05:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87pog0q2xz.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
References: <20170425083555.13547-1-nikunj@linux.vnet.ibm.com>
	<CAFEAcA-dD=DZmtvMDAz2Z8u6Qb2ozGWNroPQhwXr+zczvtjqVA@mail.gmail.com>
	<87pog0q2xz.fsf@abhimanyu.i-did-not-set--mail-host-address--so-tickle-me>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Apr 2017 10:04:54 +0100
Message-ID: <CAFEAcA9S+q8FiZ2chaLoUWmQJ3uForGaDVGqwrBHnxmpH4sy_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH RFC] configure: fix clang failure for
 libatomic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

On 25 April 2017 at 09:58, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com> wrote:
> I was trying out the program in the configure script with clang and I do
> get errors without libatomic:
>
>     $ clang /tmp/atomic.c
>     /tmp/atomic.c:6:7: warning: implicit declaration of function '__atomic_load_8' is invalid in C99 [-Wimplicit-function-declaration]
>       y = __atomic_load_8(&x, 0);
>           ^
>     /tmp/atomic.c:7:3: warning: implicit declaration of function '__atomic_store_8' is invalid in C99 [-Wimplicit-function-declaration]
>       __atomic_store_8(&x, y, 0);
>       ^
>     /tmp/atomic.c:8:3: warning: implicit declaration of function '__atomic_compare_exchange_8' is invalid in C99 [-Wimplicit-function-declaration]
>       __atomic_compare_exchange_8(&x, &y, x, 0, 0, 0);
>       ^
>     /tmp/atomic.c:9:3: warning: implicit declaration of function '__atomic_exchange_8' is invalid in C99 [-Wimplicit-function-declaration]
>       __atomic_exchange_8(&x, y, 0);
>       ^
>     /tmp/atomic.c:10:3: warning: implicit declaration of function '__atomic_fetch_add_8' is invalid in C99 [-Wimplicit-function-declaration]
>       __atomic_fetch_add_8(&x, y, 0);
>       ^
>     5 warnings generated.
>     /tmp/atomic-1660e0.o: In function `main':
>     /tmp/atomic.c:(.text+0x28): undefined reference to `__atomic_load_8'
>     /tmp/atomic.c:(.text+0x40): undefined reference to `__atomic_store_8'
>     /tmp/atomic.c:(.text+0x69): undefined reference to `__atomic_compare_exchange_8'
>     /tmp/atomic.c:(.text+0x7d): undefined reference to `__atomic_exchange_8'
>     /tmp/atomic.c:(.text+0x91): undefined reference to `__atomic_fetch_add_8'
>     clang-3.9: error: linker command failed with exit code 1 (use -v to see invocation)
>
> With -latomic, the linker succeeds in getting the binary.

What host is this on ?

thanks
-- PMM
