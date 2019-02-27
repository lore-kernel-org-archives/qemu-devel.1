Received: from eggs.gnu.org ([209.51.188.92]:42615)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8od-0004Su-MI
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:40:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gz8ob-0007t5-PD
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:40:43 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46031)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gz8ob-0007de-9n
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 18:40:41 -0500
Received: by mail-pg1-x544.google.com with SMTP id y4so8700734pgc.12
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 15:40:35 -0800 (PST)
References: <20190226113915.20150-1-david@redhat.com>
	<20190226113915.20150-27-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9bd1de91-6cc5-dd99-4fe9-479d1cf28c34@linaro.org>
Date: Wed, 27 Feb 2019 15:40:30 -0800
MIME-Version: 1.0
In-Reply-To: <20190226113915.20150-27-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 26/33] s390x/tcg: Implement VECTOR
 SCATTER ELEMENT
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
> Similar to VECTOR GATHER ELEMENT, but the other direction.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/insn-data.def      |  3 +++
>  target/s390x/translate_vx.inc.c | 22 ++++++++++++++++++++++
>  2 files changed, 25 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
