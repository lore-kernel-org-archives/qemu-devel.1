Received: from eggs.gnu.org ([209.51.188.92]:58228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6aG-0005ey-ET
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6aF-0001Bg-HE
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:31:52 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:33271)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6aF-0001As-3U
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:31:51 -0400
Received: by mail-pg1-x542.google.com with SMTP id k19so5948402pgh.0
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:31:51 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-30-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <07c96b48-c3f9-096c-1cd6-d95bce3c3ccd@linaro.org>
Date: Fri, 12 Apr 2019 14:31:46 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-30-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 29/41] s390x/tcg: Implement VECTOR
 ELEMENT SHIFT
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
> Only for one special case we can reuse real gvec helpers. Mostly
> rely on oom helpers.
> 
> One important thing to take care of is always to properly mask of
> unused bits from the shift count.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  18 +++++
>  target/s390x/insn-data.def      |   9 +++
>  target/s390x/translate_vx.inc.c | 113 ++++++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   |  99 ++++++++++++++++++++++++++++
>  4 files changed, 239 insertions(+)

Again, I should fill out these in gvec...

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
