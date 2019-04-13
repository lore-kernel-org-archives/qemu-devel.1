Received: from eggs.gnu.org ([209.51.188.92]:59128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6f0-00075z-LO
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:36:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hF6ez-0003lt-N3
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:36:46 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hF6ez-0003in-Ay
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 20:36:45 -0400
Received: by mail-pg1-x542.google.com with SMTP id y3so5919406pgk.12
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 17:36:45 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-31-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0fabfadd-5e7b-9b7d-2512-f81ba95f1cb6@linaro.org>
Date: Fri, 12 Apr 2019 14:36:39 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-31-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 30/41] s390x/tcg: Implement VECTOR SHIFT
 LEFT (BY BYTE)
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
> We can reuse the existing 128-bit shift utility function.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  1 +
>  target/s390x/insn-data.def      |  4 ++++
>  target/s390x/translate_vx.inc.c | 20 ++++++++++++++++++++
>  target/s390x/vec_int_helper.c   |  6 ++++++
>  4 files changed, 31 insertions(+)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
