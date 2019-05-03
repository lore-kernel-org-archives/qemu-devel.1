Received: from eggs.gnu.org ([209.51.188.92]:49831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMQhd-0006fF-2E
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:25:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMQhc-0007B0-7x
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:25:45 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMQhc-0007AT-2P
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:25:44 -0400
Received: by mail-pl1-x643.google.com with SMTP id e92so2146602plb.6
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 22:25:43 -0700 (PDT)
References: <20190502141019.6385-1-david@redhat.com>
	<20190502141019.6385-28-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9161ba93-fad8-c74b-3f49-71659f9f6017@linaro.org>
Date: Thu, 2 May 2019 22:25:39 -0700
MIME-Version: 1.0
In-Reply-To: <20190502141019.6385-28-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 27/40] s390x/tcg: Implement VECTOR
 ELEMENT ROTATE AND INSERT UNDER MASK
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

On 5/2/19 7:10 AM, David Hildenbrand wrote:
> Use the new vector expansion for GVecGen3i.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 51 +++++++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 20 +++++++++++++
>  4 files changed, 75 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
