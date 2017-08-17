Received: from eggs.gnu.org ([2001:4830:134:3::10]:36767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diRBT-000657-Vy
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:14:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1diRBT-0004EZ-5U
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:14:27 -0400
Received: from mail-pg0-x236.google.com ([2607:f8b0:400e:c05::236]:35913)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1diRBS-0004E8-WA
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 16:14:27 -0400
Received: by mail-pg0-x236.google.com with SMTP id i12so49724301pgr.3
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 13:14:26 -0700 (PDT)
References: <20170817180404.29334-1-alex.bennee@linaro.org>
	<20170817180404.29334-7-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <36653cbe-3043-da48-3303-864f07a428bc@linaro.org>
Date: Thu, 17 Aug 2017 13:14:23 -0700
MIME-Version: 1.0
In-Reply-To: <20170817180404.29334-7-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 6/9] target/arm/translate-a64: regnames
 -> x_regnames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, rth@twiddle.net, cota@braap.org, batuzovk@ispras.ru
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 08/17/2017 11:04 AM, Alex Bennée wrote:
> -static const char *regnames[] = {
> +static const char *x_regnames[] = {
>      "x0", "x1", "x2", "x3", "x4", "x5", "x6", "x7",
>      "x8", "x9", "x10", "x11", "x12", "x13", "x14", "x15",
>      "x16", "x17", "x18", "x19", "x20", "x21", "x22", "x23",

Mis-patch?  There should be uses of this array to be renamed too.


r~
