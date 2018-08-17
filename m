Received: from eggs.gnu.org ([2001:4830:134:3::10]:51987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqhiq-0001v5-Ob
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:35:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqhiq-0004E2-4n
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:35:36 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:44897)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqhiq-0004DC-0L
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 12:35:36 -0400
Received: by mail-oi0-x243.google.com with SMTP id s198-v6so14971069oih.11
	for <qemu-devel@nongnu.org>; Fri, 17 Aug 2018 09:35:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180809042206.15726-11-richard.henderson@linaro.org>
References: <20180809042206.15726-1-richard.henderson@linaro.org>
	<20180809042206.15726-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Aug 2018 17:35:15 +0100
Message-ID: <CAFEAcA9K2SR+Y0JHwP1WKcsWs=diE+H_1xDX2Z7UoCTfCL3YXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 10/20] target/arm: Adjust
 aarch64_cpu_dump_state for system mode SVE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Laurent Desnogues <laurent.desnogues@gmail.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On 9 August 2018 at 05:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
> Use the existing helpers to determine if (1) the fpu is enabled,
> (2) sve state is enabled, and (3) the current sve vector length.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h           | 4 ++++
>  target/arm/helper.c        | 6 +++---
>  target/arm/translate-a64.c | 8 ++++++--
>  3 files changed, 13 insertions(+), 5 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I can't think of a reason why we'd want to look at the FPU
state with the FPU disabled, so I guess this is ok...

thanks
-- PMM
