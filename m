Received: from eggs.gnu.org ([209.51.188.92]:58338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gsCWN-0000F8-H1
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:13:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gsCW6-0007Dx-Aw
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:12:59 -0500
Received: from chuckie.co.uk ([82.165.15.123]:47782
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gsCVn-0005a0-Ea
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 15:12:43 -0500
References: <20190207224258.426-1-mark.cave-ayland@ilande.co.uk>
	<3ed73de0-9d3b-8e7c-cda1-1c759ba969f2@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <736bf099-de1d-3522-7fff-c8ba93f75277@ilande.co.uk>
Date: Fri, 8 Feb 2019 18:09:39 +0000
MIME-Version: 1.0
In-Reply-To: <3ed73de0-9d3b-8e7c-cda1-1c759ba969f2@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
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
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org

On 08/02/2019 17:39, Richard Henderson wrote:

> On 2/7/19 2:42 PM, Mark Cave-Ayland wrote:
>> Due to a cut/paste error in the original implementation, the unsigned vector
>> saturating arithmetic was erroneously being calculated as signed vector saturating
>> arithmetic.
>>
>> Fixes: 8ffafbcec2 ("tcg/i386: Implement vector saturating arithmetic")
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> ---
>>  tcg/i386/tcg-target.inc.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Ooof.  Thanks.

AFAICT none of the other TCG backends currently make use of it, but it was this bug
causing the graphical corruption that myself and Howard saw testing the PPC vector
patchset.

FWIW I've now rebased and repushed the outstanding patches from your patchset along
with this fix to https://github.com/mcayland/qemu/commits/ppc-altivec-v6 as it would
be great if this could make it into 4.0.


ATB,

Mark.
