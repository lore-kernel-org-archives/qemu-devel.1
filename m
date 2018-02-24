Received: from eggs.gnu.org ([2001:4830:134:3::10]:42591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1epjBk-0003Ut-Gz
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 18:25:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1epjBg-0006DR-9v
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 18:25:08 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:44309)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1epjBg-0006DD-3Y
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 18:25:04 -0500
Received: by mail-pg0-x243.google.com with SMTP id l4so4765392pgp.11
	for <qemu-devel@nongnu.org>; Sat, 24 Feb 2018 15:25:03 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180224201802.911-1-laurent@vivier.eu>
	<20180224201802.911-4-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <6a42ae16-2db7-0427-dc26-c758de14e2a4@twiddle.net>
Date: Sat, 24 Feb 2018 15:24:59 -0800
MIME-Version: 1.0
In-Reply-To: <20180224201802.911-4-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 3/4] softfloat: use floatx80_infinity in
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
Cc: Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>

On 02/24/2018 12:18 PM, Laurent Vivier wrote:
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
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> CC: Aurelien Jarno <aurelien@aurel32.net>
>     v4: fix floatx80_to_int64() to check for NaN, not for infinity
>         fix floatx80_is_infinity() to ignore mantissa's MSB
> 
>  fpu/softfloat-specialize.h | 14 ++++++++++++++
>  fpu/softfloat.c            | 39 +++++++++++++++++++++++++--------------
>  include/fpu/softfloat.h    | 13 +++++++++++--
>  3 files changed, 50 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
