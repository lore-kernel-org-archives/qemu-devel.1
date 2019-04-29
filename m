Received: from eggs.gnu.org ([209.51.188.92]:60285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8EJ-0006fc-G4
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL8EH-0000i7-Ky
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:30:07 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:32813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL8EF-0000ey-VY
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:30:04 -0400
Received: by mail-oi1-x241.google.com with SMTP id l1so6777706oib.0
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-29-richard.henderson@linaro.org>
	<CAFEAcA8=Tq4txdRkv2x04ZaaHBUnc1DCvvXOwdjOZj4JiQNVgw@mail.gmail.com>
	<84ca26c6-fe25-092c-2c18-5d5ecbcbd481@linaro.org>
In-Reply-To: <84ca26c6-fe25-092c-2c18-5d5ecbcbd481@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 16:29:50 +0100
Message-ID: <CAFEAcA88Rg+QEdwJ+32SWAAUzZ+_hq85ECZiO4uELN30+=XZMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 28/36] target/xtensa: Use
 env_cpu, env_archcpu
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

On Mon, 29 Apr 2019 at 16:20, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/29/19 7:36 AM, Peter Maydell wrote:
> > On Thu, 28 Mar 2019 at 23:38, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >> @@ -712,10 +707,15 @@ static inline int cpu_mmu_index(CPUXtensaState *env, bool ifetch)
> >>  #define XTENSA_CSBASE_LBEG_OFF_MASK 0x00ff0000
> >>  #define XTENSA_CSBASE_LBEG_OFF_SHIFT 16
> >>
> >> +typedef CPUXtensaState CPUArchState;
> >> +typedef XtensaCPU ArchCPU;
> >> +
> >> +#include "exec/cpu-all.h"
> >
> > Shouldn't this bit be in an earlier patch ?
>
> The diff is just funny here.
>
> As with cris, it's really moving the following function below
> exec/cpu-all.h, so that env_archcpu is defined.

Oh, I see. With a note in the commit message about the
function definition moving

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
