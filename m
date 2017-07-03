Received: from eggs.gnu.org ([2001:4830:134:3::10]:37323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS6qa-00021A-Pa
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:17:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS6qX-0007HJ-Mi
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:17:24 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS6qX-0007Gu-Gy
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:17:21 -0400
Received: by mail-qk0-x244.google.com with SMTP id v143so12331423qkb.3
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 12:17:21 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
References: <20170703162328.24474-1-laurent@vivier.eu>
	<20170703162328.24474-3-laurent@vivier.eu>
	<255de989-982c-273e-55d1-0940a60169c2@twiddle.net>
Message-ID: <ce19bb9a-45cc-d4d8-0321-79e5561f5924@twiddle.net>
Date: Mon, 3 Jul 2017 12:17:16 -0700
MIME-Version: 1.0
In-Reply-To: <255de989-982c-273e-55d1-0940a60169c2@twiddle.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] target/m68k: add FPU trigonometric
 instructions
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

On 07/03/2017 12:11 PM, Richard Henderson wrote:
>    if (floatx80_to_ldouble(&d, val))) {
>      d = sinl(d);
>      val = ldouble_to_floatx80(d, status);
>    } else {
>      status->float_exception_flags |= float_flag_invalid;
>      val = floatx80_default_nan(status);
>    }

Blah.  I didn't mean default_nan here, but use floatx80_maybe_silence_nan on 
the original input to the output.


r~
