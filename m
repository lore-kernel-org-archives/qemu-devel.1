Received: from eggs.gnu.org ([209.51.188.92]:54056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjXmU-0000Y9-PH
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gjXmT-0004yg-S7
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:06:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34098)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gjXmT-0004x7-Gu
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 18:06:01 -0500
References: <cover.1547166960.git.balaton@eik.bme.hu>
From: John Snow <jsnow@redhat.com>
Message-ID: <fec2fc0a-4bf1-e2f3-e137-32722cad878e@redhat.com>
Date: Tue, 15 Jan 2019 18:05:58 -0500
MIME-Version: 1.0
In-Reply-To: <cover.1547166960.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Richard Henderson <rth@twiddle.net>



On 1/10/19 7:36 PM, BALATON Zoltan wrote:
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
> 

Hi, just a note to let you know I just got back from vacation and I will
take a little while to get to this as I unbury.

--js
