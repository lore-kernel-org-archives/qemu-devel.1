Received: from eggs.gnu.org ([2001:4830:134:3::10]:38655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGn6i-0006Ll-Ce
	for qemu-devel@nongnu.org; Thu, 10 May 2018 11:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fGn6h-00031i-Jj
	for qemu-devel@nongnu.org; Thu, 10 May 2018 11:03:48 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:37652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fGn6h-00031T-Dn
	for qemu-devel@nongnu.org; Thu, 10 May 2018 11:03:47 -0400
Received: by mail-ot0-x22b.google.com with SMTP id 77-v6so2655650otd.4
	for <qemu-devel@nongnu.org>; Thu, 10 May 2018 08:03:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180508151437.4232-1-richard.henderson@linaro.org>
References: <20180508151437.4232-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 10 May 2018 16:03:26 +0100
Message-ID: <CAFEAcA-G6XmdJo9oD1oBO_GU4k+vvjz4dAc2FX4VOLYfTjBg_w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/10] target/arm: Implement v8.1-Atomics
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 May 2018 at 16:14, Richard Henderson <richard.henderson@linaro.org> wrote:
> This implements the Atomics extension, which is mandatory for v8.1.
> While testing the v8.2-SVE extension, I've run into issues with the
> GCC testsuite expecting this to exist.
>
> Missing is the wiring up of the system registers to indicate that
> the extension exists, but we have no system CPU model that would
> exercise such a setting.
>
> Changes since v3:
>   * Patch 8: Do not zero-extend X[s] via the third parameter
>     to read_cpu_reg.
>
> Changes since v2:
>   * New patch to use a helper macro for opposite-endian
>     atomic_fetch_add and atomic_add_fetch, as suggested
>     by pm215.
>   * Introduce ARM_FEATURE_V8_1 and define ARM_FEATURE_V8_ATOMICS
>     in terms of that, reinforcing the mandatory nature of
>     the extension.
>   * Typo fix in patch 8



Applied to target-arm.next (with the atomics.h workaround first
and the removal of ARM_FEATURE_V8_1), thanks.

-- PMM
