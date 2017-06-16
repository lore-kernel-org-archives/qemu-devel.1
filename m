Received: from eggs.gnu.org ([2001:4830:134:3::10]:59908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dLo5Q-0002ZP-L7
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:02:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dLo5M-0000gm-P7
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:02:40 -0400
Received: from chuckie.co.uk ([82.165.15.123]:52551
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dLo5M-0000fU-Id
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 06:02:36 -0400
References: <1497302470-10776-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<44b45a54-1e9e-5373-a9da-f11184b3c22f@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <7ba10a6e-bacd-f784-c675-0c5f08f604f3@ilande.co.uk>
Date: Fri, 16 Jun 2017 11:02:24 +0100
MIME-Version: 1.0
In-Reply-To: <44b45a54-1e9e-5373-a9da-f11184b3c22f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2 0/4] fw_cfg: qdev-related tidy-ups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, lersek@redhat.com, imammedo@redhat.com, somlo@cmu.edu, ehabkost@redhat.com, mst@redhat.com, rjones@redhat.com, peter.maydell@linaro.org

On 14/06/17 13:38, Paolo Bonzini wrote:

> On 12/06/2017 23:21, Mark Cave-Ayland wrote:
>> As part of some ongoing sun4u work, I need to be able to wire the fw_cfg
>> IO interface to a separate IO space by instantiating the qdev device instead
>> of calling fw_cfg_init_io(). This patchset brings FW_CFG_IO in line with
>> FW_CFG_MEM and tidies up the realize methods accordingly.
> 
> Could you use FW_CFG_MEM instead, and add a new function
> 
> void sysbus_mmio_map_subregion(SysBusDevice *dev, int n,
>                                MemoryRegion *mr, hwaddr addr)
> 
> ?

Hmmm possibly that could work with some wrappers to emulate the ioport
accesses, however Laszlo wasn't too keen on the ioport regions appearing
as MMIO in the device tree and I believe that the final patchset will
offer some useful cleanups. There's also the argument that outside of
OpenBIOS I don't have a large set of clients for testing so I'd much
prefer to leave access-related changes if at all possible.


ATB,

Mark.
