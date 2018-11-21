Received: from eggs.gnu.org ([2001:4830:134:3::10]:42470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gPVFb-0004JW-H6
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:21:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1gPVFY-0006B1-21
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:21:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <abologna@redhat.com>) id 1gPVFX-00069M-Qb
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 11:21:12 -0500
Message-ID: <f2244e2026af0d3b067bfdfc5e0d676c2ec21e33.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Wed, 21 Nov 2018 17:20:41 +0100
In-Reply-To: <20181120140251-mutt-send-email-mst@kernel.org>
References: <20181114233831.10374-1-ehabkost@redhat.com>
	<c1b4a0ee39dfddeb19f1be46710c10cbefd3f07a.camel@redhat.com>
	<20181116034551.GK3807@habkost.net>
	<20181119114105.4da89f2c.cohuck@redhat.com>
	<20181119125519-mutt-send-email-mst@kernel.org>
	<20181119193238.117c2f4e.cohuck@redhat.com>
	<20181119133434-mutt-send-email-mst@kernel.org>
	<20181119195638.49a9c21e.cohuck@redhat.com>
	<20181119140813-mutt-send-email-mst@kernel.org>
	<9bc6ced6b0491643775081b8f8437065684e9959.camel@redhat.com>
	<20181120140251-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, Amit Shah <amit@kernel.org>, Cleber Rosa <crosa@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Jason Wang <jasowang@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, libvir-list@redhat.com, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On Tue, 2018-11-20 at 14:14 -0500, Michael S. Tsirkin wrote:
> On Tue, Nov 20, 2018 at 01:27:05PM +0100, Andrea Bolognani wrote:
> > On Mon, 2018-11-19 at 14:14 -0500, Michael S. Tsirkin wrote:
> > > Well it works now - connect it to a bus and it figures out whether it
> > > should do transitional or not. You can force transitional in PCIe anyway
> > > but then you are limited to about 15 devices - probably sufficient for
> > > most people ...
> > 
> > That's not how it works, though: current virtio-*-pci devices will
> > be transitional (and thus support older guest OS) or not based on
> > the kind of slot you plug them into.
> > 
> > From the management point of view that's problematic, because libvirt
> > (which takes care of the virtual hardware, including assigning PCI
> > addresses to devices) has no knowledge of the guest OS running on
> > said hardware, and management apps (which know about the guest OS and
> > can figure out its capabilities using libosinfo) don't want to be in
> > the business of assigning PCI addresses themselves.
> > 
> > Having separate transitional and non-transitional variants solves the
> > issue because now management apps can query libosinfo to figure out
> > whether the guest OS supports non-transitional virtio devices, and
> > based on that they can ask libvirt to use either the transitional or
> > non-transitional variant; from that, libvirt will be able to choose
> > the correct slot for the device.
> > 
> > None of the above quite works if we have a single variant that
> > morphs based on the slot, as we have today.
> 
> So can we get an ack on the patchset then?

Sure thing - whatever it might be worth :)

  Acked-by: Andrea Bolognani <abologna@redhat.com>

-- 
Andrea Bolognani / Red Hat / Virtualization
