Received: from eggs.gnu.org ([2001:4830:134:3::10]:44006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dGf7j-00031s-HM
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 01:27:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dGf7g-0002pj-En
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 01:27:47 -0400
Received: from chuckie.co.uk ([82.165.15.123]:34981
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dGf7g-0002m6-6p
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 01:27:44 -0400
Received: from host86-157-6-84.range86-157.btcentralplus.com ([86.157.6.84]
	helo=[192.168.1.65]) by s16892447.onlinehome-server.info with esmtpsa
	(TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dGf7R-0001IS-0p
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 06:27:29 +0100
References: <20170525133451.22459-1-zxq_yx_007@163.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <c6ac5958-30bf-b3a7-b531-caabee6ebfda@ilande.co.uk>
Date: Fri, 2 Jun 2017 06:27:22 +0100
MIME-Version: 1.0
In-Reply-To: <20170525133451.22459-1-zxq_yx_007@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 0/8] QOM'ify work for sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 25/05/17 14:34, xiaoqiang zhao wrote:

> This patch set aims for QOM'ifying code relate with sparc.
> It is part of my QOM'ify work of qemu code base.
> 
> Changes:
> 
> v2 -> v3:
> * rebased on the latest master
> * squash two patches about m48txx_sysbus into one
> 
> v1 ->  v2: 
> * rebased on the latest master
> 
> xiaoqiang zhao (8):
>   hw/misc: QOM'ify eccmemctl.c
>   hw/dma: QOM'ify sparc32_dma.c
>   hw/dma: QOM'ify sun4m_iommu.c
>   hw/misc: QOM'ify slavio_misc.c
>   hw/timer: QOM'ify m48txx_sysbus
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

These look good here, so I've applied them to my qemu-sparc branch and
will send a pull request shortly.


ATB,

Mark.
