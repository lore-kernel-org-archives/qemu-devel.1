Received: from eggs.gnu.org ([209.51.188.92]:41286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8il-0000GV-UZ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:34:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8ik-0006AF-B9
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:34:39 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8ik-0005wb-23
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:34:38 -0500
Received: by mail-pl1-x641.google.com with SMTP id y10so8790623plp.0
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:34:27 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-22-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <275fd1c1-a911-d527-d492-9aaffbbb6790@linaro.org>
Date: Wed, 27 Feb 2019 15:18:51 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-22-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 21/33] s390x/tcg: Implement VECTOR PACK
 (LOGICAL) SATURATE
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
> We'll implement both via gvec ool helpers. As these can't return
> values, we'll return the CC via env->cc_op. Generate different C
> functions for the different cases using makros.
> 
> In the future we might want to do a translation like VECTOR PACK or
> use separate handlers in case no CC update is needed. As linux does
> not seem to use the function right now, no need to tune for performance.

Fair enough.

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  6 +++
>  target/s390x/insn-data.def      |  4 ++
>  target/s390x/translate_vx.inc.c | 37 ++++++++++++++++
>  target/s390x/vec_helper.c       | 75 +++++++++++++++++++++++++++++++++
>  4 files changed, 122 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
