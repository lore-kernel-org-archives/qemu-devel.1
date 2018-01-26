Received: from eggs.gnu.org ([2001:4830:134:3::10]:34838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ef7yS-0004g8-FZ
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:39:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ef7yP-0003ys-9A
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:39:36 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:36276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ef7yP-0003yI-1M
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 12:39:33 -0500
Received: by mail-wm0-x243.google.com with SMTP id f3so22754307wmc.1
	for <qemu-devel@nongnu.org>; Fri, 26 Jan 2018 09:39:32 -0800 (PST)
References: <20180117161435.28981-1-richard.henderson@linaro.org>
	<20180117161435.28981-12-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180117161435.28981-12-richard.henderson@linaro.org>
Date: Fri, 26 Jan 2018 09:52:47 +0000
Message-ID: <878tcl6j68.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v10.5 11/20] target/arm: Align vector
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 96316700dd..3ff4dea6b8 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -492,7 +492,7 @@ typedef struct CPUARMState {
>           * the two execution states, and means we do not need to explici=
tly
>           * map these registers when changing states.
>           */
> -        float64 regs[64];
> +        float64 regs[64] QEMU_ALIGNED(16);

There is a minor conflict that needs to be fixed with the now merged: 3f68b=
8a5a6862f856524bb347bf348ae364dd43c
>
>          uint32_t xregs[16];
>          /* We store these fpcsr fields separately for convenience.  */


--
Alex Benn=C3=A9e
