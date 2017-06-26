Received: from eggs.gnu.org ([2001:4830:134:3::10]:54632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPYil-0006x4-Gu
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:26:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPYig-0003x8-Hx
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:26:47 -0400
Received: from mail-qk0-x22c.google.com ([2607:f8b0:400d:c09::22c]:36070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPYig-0003x1-AV
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 14:26:42 -0400
Received: by mail-qk0-x22c.google.com with SMTP id p21so8095505qke.3
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 11:26:42 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170625192125.9992-1-laurent@vivier.eu>
	<20170625192125.9992-5-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d22a4853-0fc2-f54a-f244-97fabe963be7@twiddle.net>
Date: Mon, 26 Jun 2017 11:26:38 -0700
MIME-Version: 1.0
In-Reply-To: <20170625192125.9992-5-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/7] target/m68k: add explicit single and
 double precision operations
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

On 06/25/2017 12:21 PM, Laurent Vivier wrote:
> Add fssqrt, fdsqrt, fsadd, fdadd, fssub, fdsub, fsmul, fdmul,
> fsdiv, fddiv.
> 
> The precision is managed using set_floatx80_rounding_precision().
> 
> Signed-off-by: Laurent Vivier<laurent@vivier.eu>
> ---
>   target/m68k/fpu_helper.c | 80 ++++++++++++++++++++++++++++++++++++++++++++++++
>   target/m68k/helper.h     | 10 ++++++
>   target/m68k/translate.c  | 40 +++++++++++++++++++++---
>   3 files changed, 125 insertions(+), 5 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
