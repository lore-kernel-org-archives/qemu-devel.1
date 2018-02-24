Received: from eggs.gnu.org ([2001:4830:134:3::10]:51172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epPXo-0000ij-Ly
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 21:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epPXj-0006fZ-Q5
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 21:26:36 -0500
Received: from mail-pl0-x243.google.com ([2607:f8b0:400e:c01::243]:39912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epPXj-0006fD-Hz
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 21:26:31 -0500
Received: by mail-pl0-x243.google.com with SMTP id s13so5949588plq.6
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 18:26:31 -0800 (PST)
References: <20180223145959.18761-1-laurent@vivier.eu>
	<20180223145959.18761-4-laurent@vivier.eu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <94ca7b93-4c6e-015e-6c7b-afec3884e212@linaro.org>
Date: Fri, 23 Feb 2018 18:26:26 -0800
MIME-Version: 1.0
In-Reply-To: <20180223145959.18761-4-laurent@vivier.eu>
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
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 02/23/2018 06:59 AM, Laurent Vivier wrote:
> @@ -4550,8 +4556,8 @@ int64_t floatx80_to_int64(floatx80 a, float_status *status)
>          if ( shiftCount ) {
>              float_raise(float_flag_invalid, status);
>              if (    ! aSign
> -                 || (    ( aExp == 0x7FFF )
> -                      && ( aSig != LIT64( 0x8000000000000000 ) ) )
> +                 || ((aExp == floatx80_infinity_high)
> +                     && (aSig != floatx80_infinity_low))
>                 ) {

As long as you're cleaning this up, m68k ignores the explicit integer bit when
considering an infinity.  However, Intel doesn't ignore the bit -- it appears
to treat 7fff.0* as a NaN.


r~
