Received: from eggs.gnu.org ([2001:4830:134:3::10]:37814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cWgZ8-0001Ap-1u
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:42:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1cWgZ5-00067x-0P
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:42:02 -0500
Received: from chuckie.co.uk ([82.165.15.123]:49090
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1cWgZ4-000655-Pz
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:41:58 -0500
References: <20161023063135.21058-1-zxq_yx_007@163.com>
	<2f476a20.17fe.1593424b176.Coremail.zxq_yx_007@163.com>
	<80cfd7e0-b555-b7c9-686a-296e22e32c6b@ilande.co.uk>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <ca998a25-38de-a2f3-fc9e-4f3e0deb6031@ilande.co.uk>
Date: Thu, 26 Jan 2017 09:41:40 +0000
MIME-Version: 1.0
In-Reply-To: <80cfd7e0-b555-b7c9-686a-296e22e32c6b@ilande.co.uk>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/9] QOM'ify work for sparc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?6LW15bCP5by6?= <zxq_yx_007@163.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: pbonzini@redhat.com, atar4qemu@gmail.com, peter.maydell@linaro.org

On 30/12/16 18:32, Mark Cave-Ayland wrote:

> On 25/12/16 04:02, ÕÔÐ¡Ç¿ wrote:
> 
>> ping .... 
>>
>> At 2016-10-23 14:31:26, "xiaoqiang zhao" <zxq_yx_007@163.com> wrote:
>>> This patch set aims for QOM'ifying code relate with sparc.
>>> It is part of my QOM'ify work of qemu code base.
>>>
>>> xiaoqiang zhao (9):
>>>  hw/misc: QOM'ify eccmemctl.c
>>>  hw/dma: QOM'ify sparc32_dma.c
>>>  hw/dma: QOM'ify sun4m_iommu.c
>>>  hw/misc: QOM'ify slavio_misc.c
>>>  hw/timer: QOM'ify m48txx_sysbus (pass 1)
>>>  hw/timer: QOM'ify m48txx_sysbus (pass 2)
>>>  hw/timer: QOM'ify slavio_timer
>>>  hw/sparc: QOM'ify sun4m.c
>>>  hw/sparc64: QOM'ify sun4u.c
>>>
>>> hw/dma/sparc32_dma.c    | 25 ++++++++++++--------
>>> hw/dma/sun4m_iommu.c    | 12 ++++------
>>> hw/misc/eccmemctl.c     | 25 ++++++++++++--------
>>> hw/misc/slavio_misc.c   | 43 ++++++++++++++--------------------
>>> hw/sparc/sun4m.c        | 54 +++++++++++++++----------------------------
>>> hw/sparc64/sun4u.c      | 20 ++++++++--------
>>> hw/timer/m48t59.c       | 61 ++++++++++++++++++++++++++++++++++---------------
>>> hw/timer/slavio_timer.c | 12 ++++------
>>> 8 files changed, 128 insertions(+), 124 deletions(-)
>>>
>>> -- 
>>> 2.9.3
> 
> Thanks for the patch!
> 
> Given that Artyom's sun4v work has been waiting since before freeze, I'd
> like to see that merged first and then this patch rebased on top if
> required.

The sun4v patchset has now been applied, so please can you rebase
against master and repost for review?


ATB,

Mark.
