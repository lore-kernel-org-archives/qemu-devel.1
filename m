Received: from eggs.gnu.org ([2001:4830:134:3::10]:53663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gCRdf-00078J-NR
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:52:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gCRde-0003L7-Tk
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:52:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1gCRde-0003Kj-Mg
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:52:06 -0400
Date: Tue, 16 Oct 2018 17:51:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20181016175149.69f608b8.cohuck@redhat.com>
In-Reply-To: <20181016133220.GP31060@habkost.net>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181014173258-mutt-send-email-mst@kernel.org>
	<20181015181404.GQ31060@habkost.net>
	<20181016103930.287d0c2a.cohuck@redhat.com>
	<20181016133220.GP31060@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Fabian Deutsch <fdeutsch@redhat.com>, Markus Armbruster <armbru@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Laine Stump <laine@redhat.com>, Cleber Rosa <crosa@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>

On Tue, 16 Oct 2018 10:32:20 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Tue, Oct 16, 2018 at 10:39:30AM +0200, Cornelia Huck wrote:
> > So, what I'd propose is:
> > - virtio-*-pci-standard: compliant with the virtio standard 1.0 or
> >   later; no legacy fallback
> > - virtio-*-pci-transitional: compliant with the virtio standard 1.0 or
> >   later; fallback to legacy included, as specified by the standard
> > (- virtio-*-pci-legacy: legacy devices, should we need that for compat
> > reasons)
> > 
> > We could also use '-virtio-1' instead of '-standard', if we do a major
> > break with a 2.x standard (I don't see it yet). But having a new type
> > for 1.1 sounds wrong.  
> 
> That's true: adding a new type for 1.1 is probably going to be
> wrong.
> 
> But how can I make any promises about the existing device type
> being compatible with 1.1 (or 1.2, 1.3...), if the 1.1 (or 1.2,
> 1.3...) specification wasn't released yet?

I think the *goal* is to keep them compatible. We'll probably want to
switch to virtio-2 should we want to do an explicit break in the future.

> 
> Maybe using "-virtio-1" would be a good way to be clear we're
> talking about virtio-1.x without making any promises about 1.1,
> 1.2, 1.3, etc.

It would fit the way this is supposed to work, yes.
