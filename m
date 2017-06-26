Received: from eggs.gnu.org ([2001:4830:134:3::10]:39032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPcxF-0007Im-4W
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:58:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dPcxC-0004hn-4J
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:58:01 -0400
Received: from mail-qt0-x236.google.com ([2607:f8b0:400d:c0d::236]:34872)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dPcxB-0004hf-Vf
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 18:57:58 -0400
Received: by mail-qt0-x236.google.com with SMTP id f92so12830161qtb.2
	for <qemu-devel@nongnu.org>; Mon, 26 Jun 2017 15:57:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170626220330.6785-1-laurent@vivier.eu>
	<20170626220330.6785-6-laurent@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <379fda79-9fdf-7559-1b81-dbd8df0bbfe2@twiddle.net>
Date: Mon, 26 Jun 2017 15:57:54 -0700
MIME-Version: 1.0
In-Reply-To: <20170626220330.6785-6-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 5/7] target/m68k: add fsglmul and fsgldiv
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

On 06/26/2017 03:03 PM, Laurent Vivier wrote:
> +void HELPER(fsglmul)(CPUM68KState *env, FPReg *res, FPReg *val0, FPReg *val1)
> +{
> +    floatx80 a, b;
> +
> +    PREC_BEGIN(32);
> +    a = floatx80_round(val0->d, &env->fp_status);
> +    b = floatx80_round(val1->d, &env->fp_status);
> +    res->d = floatx80_mul(a, b, &env->fp_status);
> +    PREC_END();
> +}
> +

You need to set the rounding mode to truncate for the first two operations.


r~
