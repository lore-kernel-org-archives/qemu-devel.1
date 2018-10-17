Received: from eggs.gnu.org ([2001:4830:134:3::10]:45700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gCfQ1-000386-QM
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 02:34:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gCfPy-00032k-Lq
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 02:34:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gCfPy-000328-Fr
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 02:34:54 -0400
Date: Wed, 17 Oct 2018 08:34:43 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181017063443.bfjm5yh47cx3vva3@sirius.home.kraxel.org>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net>
	<20181016170236.GJ7995@redhat.com>
	<d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
	<87murdf73g.fsf_-_@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87murdf73g.fsf_-_@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] No more chameleon devices (was: [PATCH] virtio:
 Provide version-specific variants of virtio PCI devices)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Laine Stump <laine@redhat.com>, Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>, qemu-devel@nongnu.org, Wainer dos Santos Moschetta <wainersm@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Andrea Bolognani <abologna@redhat.com>, Cleber Rosa <crosa@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

On Wed, Oct 17, 2018 at 07:57:39AM +0200, Markus Armbruster wrote:
> Laine Stump <laine@redhat.com> writes:
> 
> [...]
> > In the end, having a device that changed PCI ID depending on what kind
> > of slot it was plugged into was an idea "too clever for its own good",
> > should be avoided when new devices are added in the future, and we
> > should at least provide an alternative that doesn't do that for existing
> > devices.
> 
> That means for each chameleon PCI/PCIe device:
> 
> * create a pair of devices that can only go into one kind of slot
> * deprecate the chameleon

I think virtio devices are the only ones which actually change the pci
id and have non-trivial differences.

qemu-xhci can likewise be plugged into both pci and pcie slots.  When
plugged into a pcie slot it'll have pcie endpoint capability.  That is
the only difference though.  Do you consider that a chameleon device?

cheers,
  Gerd
