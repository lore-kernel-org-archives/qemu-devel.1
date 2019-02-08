Received: from eggs.gnu.org ([209.51.188.92]:60115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsCaD-0001OR-9i
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:17:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsCaB-0000ai-Np
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:17:08 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:42578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsCa7-0007a7-J6
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:17:05 -0500
Received: by mail-pg1-x543.google.com with SMTP id d72so2047279pga.9
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 12:13:48 -0800 (PST)
References: <20190207224258.426-1-mark.cave-ayland@ilande.co.uk>
	<3ed73de0-9d3b-8e7c-cda1-1c759ba969f2@linaro.org>
	<736bf099-de1d-3522-7fff-c8ba93f75277@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b07c6fa3-67ca-d88f-4ccd-cf876e9c0c6e@linaro.org>
Date: Fri, 8 Feb 2019 11:09:30 -0800
MIME-Version: 1.0
In-Reply-To: <736bf099-de1d-3522-7fff-c8ba93f75277@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tcg/i386: fix unsigned vector saturating
 arithmetic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org

On 2/8/19 10:09 AM, Mark Cave-Ayland wrote:
> On 08/02/2019 17:39, Richard Henderson wrote:
> 
>> On 2/7/19 2:42 PM, Mark Cave-Ayland wrote:
>>> Due to a cut/paste error in the original implementation, the unsigned vector
>>> saturating arithmetic was erroneously being calculated as signed vector saturating
>>> arithmetic.
>>>
>>> Fixes: 8ffafbcec2 ("tcg/i386: Implement vector saturating arithmetic")
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> ---
>>>  tcg/i386/tcg-target.inc.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> Ooof.  Thanks.
> 
> AFAICT none of the other TCG backends currently make use of it, but it was this bug
> causing the graphical corruption that myself and Howard saw testing the PPC vector
> patchset.

I would have seen the error if I had done ARM SVE regression testing.
But I only did ARM NEON testing, which does not make use of this, and
I had forgotten that.

Like PPC, NEON sets a "saw saturation" bit.  I think I'll do the same
trick as we did for ppc to compute that with vector insns.


> FWIW I've now rebased and repushed the outstanding patches from your patchset along
> with this fix to https://github.com/mcayland/qemu/commits/ppc-altivec-v6 as it would
> be great if this could make it into 4.0.

I've given all of my r-b...


r~
