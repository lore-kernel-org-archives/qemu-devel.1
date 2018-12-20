Received: from eggs.gnu.org ([2001:4830:134:3::10]:56088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ga1Yf-00059i-FA
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 11:52:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1ga1YZ-00042r-69
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 11:52:24 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-12-richard.henderson@linaro.org>
	<20181219061529.GG30570@umbus.fritz.box>
	<2336e34c-37a1-67e2-68a0-4a85f0c674f6@ilande.co.uk>
Message-ID: <bc0bea12-10a4-e2d3-5538-96cf0e470787@ilande.co.uk>
Date: Thu, 20 Dec 2018 16:52:05 +0000
MIME-Version: 1.0
In-Reply-To: <2336e34c-37a1-67e2-68a0-4a85f0c674f6@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 11/34] target/ppc: introduce get_fpr() and
 set_fpr() helpers for FP register access
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 19/12/2018 12:29, Mark Cave-Ayland wrote:

> On 19/12/2018 06:15, David Gibson wrote:
> 
>> On Mon, Dec 17, 2018 at 10:38:48PM -0800, Richard Henderson wrote:
>>> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>>
>>> These helpers allow us to move FP register values to/from the specified TCGv_i64
>>> argument in the VSR helpers to be introduced shortly.
>>>
>>> To prevent FP helpers accessing the cpu_fpr array directly, add extra TCG
>>> temporaries as required.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>> Message-Id: <20181217122405.18732-2-mark.cave-ayland@ilande.co.uk>
>>
>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>>
>> Do you want me to take these, or will you take them via your tree?
> 
> Well as discussed yesterday with Richard, I've already found another couple of bugs
> in this version: a sign-extension bug, plus some leaking temporaries so there will at
> least need to be a v3 of my patches.
> 
> I'm wondering if it makes sense for me to pass the 2 vector operation conversion
> patches over to Richard, and for you to take my v3 patchset that does all the
> groundwork separately first?

So this is the approach I've gone for - I've dropped my TCG vector conversion patches
from the previous iteration, and posted v3 with all my latest fixes as a separate
"prepare for conversion to TCG vector operations" patchset.

Richard - I've rebased your "tcg, target/ppc vector improvements" patchset on top of
my v3 patchset and pushed to https://github.com/mcayland/qemu/commits/ppc-altivec-rth
to make it easier for us both to test.

Note that the 2 TCG vector conversion patches I originally created for v2 are now
included as part of your patchset instead (including a squash of your "target/ppc:
nand, nor, eqv are now generic vector operations" patch).


ATB,

Mark.
