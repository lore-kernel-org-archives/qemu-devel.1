Received: from eggs.gnu.org ([2001:4830:134:3::10]:49693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epKR2-0002kl-Ce
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 15:59:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1epKQz-0007ID-Bd
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 15:59:16 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:33088)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1epKQz-0007HS-4W
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 15:59:13 -0500
Received: by mail-pg0-x243.google.com with SMTP id g12so3807003pgs.0
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 12:59:12 -0800 (PST)
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-39-richard.henderson@linaro.org>
	<CAFEAcA8pcZL=zkjQBZjswznKdU6z4L7h5-So3Wwkwfpg++jPAQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <30d86f9d-2fa9-dda2-4acc-7331b48b395c@linaro.org>
Date: Fri, 23 Feb 2018 12:59:09 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8pcZL=zkjQBZjswznKdU6z4L7h5-So3Wwkwfpg++jPAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 38/67] target/arm: Implement
 SVE Partition Break Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 02/23/2018 08:41 AM, Peter Maydell wrote:
> On 17 February 2018 at 18:22, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/helper-sve.h    |  18 ++++
>>  target/arm/sve_helper.c    | 247 +++++++++++++++++++++++++++++++++++++++++++++
>>  target/arm/translate-sve.c |  96 ++++++++++++++++++
>>  target/arm/sve.decode      |  19 ++++
>>  4 files changed, 380 insertions(+)
> 
> 
>> +        b = g & n;            /* guard true, pred true*/
> 
> missing space before */
> 
>> +/* Given a computation function, compute a merging BRK.  */
>> +static void compute_brk_m(uint64_t *d, uint64_t *n, uint64_t *g,
>> +                          intptr_t oprsz, bool after)
> 
> Comment says "given a computation function" but the prototype
> doesn't take a function as parameter ?

Whoops, old comment.  FWIW, it did at one point.


r~
