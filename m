Received: from eggs.gnu.org ([2001:4830:134:3::10]:45071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dwyPq-0003Dj-JG
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dwyPl-0002uG-NQ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:33:22 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:56328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dwyPl-0002tb-GQ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 18:33:17 -0400
Received: by mail-wr0-x230.google.com with SMTP id r74so14360836wrb.13
	for <qemu-devel@nongnu.org>; Tue, 26 Sep 2017 15:33:17 -0700 (PDT)
References: <20170916023417.14599-1-richard.henderson@linaro.org>
	<20170916023417.14599-4-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170916023417.14599-4-richard.henderson@linaro.org>
Date: Tue, 26 Sep 2017 23:33:15 +0100
Message-ID: <87poadccpg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/6] target/arm: Align vector registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, f4bug@amsat.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 98b9b26fd3..c346bd148f 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -486,7 +486,7 @@ typedef struct CPUARMState {
>           * the two execution states, and means we do not need to explicitly
>           * map these registers when changing states.
>           */
> -        float64 regs[64];
> +        float64 regs[64] QEMU_ALIGNED(16);
>
>          uint32_t xregs[16];
>          /* We store these fpcsr fields separately for convenience.  */


--
Alex Bennée
