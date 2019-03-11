Received: from eggs.gnu.org ([209.51.188.92]:35538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1h3MOs-0006iB-2f
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:59:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1h3MOq-0003dc-TL
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:59:34 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33707)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1h3MOq-0003dA-JA
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:59:32 -0400
Received: by mail-pg1-x544.google.com with SMTP id h11so4246631pgl.0
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 07:59:32 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190310003428.11723-1-f4bug@amsat.org>
	<20190310003428.11723-6-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <d49bf2d2-8c5b-0d00-188e-1ba92571aa28@twiddle.net>
Date: Mon, 11 Mar 2019 07:59:28 -0700
MIME-Version: 1.0
In-Reply-To: <20190310003428.11723-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 5/6] target/m68k: Optimize rotate_x() using
 extract_i32()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org

On 3/9/19 4:34 PM, Philippe Mathieu-Daudé wrote:
> Optimize rotate_x() using tcg_gen_extract_i32(). We can now free the
> 'sz' tcg_temp earlier. Since it is allocated with tcg_const_i32(),
> free it with tcg_temp_free_i32().
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  target/m68k/translate.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
