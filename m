Received: from eggs.gnu.org ([209.51.188.92]:34390)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtcap-0001uX-C2
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:15:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtca7-0006pm-QQ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:14:56 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:33549)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtca7-0006dq-HL
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:14:55 -0500
Received: by mail-pg1-x544.google.com with SMTP id z11so1631648pgu.0
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 10:14:46 -0800 (PST)
References: <20190212110308.13707-1-david@redhat.com>
	<20190212110308.13707-7-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <41289512-aadf-d7a6-64e1-e597d3835697@linaro.org>
Date: Tue, 12 Feb 2019 10:14:42 -0800
MIME-Version: 1.0
In-Reply-To: <20190212110308.13707-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 05/15] s390x/tcg: Hide IEEE underflows
 in some scenarios
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 2/12/19 3:02 AM, David Hildenbrand wrote:
> IEEE underflows are not reported when the mask bit is off and we don't
> also have an inexact exception.
> 
> z14 PoP, 9-20, "IEEE Underflow":
>     An IEEE-underflow exception is recognized for an
>     IEEE target when the tininess condition exists and
>     either: (1) the IEEE-underflow mask bit in the FPC
>     register is zero and the result value is inexact, or (2)
>     the IEEE-underflow mask bit in the FPC register is
>     one.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/fpu_helper.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
