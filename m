Received: from eggs.gnu.org ([2001:4830:134:3::10]:53727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPwkJ-0004r7-45
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:05:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPwkF-0006Y9-Ue
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:05:59 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:36228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPwkF-0006Xm-Or
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 16:05:55 -0400
Received: by mail-qt0-x22c.google.com with SMTP id i2so33863492qta.3
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 13:05:55 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170627191221.31650-1-laurent@vivier.eu>
	<20170627191221.31650-6-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <bdcb1df3-0098-ba3c-1d63-bc2a40459de3@twiddle.net>
Date: Tue, 27 Jun 2017 13:05:52 -0700
MIME-Version: 1.0
In-Reply-To: <20170627191221.31650-6-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 5/7] target/m68k: add fsglmul and fsgldiv
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 06/27/2017 12:12 PM, Laurent Vivier wrote:
> fsglmul and fsgldiv truncate data to single precision before computing
> results.
> 
> Signed-off-by: Laurent Vivier<laurent@vivier.eu>
> ---
>   target/m68k/fpu_helper.c | 28 ++++++++++++++++++++++++++++
>   target/m68k/helper.h     |  2 ++
>   target/m68k/translate.c  |  6 ++++++
>   3 files changed, 36 insertions(+)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
