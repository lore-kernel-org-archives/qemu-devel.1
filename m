Received: from eggs.gnu.org ([2001:4830:134:3::10]:57012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dK4M6-0001Ae-IJ
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 11:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dK4M1-0004UI-MZ
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 11:00:42 -0400
Received: from chuckie.co.uk ([82.165.15.123]:36369
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dK4M1-0004U5-F4
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 11:00:37 -0400
References: <1497097821-32754-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<6b239fc8-f691-801f-ac02-e6ca247bc4bc@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <af666e94-257c-0282-3849-89c8c101c280@ilande.co.uk>
Date: Sun, 11 Jun 2017 16:00:20 +0100
MIME-Version: 1.0
In-Reply-To: <6b239fc8-f691-801f-ac02-e6ca247bc4bc@amsat.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/6] fw_cfg: qdev-related tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, rjones@redhat.com, pbonzini@redhat.com, somlo@cmu.edu, lersek@redhat.com, mst@redhat.com, ehabkost@redhat.com

On 10/06/17 19:15, Philippe Mathieu-Daudé wrote:

> Hi Mark,
> 
> Is it possible to reorder the 3rd patch (FW_CFG_ID) first or 2nd in the
> series? Mostly for cosmetic :)
> 
> On 06/10/2017 09:30 AM, Mark Cave-Ayland wrote:
>> As part of some ongoing sun4u work, I need to be able to wire the fw_cfg
>> IO interface to a separate IO space by instantiating the qdev device
>> instead
>> of calling fw_cfg_init_io(). This patchset brings FW_CFG_IO in line with
>> FW_CFG_MEM and tidies up the realize methods accordingly.
>>
>> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>>
>> Mark Cave-Ayland (6):
>>   fw_cfg: move initialisation of FWCfgState into instance_init
>>   fw_cfg: move qdev_init_nofail() out from fw_cfg_init1() into callers
>>   fw_cfg: move setting of FW_CFG_ID into fw_cfg_init1()
>>   fw_cfg: move fw_cfg_init1() into the fw_cfg_*_realize() functions
>>   fw_cfg: use sysbus_init_mmio() in fw_cfg_io_realize()
>>   fw_cfg: move QOM type defines into fw_cfg.h
>>
>>  hw/nvram/fw_cfg.c         |   60
>> ++++++++++++++++++++++++---------------------
>>  include/hw/nvram/fw_cfg.h |    8 ++++++
>>  2 files changed, 40 insertions(+), 28 deletions(-)

I can't really get too excited about this - anyone else have any strong
opinions either way?


ATB,

Mark.
