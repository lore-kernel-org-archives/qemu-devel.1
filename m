Received: from eggs.gnu.org ([209.51.188.92]:44194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF0v1-00086b-9R
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:28:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF0uz-0007lO-Rq
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:28:55 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38983)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF0uy-0007jQ-8J
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 14:28:52 -0400
Received: by mail-pf1-x441.google.com with SMTP id i17so5536118pfo.6
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 11:28:51 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5b6300d8-7a3b-7325-e79c-c2821a3b282c@linaro.org>
Date: Fri, 12 Apr 2019 08:28:45 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 02/41] s390x/tcg: Implement VECTOR ADD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Cornelia Huck <cohuck@redhat.com>

On 4/11/19 12:07 AM, David Hildenbrand wrote:
> Introduce two types of fancy new helpers that will be reused a couple of
> times
> 
> 1. gen_gvec_fn_3: Call an existing tcg_gen_gvec_X function with 3
>    parameters, simplifying parameter passing
> 2. gen_gvec128_3_i64: Call a function that performs 128 bit calculations
>    using two 64 bit values per vector.
> 
> Luckily, for VECTOR ADD we already have everything we need.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  5 ++++
>  target/s390x/translate_vx.inc.c | 52 +++++++++++++++++++++++++++++++++
>  2 files changed, 57 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
