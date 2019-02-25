Received: from eggs.gnu.org ([209.51.188.92]:46452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyIZy-0001ha-6N
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:54:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyIZx-0008MW-AL
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:54:06 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42593)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyIZw-00086y-W5
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:54:05 -0500
Received: by mail-pf1-x443.google.com with SMTP id n74so4680155pfi.9
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 07:53:44 -0800 (PST)
References: <20190225115552.7534-1-david@redhat.com>
	<20190225115552.7534-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5b958dce-1a57-7be6-f5fe-f24ca7cae7f2@linaro.org>
Date: Mon, 25 Feb 2019 07:53:41 -0800
MIME-Version: 1.0
In-Reply-To: <20190225115552.7534-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 5/7] s390x/tcg: Factor out
 gen_addi_and_wrap_i64() from get_address()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>

On 2/25/19 3:55 AM, David Hildenbrand wrote:
> Also properly wrap in 24bit mode. While at it, convert the comment (and
> drop the comment about fundamental TCG optimizations).
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/translate.c | 41 +++++++++++++++++++++++++---------------
>  1 file changed, 26 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

> +static inline void gen_addi_and_wrap_i64(DisasContext *s, TCGv_i64 dst,
> +                                         TCGv_i64 src, int64_t imm)

I would drop the inline and let the compiler choose.
I'm using very few explicit inline markers these days...


r~
