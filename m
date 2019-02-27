Received: from eggs.gnu.org ([209.51.188.92]:35910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8Dv-0004Rf-1s
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8Dt-0002rd-VM
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:46 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:44919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8Dt-0002id-5k
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:45 -0500
Received: by mail-pf1-x441.google.com with SMTP id a3so8704718pff.11
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:02:33 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-19-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f33485ef-58c9-dd61-6ab2-aacf840d5712@linaro.org>
Date: Wed, 27 Feb 2019 08:12:37 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-19-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 18/33] s390x/tcg: Implement VECTOR LOAD
 WITH LENGTH
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
> We can reuse the helper introduced along with VECTOR LOAD TO BLOCK
> BOUNDARY. We just have to take care of converting the highest index into
> a length.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate.c        |  7 +++++++
>  target/s390x/translate_vx.inc.c | 13 +++++++++++++
>  3 files changed, 22 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
