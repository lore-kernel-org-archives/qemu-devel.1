Received: from eggs.gnu.org ([2001:4830:134:3::10]:35941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekDDb-00012k-3g
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ekDDY-0007X8-42
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:16:15 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:41254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ekDDX-0007Wo-Ue
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 13:16:12 -0500
Received: by mail-pg0-x242.google.com with SMTP id t4so3071541pgp.8
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 10:16:11 -0800 (PST)
References: <20180208173157.24705-1-alex.bennee@linaro.org>
	<20180208173157.24705-28-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0d8edd6d-663c-786c-c2b6-d96e76333550@linaro.org>
Date: Fri, 9 Feb 2018 10:15:29 -0800
MIME-Version: 1.0
In-Reply-To: <20180208173157.24705-28-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 27/32] arm/helper.c: re-factor rsqrte
 and add rsqrte_f16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

On 02/08/2018 09:31 AM, Alex Bennée wrote:
> Much like recpe the ARM ARM has simplified the pseudo code for the
> calculation which is done on a fixed point 9 bit integer maths. So
> while adding f16 we can also clean this up to be a little less heavy
> on the floating point and just return the fractional part and leave
> the calle's to do the final packing of the result.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - checkpatch fixes
> ---
>  target/arm/helper.c | 221 ++++++++++++++++++++++++----------------------------
>  target/arm/helper.h |   1 +
>  2 files changed, 104 insertions(+), 118 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
