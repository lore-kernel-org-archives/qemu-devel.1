Received: from eggs.gnu.org ([2001:4830:134:3::10]:53882)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1drT1M-0003Iv-8L
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1drT1I-0000Y6-DO
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:01:20 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:33416)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1drT1I-0000WH-7e
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 14:01:16 -0400
Received: by mail-pg0-x232.google.com with SMTP id u18so7119pgo.0
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 11:01:14 -0700 (PDT)
References: <20170911022839.23231-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1c72c0c6-bd29-5228-d4ad-b26b11afa712@linaro.org>
Date: Mon, 11 Sep 2017 11:01:10 -0700
MIME-Version: 1.0
In-Reply-To: <20170911022839.23231-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg/tci: do not use ldst label (never
 implemented)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>
Cc: qemu-devel@nongnu.org

On 09/10/2017 07:28 PM, Philippe Mathieu-Daudé wrote:
> changed in 659ef5cbb893, this fixes building with --enable-tcg-interpreter:
> 
> /home/travis/build/qemu/qemu/tcg/tcg.c:116:14: error: ‘tcg_out_ldst_finalize’ used but never defined [-Werror]
>  static bool tcg_out_ldst_finalize(TCGContext *s);
>               ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Oops.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
