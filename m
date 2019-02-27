Received: from eggs.gnu.org ([209.51.188.92]:41284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8il-0000GU-SK
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:34:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8ik-0006Ad-Hi
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:34:39 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:39810)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8ik-00068a-3z
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:34:38 -0500
Received: by mail-pf1-x42c.google.com with SMTP id i20so8754184pfo.6
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:34:37 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-24-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e5a93b57-9049-e26f-7f30-a0a0404ed6fd@linaro.org>
Date: Wed, 27 Feb 2019 15:26:29 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-24-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 23/33] s390x/tcg: Implement VECTOR
 PERMUTE DOUBLEWORD IMMEDIATE
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
> Read the whole input before modifying the destination vector.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 16 ++++++++++++++++
>  2 files changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
