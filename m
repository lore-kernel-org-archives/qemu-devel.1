Received: from eggs.gnu.org ([209.51.188.92]:34726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1h3MMs-0004sd-1p
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:57:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1h3MEc-0006e3-KM
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:48:59 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:42514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1h3MEc-0006dj-Di
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 10:48:58 -0400
Received: by mail-pf1-x441.google.com with SMTP id n74so3855256pfi.9
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 07:48:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20190310003428.11723-1-f4bug@amsat.org>
	<20190310003428.11723-4-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <ae0cdd2d-9172-ef52-6191-82f7081f9f04@twiddle.net>
Date: Mon, 11 Mar 2019 07:48:54 -0700
MIME-Version: 1.0
In-Reply-To: <20190310003428.11723-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/6] target/m68k: Fix a tcg_temp leak
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
> The function gen_get_ccr() returns a tcg_temp created with
> tcg_temp_new(). Free it with tcg_temp_free().
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> Laurent/Richard, feel free to squash this with the next patch, but
> IMHO having it split as a previous step makes the next patch easier
> to review.
> ---
>  target/m68k/translate.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
