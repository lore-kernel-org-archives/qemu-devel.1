Received: from eggs.gnu.org ([2001:4830:134:3::10]:56637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCoCr-0002LF-OM
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:58:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCoCn-0002rO-Rm
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:57:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gCoCj-0002i5-LO
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 11:57:51 -0400
Date: Wed, 17 Oct 2018 12:57:25 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181017155725.GD31060@habkost.net>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net>
	<20181016170236.GJ7995@redhat.com>
	<d8b9a6e6-c137-a553-8fe7-939edd2031b3@redhat.com>
	<048ea4797a31e3a584c36453e6cad10403462e55.camel@redhat.com>
	<20181017150137.GX31060@habkost.net>
	<20181017110249-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017110249-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH] virtio: Provide version-specific variants
 of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, Laine Stump <laine@redhat.com>, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>

On Wed, Oct 17, 2018 at 11:06:31AM -0400, Michael S. Tsirkin wrote:
> On Wed, Oct 17, 2018 at 12:01:37PM -0300, Eduardo Habkost wrote:
[...]
> > I'm considering doing this in v2:
> > 
> > * Remove the -0.9 device type, because nobody seems to need it
> > * Add two device types:
> >   * virtio-1-blk-pci-non-transitional
> >   * virtio-1-blk-pci-transitional
> > 
> > This way, we:
> > * Include only the major version of the spec (so
> >   we don't require new device types for virtio 1.1, 1.2, etc),
> > * Use terms that come from the Virtio spec itself, to avoid
> >   ambiguity.
> 
> I'd say just drop "1" completely then.  E.g. transitional and legacy
> have same ID's, differences are internal and not interesting to users.
> If spec comes up with a new type of device it will come up with a new
> term for it, I am sure.

Sounds good to me.  I'll do that in v2.

-- 
Eduardo
