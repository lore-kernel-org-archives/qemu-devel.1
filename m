Received: from eggs.gnu.org ([209.51.188.92]:49685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5qo-0005Ij-RF
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5qn-0006ON-UZ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:44:54 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:46684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5qn-0006L2-AL
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:44:53 -0400
Received: by mail-pf1-x441.google.com with SMTP id 9so5822420pfj.13
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:44:53 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-16-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1365cc84-fdb6-3a36-9b5f-6921f04423e0@linaro.org>
Date: Fri, 12 Apr 2019 13:44:46 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-16-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 15/41] s390x/tcg: Implement VECTOR
 GALOIS FIELD MULTIPLY SUM (AND ACCUMULATE)
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
> A galois field multiplication in field 2 is like binary multiplication,
> however instead of doing ordinary binary additions, xor's are performed.
> So no carries are considered.
> 
> Implement all variants via helpers. s390_vec_sar() and s390_vec_shr()
> will be reused later on.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |   8 ++
>  target/s390x/insn-data.def      |   4 +
>  target/s390x/translate_vx.inc.c |  38 ++++++++
>  target/s390x/vec_int_helper.c   | 168 ++++++++++++++++++++++++++++++++
>  4 files changed, 218 insertions(+)

FYI, this is now the 4th copy of this operation.

  arm: pmull
  x86: pclmulqdq
  ppc: vpmsum[bhwd]

We really should promote this to generic.  But that can come later,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
