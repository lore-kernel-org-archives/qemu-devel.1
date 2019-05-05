Received: from eggs.gnu.org ([209.51.188.92]:45080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNE2E-0007U7-01
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hNE2C-00027T-Pq
	for qemu-devel@nongnu.org; Sun, 05 May 2019 06:06:17 -0400
References: <20190428143845.11810-1-mark.cave-ayland@ilande.co.uk>
	<20190428143845.11810-8-mark.cave-ayland@ilande.co.uk>
	<cbd76a77-6545-73f0-53d8-57a119372568@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <6d0387c7-994a-77a9-2a82-ae7a3a8a5408@ilande.co.uk>
Date: Sun, 5 May 2019 11:06:01 +0100
MIME-Version: 1.0
In-Reply-To: <cbd76a77-6545-73f0-53d8-57a119372568@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/14] target/ppc: introduce
 GEN_VSX_HELPER_X1 macro to fpu_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, rth@twiddle.net, gkurz@kaod.org

On 30/04/2019 17:43, Richard Henderson wrote:

> On 4/28/19 7:38 AM, Mark Cave-Ayland wrote:
>> Rather than perform the VSR register decoding within the helper itself,
>> introduce a new GEN_VSX_HELPER_X1 macro which performs the decode based
>> upon xB at translation time.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  target/ppc/fpu_helper.c             |  6 ++----
>>  target/ppc/helper.h                 |  8 ++++----
>>  target/ppc/translate/vsx-impl.inc.c | 24 ++++++++++++++++++++----
>>  3 files changed, 26 insertions(+), 12 deletions(-)
> 
> Similarly wrt VSX_TSQRT.

Yes, and also the other helper touched here: helper_xststdcsp(). I think the comment
here is basically the same as for GEN_VSX_HELPER_X2_AB.


ATB,

Mark.
