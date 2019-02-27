Received: from eggs.gnu.org ([209.51.188.92]:38295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8NV-00036a-Oe
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:12:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8NU-0002OZ-J3
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:12:41 -0500
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:44888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8NS-0001oa-U0
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:12:40 -0500
Received: by mail-pg1-x542.google.com with SMTP id j3so8672988pgm.11
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:12:00 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-21-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e9be57a6-b639-39fa-2ec9-9f5cb52f954a@linaro.org>
Date: Wed, 27 Feb 2019 15:11:56 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-21-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 20/33] s390x/tcg: Implement VECTOR PACK
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

On 2/26/19 3:39 AM, David Hildenbrand wrote:
> We cannot use gvex expansion as the element size of source and
> destination differs. So expand manually. Luckily, VECTOR PACK does not
> care about saturation or setting the CC, so it can be implemented
> without a helper. We have to watch out for overlapping source and
> destination registers and use a temporary register in this case.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 41 +++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
