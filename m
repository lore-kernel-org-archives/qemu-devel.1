Received: from eggs.gnu.org ([209.51.188.92]:42901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gteKr-0008Pn-QQ
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gteKq-00068q-W3
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:07:17 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:35433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gteKq-00066h-FI
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:07:16 -0500
Received: by mail-pf1-x443.google.com with SMTP id z15so1070186pfa.2
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 12:07:16 -0800 (PST)
References: <20190212110308.13707-1-david@redhat.com>
	<20190212110308.13707-13-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ed4fe0f2-411d-70fb-d08a-f387e3d80a41@linaro.org>
Date: Tue, 12 Feb 2019 12:07:12 -0800
MIME-Version: 1.0
In-Reply-To: <20190212110308.13707-13-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 11/15] s390x/tcg: Prepare for
 IEEE-inexact-exception control (XxC)
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

On 2/12/19 3:03 AM, David Hildenbrand wrote:
> Some instructions allow to suppress IEEE inexact exceptions.
> 
> z14 PoP, 9-23, "Suppression of Certain IEEE Exceptions"
>     IEEE-inexact-exception control (XxC): Bit 1 of
>     the M4 field is the XxC bit. If XxC is zero, recogni-
>     tion of IEEE-inexact exception is not suppressed;
>     if XxC is one, recognition of IEEE-inexact excep-
>     tion is suppressed.
> 
> Especially, handling for overflow/unerflow remains as is, inexact is
> reported along
> 
> z14 PoP, 9-23, "Suppression of Certain IEEE Exceptions"
>     For example, the IEEE-inexact-exception control (XxC)
>     has no effect on the DXC; that is, the DXC for IEEE-
>     overflow or IEEE-underflow exceptions along with the
>     detail for exact, inexact and truncated, or inexact and
>     incremented, is reported according to the actual con-
>     dition.
> 
> Follow up patches will wire it correctly up for the applicable
> instructions.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/fpu_helper.c | 112 +++++++++++++++++++-------------------
>  1 file changed, 56 insertions(+), 56 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
