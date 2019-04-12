Received: from eggs.gnu.org ([209.51.188.92]:33189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF4D2-0003LY-33
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF4D1-00054S-3h
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:59:44 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533]:44352)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF4D0-00053k-Mr
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 17:59:43 -0400
Received: by mail-pg1-x533.google.com with SMTP id i2so5794243pgj.11
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 14:59:42 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-7-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <36247480-36e1-e1ea-c58e-93fe9c472a20@linaro.org>
Date: Fri, 12 Apr 2019 11:59:37 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 06/41] s390x/tcg: Implement VECTOR AND
 (WITH COMPLEMENT)
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
> Easy, as we can reuse existing gvec helpers.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  4 ++++
>  target/s390x/translate_vx.inc.c | 14 ++++++++++++++
>  2 files changed, 18 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
