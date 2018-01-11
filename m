Received: from eggs.gnu.org ([2001:4830:134:3::10]:60390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZdzU-0005Aj-5Q
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:38:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eZdzO-0007Fn-Jn
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:38:00 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:32781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eZdzO-0007FU-Dm
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 09:37:54 -0500
Received: by mail-pg0-x241.google.com with SMTP id i196so2310727pgd.0
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 06:37:54 -0800 (PST)
References: <1515637324-96034-1-git-send-email-mjc@sifive.com>
	<1515637324-96034-4-git-send-email-mjc@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d78fb981-83a5-9398-f878-095d41fc3dff@linaro.org>
Date: Thu, 11 Jan 2018 06:37:50 -0800
MIME-Version: 1.0
In-Reply-To: <1515637324-96034-4-git-send-email-mjc@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/21] RISC-V CPU Core Definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>, qemu-devel@nongnu.org
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, Sagar Karandikar <sagark@eecs.berkeley.edu>, RISC-V Patches <patches@groups.riscv.org>

On 01/10/2018 06:21 PM, Michael Clark wrote:
> +static inline void cpu_get_tb_cpu_state(CPURISCVState *env, target_ulong *pc,
> +                                        target_ulong *cs_base, uint32_t *flags)
> +{
> +    *pc = env->pc;
> +    *cs_base = 0;
> +    *flags = 0; /* necessary to avoid compiler warning */
> +}

Actually, at minimum you have to put enough into flags to differentiate machine
vs supervisor vs user mode.  Otherwise you can wind up running a previously
translated block with the wrong permissions.

The patch I saw from Stefan O'Rear would do nicely.


r~
