Received: from eggs.gnu.org ([2001:4830:134:3::10]:44421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS5kI-0003Cr-50
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:06:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS5kD-0001vq-6R
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:06:50 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS5kD-0001vA-29
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 14:06:45 -0400
Received: by mail-qt0-x242.google.com with SMTP id m54so21835631qtb.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 11:06:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170703162328.24474-1-laurent@vivier.eu>
	<20170703162328.24474-2-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <360ae6b7-15b6-64d7-54cc-85318b5b83d4@twiddle.net>
Date: Mon, 3 Jul 2017 11:06:40 -0700
MIME-Version: 1.0
In-Reply-To: <20170703162328.24474-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/4] softfloat: use floatx80_infinity in
 softfloat
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

On 07/03/2017 09:23 AM, Laurent Vivier wrote:
> Since f3218a8 ("softfloat: add floatx80 constants")
> floatx80_infinity is defined but never used.
> 
> This patch updates floatx80 functions to use
> this definition.
> 
> This allows to define a different default Infinity
> value on m68k: the m68k FPU defines infinity with
> all bits set to zero in the mantissa.
> 
> Signed-off-by: Laurent Vivier<laurent@vivier.eu>
> ---
>   fpu/softfloat-specialize.h | 14 ++++++++++++++
>   fpu/softfloat.c            | 38 ++++++++++++++++++++++++++------------
>   include/fpu/softfloat.h    |  9 +++++++--
>   3 files changed, 47 insertions(+), 14 deletions(-)

Reviewed-by: Richard Henderson <rth@twiddle.net>


r~
