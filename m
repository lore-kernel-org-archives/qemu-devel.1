Received: from eggs.gnu.org ([2001:4830:134:3::10]:34800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dpfb9-0004wm-C6
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 15:02:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dpfb0-0003vP-0v
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 15:02:51 -0400
Received: from chuckie.co.uk ([82.165.15.123]:47421
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dpfaz-0003tm-Qw
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 15:02:41 -0400
References: <1500236854-28271-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1500236854-28271-2-git-send-email-mark.cave-ayland@ilande.co.uk>
	<66bd157d-02d4-5d87-5774-71fd995652f6@linux.vnet.ibm.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <d58de819-f5aa-9fb5-6f09-ada3ec14fd0c@ilande.co.uk>
Date: Wed, 6 Sep 2017 20:02:30 +0100
MIME-Version: 1.0
In-Reply-To: <66bd157d-02d4-5d87-5774-71fd995652f6@linux.vnet.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv3 1/2] pci: move check for existing devfn
 into new pci_bus_devfn_available() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On 04/09/17 11:01, Yi Min Zhao wrote:

> I want to ask a question. According to the next patch, you check
> bus->devices[devfn]
> and reserved bit separately. Why not move the reserved bit check here?
> I think bus->devices[devfn] != NULL or revsered bit set means slot is
> unavailable.

Primarily it was to allow callers to distinguish between the two
different cases i.e. the error message can tell you that the reason the
slot was unavailable was because it was reserved, i.e. you can *never*
plug anything into it compared with unavailable where someone has
plugged something into the slot with -device but it could be later
removed, for example with hotplug.


ATB,

Mark.
