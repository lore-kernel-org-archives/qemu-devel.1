Received: from eggs.gnu.org ([209.51.188.92]:36149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hL8VW-00047L-9x
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hL8VV-0007fx-Cm
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:47:54 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hL8VV-0007db-3m
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 11:47:53 -0400
Received: by mail-pf1-x443.google.com with SMTP id w25so5497426pfi.9
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 08:47:52 -0700 (PDT)
References: <20190328230404.12909-1-richard.henderson@linaro.org>
	<20190328230404.12909-37-richard.henderson@linaro.org>
	<CAFEAcA-an2BRh+Ji0y-6P9e_3=Z22CDVSMJ1RAEXefa-MFZdFw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fdd4967a-7e65-1497-9377-456232f12d00@linaro.org>
Date: Mon, 29 Apr 2019 08:42:55 -0700
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-an2BRh+Ji0y-6P9e_3=Z22CDVSMJ1RAEXefa-MFZdFw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2 36/36] tcg/arm: Use LDRD to load
 tlb mask+table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 4/29/19 8:00 AM, Peter Maydell wrote:
> On Thu, 28 Mar 2019 at 23:23, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  tcg/arm/tcg-target.inc.c | 109 +++++++++++++++++++--------------------
>>  1 file changed, 52 insertions(+), 57 deletions(-)
> 
> I think this would be easier to understand if the commit message
> included what the old and new generated code fragments looked like.

Fair enough.  This change is complicated by having
to rearrange register usage, so that we ldrd into r0+r1
instead of ldr into r1+r2, etc.  Just this once it would
have been easier in thumb2.  ;-)

> The same remark about a compile-time check that mask and
> table are where we expect from patch 35 applies here too.

Ok.


r~
