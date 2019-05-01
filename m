Received: from eggs.gnu.org ([209.51.188.92]:52925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqPC-0000l6-7N
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqP9-000554-5E
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:40:18 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:45682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLqP8-00054F-U4
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:40:15 -0400
Received: by mail-pl1-x642.google.com with SMTP id o5so8265112pls.12
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:40:14 -0700 (PDT)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1b33ac75-d531-1a9d-46ea-f392249e2a19@linaro.org>
Date: Wed, 1 May 2019 07:40:10 -0700
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 05/15] tests/tcg/minilib: support %c
 format char
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org

On 4/30/19 9:52 AM, Alex Bennée wrote:
> @@ -119,6 +119,10 @@ void ml_printf(const char *fmt, ...)
>              str = va_arg(ap, char*);
>              print_str(str);
>              break;
> +        case 'c':
> +            c = (char) va_arg(ap, int);
> +            __sys_outc(c);
> +            break;

The assignment and cast are both unnecessary.
You could just as well write

    __sys_outc(va_arg(ap, int))

but it's not wrong so

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
