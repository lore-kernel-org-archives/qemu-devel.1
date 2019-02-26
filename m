Received: from eggs.gnu.org ([209.51.188.92]:60123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyhRV-0004vV-4a
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:27:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyhRR-0002wc-NA
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:26:59 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45754)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyhRI-0002pm-9s
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:26:49 -0500
Received: by mail-pf1-x443.google.com with SMTP id v21so6620112pfm.12
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 10:26:47 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-3-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3bb4f237-8dcf-aeb8-0305-03d69b4e79b5@linaro.org>
Date: Tue, 26 Feb 2019 10:26:43 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-3-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 02/33] s390x/tcg: Check vector register
 instructions at central point
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

On 2/26/19 3:38 AM, David Hildenbrand wrote:
> Check them at a central point. We'll use a new instruction flag to
> flag all vector instructions (IF_VEC) and handle it very similar to
> AFP, whereby we use another unused position in the PSW mask to store
> the state of vector register enablement per translation block.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cpu.h       |  7 +++++++
>  target/s390x/translate.c | 12 ++++++++++++
>  2 files changed, 19 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
