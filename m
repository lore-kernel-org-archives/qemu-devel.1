Received: from eggs.gnu.org ([209.51.188.92]:34440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtcb3-00025J-0V
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:15:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtcZ0-0005Zl-CP
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:13:47 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:37391)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtcYv-0004co-3D
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 13:13:42 -0500
Received: by mail-pg1-x543.google.com with SMTP id q206so1620436pgq.4
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 10:13:11 -0800 (PST)
References: <20190212110308.13707-1-david@redhat.com>
	<20190212110308.13707-6-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b646aacd-ca2e-42c7-7b91-f7ffcb3ee18c@linaro.org>
Date: Tue, 12 Feb 2019 10:13:07 -0800
MIME-Version: 1.0
In-Reply-To: <20190212110308.13707-6-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 04/15] s390x/tcg: Fix parts of IEEE
 exception handling
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
> Many things are wrong and some parts cannot be fixed yet. Fix what we
> can fix easily and add two FIXMEs:
> 
> The fpc flags are not updated in case an exception is actually injected.
> Inexact exceptions have to be handled separately, as they are the only
> exceptions that can coexist with underflows and overflows.
> 
> I reread the horribly complicated chapters in the PoP at least 5 times
> and hope I got it right.
> 
> For references:
> - z14 PoP, 9-18, "IEEE Exceptions"
> - z14 PoP, 19-9, Figure 19-8
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/fpu_helper.c | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
