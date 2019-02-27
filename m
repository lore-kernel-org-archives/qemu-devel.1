Received: from eggs.gnu.org ([209.51.188.92]:35594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8DF-0003wi-Hq
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8D2-0002AE-2Z
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:01:56 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:32934)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8D0-00027p-6K
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:01:50 -0500
Received: by mail-pl1-x642.google.com with SMTP id y10so8753929plp.0
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:01:49 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-10-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b4a72e0b-9116-eae4-a586-d55acaaa3890@linaro.org>
Date: Wed, 27 Feb 2019 07:40:29 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 09/33] s390x/tcg: Implement VECTOR LOAD
 AND REPLICATE
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
> We can use tcg_gen_gvec_dup_i64() to carry out the duplication.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
