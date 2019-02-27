Received: from eggs.gnu.org ([209.51.188.92]:35930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8Dw-0004Sv-2c
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8Dv-0002su-07
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:47 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:36275)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8Du-0002pL-EH
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:46 -0500
Received: by mail-pl1-x630.google.com with SMTP id k2so8733128plt.3
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:02:43 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-20-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9e7cf739-8f5d-ac34-abc0-e43876c37337@linaro.org>
Date: Wed, 27 Feb 2019 08:14:53 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-20-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 19/33] s390x/tcg: Implement VECTOR MERGE
 (HIGH|LOW)
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
> We cannot use gvec expansion as source and destination elements are
> have different element numbers. So we'll expand using a fancy loop.
> Also, we have to take care of overlapping source and target registers and
> use a temporary register in case they do.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  4 +++
>  target/s390x/translate_vx.inc.c | 43 +++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
