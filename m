Received: from eggs.gnu.org ([209.51.188.92]:46857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBwW-000616-5g
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:15:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBwV-0000TY-Dg
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:15:12 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:44989)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFBwV-0000T9-4b
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:15:11 -0400
Received: by mail-pg1-x529.google.com with SMTP id i2so6168993pgj.11
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 23:15:10 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-39-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <372cdc7f-08b8-4856-cd6f-d6d67381ef29@linaro.org>
Date: Fri, 12 Apr 2019 20:15:05 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-39-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 38/41] s390x/tcg: Implement VECTOR SUM
 ACROSS DOUBLEWORD
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
> Perform the calculations without a helper. Only 16 bit or 32 bit values
> have to be added.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
