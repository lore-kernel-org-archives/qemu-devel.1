Received: from eggs.gnu.org ([2001:4830:134:3::10]:41047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYwcU-0005Uu-3N
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:23:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gYwcT-00005n-8j
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 12:23:54 -0500
References: <20181217122405.18732-1-mark.cave-ayland@ilande.co.uk>
	<20181217122405.18732-5-mark.cave-ayland@ilande.co.uk>
	<2bd3dead-354e-31ca-bc19-fb1ed3191f15@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <1d0b9d9d-4979-7136-fc50-fb8355d50336@ilande.co.uk>
Date: Mon, 17 Dec 2018 17:23:36 +0000
MIME-Version: 1.0
In-Reply-To: <2bd3dead-354e-31ca-bc19-fb1ed3191f15@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 4/9] target/ppc: delay writeback of
 avr{l, h} during lvx instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

On 17/12/2018 16:46, Richard Henderson wrote:

> On 12/17/18 4:24 AM, Mark Cave-Ayland wrote:
>> During review of the previous patch, Richard pointed out an existing bug that
>> the writeback to the avr{l,h} registers should be delayed until after any
>> exceptions have been raised.
>>
>> Perform both 64-bit loads into separate temporaries and then write them into
>> the avr{l,h} registers together to ensure that this is always the case.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  target/ppc/translate/vmx-impl.inc.c | 24 +++++++++++++-----------
>>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> I feel a bit silly.  There was no bug, since the address is forced to be
> aligned on a 16-byte boundary.  The second memory access will be to the same
> page and cannot trap.
> 
> That said, I think the cleanup looks good.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Ah okay. I'm inclined to drop this patch for now, since it feels strange introducing
a cleanup to just one of the load functions...


ATB,

Mark.
