Received: from eggs.gnu.org ([209.51.188.92]:57485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF3qc-00069v-Tv
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:36:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF3qY-0000El-O4
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:36:32 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF3qV-0000Ct-2a
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:36:29 -0400
Received: by mail-pg1-x543.google.com with SMTP id j26so5781810pgl.5
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 14:36:26 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b3a0517f-2f5b-d56c-d3f6-627f479f58af@linaro.org>
Date: Fri, 12 Apr 2019 11:36:20 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 04/41] s390x/tcg: Implement VECTOR ADD
 WITH CARRY
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

On 4/11/19 12:07 AM, David Hildenbrand wrote:
> Only slightly ugly, perform two additions. At least it is only supported
> for 128 bit elements.
> 
> Introduce gen_gvec128_4_i64() similar to gen_gvec128_3_i64().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 63 +++++++++++++++++++++++++++++++++
>  2 files changed, 65 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
