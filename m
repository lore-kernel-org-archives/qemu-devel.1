Received: from eggs.gnu.org ([209.51.188.92]:41117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1E5D-0001g7-Nt
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:42:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h1E5D-0001Ca-4s
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 12:42:27 -0500
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
	<20190303172343.13406-8-mark.cave-ayland@ilande.co.uk>
	<ef383e24-2a66-10c4-b328-5177719b268d@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <27b017d4-7573-f857-0e77-087eee7fe9e8@ilande.co.uk>
Date: Tue, 5 Mar 2019 17:42:23 +0000
MIME-Version: 1.0
In-Reply-To: <ef383e24-2a66-10c4-b328-5177719b268d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 7/8] target/ppc: introduce vsrh_offset()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 03/03/2019 23:33, Richard Henderson wrote:

> On 3/3/19 9:23 AM, Mark Cave-Ayland wrote:
>> -static inline int fpr_offset(int i)
>> +static inline int vsrh_offset(int i)
> 
> I don't agree with this.  The original is clearer for its uses.

Well as the patchset was coming from a VSX perspective, I took the approach that more
people would be familiar with high/low pair rather than understanding that VSX was
evolution of the original FPRs.

But again for me, I'm happy with either way so I don't mind changing it.


ATB,

Mark.
