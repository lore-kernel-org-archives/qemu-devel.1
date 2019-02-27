Received: from eggs.gnu.org ([209.51.188.92]:35711)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8DQ-00044G-W7
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8DP-0002So-Tx
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:16 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8DP-0002Lw-ID
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:15 -0500
Received: by mail-pg1-x542.google.com with SMTP id l11so8668371pgq.10
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:02:07 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-14-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d21b7c5f-8c54-6fde-84c5-a0799ad61142@linaro.org>
Date: Wed, 27 Feb 2019 07:56:43 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-14-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 13/33] s390x/tcg: Implement VECTOR LOAD
 LOGICAL ELEMENT AND ZERO
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

On 2/26/19 3:38 AM, David Hildenbrand wrote:
> +    zero_vec(TMP_VREG_0);
> +    load_vec_element(s, TMP_VREG_0, enr, o->addr1, es);
> +    gen_gvec_mov(get_field(s->fields, v1), TMP_VREG_0);

load into TCGv_i64, zero real dest, store into real dest.


r~
