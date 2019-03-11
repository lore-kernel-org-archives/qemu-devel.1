Received: from eggs.gnu.org ([209.51.188.92]:35162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1h3MNV-0005Yq-DS
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:58:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1h3MNU-0002rw-MG
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:58:09 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:43176)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1h3MNU-0002pe-CA
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:58:08 -0400
Received: by mail-pf1-x441.google.com with SMTP id q17so3871512pfh.10
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 07:58:08 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190310003428.11723-1-f4bug@amsat.org>
	<20190310003428.11723-7-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <4b08a03a-e5ab-3e7c-7335-6d78539614d3@twiddle.net>
Date: Mon, 11 Mar 2019 07:58:04 -0700
MIME-Version: 1.0
In-Reply-To: <20190310003428.11723-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 6/6] target/m68k: Reduce the scope of the
 'zero' tcg_temp
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
>      if (left) {
> +        TCGv zero = tcg_const_i32(0);
>          tcg_gen_mov_i32(shl, shift);      /* shl = shift */
>          tcg_gen_movi_i32(shr, size + 1);
>          tcg_gen_sub_i32(shr, shr, shift); /* shr = size + 1 - shift */
>          tcg_gen_subi_i32(shx, shift, 1);  /* shx = shift - 1 */
>          /* shx = shx < 0 ? size : shx; */
> -        zero = tcg_const_i32(0);
>          tcg_gen_movcond_i32(TCG_COND_LT, shx, shx, zero, sz, shx);
> -        tcg_temp_free(zero);
> +        tcg_temp_free_i32(zero);

But you're extending its lifetime.

r~
