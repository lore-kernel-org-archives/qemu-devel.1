Received: from eggs.gnu.org ([209.51.188.92]:50270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5tg-0006ex-7z
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF5te-00010I-Ff
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:47:52 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:41738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF5tb-0000tS-Hw
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 19:47:49 -0400
Received: by mail-pf1-x442.google.com with SMTP id 188so5840845pfd.8
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 16:47:39 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-17-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c8a27981-380c-cbe0-7a55-fd45b412e8e4@linaro.org>
Date: Fri, 12 Apr 2019 13:47:33 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-17-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 16/41] s390x/tcg: Implement VECTOR LOAD
 COMPLEMENT
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
> We can reuse an existing gvec helper for negating the values.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
