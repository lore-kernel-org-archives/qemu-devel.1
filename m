Received: from eggs.gnu.org ([2001:4830:134:3::10]:54082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeP3X-0001ro-Oy
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eeP3U-0005pE-BF
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:41:51 -0500
Received: from mail-pf0-x22c.google.com ([2607:f8b0:400e:c00::22c]:34533)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eeP3U-0005oe-5D
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 12:41:48 -0500
Received: by mail-pf0-x22c.google.com with SMTP id e76so3650481pfk.1
	for <qemu-devel@nongnu.org>; Wed, 24 Jan 2018 09:41:48 -0800 (PST)
References: <20180124131315.30567-1-alex.bennee@linaro.org>
	<20180124131315.30567-20-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <57ab078a-049b-72e7-5bc5-f73a3c947b45@linaro.org>
Date: Wed, 24 Jan 2018 09:41:44 -0800
MIME-Version: 1.0
In-Reply-To: <20180124131315.30567-20-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 19/22] fpu/softfloat: re-factor scalbn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 01/24/2018 05:13 AM, Alex Bennée wrote:
> +/* Multiply A by 2 raised to the power N.  */
> +static FloatParts scalbn_decomposed(FloatParts a, int n,
> +                                          float_status *s)
> +{
> +    if (a.cls == float_class_normal) {
> +        a.exp += n;
> +    }
> +    return a;
> +}

...

> -    if ( aExp == 0x7FF ) {
> -        if ( aSig ) {
> -            return propagateFloat64NaN(a, a, status);

This is where we used to raise inexact.
In the new function we need to handle this as in round_to_int.


r~
