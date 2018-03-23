Received: from eggs.gnu.org ([2001:4830:134:3::10]:44793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ezRRb-0001gr-Oe
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:29:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1ezRRY-00063k-L3
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:29:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59710 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1ezRRY-00063O-HD
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 14:29:36 -0400
References: <20180323122520.11270-1-kraxel@redhat.com>
	<43fc23c1-d72f-748a-5b9d-a816466d7406@redhat.com>
	<20180323145131.whyitmksl2s3d6c6@sirius.home.kraxel.org>
	<646a54e2-dc81-978d-de7a-293f2ce1766a@redhat.com>
	<20180323170754.2ydh63wpxzejf6tk@sirius.home.kraxel.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <a1f7ca02-4bd8-b347-79a2-aaa992eba4ff@redhat.com>
Date: Fri, 23 Mar 2018 19:29:20 +0100
MIME-Version: 1.0
In-Reply-To: <20180323170754.2ydh63wpxzejf6tk@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/7] ramfb: simple boot framebuffer,
 no legacy vga
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>

On 03/23/18 18:07, Gerd Hoffmann wrote:
> On Fri, Mar 23, 2018 at 04:12:21PM +0100, Laszlo Ersek wrote:
>> On 03/23/18 15:51, Gerd Hoffmann wrote:
>>>   Hi,
>>>
>>>> I believe the only point of this device model (and the associated guest
>>>> fw driver) is Windows-on-KVM/aarch64.
>>>
>>> The other one is vgpu boot display.
>>
>> Interesting. I know nearly nothing about vgpu, but I hoped it'd come
>> with its own UEFI GOP driver in the ROM BAR; similarly to assigned
>> physical GPUs.
> 
> Well.  They don't ...
> 
> And even for assigned GPUs it is a PITA.  For example the intel rom
> appears to have the pci slot hardcoded.  You have to place the GPU in
> 00:02.0 (which it has on bare metal), otherwise the rom doesn't work.
> I would be *very* surprised if the rom is able to handle vgpu devices
> correctly.  Beside that it isn't easy to get the rom in the first place,
> at least for intel, as it isn't stored in the rom bar but in the
> firmware flash.

Sure, IGD assignment is a different animal; I thought vgpu would follow
the discrete PCI card assignment case.

Anyway, I just wanted to educate myself on this; thanks!
Laszlo
