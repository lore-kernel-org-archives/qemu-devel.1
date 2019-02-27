Received: from eggs.gnu.org ([209.51.188.92]:43174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8re-00066m-Te
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:43:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8rd-0006jy-AQ
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:43:50 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8ra-0006UB-Cq
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:43:46 -0500
Received: by mail-pg1-x541.google.com with SMTP id 196so8714798pgf.13
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:43:42 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-29-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a484fd5d-a46f-c531-1000-6a3f4742e31f@linaro.org>
Date: Wed, 27 Feb 2019 15:43:38 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-29-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 28/33] s390x/tcg: Implement VECTOR SIGN
 EXTEND TO DOUBLEWORD
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
> Load both elements signed and store them into the two 64 bit elements.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
