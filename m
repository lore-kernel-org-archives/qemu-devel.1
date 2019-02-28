Received: from eggs.gnu.org ([209.51.188.92]:47500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz9QM-0004jJ-TU
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:19:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz9QL-00017G-BF
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:19:42 -0500
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:41923)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz9QK-00074W-6O
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 19:19:40 -0500
Received: by mail-pf1-x430.google.com with SMTP id d25so8799176pfn.8
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 16:18:56 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-34-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9c8913f5-76b6-1175-5574-19f19d1e8eef@linaro.org>
Date: Wed, 27 Feb 2019 16:03:53 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-34-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 33/33] s390x/tcg: Implement VECTOR
 UNPACK *
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
> Combine all variant in a single handler. As source and destination
> have different element sizes, we can't use gvec expansion. Expand
> manually. Also watch out for overlapping source and destination and
> use a temporary register in that case.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  8 +++++++
>  target/s390x/translate_vx.inc.c | 41 +++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)

This works as is, so
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

But the same comment applies wrt iteration order and not needing a temporary.
High unpack can iterate backward, while low unpack can iterate forward, with no
lost data.


r~
