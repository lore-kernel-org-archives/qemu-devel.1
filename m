Received: from eggs.gnu.org ([2001:4830:134:3::10]:38984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnTF-0008QG-OC
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:13:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gWnTB-00045U-L8
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:13:29 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60225
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gWnTB-00042x-9E
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 14:13:25 -0500
References: <20181210165636.28366-1-peter.maydell@linaro.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <0a32d286-7961-c9cd-2643-cf9cd3c95de8@ilande.co.uk>
Date: Tue, 11 Dec 2018 19:13:13 +0000
MIME-Version: 1.0
In-Reply-To: <20181210165636.28366-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/3] target/m68k: convert to
 transaction_failed hook
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, patches@linaro.org

On 10/12/2018 16:56, Peter Maydell wrote:

> This patchset converts the m68k target from the deprecated
> unassigned_access hook to the new transaction_failed hook.
> It's RFC for a couple of reasons:
>  * it's untested, since I don't have an m68k test image
>  * the second patch just makes "bus error while trying to
>    read page tables" be treated as a page fault, when it
>    should probably cause a fault reporting it as a bus error
>    of some kind
>  * I don't understand why the old unassigned_access hook
>    set the ATC bit in the MMU SSW, since the docs I have say
>    this should be set if the fault happened during a table
>    search, but cleared if it's just an ordinary bus-errored
>    data or insn access. Probably this is a pre-existing bug?
> 
> Anyway, I send it out as a skeleton for comments, because
> it would be nice to get rid of the old unassigned_access
> hook, which is fundamentally broken (it's still used by m68k,
> microblaze, mips and sparc).

Laurent is really the expert here (my work on the q800 was purely on the device
side), however is this also a nudge to see if the unassigned_access hook can be
eliminated from sparc too? ;)


ATB,

Mark.
