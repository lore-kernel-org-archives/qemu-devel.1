Received: from eggs.gnu.org ([209.51.188.92]:51898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gkUTz-0007A0-74
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1gkUTx-0001Ul-6E
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:46:51 -0500
Received: from chuckie.co.uk ([82.165.15.123]:60336
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1gkUTt-0001Lh-Jj
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:46:47 -0500
References: <cover.1547166960.git.balaton@eik.bme.hu>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <604061b8-2045-566e-c5dc-41346bc1b1fd@ilande.co.uk>
Date: Fri, 18 Jan 2019 13:46:29 +0000
MIME-Version: 1.0
In-Reply-To: <cover.1547166960.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/5] Refactor common PCI IDE functions from
 CMD646
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Richard Henderson <rth@twiddle.net>

On 11/01/2019 00:36, BALATON Zoltan wrote:

> Hello,
> 
> This series is a small refactoring that moves some common PCI IDE io
> mem ops functions from the CMD646 model to the PCI IDE model so a
> CMD646 specific type can be dropped from PCIIDEState, removes code
> duplication from SiI3112 model (also fixing a bug) and allows these
> functions to be used by future PCI IDE implementations.
> 
> Also cc'd Mark and Richard because the CMD646 seems to be used by
> Sparc, HPPA and Alpha machines.
> 
> Regards,
> BALATON Zoltan
> 
> BALATON Zoltan (5):
>   cmd646: Remove unused variable
>   cmd646: Remove IDEBus from CMD646BAR
>   cmd646: Move PCI IDE specific functions to ide/pci.c
>   ide: Get rid of CMD646BAR struct
>   sii3112: Remove duplicated code and use PCI IDE ops instead
> 
>  hw/ide/cmd646.c      | 102 ++++++++-------------------------------------------
>  hw/ide/pci.c         |  65 ++++++++++++++++++++++++++++++++
>  hw/ide/sii3112.c     |  52 ++++----------------------
>  include/hw/ide/pci.h |  14 ++-----
>  4 files changed, 93 insertions(+), 140 deletions(-)

This looks like a good tidy-up to me. I've applied these patches locally and tried a
quick boot test under qemu-system-sparc64 and it seems to work, so:

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
