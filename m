Received: from eggs.gnu.org ([209.51.188.92]:42630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBXu-0006aT-KX
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hFBXt-0007OZ-OY
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:49:46 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:33123)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hFBXt-0007Nn-Ek
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 01:49:45 -0400
Received: by mail-pl1-x62d.google.com with SMTP id t16so6117232plo.0
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 22:49:45 -0700 (PDT)
References: <20190411100836.646-1-david@redhat.com>
	<20190411100836.646-35-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <45b58bee-214e-2683-c9f5-3153c177ecd4@linaro.org>
Date: Fri, 12 Apr 2019 19:49:40 -1000
MIME-Version: 1.0
In-Reply-To: <20190411100836.646-35-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 34/41] s390x/tcg: Implement VECTOR
 SUBTRACT
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
> We can use tcg_gen_sub2_i64() to do 128-bit subtraction and otherwise
> existing gvec helpers.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 17 +++++++++++++++++
>  2 files changed, 19 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
