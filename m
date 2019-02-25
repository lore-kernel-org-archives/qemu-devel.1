Received: from eggs.gnu.org ([209.51.188.92]:48665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyIfR-0006f8-Aw
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gyIfQ-0004Ku-O3
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:59:45 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:33049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gyIfQ-0004Jc-Dm
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:59:44 -0500
Received: by mail-pl1-x62d.google.com with SMTP id y10so4718281plp.0
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 07:59:44 -0800 (PST)
References: <20190225115552.7534-1-david@redhat.com>
	<20190225115552.7534-7-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <062d1997-7af7-d504-65bd-da191a091038@linaro.org>
Date: Mon, 25 Feb 2019 07:59:40 -0800
MIME-Version: 1.0
In-Reply-To: <20190225115552.7534-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 6/7] s390x/tcg: Implement LOAD
 LENGTHENED short HFP to long HFP
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

On 2/25/19 3:55 AM, David Hildenbrand wrote:
> Nice trick to load a 32 bit value into vector element 0 (32 bit element
> size) from memory, zeroing out element1. The short HFP to long HFP
> conversion really only is a shift.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def | 2 ++
>  target/s390x/translate.c   | 6 ++++++
>  2 files changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
