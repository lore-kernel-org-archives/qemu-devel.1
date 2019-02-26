Received: from eggs.gnu.org ([209.51.188.92]:59326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyhOq-0003rG-IR
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:24:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyhOp-0008Od-QO
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:24:16 -0500
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a]:38806)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyhOp-0008Nn-Hn
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 13:24:15 -0500
Received: by mail-pg1-x52a.google.com with SMTP id m2so6602491pgl.5
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 10:24:15 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-2-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aa52d2ef-536e-a39f-51ec-40e9b04b8c95@linaro.org>
Date: Tue, 26 Feb 2019 10:24:10 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 01/33] s390x/tcg: Define vector
 instruction formats
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

On 2/26/19 3:38 AM, David Hildenbrand wrote:
> These are the new instruction formats related to vector instructions as
> up to the z14 (a.k.a. latest PoP).
> 
> As v2 appeares (like x2 in VRX) with d2/b2 in VRV, we have to assign it a
> higher field number to avoid collisions.
> 
> Properly take care of the MSB (to be able to address 32 registers) for
> each vector register field stored in the RXB field (Bit 36 - 30  for all
> vector instructions). As we have 32 bit vector registers and the
> "v" fields are only 4 bit in size, the 5th bit is stored in the RXB.
> We use a new type to indicate that the MSB has to be fetched from the
> RXB.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-format.def | 25 +++++++++++++++++++++++
>  target/s390x/translate.c     | 39 +++++++++++++++++++++++++++++++++++-
>  2 files changed, 63 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
