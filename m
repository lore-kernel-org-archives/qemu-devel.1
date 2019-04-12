Received: from eggs.gnu.org ([209.51.188.92]:45517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5QE-0006Pi-29
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:17:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5QD-0002UJ-6S
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:17:26 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d]:39876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5QC-0002Ss-O7
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:17:25 -0400
Received: by mail-pg1-x52d.google.com with SMTP id k3so5872839pga.6
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:17:24 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-12-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <846737e8-f010-44de-6757-ac09b130696f@linaro.org>
Date: Fri, 12 Apr 2019 13:17:19 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-12-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 11/41] s390x/tcg: Implement VECTOR
 COMPARE *
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
> To carry out the comparison, we can reuse the existing gvec comparison
> function. In case the CC is to be computed, save the result vector
> and compute the CC lazily. The result is a vector consisting of all 1's
> for elements that matched and 0's for elements that didn't match.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cc_helper.c        | 17 +++++++++++++++++
>  target/s390x/helper.c           |  1 +
>  target/s390x/insn-data.def      |  6 ++++++
>  target/s390x/internal.h         |  1 +
>  target/s390x/translate.c        |  1 +
>  target/s390x/translate_vx.inc.c | 28 ++++++++++++++++++++++++++++
>  6 files changed, 54 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
