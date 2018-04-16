Received: from eggs.gnu.org ([2001:4830:134:3::10]:47409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f89yy-0004wu-Ce
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 15:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1f89yu-0006HN-JA
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 15:40:08 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:40585)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1f89yu-0006Gq-CR
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 15:40:04 -0400
Received: by mail-pg0-x229.google.com with SMTP id e9so3195488pgr.7
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 12:40:03 -0700 (PDT)
References: <20180416135442.30606-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <614d4cef-07d2-f025-1039-2577be467c71@linaro.org>
Date: Mon, 16 Apr 2018 09:39:57 -1000
MIME-Version: 1.0
In-Reply-To: <20180416135442.30606-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] fpu/softfloat: check for Inf / x or 0 / x
 before /0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

On 04/16/2018 03:54 AM, Alex Bennée wrote:
> +    /* Inf / x or 0 / x */
> +    if (a.cls == float_class_inf || a.cls == float_class_zero) {
> +        a.sign = sign;
> +        return a;
> +    }

0/0 should raise an exception.

I find inf/0 non-intuitive, but there ya go.

r~
