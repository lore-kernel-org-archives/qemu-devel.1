Received: from eggs.gnu.org ([2001:4830:134:3::10]:36242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gXBMI-0000lt-7N
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 15:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gXBME-0008E1-VW
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 15:43:54 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:45379)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1gXBME-0008Cf-Ll
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 15:43:50 -0500
References: <20181210165636.28366-1-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3afc2ab8-c6b6-7157-e744-e742b384b0da@vivier.eu>
Date: Wed, 12 Dec 2018 21:43:47 +0100
MIME-Version: 1.0
In-Reply-To: <20181210165636.28366-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, patches@linaro.org

On 10/12/2018 17:56, Peter Maydell wrote:
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
> 
> thanks
> -- PMM
> 
> Peter Maydell (3):
>   target/m68k: In dump_address_map() check for memory access failures
>   target/m68k: In get_physical_address() check for memory access
>     failures
>   target/m68k: Switch to transaction_failed hook
> 
>  target/m68k/cpu.h       |  7 ++--
>  target/m68k/cpu.c       |  2 +-
>  target/m68k/helper.c    | 84 ++++++++++++++++++++++++++++++++---------
>  target/m68k/op_helper.c | 20 ++++------
>  4 files changed, 80 insertions(+), 33 deletions(-)
> 

Tested-by: Laurent Vivier <laurent@vivier.eu>

I'll try to review this later...

Thanks,
Laurent
