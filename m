Received: from eggs.gnu.org ([209.51.188.92]:42892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8qE-0005Ky-DK
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:42:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8qD-0003HC-RC
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:42:22 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:40195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8qD-0003CW-Eb
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:42:21 -0500
Received: by mail-pl1-x632.google.com with SMTP id bj4so8767974plb.7
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:42:21 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-28-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <4275baaf-f3c4-6a64-46bf-21a0e6d511c6@linaro.org>
Date: Wed, 27 Feb 2019 15:42:17 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-28-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 27/33] s390x/tcg: Implement VECTOR SELECT
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
> +    tcg_gen_not_vec(vece, t, c);
> +    tcg_gen_and_vec(vece, t, t, b);

tcg_gen_andc_vec(t, b, c);

> +    tcg_gen_not_i64(t, c);
> +    tcg_gen_and_i64(t, b, t);

Likewise.


r~
