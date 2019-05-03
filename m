Received: from eggs.gnu.org ([209.51.188.92]:36441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMP9m-0002Cx-Ns
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMP9l-0004Xl-PR
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:46:42 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:37679)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMP9l-0004Wv-JA
	for qemu-devel@nongnu.org; Thu, 02 May 2019 23:46:41 -0400
Received: by mail-pf1-x442.google.com with SMTP id g3so2199193pfi.4
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 20:46:41 -0700 (PDT)
References: <20190502141019.6385-1-david@redhat.com>
	<20190502141019.6385-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bab51b97-8cec-ed85-594d-e63c9a5fe6c8@linaro.org>
Date: Thu, 2 May 2019 20:46:38 -0700
MIME-Version: 1.0
In-Reply-To: <20190502141019.6385-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 04/40] s390x/tcg: Implement VECTOR ADD
 WITH CARRY COMPUTE CARRY
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

On 5/2/19 7:09 AM, David Hildenbrand wrote:
> Similar to VECTOR ADD COMPUTE CARRY, however 128-bit handling only.
> Courtesy of Richard H.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 32 ++++++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~
