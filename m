Received: from eggs.gnu.org ([2001:4830:134:3::10]:45673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9J0b-0005v9-92
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d9J0a-0006df-5b
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:26:01 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:35131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d9J0Z-0006dY-TH
	for qemu-devel@nongnu.org; Fri, 12 May 2017 18:26:00 -0400
Received: by mail-qt0-x243.google.com with SMTP id r58so8541629qtb.2
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 15:25:59 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170510182636.17791-1-aurelien@aurel32.net>
	<20170510182636.17791-15-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d98ef0f3-cb00-0671-e362-c81788d8269a@twiddle.net>
Date: Fri, 12 May 2017 15:25:56 -0700
MIME-Version: 1.0
In-Reply-To: <20170510182636.17791-15-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 14/15] target/sh4: trap unaligned
 accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org

On 05/10/2017 11:26 AM, Aurelien Jarno wrote:
> SH4 requires that memory accesses are naturally aligned, except for the
> SH4-A movua.l instructions which can do unaligned loads.
> 
> Reviewed-by: Philippe Mathieu-Daudé<f4bug@amsat.org>
> Signed-off-by: Aurelien Jarno<aurelien@aurel32.net>
> ---
>   target/sh4/cpu.c       |  1 +
>   target/sh4/cpu.h       |  4 ++++
>   target/sh4/op_helper.c | 16 ++++++++++++++++
>   target/sh4/translate.c |  6 ++++--
>   4 files changed, 25 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
