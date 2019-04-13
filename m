Received: from eggs.gnu.org ([209.51.188.92]:52845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF69j-00036G-C7
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:04:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF69i-0002LG-EE
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:04:27 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f]:41255)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF69i-0002Ki-4P
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:04:26 -0400
Received: by mail-pl1-x62f.google.com with SMTP id d1so5847249plj.8
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:04:26 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-21-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <940b3c42-5225-c8e0-41be-5ee0df498f39@linaro.org>
Date: Fri, 12 Apr 2019 14:04:20 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-21-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 20/41] s390x/tcg: Implement VECTOR
 MULTIPLY *
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

On 4/11/19 12:08 AM, David Hildenbrand wrote:
> +static void gen_mh_i32(TCGv_i32 d, TCGv_i32 a, TCGv_i32 b)
> +{
> +    TCGv_i64 t0 = tcg_temp_new_i64();
> +    TCGv_i64 t1 = tcg_temp_new_i64();
> +
> +    tcg_gen_ext_i32_i64(t0, a);
> +    tcg_gen_ext_i32_i64(t1, b);
> +    tcg_gen_mul_i64(t0, t0, t1);
> +    tcg_gen_extrh_i64_i32(d, t0);

This is

  tcg_gen_muls2_i32(tmp, d, a, b);

Similarly for mlh w/ mulu2.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
