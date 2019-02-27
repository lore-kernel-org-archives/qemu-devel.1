Received: from eggs.gnu.org ([209.51.188.92]:43697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8uw-0007dB-04
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:47:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8uu-0003RW-CJ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:47:13 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:32786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8ut-0003Pe-KA
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:47:11 -0500
Received: by mail-pg1-x541.google.com with SMTP id h11so8749275pgl.0
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:47:11 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-31-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f0af712e-3d1b-3ccf-2d25-5f0e85cd5dbb@linaro.org>
Date: Wed, 27 Feb 2019 15:47:07 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-31-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 30/33] s390x/tcg: Implement VECTOR STORE
 ELEMENT
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
> As we only store one element, there is nothing to consider regarding
> exceptions.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  5 +++++
>  target/s390x/translate_vx.inc.c | 18 ++++++++++++++++++
>  2 files changed, 23 insertions(+)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
