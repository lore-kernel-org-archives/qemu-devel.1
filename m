Received: from eggs.gnu.org ([209.51.188.92]:40027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsCjy-00022e-6b
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:27:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gsCjs-0006Qk-SV
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:27:13 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gsCjs-0006Pg-Ks
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:27:08 -0500
Received: by mail-pf1-x442.google.com with SMTP id j3so2186889pfi.12
	for <qemu-devel@nongnu.org>; Fri, 08 Feb 2019 12:27:08 -0800 (PST)
References: <20190208163727.13733-1-remi@remlab.net>
	<8f51cf7f-ba18-a123-e31d-a95d18918cb8@linaro.org>
	<2034657.8N3RCfXzMK@basile.remlab.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <85b56507-bc4b-a4fc-18a3-d45569f19968@linaro.org>
Date: Fri, 8 Feb 2019 12:27:04 -0800
MIME-Version: 1.0
In-Reply-To: <2034657.8N3RCfXzMK@basile.remlab.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] tcg: assert last byte is in guest space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?R=c3=a9mi_Denis-Courmont?= <remi@remlab.net>, qemu-devel@nongnu.org

On 2/8/19 10:32 AM, Rémi Denis-Courmont wrote:
> Le perjantaina 8. helmikuuta 2019, 20.12.13 EET Richard Henderson a écrit :
>> On 2/8/19 8:37 AM, Rémi Denis-Courmont wrote:
>>> Rather than assert that the first byte of a checked range is within the
>>> guest address space, assert that the last byte is. The assertion is
>>> moved past the overflow check to ensure that the last byte is actually
>>> the one with the highest address.
>>>
>>> Signed-off-by: Rémi Denis-Courmont <remi@remlab.net>
>>> ---
>>>
>>>  accel/tcg/translate-all.c | 14 +++++++-------
>>>  1 file changed, 7 insertions(+), 7 deletions(-)
>>
>> What are you trying to fix here?
> 
> As far as I can tell, the following code assumes that the entire range of 
> checked addresses falls within the guest address range. So it makes sense to 
> fail the assertion if the any byte is out of range, rather than only the first 
> one.

Sure.  But that would call for adding a second assert, rather than removing one
from some paths.  Which you say you "would not dare", which is confusing to me.

Is there a particular problem you are attempting to solve, or is this mere code
inspection?


r~
