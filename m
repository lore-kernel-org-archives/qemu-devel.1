Received: from eggs.gnu.org ([209.51.188.92]:44249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcTp-0007jH-4m
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hGcTo-00064i-9O
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:47:29 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:39230)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hGcTn-00064B-ST
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 00:47:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id k3so11403464pga.6
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 21:47:27 -0700 (PDT)
References: <20190416185301.25344-1-david@redhat.com>
	<20190416185301.25344-29-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b50e9346-f917-1b7d-0ceb-f0c171e8e9ce@linaro.org>
Date: Tue, 16 Apr 2019 18:47:22 -1000
MIME-Version: 1.0
In-Reply-To: <20190416185301.25344-29-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 28/41] s390x/tcg: Implement VECTOR
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

On 4/16/19 8:52 AM, David Hildenbrand wrote:
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
