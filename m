Received: from eggs.gnu.org ([2001:4830:134:3::10]:37972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL7Yr-0003pm-2l
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dL7Yo-0001Db-1G
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:38:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dL7Yn-0001CA-RD
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 08:38:09 -0400
References: <1497302470-10776-1-git-send-email-mark.cave-ayland@ilande.co.uk>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <44b45a54-1e9e-5373-a9da-f11184b3c22f@redhat.com>
Date: Wed, 14 Jun 2017 14:38:04 +0200
MIME-Version: 1.0
In-Reply-To: <1497302470-10776-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCHv2 0/4] fw_cfg: qdev-related tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, lersek@redhat.com, imammedo@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, rjones@redhat.com, peter.maydell@linaro.org



On 12/06/2017 23:21, Mark Cave-Ayland wrote:
> As part of some ongoing sun4u work, I need to be able to wire the fw_cfg
> IO interface to a separate IO space by instantiating the qdev device instead
> of calling fw_cfg_init_io(). This patchset brings FW_CFG_IO in line with
> FW_CFG_MEM and tidies up the realize methods accordingly.

Could you use FW_CFG_MEM instead, and add a new function

void sysbus_mmio_map_subregion(SysBusDevice *dev, int n,
                               MemoryRegion *mr, hwaddr addr)

?

Thanks,

Paolo
