Received: from eggs.gnu.org ([209.51.188.92]:48831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtegC-0001bE-8f
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:29:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gtegB-00068K-Bv
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:29:20 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gtegA-00061b-Ey
	for qemu-devel@nongnu.org; Tue, 12 Feb 2019 15:29:18 -0500
Received: by mail-pl1-x641.google.com with SMTP id w4so17964plz.1
	for <qemu-devel@nongnu.org>; Tue, 12 Feb 2019 12:29:17 -0800 (PST)
References: <20190212110308.13707-1-david@redhat.com>
	<20190212110308.13707-16-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <50596abc-8e65-8dcf-2b35-65991bdf209b@linaro.org>
Date: Tue, 12 Feb 2019 12:29:13 -0800
MIME-Version: 1.0
In-Reply-To: <20190212110308.13707-16-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 14/15] s390x/tcg: Handle all rounding
 modes overwritten by BFP instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>

On 2/12/19 3:03 AM, David Hildenbrand wrote:
> PoP describes "Round to nearest with ties away from 0" as
>   "The candidate nearest to the input value is selected. In case of a tie,
>    the candidate selected is the one that is larger in magnitude."
> 
> While float_round_ties_away is according to the introducing commit
> f9288a76f181 ("softfloat: Add support for ties-away rounding")
>   "roundTiesToAway: the floating-point number nearest to the infinitely
>    precise result shall be delivered; if the two nearest floating-point
>    numbers bracketing an unrepresentable infinitely precise result are
>    equally near, the one with larger magnitude shall be delivered."
> 
> So this could be it if we're lucky ;)

Yep, that's right.

> 
> Handle "round to prepare for shorter precision" just as when setting it
> via SET FLOATING POINT and friends.
> 
> As all instructions properly check for valid rounding modes in translate.c
> we can add an assert. Fix one missing empty line.
> 
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
