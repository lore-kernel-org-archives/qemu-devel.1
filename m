Received: from eggs.gnu.org ([2001:4830:134:3::10]:46532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcwdl-0002LP-8H
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dcwdh-0006TF-A4
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:36:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dcwdh-0006Rl-3b
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 12:36:53 -0400
Date: Wed, 2 Aug 2017 19:26:42 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170802192446-mutt-send-email-mst@kernel.org>
References: <1501285073-2215-1-git-send-email-zuban32s@gmail.com>
	<1501285073-2215-6-git-send-email-zuban32s@gmail.com>
	<491f77fc-974c-33dd-3974-08ab61d2c078@redhat.com>
	<CAKSfGUCTom8YBs8wOHMX_MpzDF1efB8_USb4tuW+hcAdoG2xvw@mail.gmail.com>
	<20170802003910-mutt-send-email-mst@kernel.org>
	<17a71bfc-1933-f707-2504-c9c699534cea@redhat.com>
	<20170802164551-mutt-send-email-mst@kernel.org>
	<9e36b7d6-bff3-b046-6053-162fb75ca0a0@redhat.com>
	<b0e1c72d-9c17-42e5-3135-5ebb1e53b4f1@redhat.com>
	<c4761b15-4525-247c-14da-510b20dbf90a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4761b15-4525-247c-14da-510b20dbf90a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/5] docs: update documentation
 considering PCIE-PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Bezzubikov <zuban32s@gmail.com>, qemu-devel@nongnu.org, ehabkost@redhat.com, seabios@seabios.org, Kevin OConnor <kevin@koconnor.net>, Gerd Hoffmann <kraxel@redhat.com>, pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, rth@twiddle.net

On Wed, Aug 02, 2017 at 06:36:29PM +0300, Marcel Apfelbaum wrote:
> > > > > > Can dmi-pci support shpc? why doesn't it? For compatibility?
> > > > > 
> > > > > I don't know why, but the fact that it doesn't is the reason libvirt
> > > > > settled on auto-creating a dmi-pci bridge and a pci-pci bridge under
> > > > > that for Q35. The reasoning was (IIRC Laine's words correctly) that the
> > > > > dmi-pci bridge cannot receive hotplugged devices, while the pci-pci
> > > > > bridge cannot be connected to the root complex. So both were needed.
> > > > > 
> > > > > Thanks
> > > > > Laszlo
> > > > 
> > > > OK. Is it true that dmi-pci + pci-pci under it will allow hotplug
> > > > on Q35 if we just flip the bit in _OSC?
> > > 
> > > Marcel, what say you?... :)
> 
> Good news, works with:
>    -device i82801b11-bridge,id=b1
>    -device pci-bridge,id=b2,bus=b1,chassis_nr=1,msi=off

And presumably it works for modern windows?
OK, so it looks like patch 1 is merely a bugfix, I'll merge it for 2.10.

> Notice bridge's msi=off until the following kernel bug will be merged:
>   https://www.spinics.net/lists/linux-pci/msg63052.html

Does libvirt support msi=off as a work-around?

> 
> Thanks,
> Marcel

-- 
MST
