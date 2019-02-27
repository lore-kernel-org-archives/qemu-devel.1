Received: from eggs.gnu.org ([209.51.188.92]:42277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8ni-0003hw-3V
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:39:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8nh-000625-8N
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:39:46 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41884)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8ng-0005RS-RI
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:39:45 -0500
Received: by mail-pl1-x642.google.com with SMTP id y5so8767814plk.8
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:39:24 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-26-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f76916bb-ef7e-e734-e675-2f2d520c1ee3@linaro.org>
Date: Wed, 27 Feb 2019 15:39:19 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-26-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 25/33] s390x/tcg: Implement VECTOR
 REPLICATE IMMEDIATE
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

On 2/26/19 3:39 AM, David Hildenbrand wrote:
> +    tmp = tcg_temp_new_i64();
> +    tcg_gen_movi_i64(tmp, data);
> +    gen_gvec_dup_i64(es, get_field(s->fields, v1), tmp);
> +    tcg_temp_free_i64(tmp);
> +    return DISAS_NEXT;

Reuse the dupi8, dupi16, ... switch from one of the other patches upthread?


r~
