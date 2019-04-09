Received: from eggs.gnu.org ([209.51.188.92]:52419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDki2-0003J9-3T
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:58:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDki1-0008Fx-6O
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:58:18 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434]:42424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hDki0-0008FZ-My
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 02:58:17 -0400
Received: by mail-pf1-x434.google.com with SMTP id w25so7677209pfi.9
	for <qemu-devel@nongnu.org>; Mon, 08 Apr 2019 23:58:16 -0700 (PDT)
References: <20190409060435.22801-1-sw@weilnetz.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4a16a810-9806-3a76-7d17-1b6282296502@linaro.org>
Date: Mon, 8 Apr 2019 20:58:10 -1000
MIME-Version: 1.0
In-Reply-To: <20190409060435.22801-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tci: Fix some unaligned memory accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

On 4/8/19 8:04 PM, Stefan Weil wrote:
>  static tcg_target_ulong tci_read_i(uint8_t **tb_ptr)
>  {
> -    tcg_target_ulong value = *(tcg_target_ulong *)(*tb_ptr);
> +    tcg_target_ulong value;

Ideally these would use the helpers from "qemu/bswap.h", ldl_he_p(), etc.


r~
