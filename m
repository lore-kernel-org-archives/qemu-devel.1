Received: from eggs.gnu.org ([2001:4830:134:3::10]:54289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dKRyD-0008Fh-Da
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:13:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dKRyA-0005IS-Nj
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:13:37 -0400
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:34235)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dKRyA-0005I9-IZ
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 12:13:34 -0400
Received: by mail-qt0-x243.google.com with SMTP id o21so27456007qtb.1
	for <qemu-devel@nongnu.org>; Mon, 12 Jun 2017 09:13:31 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170611231633.32582-1-laurent@vivier.eu>
	<20170611231633.32582-5-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <48fecf30-cc95-de46-e4a7-50f94dd1d49b@twiddle.net>
Date: Mon, 12 Jun 2017 09:13:27 -0700
MIME-Version: 1.0
In-Reply-To: <20170611231633.32582-5-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 4/7] target-m68k: move fmove CR to a
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 06/11/2017 04:16 PM, Laurent Vivier wrote:
> Move code of fmove to/from control register to a function
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>   target/m68k/translate.c | 66 ++++++++++++++++++++++++++++++-------------------
>   1 file changed, 41 insertions(+), 25 deletions(-)

In that this is 100% code movement,

Reviewed-by: Richard Henderson <rth@twiddle.net>


> +            cpu_abort(NULL, "Unimplemented: fmove from control %d", mask);
> +            goto undef;

But cpu_abort doesn't return, and will exit qemu.
This should be qemu_log_mask(LOG_UNIMP, ...).


r~
