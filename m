Received: from eggs.gnu.org ([2001:4830:134:3::10]:35951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCPZa-0002sH-5I
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gCPZW-0000hz-PS
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:39:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58692)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gCPZW-0000gv-Ik
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:39:42 -0400
Date: Tue, 16 Oct 2018 10:39:21 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181016133921.GQ31060@habkost.net>
References: <20181013025435.25785-1-ehabkost@redhat.com>
	<20181015081641.q6r5wnhm7rq5tgfh@sirius.home.kraxel.org>
	<20181015062543-mutt-send-email-mst@kernel.org>
	<20181015230342.GJ31060@habkost.net>
	<20181016064816.34ykasexdp5ikioz@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016064816.34ykasexdp5ikioz@sirius.home.kraxel.org>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>, Laine Stump <laine@redhat.com>, Caio Carrara <ccarrara@redhat.com>

On Tue, Oct 16, 2018 at 08:48:16AM +0200, Gerd Hoffmann wrote:
>   Hi,
> 
> > I don't know.  The `disable-modern` option already exists but I
> > don't know who would want to use it.
> 
> Compat property for old (2.6 & older) machine types.
> 
> > > Right - maybe a flag to disable modern interface is enough.
> > > We thus get two types:
> > > - transitional (legacy)
> > > - non-transitional (modern)
> > > which matches spec nicely.
> > 
> > I would agree with the removal of virtio-*-0.9 only if we decide
> > to drop support for disable-modern=true.
> 
> See above.  We can't drop disable-modern.

Good point.  But this doesn't require it to be a supported device
option for users/management.  Maybe we should rename it to
"x-disable-modern" (but that's a separate discussion).


> 
> > If we still want to provide a legacy-only virtio device, it should be
> > a separate device type.
> 
> I can't see a reason why we should provide legacy-only virtio devices.

If the only reason for disable-modern to exist is for internal
usage by machine-type code, I agree we don't need the -0.9 device
types.

-- 
Eduardo
