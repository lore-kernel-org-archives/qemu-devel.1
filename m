Received: from eggs.gnu.org ([2001:4830:134:3::10]:59614)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1daapV-0003Xt-AR
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 00:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1daapU-0005bA-Lk
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 00:55:21 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170727024224.22900-1-f4bug@amsat.org>
	<20170727024224.22900-11-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <1f4f328c-965e-1000-644b-68f799ceab41@twiddle.net>
Date: Wed, 26 Jul 2017 21:55:10 -0700
MIME-Version: 1.0
In-Reply-To: <20170727024224.22900-11-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 10/20] m68k/translate: fix
 incorrect copy/paste
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 07/26/2017 07:42 PM, Philippe Mathieu-Daudé wrote:
> db3d7945ae extended gen_cc_cond() for cond [6, 7, 9, 10] but misswrote [4, 5]
> 
> target/m68k/translate.c:1323:70: warning: identical expressions on both sides of logical operator
>          if (op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL ||
>              op == CC_OP_ADDB || op == CC_OP_ADDW || op == CC_OP_ADDL) {
>              ~~~~~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~    ~~~~~~~~~~~~~~~~ ^
> 
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daudé<f4bug@amsat.org>
> Reviewed-by: Laurent Vivier<laurent@vivier.eu>
> ---
>   target/m68k/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
