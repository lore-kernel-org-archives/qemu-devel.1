Received: from eggs.gnu.org ([209.51.188.92]:47247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBz0-0007Iv-55
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFByz-0001Y2-3m
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:17:46 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:43444)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFByy-0001W0-Ol
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:17:45 -0400
Received: by mail-pl1-x642.google.com with SMTP id n8so6111149plp.10
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 23:17:44 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-40-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <606f01ca-f4db-068d-7dcb-c1c7925a9216@linaro.org>
Date: Fri, 12 Apr 2019 20:17:38 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-40-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 39/41] s390x/tcg: Implement VECTOR SUM
 ACROSS QUADWORD
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
> +    read_vec_element_i64(suml, get_field(s->fields, v3), max_idx, es);
> +    for (idx = 0; idx <= max_idx; idx++) {
> +        read_vec_element_i64(tmpl, get_field(s->fields, v2), idx, es);
> +        tcg_gen_add2_i64(suml, sumh, suml, sumh, tmpl, zero);
> +    }
> +    write_vec_element_i64(sumh, get_field(s->fields, v1), 0, ES_64);
> +    write_vec_element_i64(suml, get_field(s->fields, v1), 1, ES_64);

It's a long way around for ES_32, as there will never be overflow into bit 65.
 But I guess it's not wrong.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
