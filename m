Received: from eggs.gnu.org ([209.51.188.92]:50780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5wI-0007OH-O6
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:50:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5wH-0002Iq-Pp
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:50:34 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5wH-0002Hm-Cq
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:50:33 -0400
Received: by mail-pf1-x443.google.com with SMTP id b3so5865063pfd.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:50:32 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-18-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <baebe333-5e28-9fd3-adef-7027c166a599@linaro.org>
Date: Fri, 12 Apr 2019 13:50:27 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-18-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 17/41] s390x/tcg: Implement VECTOR LOAD
 POSITIVE
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
> Similar to VECTOR LOAD COMPLEMENT but unfortunately we don't have a
> gvec helper.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 40 +++++++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 14 ++++++++++++
>  4 files changed, 58 insertions(+)

I would be happy to add ABS as a gvec primitive, if you like.
Expandable with MAX or CMP on hosts without ABS.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
