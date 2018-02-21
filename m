Received: from eggs.gnu.org ([2001:4830:134:3::10]:45444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eobbL-0004b3-Lo
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 16:07:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1eobaH-0007Wb-IT
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 16:06:55 -0500
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1eobaH-0007V4-5u
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 16:05:49 -0500
Received: by mail-pl0-x241.google.com with SMTP id 31so1617192ple.9
	for <qemu-devel@nongnu.org>; Wed, 21 Feb 2018 13:05:49 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <1519246509-4022-1-git-send-email-cota@braap.org>
	<1519246509-4022-2-git-send-email-cota@braap.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <19ddf862-2525-50c0-4375-7c88e7fcebc2@twiddle.net>
Date: Wed, 21 Feb 2018 13:05:45 -0800
MIME-Version: 1.0
In-Reply-To: <1519246509-4022-2-git-send-email-cota@braap.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv3 1/2] translator: merge max_insns into
 DisasContextBase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 02/21/2018 12:55 PM, Emilio G. Cota wrote:
> While at it, use int for both num_insns and max_insns to make
> sure we have same-type comparisons.
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/translator.c     | 21 ++++++++++-----------
>  include/exec/translator.h  |  8 ++++----
>  target/alpha/translate.c   |  6 ++----
>  target/arm/translate-a64.c |  8 +++-----
>  target/arm/translate.c     |  9 +++------
>  target/hppa/translate.c    |  7 ++-----
>  target/i386/translate.c    |  5 +----
>  target/ppc/translate.c     |  5 ++---
>  8 files changed, 27 insertions(+), 42 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
