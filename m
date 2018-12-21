Received: from eggs.gnu.org ([2001:4830:134:3::10]:39911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gaSqz-0006r0-M3
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 17:01:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gaSqw-0003ob-Hp
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 17:01:09 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gaSqw-0003nd-2d
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 17:01:06 -0500
Received: by mail-pl1-x643.google.com with SMTP id u18so3055271plq.7
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 14:01:05 -0800 (PST)
References: <20181220111008.24954-1-alex.bennee@linaro.org>
	<20181221193037.GB11197@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <72dff278-24d4-61db-3b49-a50a5aec6448@linaro.org>
Date: Fri, 21 Dec 2018 14:01:02 -0800
MIME-Version: 1.0
In-Reply-To: <20181221193037.GB11197@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH] fpu: add compile time check for old
 glibc/libm and fma
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: laurent.desnogues@gmail.com, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 12/21/18 11:30 AM, Emilio G. Cota wrote:
> +    ua.s = 0x0020000000000001;
> +    ub.s = 0x3ca0000000000000;
> +    uc.s = 0x0020000000000000;
> +    ur.h = fma(ua.h, ub.h, uc.h);
> +    if (ur.s != 0x0020000000000001) {

Forgot your ull's, but otherwise ok.

In email to Alex, I did wonder if we should check for fma hardware (at least on
x86).  Without a hardware insn, the libm routine is probably no faster than
softmmu.


r~
