Received: from eggs.gnu.org ([2001:4830:134:3::10]:60133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dBjvR-0008Sx-Cn
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dBjvO-0005mR-8u
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:34:45 -0400
Received: from chuckie.co.uk ([82.165.15.123]:59663
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dBjvO-0005io-1P
	for qemu-devel@nongnu.org; Fri, 19 May 2017 11:34:42 -0400
References: <20170429104937.31341-1-zxq_yx_007@163.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <fd908ca1-2efe-dd73-7f02-972d2755bb34@ilande.co.uk>
Date: Fri, 19 May 2017 16:34:14 +0100
MIME-Version: 1.0
In-Reply-To: <20170429104937.31341-1-zxq_yx_007@163.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 0/9] QOM'ify work for sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xiaoqiang zhao <zxq_yx_007@163.com>, qemu-devel@nongnu.org
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, pbonzini@redhat.com, atar4qemu@gmail.com, david@gibson.dropbear.id.au

On 29/04/17 11:49, xiaoqiang zhao wrote:

> This patch set aims for QOM'ifying code relate with sparc.
> It is part of my QOM'ify work of qemu code base.
> 
> changes since v1: 
> * rebased on the latest master
> 
> xiaoqiang zhao (9):
>   hw/misc: QOM'ify eccmemctl.c
>   hw/dma: QOM'ify sparc32_dma.c
>   hw/dma: QOM'ify sun4m_iommu.c
>   hw/misc: QOM'ify slavio_misc.c
>   hw/timer: QOM'ify m48txx_sysbus (pass 1)
>   hw/timer: QOM'ify m48txx_sysbus (pass 2)
>   hw/timer: QOM'ify slavio_timer
>   hw/sparc: QOM'ify sun4m.c
>   hw/sparc64: QOM'ify sun4u.c
> 
>  hw/dma/sparc32_dma.c    | 25 ++++++++++++++---------
>  hw/dma/sun4m_iommu.c    | 12 +++++------
>  hw/misc/eccmemctl.c     | 25 ++++++++++++++---------
>  hw/misc/slavio_misc.c   | 43 ++++++++++++++++-----------------------
>  hw/sparc/sun4m.c        | 54 +++++++++++++++++--------------------------------
>  hw/sparc64/sun4u.c      | 20 +++++++++---------
>  hw/timer/m48t59.c       | 38 +++++++++++++++++-----------------
>  hw/timer/slavio_timer.c | 12 +++++------
>  8 files changed, 105 insertions(+), 124 deletions(-)

I've finally found time to take a look at these and they look good to me.

I'll wait a few days to see if anyone has any comments (particularly
relating to the m48t59 device since that it appears that device is also
used by PReP) but if I hear nothing then I'll apply to my qemu-sparc branch.

And please do accept my apologies that it has taken so long to review
these patches, I will aspire to do much better in future.


ATB,

Mark.
