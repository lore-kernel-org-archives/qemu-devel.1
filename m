Received: from eggs.gnu.org ([2001:4830:134:3::10]:36057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egxRK-0005FP-OT
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:48:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1egxRJ-000509-Rx
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:48:58 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:38512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1egxRJ-0004z3-Kt
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 13:48:57 -0500
Received: by mail-ot0-x241.google.com with SMTP id v5so14389693oth.5
	for <qemu-devel@nongnu.org>; Wed, 31 Jan 2018 10:48:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKN+VD9NV6oy0USJ0ChLXodw3k7J4uRqyW41+iSRzr4G_A@mail.gmail.com>
References: <CAKmqyKPZ3AUwGFwp6zK+aFSd6R3p8c+pP-i-W-g=t6ZfR5GVaA@mail.gmail.com>
	<8942a41a-a924-f626-3613-3c74b9db0da6@redhat.com>
	<CAKmqyKN+VD9NV6oy0USJ0ChLXodw3k7J4uRqyW41+iSRzr4G_A@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 31 Jan 2018 18:48:36 +0000
Message-ID: <CAFEAcA_YWx9wsRjHuBXnfyXOKA34YR+bfgoLeP-y1AwgpEj6+Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] MTTCG External Halt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>

On 31 January 2018 at 18:17, Alistair Francis <alistair23@gmail.com> wrote:
> On Wed, Jan 31, 2018 at 9:13 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> cpu->halted = false likewise should not be needed here, but you cannot
>> just clear CPU_INTERRUPT_HALT either.  You need to set a *different*
>> interrupt request bit (the dummy CPU_INTERRUPT_EXITTB will do) and
>> cpu_handle_halt will clear cpu->halted.
>
> The problem with that is that I hit this assert for ARM CPUs:
>
> qemu-system-aarch64: ./target/arm/cpu.h:1446: arm_el_is_aa64:
> Assertion `el >= 1 && el <= 3' failed.

Backtrace from when you hit that might be useful...

thanks
-- PMM
