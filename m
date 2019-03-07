Received: from eggs.gnu.org ([209.51.188.92]:48252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h20Yh-0004Yt-9G
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:28:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1h20Yg-00007E-Er
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 16:28:07 -0500
References: <20190307180520.13868-1-mark.cave-ayland@ilande.co.uk>
	<bbc08425-8ff8-e6ff-7d2d-5df508316469@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <5dc6e24f-504d-c1fc-1580-6b3abc049275@ilande.co.uk>
Date: Thu, 7 Mar 2019 21:27:56 +0000
MIME-Version: 1.0
In-Reply-To: <bbc08425-8ff8-e6ff-7d2d-5df508316469@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] target/ppc: switch fpr/vsrl
 registers so all VSX registers are in host endian order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 07/03/2019 21:00, Richard Henderson wrote:

> On 3/7/19 10:05 AM, Mark Cave-Ayland wrote:
>> Finally now that all VSX registers are stored in the same way, the vsr offset
>> functions and get_cpu_vsrh()/get_cpu_vsrl() can be simplified accordingly.
> 
> For the todo list for 4.1 should be getting rid of getVSR and setVSR.

That's something that certainly crossed my mind, although I was conscious that freeze
was coming up and wanted to get the fix for the existing VSX vector ops merged. I
think it should be a simple mechanical change, but I'm not real set up right now for
much in the way of ppc64 testing.


ATB,

Mark.
