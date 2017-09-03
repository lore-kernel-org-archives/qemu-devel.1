Received: from eggs.gnu.org ([2001:4830:134:3::10]:50559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1doYYQ-000796-QE
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 13:19:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1doYYL-0008Ve-PY
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 13:19:26 -0400
Received: from chuckie.co.uk ([82.165.15.123]:38899
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1doYYL-00088l-J6
	for qemu-devel@nongnu.org; Sun, 03 Sep 2017 13:19:21 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Message-ID: <f119bdad-d108-c9ef-d5c3-e94729d2ffcd@ilande.co.uk>
Date: Sun, 3 Sep 2017 18:18:54 +0100
MIME-Version: 1.0
In-Reply-To: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/8] sun4u: change PCI topology to better
 match a real Ultra 5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

On 11/07/17 22:53, Mark Cave-Ayland wrote:

> The aim of this patchset is to bring the sun4u machine in line with a real Ultra 5
> in order to resolve issues related to PCI bridge windows and interrupt routing.
> 
> The majority of the changes are designed to accommodate the simba PCI bridges on
> the root PCI bus, moving the on-board devices behind busA (as well as making the NIC
> a fixed on-board multi-function device as per a real Ultra 5).
> 
> Finally we mark unavailable PCI bus slots as reserved on all 3 PCI buses to ensure
> that correct interrupt routing is maintained, regardless of how the command line is
> configure with -device.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> 
> 
> Mark Cave-Ayland (8):
>   sun4u: pass PCIDevice into pci_ebus_init() instead of PCIBus
>   sun4u: switch to using qdev to instantiate fw_cfg interface
>   sun4u: expose fw_cfg and NVRAM on ebus PCI IO address space
>   apb: fix up PCI bus nomenclature
>   apb: fix endianness for APB and PCI config accesses
>   apb: add busA qdev property to PBM PCI bridge
>   sun4u: create single default onboard ne2k_pci NIC for machine
>   sun4u: move in-built devices behind PCI bridge A
> 
>  hw/pci-host/apb.c  |   93 ++++++++++++++++++++++++++++++++++++++--------------
>  hw/sparc64/sun4u.c |   52 +++++++++++++++++++++--------
>  2 files changed, 107 insertions(+), 38 deletions(-)

Now that the fw_cfg changes are upstream, I'll apply patches 1-6 to my
qemu-sparc branch. The plan is to replace the ne2k_pci NIC with another,
and the final switch moving devices behind the PCI bridge is dependent
upon other patches still pending further review.


ATB,

Mark.
