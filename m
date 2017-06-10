Received: from eggs.gnu.org ([2001:4830:134:3::10]:50991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJkvZ-0003wC-J9
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 14:16:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJkvU-00018M-Dz
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 14:16:01 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:36045)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dJkvU-00018E-5X
	for qemu-devel@nongnu.org; Sat, 10 Jun 2017 14:15:56 -0400
Received: by mail-qt0-x241.google.com with SMTP id s33so20115381qtg.3
	for <qemu-devel@nongnu.org>; Sat, 10 Jun 2017 11:15:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6b239fc8-f691-801f-ac02-e6ca247bc4bc@amsat.org>
Date: Sat, 10 Jun 2017 15:15:50 -0300
MIME-Version: 1.0
In-Reply-To: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/6] fw_cfg: qdev-related tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, somlo@cmu.edu, lersek@redhat.com, mst@redhat.com, ehabkost@redhat.com

Hi Mark,

Is it possible to reorder the 3rd patch (FW_CFG_ID) first or 2nd in the 
series? Mostly for cosmetic :)

On 06/10/2017 09:30 AM, Mark Cave-Ayland wrote:
> As part of some ongoing sun4u work, I need to be able to wire the fw_cfg
> IO interface to a separate IO space by instantiating the qdev device instead
> of calling fw_cfg_init_io(). This patchset brings FW_CFG_IO in line with
> FW_CFG_MEM and tidies up the realize methods accordingly.
>
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>
> Mark Cave-Ayland (6):
>   fw_cfg: move initialisation of FWCfgState into instance_init
>   fw_cfg: move qdev_init_nofail() out from fw_cfg_init1() into callers
>   fw_cfg: move setting of FW_CFG_ID into fw_cfg_init1()
>   fw_cfg: move fw_cfg_init1() into the fw_cfg_*_realize() functions
>   fw_cfg: use sysbus_init_mmio() in fw_cfg_io_realize()
>   fw_cfg: move QOM type defines into fw_cfg.h
>
>  hw/nvram/fw_cfg.c         |   60 ++++++++++++++++++++++++---------------------
>  include/hw/nvram/fw_cfg.h |    8 ++++++
>  2 files changed, 40 insertions(+), 28 deletions(-)
>
