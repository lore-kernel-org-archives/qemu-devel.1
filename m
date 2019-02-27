Received: from eggs.gnu.org ([209.51.188.92]:41236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8ik-0000GD-PI
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:34:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8ij-00069Z-WE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:34:38 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8ij-00062w-Hb
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:34:37 -0500
Received: by mail-pf1-x442.google.com with SMTP id g6so8738113pfh.13
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:34:32 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-23-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <65e35aaa-70a1-0357-c7b2-8c1c0c54d1a4@linaro.org>
Date: Wed, 27 Feb 2019 15:21:38 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-23-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 22/33] s390x/tcg: Implement VECTOR
 PERMUTE
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
> Take care of overlying inputs and outputs by using a temporary vector.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  1 +
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 12 ++++++++++++
>  target/s390x/vec_helper.c       | 20 ++++++++++++++++++++
>  4 files changed, 35 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
