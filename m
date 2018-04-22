Received: from eggs.gnu.org ([2001:4830:134:3::10]:39018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAKZC-00087O-1R
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 15:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fAKZ8-0005Er-Tp
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 15:22:30 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:37813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fAKZ8-0005EJ-N4
	for qemu-devel@nongnu.org; Sun, 22 Apr 2018 15:22:26 -0400
Received: by mail-pg0-x244.google.com with SMTP id a13so2390213pgu.4
	for <qemu-devel@nongnu.org>; Sun, 22 Apr 2018 12:22:26 -0700 (PDT)
References: <20180421232120.22208-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b258037c-2e37-3c21-8fe5-38e5dcf5cf2c@linaro.org>
Date: Sun, 22 Apr 2018 09:22:20 -1000
MIME-Version: 1.0
In-Reply-To: <20180421232120.22208-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] elf-loader: Avoid calling qsort(NULL, 0,
 ...) call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 04/21/2018 01:21 PM, Philippe Mathieu-Daudé wrote:
> This fixes the following ASan warning:
> 
>   $ qemu-system-xtensa -M kc705 -m 128M -semihosting -nographic -monitor null -kernel Image.elf
>   include/hw/elf_ops.h:179:5: runtime error: null pointer passed as argument 1, which is declared to never be null
> 
> Reported-by: AddressSanitizer
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/elf_ops.h | 39 ++++++++++++++++++++++-----------------
>  1 file changed, 22 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
