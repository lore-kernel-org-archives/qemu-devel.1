Received: from eggs.gnu.org ([2001:4830:134:3::10]:37628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIXMJ-0006OA-55
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIXMI-00049K-Dm
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:39:07 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:40565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIXMI-000494-8p
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:39:06 -0400
Received: by mail-ot0-x243.google.com with SMTP id n1-v6so17852745otf.7
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 03:39:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514221219.7091-27-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-27-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 11:38:45 +0100
Message-ID: <CAFEAcA_wCKQc40HA--kv3pJ34ih79ft-0mXCx4-6QbtvkN8Xzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 26/28] fpu/softfloat: Define
 floatN_default_nan in terms of parts_default_nan
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 14 May 2018 at 23:12, Richard Henderson <richard.henderson@linaro.org> wrote:
> Isolate the target-specific choice to 2 functions instead of 6.
>
> The code in float16_default_nan was only correct for ARM, MIPS, and X86.
> Though float16 support is rare among our targets.
>
> The code in float128_default_nan was arguably wrong for Sparc.  While
> QEMU supports the Sparc 128-bit insns, no real cpu enables it.
>
> The code in floatx80_default_nan tried to be over-general.  There are
> only two targets that support this format: x86 and m68k.  Thus there
> is no point in inventing a value for snan_bit_is_one.
>
> Move routines that no longer have ifdefs out of softfloat-specialize.h.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

This patch results in float32_default_nan() for Arm returning 0x7f800000,
which is not a NaN...

thanks
-- PMM
