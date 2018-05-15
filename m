Received: from eggs.gnu.org ([2001:4830:134:3::10]:41408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIXeQ-0006BM-Dc
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:57:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fIXeP-0005DP-9o
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:57:50 -0400
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:46402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fIXeP-0005D1-3j
	for qemu-devel@nongnu.org; Tue, 15 May 2018 06:57:49 -0400
Received: by mail-ot0-x243.google.com with SMTP id t1-v6so17907093ott.13
	for <qemu-devel@nongnu.org>; Tue, 15 May 2018 03:57:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180514221219.7091-23-richard.henderson@linaro.org>
References: <20180514221219.7091-1-richard.henderson@linaro.org>
	<20180514221219.7091-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 15 May 2018 11:57:27 +0100
Message-ID: <CAFEAcA_11r0v_Xc9a=fogtCpuN93CxSW0yrxCZ08vTLyDTrygw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 22/28] fpu/softfloat: Specialize on
 snan_bit_is_one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@mips.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Guan Xuetao <gxt@mprc.pku.edu.cn>

On 14 May 2018 at 23:12, Richard Henderson <richard.henderson@linaro.org> wrote:
> Only MIPS requires snan_bit_is_one to be variable.  While we are
> specializing softfloat behaviour, allow other targets to eliminate
> this runtime check.
>
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Yongbok Kim <yongbok.kim@mips.com>
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v5
>   - do not remove the set_snan_bit_is_one function
>   - tidy the language in the snan_bit_is_one block comment

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I think this change makes the comments in target/riscv/fpu_helper.c
helper_fclass_s() and helper_fclass_d() stale, incidentally.

thanks
-- PMM
