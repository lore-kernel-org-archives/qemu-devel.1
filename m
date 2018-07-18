Received: from eggs.gnu.org ([2001:4830:134:3::10]:44677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffo9r-0006Bv-Fr
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:14:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffo9o-0005wL-C1
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:14:27 -0400
Received: from mail-vk0-x243.google.com ([2607:f8b0:400c:c05::243]:40404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffo9o-0005ui-5r
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:14:24 -0400
Received: by mail-vk0-x243.google.com with SMTP id s23-v6so2683001vks.7
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 08:14:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <09124b32-2571-2b6f-f10f-4c542683b1e7@amsat.org>
	<285670de-6281-4de2-54a4-78610d3d7835@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3f1c5e5e-2e72-0c0d-df29-5db8118d96dd@amsat.org>
Date: Wed, 18 Jul 2018 12:14:18 -0300
MIME-Version: 1.0
In-Reply-To: <285670de-6281-4de2-54a4-78610d3d7835@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] spice/qlx: atomic-alignment error with clang-7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <rth@twiddle.net>, Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, "Emilio G. Cota" <cota@braap.org>

On 07/18/2018 12:12 PM, Paolo Bonzini wrote:
> On 18/07/2018 16:56, Philippe Mathieu-Daudé wrote:
>> Using clang-7 (Debian) on x86_64 to build v3.0.0-rc1.
>>
>> Not a regression, it was probably always there:
>>
>> $ ./configure --cc=clang-7 && make hw/display/qxl.o
>> hw/display/qxl.c:1884:19: error: misaligned or large atomic operation
>> may incur significant performance penalty [-Werror,-Watomic-alignment]
>>     old_pending = atomic_fetch_or(&d->ram->int_pending, le_events);
>>                   ^
>> include/qemu/atomic.h:206:34: note: expanded from macro 'atomic_fetch_or'
>> #define atomic_fetch_or(ptr, n)  __atomic_fetch_or(ptr, n, __ATOMIC_SEQ_CST)
>>                                  ^
>> 1 error generated.
> 
> Hi, this is fixed in the latest SPICE git.  The upstream commit is
> 
> https://gitlab.freedesktop.org/spice/spice-protocol/commit/beda5ec7a6848be20c0cac2a9a8ef2a41e8069c1

That was fast =)

Thanks!

Phil.
