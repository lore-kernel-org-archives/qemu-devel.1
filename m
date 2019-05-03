Received: from eggs.gnu.org ([209.51.188.92]:55706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMRCr-0000m4-UR
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMRCr-0005Oy-1W
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:58:01 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:46072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMRCq-0005Oo-QS
	for qemu-devel@nongnu.org; Fri, 03 May 2019 01:58:00 -0400
Received: by mail-pg1-x543.google.com with SMTP id i21so2184424pgi.12
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 22:58:00 -0700 (PDT)
References: <20190502141019.6385-1-david@redhat.com>
	<20190502141019.6385-35-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a2d14b29-e162-54f2-a44f-09630212c63b@linaro.org>
Date: Thu, 2 May 2019 22:57:56 -0700
MIME-Version: 1.0
In-Reply-To: <20190502141019.6385-35-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 34/40] s390x/tcg: Implement VECTOR
 SUBTRACT COMPUTE BORROW INDICATION
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
> Let's keep it simple for now and handle 8/16 bit elements via helpers.
> Especially for 8/16, we could come up with some bit tricks.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 52 +++++++++++++++++++++++++++++++++
>  target/s390x/vec_int_helper.c   | 16 ++++++++++
>  4 files changed, 72 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
