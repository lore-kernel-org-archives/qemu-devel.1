Received: from eggs.gnu.org ([209.51.188.92]:41307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gwOnJ-0001j9-Dn
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent.desnogues@gmail.com>) id 1gwOnI-0006P2-Fe
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:08:01 -0500
Received: from mail-it1-x141.google.com ([2607:f8b0:4864:20::141]:51119)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent.desnogues@gmail.com>)
	id 1gwOnI-0006KC-8y
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 05:08:00 -0500
Received: by mail-it1-x141.google.com with SMTP id m137so13947131ita.0
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 02:07:53 -0800 (PST)
MIME-Version: 1.0
References: <20190220050451.10939-1-richard.henderson@linaro.org>
In-Reply-To: <20190220050451.10939-1-richard.henderson@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Wed, 20 Feb 2019 11:07:41 +0100
Message-ID: <CABoDooNvVGXeh9rKDzzagkz0pUgx0A4rgWvr_kpLKAHL4dfTRQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] target/arm: Implement ARMv8.5-CondM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

Hi,

On Wed, Feb 20, 2019 at 6:05 AM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg02733.html
> aka the v3 ARMv8.5-MemTag patch set,
> or at least some of the early patches that split handle_msr_i.
>
> The v8.4 parts have been tested vs FVP, but there's no released
> version that supports v8.5 yet, so XAFlag and AXFlag are untested.
> But they seem fairly straightforward, unless I've done something silly.

I tested xaflag/axflag (after setting the ID_AA64ISAR0 TS field to 2).

I also tested rmif/setf8/setf16.

Everything passes.

tested-by: Laurent Desnogues <laurent.desnogues@gmail.com>

Thanks,

Laurent

>
> r~
>
>
> Richard Henderson (3):
>   target/arm: Rearrange disas_data_proc_reg
>   target/arm: Implement ARMv8.4-CondM
>   target/arm: Implement ARMv8.5-CondM
>
>  target/arm/cpu.h           |  10 ++
>  linux-user/elfload.c       |   1 +
>  target/arm/cpu64.c         |   1 +
>  target/arm/translate-a64.c | 249 +++++++++++++++++++++++++++++++------
>  4 files changed, 221 insertions(+), 40 deletions(-)
>
> --
> 2.17.2
>
>
