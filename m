Received: from eggs.gnu.org ([2001:4830:134:3::10]:56503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvUEb-00083S-Iw
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 15:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cvUEX-0002th-Cj
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 15:35:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47852)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cvUEX-0002tF-6T
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 15:35:17 -0400
Date: Tue, 4 Apr 2017 16:35:10 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170404193510.GA15929@thinpad.lan.raisama.net>
References: <20170401004624.30886-1-ehabkost@redhat.com>
	<20170401004624.30886-20-ehabkost@redhat.com>
	<a68c146f-7afa-235b-480b-25676a6bc519@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a68c146f-7afa-235b-480b-25676a6bc519@redhat.com>
Subject: Re: [Qemu-devel] [RFC 19/19] virtio-mmio: Remove user_creatable flag
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@suse.de>, Markus Armbruster <armbru@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Marcel Apfelbaum <marcel@redhat.com>

On Mon, Apr 03, 2017 at 05:50:13PM +0200, Laszlo Ersek wrote:
> On 04/01/17 02:46, Eduardo Habkost wrote:
> > virtio-mmio needs to be wired and mapped by other device or board
> > code, and won't work with -device. Remove the user_creatable flag
> > from the device class.
> > 
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: Shannon Zhao <zhaoshenglong@huawei.com>
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  hw/virtio/virtio-mmio.c | 5 -----
> >  1 file changed, 5 deletions(-)
> > 
> > diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> > index b595512a3d..5807aa87fe 100644
> > --- a/hw/virtio/virtio-mmio.c
> > +++ b/hw/virtio/virtio-mmio.c
> > @@ -450,11 +450,6 @@ static void virtio_mmio_class_init(ObjectClass *klass, void *data)
> >      dc->reset = virtio_mmio_reset;
> >      set_bit(DEVICE_CATEGORY_MISC, dc->categories);
> >      dc->props = virtio_mmio_properties;
> > -    /*
> > -     * FIXME: Set only for compatibility on q35 machine-type.
> > -     * Probably never meant to be user-creatable
> > -     */
> > -    dc->user_creatable = true;
> >  }
> >  
> >  static const TypeInfo virtio_mmio_info = {
> > 
> 
> Possible addition to the commit message: a reference to commit
> 587078f0ed63 ("hw/arm/virt: explain device-to-transport mapping in
> create_virtio_devices()", 2015-02-05).

I'm confused by the comments there: it says "Unfortunately, we
can't counteract the kernel change by reversing the loop; it
would break existing command lines". But, which comment-lines it
would break, if "-device virtio-mmio" was never supported?

> 
> That's another example showing that board code has to participate in
> virtio-mmio transport placement.
> 
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!

-- 
Eduardo
