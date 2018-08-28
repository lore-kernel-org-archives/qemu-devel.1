Received: from eggs.gnu.org ([2001:4830:134:3::10]:60212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fub3y-00065V-7j
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:17:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fub1c-0005K3-Sn
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:15:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52544 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fub1c-0005He-Mr
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:15:04 -0400
Date: Tue, 28 Aug 2018 12:14:58 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180828101458.pnsldezdzp6tdulp@sirius.home.kraxel.org>
References: <1533793434-7614-1-git-send-email-whois.zihan.yang@gmail.com>
	<ece2a3ff-678d-00b6-3fd6-660972c5beca@gmail.com>
	<20180827070406.t525gr43qpu7wpsj@sirius.home.kraxel.org>
	<CAKwiv-gyGoqEpmpicxo_a3cQBsb0-XoT9cqkJu5WOtkUtAx0eQ@mail.gmail.com>
	<5f5dc082-7053-d6b9-b01f-fffba1847ba5@gmail.com>
	<20180828060752.mmsd7x7uobqm2gsr@sirius.home.kraxel.org>
	<8b232ca6-4643-24c7-d93d-589a452d0785@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b232ca6-4643-24c7-d93d-589a452d0785@gmail.com>
Subject: Re: [Qemu-devel] [SeaBIOS] [RFC v2 0/3] Support multiple pci
 domains in pci_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Zihan Yang <whois.zihan.yang@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, seabios@seabios.org

  Hi,

> > Where is the pxb-pcie device?  0000:$somewhere?  Or $domain:00:00.0?
> 
>  0000:$somewhere (On PCI domain 0)

Cool, so we don't have an chicken-and-egg issue.

> > If we can access pxb-pcie registers before configuring MMCFG then yes,
> > we should use pxb-pcie registers for that.
> 
> Yes, we can.

Ok, so we can configure mmcfg as hidden pci bar, simliar to the q35
mmcfg.  Any configuration hints can be passed as pci vendor capability
(simliar to the bridge window size hints), if needed.

cheers,
  Gerd
