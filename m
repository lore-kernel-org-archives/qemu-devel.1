Received: from eggs.gnu.org ([209.51.188.92]:42372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBWY-0005qo-6X
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBWX-0006Ye-84
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:48:22 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:38973)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFBWW-0006Y6-KH
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:48:21 -0400
Received: by mail-pf1-x443.google.com with SMTP id i17so6119983pfo.6
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 22:48:20 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-33-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a5addbcf-5e3d-7b27-1540-69f026726d86@linaro.org>
Date: Fri, 12 Apr 2019 19:48:13 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-33-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 32/41] s390x/tcg: Implement VECTOR SHIFT
 RIGHT ARITHMETIC
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
> Similar to VECTOR SHIFT LEFT ARITHMETIC. Add s390_vec_sar() similar to
> s390_vec_shr().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  1 +
>  target/s390x/insn-data.def      |  4 ++++
>  target/s390x/translate_vx.inc.c | 17 +++++++++++++++++
>  target/s390x/vec_int_helper.c   | 26 ++++++++++++++++++++++++++
>  4 files changed, 48 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
