Received: from eggs.gnu.org ([2001:4830:134:3::10]:55682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gMGZZ-0004RW-4m
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 13:04:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1gMGZG-0007b2-IZ
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 13:04:22 -0500
References: <20181111094023.18038-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <3a19b90b-71aa-36b2-4e30-867d29ac5683@reactos.org>
Date: Mon, 12 Nov 2018 19:03:43 +0100
MIME-Version: 1.0
In-Reply-To: <20181111094023.18038-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1] fdc: fix segfault in
 fdctrl_stop_transfer() when DMA is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, martin@duskware.de

Le 11/11/2018 à 10:40, Mark Cave-Ayland a écrit :
> Commit c8a35f1cf0f "fdc: use IsaDma interface instead of global DMA_*
> functions" accidentally introduced a segfault in fdctrl_stop_transfer() for
> non-DMA transfers.
> 
> If fdctrl->dma_chann has not been configured then the fdctrl->dma interface
> reference isn't initialised during isabus_fdc_realize(). Unfortunately
> fdctrl_stop_transfer() unconditionally references the DMA interface when
> finishing the transfer causing a NULL pointer dereference.
> 
> Fix the issue by adding a check in fdctrl_stop_transfer() so that the DMA
> interface reference and release method is only invoked if fdctrl->dma_chann
> has been set.
> 
> (This issue was discovered by Martin testing a recent change in the NetBSD
> installer under qemu-system-sparc)
> 
> Reported-by: Martin Husemann <martin@duskware.de>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
