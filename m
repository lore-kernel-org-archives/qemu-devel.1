Received: from eggs.gnu.org ([2001:4830:134:3::10]:53773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNRzG-0005Gr-Dp
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:51:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dNRzD-00015h-RX
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:51:06 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34353)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dNRzD-00015Z-N8
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 18:51:03 -0400
Received: by mail-qt0-x243.google.com with SMTP id o21so25134204qtb.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 15:51:03 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170620205121.26515-1-laurent@vivier.eu>
	<20170620205121.26515-3-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6d2a1a13-17d9-d890-273d-9bda9c66494e@twiddle.net>
Date: Tue, 20 Jun 2017 15:51:00 -0700
MIME-Version: 1.0
In-Reply-To: <20170620205121.26515-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 2/6] target-m68k: initialize FPU
 registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 06/20/2017 01:51 PM, Laurent Vivier wrote:
> on reset, set FP registers to NaN and control registers to 0
> 
> Signed-off-by: Laurent Vivier<laurent@vivier.eu>
> ---
>   target/m68k/cpu.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Nevermind the last... it's in 5/6.

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
