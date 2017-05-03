Received: from eggs.gnu.org ([2001:4830:134:3::10]:38422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5to0-0006SG-1K
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:54:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5tnw-0007nc-WA
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:54:56 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33485)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1d5tnw-0007nM-Qj
	for qemu-devel@nongnu.org; Wed, 03 May 2017 08:54:52 -0400
Received: by mail-qk0-x244.google.com with SMTP id o85so2511908qkh.0
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 05:54:52 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170502120350.3368.92338.stgit@PASHA-ISP>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <84b9ea39-f5ff-7340-4e5f-3685d6cadc53@amsat.org>
Date: Wed, 3 May 2017 09:54:48 -0300
MIME-Version: 1.0
In-Reply-To: <20170502120350.3368.92338.stgit@PASHA-ISP>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] mips: set CP0 Debug DExcCode for SDBBP
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: yongbok.kim@imgtec.com, aurelien@aurel32.net

On 05/02/2017 09:03 AM, Pavel Dovgalyuk wrote:
> From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>
> This patch fixes setting DExcCode field of CP0 Debug register
> when SDBBP instruction is executed. According to EJTAG specification,
> this field must be set to the value 9 (Bp).
>
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/mips/helper.c |    2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index e359ca3b44..166f0d1243 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -627,6 +627,8 @@ void mips_cpu_do_interrupt(CPUState *cs)
>          goto set_DEPC;
>      case EXCP_DBp:
>          env->CP0_Debug |= 1 << CP0DB_DBp;
> +        /* Setup DExcCode - SDBBP instruction */
> +        env->CP0_Debug = (env->CP0_Debug & ~(0x1fULL << CP0DB_DEC)) | 9 << CP0DB_DEC;
>          goto set_DEPC;
>      case EXCP_DDBS:
>          env->CP0_Debug |= 1 << CP0DB_DDBS;
>
>
