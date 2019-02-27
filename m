Received: from eggs.gnu.org ([209.51.188.92]:41317)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8in-0000I7-IE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:34:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8im-0006E4-R1
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:34:41 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40094)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8im-0006DA-GD
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:34:40 -0500
Received: by mail-pl1-x643.google.com with SMTP id bj4so8759782plb.7
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:34:40 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-25-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <46273279-a74f-69ae-d6d4-b4ffa15260af@linaro.org>
Date: Wed, 27 Feb 2019 15:29:25 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-25-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 24/33] s390x/tcg: Implement VECTOR
 REPLICATE
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
> Load the element and replicate it using gvec_dup.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 18 ++++++++++++++++++
>  2 files changed, 20 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
