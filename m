Received: from eggs.gnu.org ([209.51.188.92]:47538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFC0N-0007wn-7B
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:19:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFC0M-0002eW-B1
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:19:11 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:33851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFC0L-0002dw-Ug
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 02:19:10 -0400
Received: by mail-pf1-x42d.google.com with SMTP id b3so6155981pfd.1
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 23:19:09 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-41-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d1a4039a-2bdf-8fdf-63db-80ba699523cf@linaro.org>
Date: Fri, 12 Apr 2019 20:19:04 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-41-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 40/41] s390x/tcg: Implement VECTOR SUM
 ACROSS WORD
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
> Similar to VECTOR SUM ACROSS DOUBLEWORD.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 29 +++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
