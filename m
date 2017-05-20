Received: from eggs.gnu.org ([2001:4830:134:3::10]:56531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBrxX-0001az-RQ
	for qemu-devel@nongnu.org; Fri, 19 May 2017 20:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBrxU-0004wE-Im
	for qemu-devel@nongnu.org; Fri, 19 May 2017 20:09:27 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:33803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dBrxU-0004vL-E9
	for qemu-devel@nongnu.org; Fri, 19 May 2017 20:09:24 -0400
Received: by mail-oi0-x244.google.com with SMTP id w10so14770981oif.1
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 17:09:24 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170429104937.31341-1-zxq_yx_007@163.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9bf6a5a4-e8d7-b3b3-029d-baad2e3b507e@amsat.org>
Date: Fri, 19 May 2017 21:09:21 -0300
MIME-Version: 1.0
In-Reply-To: <20170429104937.31341-1-zxq_yx_007@163.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org, mark.cave-ayland@ilande.co.uk, pbonzini@redhat.com, atar4qemu@gmail.com, david@gibson.dropbear.id.au

Hi Xiaoqiang,

On 04/29/2017 07:49 AM, xiaoqiang zhao wrote:
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

I think you can squash those 2. Any particular reason you did pass 2 in 
another commit?

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
