Received: from eggs.gnu.org ([209.51.188.92]:35820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8DX-00049k-S7
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8DS-0002YK-UE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:19 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:39956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8DS-0002W9-Ig
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:18 -0500
Received: by mail-pl1-x641.google.com with SMTP id bj4so8723249plb.7
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:02:17 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-17-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <268dd993-8a80-d12b-70a9-88e752cf66f4@linaro.org>
Date: Wed, 27 Feb 2019 08:08:52 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-17-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 16/33] s390x/tcg: Implement VECTOR LOAD
 VR ELEMENT FROM GR
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
> Very similar to VECTOR LOAD GR FROM VR ELEMENT, just the opposite
> direction.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 33 +++++++++++++++++++++++++++++++++
>  2 files changed, 35 insertions(+)

Similar comment re constant offset.  ;-)
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
