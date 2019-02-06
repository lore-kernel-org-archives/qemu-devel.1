Received: from eggs.gnu.org ([209.51.188.92]:53963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grJoQ-0005Xh-2N
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 04:48:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1grJgP-0000lm-Tm
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 04:39:54 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:46838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1grJgP-0000kp-Ks
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 04:39:53 -0500
Received: by mail-wr1-x444.google.com with SMTP id l9so6679250wrt.13
	for <qemu-devel@nongnu.org>; Wed, 06 Feb 2019 01:39:50 -0800 (PST)
References: <20190206091043.10985-1-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b70f98e5-6309-1cb1-6d11-1eaaeff8fc4e@linaro.org>
Date: Wed, 6 Feb 2019 09:39:46 +0000
MIME-Version: 1.0
In-Reply-To: <20190206091043.10985-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] softfloat: add float128_is_{normal,
 denormal}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 2/6/19 9:10 AM, David Hildenbrand wrote:
> Needed on s390x, to test for the data class of a number. So it will
> gain soon a user.
> 
> A number is considered normal if the exponent is neither 0 nor all 1's.
> That can be checked by adding 1 to the exponent, and comparing against
>> = 2 after dropping an eventual overflow into the sign bit.
> While at it, convert the other floatXX_is_normal functions to use a
> similar, less error prone calculation, as suggested by Richard H.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  include/fpu/softfloat.h | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
