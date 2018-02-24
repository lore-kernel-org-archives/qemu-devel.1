Received: from eggs.gnu.org ([2001:4830:134:3::10]:39270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1epdb1-0004ON-Fc
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 12:26:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1epdax-0001IY-F7
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 12:26:51 -0500
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:35883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1epdax-0001IK-8K
	for qemu-devel@nongnu.org; Sat, 24 Feb 2018 12:26:47 -0500
Received: by mail-pf0-x22c.google.com with SMTP id 68so4838318pfx.3
	for <qemu-devel@nongnu.org>; Sat, 24 Feb 2018 09:26:47 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20180223145959.18761-1-laurent@vivier.eu>
	<20180223145959.18761-4-laurent@vivier.eu>
	<94ca7b93-4c6e-015e-6c7b-afec3884e212@linaro.org>
	<e25dcf61-9230-6a2c-13b6-5cb979b70e44@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <3788f7c4-4981-4d08-8ba9-d6919caf0ff9@twiddle.net>
Date: Sat, 24 Feb 2018 09:26:42 -0800
MIME-Version: 1.0
In-Reply-To: <e25dcf61-9230-6a2c-13b6-5cb979b70e44@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 3/4] softfloat: use floatx80_infinity in
 softfloat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>

On 02/24/2018 09:21 AM, Laurent Vivier wrote:
> I think the change should be in fact:
> 
> @@ -4549,10 +4555,7 @@ int64_t floatx80_to_int64(floatx80 a,
> float_status *status)
>      if ( shiftCount <= 0 ) {
>          if ( shiftCount ) {
>              float_raise(float_flag_invalid, status);
> -            if (    ! aSign
> -                 || (    ( aExp == 0x7FFF )
> -                      && ( aSig != LIT64( 0x8000000000000000 ) ) )
> -               ) {
> +            if (!aSign || floatx80_is_any_nan(a)) {
>                  return LIT64( 0x7FFFFFFFFFFFFFFF );
>              }
>              return (int64_t) LIT64( 0x8000000000000000 );
> 
> Do you agree?

Yep, looks good.


r~
