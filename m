Received: from eggs.gnu.org ([209.51.188.92]:35871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8Dt-0004Q3-54
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8Dr-0002pk-SX
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:44 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:36325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8Dj-0002bN-Jm
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:02:40 -0500
Received: by mail-pl1-x642.google.com with SMTP id k2so8732750plt.3
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:02:24 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-18-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2fa6533d-f120-9be7-736e-e0b12e8f3d1a@linaro.org>
Date: Wed, 27 Feb 2019 08:10:02 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-18-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 17/33] s390x/tcg: Implement VECTOR LOAD
 VR FROM GRS DISJOINT
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
> Fairly easy, just load from to gprs into a single vector.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      | 2 ++
>  target/s390x/translate_vx.inc.c | 7 +++++++
>  2 files changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
