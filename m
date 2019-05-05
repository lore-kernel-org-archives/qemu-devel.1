Received: from eggs.gnu.org ([209.51.188.92]:44499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNDze-0005yQ-RU
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:03:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNDzd-0007pW-R2
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:03:38 -0400
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-7-mark.cave-ayland@ilande.co.uk>
	<5a60992b-d6db-4761-38fa-bb413f69d3ae@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <0bc1c469-5148-2594-4b14-c44542699ea9@ilande.co.uk>
Date: Sun, 5 May 2019 11:03:27 +0100
MIME-Version: 1.0
In-Reply-To: <5a60992b-d6db-4761-38fa-bb413f69d3ae@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 06/14] target/ppc: introduce
 GEN_VSX_HELPER_X2_AB macro to fpu_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 30/04/2019 17:41, Richard Henderson wrote:

> On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
>> Rather than perform the VSR register decoding within the helper itself,
>> introduce a new GEN_VSX_HELPER_X2_AB macro which performs the decode based
>> upon xA and xB at translation time.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  target/ppc/fpu_helper.c             | 15 ++++++---------
>>  target/ppc/helper.h                 | 12 ++++++------
>>  target/ppc/translate/vsx-impl.inc.c | 30 ++++++++++++++++++++++++------
>>  3 files changed, 36 insertions(+), 21 deletions(-)
> 
> This time I see VSX_TDIV right away as a place that still
> uses opcode.  It can certainly be cleaned up, but that's
> a different patch.

Right, and also helper_xscmpexpdp() and VSX_SCALAR_CMP() which is all of the helpers
touched here. Perhaps one to think about since if this macro isn't used anywhere else
after I've reworked the series to use separate gen/helper functions then probably it
makes sense not to bother with this one.


ATB,

Mark.
