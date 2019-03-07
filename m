Received: from eggs.gnu.org ([209.51.188.92]:39060)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1tZV-0001Q4-Sn
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:00:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1tZR-0006hd-0R
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:00:29 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:34965)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1tZQ-0006eO-Dv
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:00:24 -0500
Received: by mail-pg1-x542.google.com with SMTP id e17so11336772pgd.2
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 06:00:24 -0800 (PST)
References: <20190307121539.12842-1-david@redhat.com>
	<20190307121539.12842-4-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f0bd00c0-2e67-44f1-0ced-1c18a78d99db@linaro.org>
Date: Thu, 7 Mar 2019 06:00:19 -0800
MIME-Version: 1.0
In-Reply-To: <20190307121539.12842-4-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 03/32] s390x/tcg: Utilities for vector
 instruction helpers
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

On 3/7/19 4:15 AM, David Hildenbrand wrote:
> We'll have to read/write vector elements quite frequently from helpers.
> The tricky bit is properly taking care of endianess. Handle it similar
> to aarch64.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/vec.h | 101 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
>  create mode 100644 target/s390x/vec.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
