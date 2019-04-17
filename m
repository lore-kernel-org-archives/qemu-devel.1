Received: from eggs.gnu.org ([209.51.188.92]:42760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcK1-0005XP-PL
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:37:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcK0-0001j0-Rw
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:37:21 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:43764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGcK0-0001iI-Fd
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:37:20 -0400
Received: by mail-pf1-x442.google.com with SMTP id c8so11459478pfd.10
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 21:37:20 -0700 (PDT)
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d00846cc-9571-484e-58ab-7dc78a8bc8d0@linaro.org>
Date: Tue, 16 Apr 2019 18:37:15 -1000
MIME-Version: 1.0
In-Reply-To: <20190416185301.25344-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 05/41] s390x/tcg: Implement VECTOR ADD
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

On 4/16/19 8:52 AM, David Hildenbrand wrote:
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
