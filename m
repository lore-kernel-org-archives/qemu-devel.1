Received: from eggs.gnu.org ([209.51.188.92]:42653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1CWJ-0004LM-24
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:02:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1h1CWC-00036C-K8
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:02:18 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41751)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1h1CW3-0002p7-9r
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:02:06 -0500
Received: by mail-oi1-x244.google.com with SMTP id e7so7212498oia.8
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:01:57 -0800 (PST)
MIME-Version: 1.0
References: <20190305150123.25048-1-richard.henderson@linaro.org>
In-Reply-To: <20190305150123.25048-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2019 16:01:45 +0000
Message-ID: <CAFEAcA-1OaDU0T64TyXHfDZGLse5fknT7uVmRsX68mRcxqC4Xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/73] tcg: per-cpu locks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Emilio G. Cota" <cota@braap.org>

On Tue, 5 Mar 2019 at 15:01, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is Emilio's v7, unchanged, so I'm not re-posting the 73 patches.
>
> I also didn't want to add Signed-off-by to 73 patches, so I verified
> that there was nothing on Emilio's branch that shouldn't be there and
> then used git-merge -S --signoff.

Hi; I'm afraid this doesn't build on OSX:

/Users/pm215/src/qemu-for-merges/target/i386/hvf/x86hvf.c:361:14:
error: unused variable 'interrupt_request' [-Werror,-Wunused-variable]
    uint32_t interrupt_request;
             ^
/Users/pm215/src/qemu-for-merges/target/i386/hvf/x86hvf.c:465:23:
error: incompatible pointer types passing 'X86CPU *' (aka 'struct
X86CPU *') to parameter of type 'CPUState *' (aka 'struct CPUState *')
[-Werror,-Wincompatible-pointer-types]
    return cpu_halted(cpu);
                      ^~~
/Users/pm215/src/qemu-for-merges/include/qom/cpu.h:510:45: note:
passing argument to parameter 'cpu' here
static inline uint32_t cpu_halted(CPUState *cpu)
                                            ^
2 errors generated.


thanks
-- PMM
