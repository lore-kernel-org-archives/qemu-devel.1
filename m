Received: from eggs.gnu.org ([2001:4830:134:3::10]:44115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gM7Pj-0007K9-P9
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gM7Pc-0000LS-6I
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:17:43 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gM7PY-0000JC-Fj
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 03:17:34 -0500
Received: by mail-wm1-x343.google.com with SMTP id i73-v6so2155171wmd.5
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 00:17:32 -0800 (PST)
References: <20181111233622.8976-1-f4bug@amsat.org>
	<20181111233622.8976-5-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fcf6a09c-abd2-4e15-2b80-e0c599accf31@linaro.org>
Date: Mon, 12 Nov 2018 09:17:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181111233622.8976-5-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 04/11] target/mips: Avoid access to
 CPUMIPSState from decode* functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 11/12/18 12:36 AM, Philippe Mathieu-Daudé wrote:
> The DisasContext is already initialized from the CPUMIPSState in
> mips_tr_init_disas_context().
> 
> Suggested-by: Richard Henderson <rth@twiddle.net>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/mips/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
