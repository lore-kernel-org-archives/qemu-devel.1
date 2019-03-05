Received: from eggs.gnu.org ([209.51.188.92]:59543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LGL-0004tX-6X
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1LGK-0004V5-MH
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:25 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:42070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1LGK-0004Ux-G7
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 20:22:24 -0500
Received: by mail-pf1-x444.google.com with SMTP id n74so7107302pfi.9
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 17:22:24 -0800 (PST)
References: <20190305162829.20079-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cfdd3844-8c4e-4b4c-a6f5-a02c8fab945d@linaro.org>
Date: Tue, 5 Mar 2019 15:54:02 -0800
MIME-Version: 1.0
In-Reply-To: <20190305162829.20079-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/5] mips_malta: Clean up definition of
 flash memory size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 3/5/19 8:28 AM, Philippe Mathieu-Daudé wrote:
> Markus Armbruster (1):
>   mips_malta: Clean up definition of flash memory size somewhat
> 
> Philippe Mathieu-Daudé (4):
>   hw/mips/malta: Fix the DEBUG_BOARD_INIT code
>   hw/mips/malta: Remove fl_sectors variable (used one single time)
>   hw/mips/malta: Restrict 'bios_size' variable scope
>   hw/mips/malta: Only accept 'monitor' pflash of 4MiB
> 
>  hw/mips/mips_malta.c | 27 +++++++++++++++++----------
>  1 file changed, 17 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
