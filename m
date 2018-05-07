Received: from eggs.gnu.org ([2001:4830:134:3::10]:58646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1fFoor-0001Q5-Hw
	for qemu-devel@nongnu.org; Mon, 07 May 2018 18:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1fFooq-0005l8-Go
	for qemu-devel@nongnu.org; Mon, 07 May 2018 18:41:21 -0400
Received: from mail-wm0-x22d.google.com ([2a00:1450:400c:c09::22d]:33322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1fFooq-0005kk-AL
	for qemu-devel@nongnu.org; Mon, 07 May 2018 18:41:20 -0400
Received: by mail-wm0-x22d.google.com with SMTP id x12-v6so16864151wmc.0
	for <qemu-devel@nongnu.org>; Mon, 07 May 2018 15:41:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171220192116-mutt-send-email-mst@kernel.org>
References: <20171213082644.83113-1-ben@skyportsystems.com>
	<20171213100712.GA16782@stefanha-x1.localdomain>
	<20171220192116-mutt-send-email-mst@kernel.org>
From: Benjamin Warren <ben@skyportsystems.com>
Date: Mon, 7 May 2018 15:41:17 -0700
Message-ID: <CAFtH1GWjux9u27suHtrpwm4EL_X+9J1jrDTEKx1rLtkmXo6ZAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] virtio-pci: Add subsystem-vendor-id
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu devel list <qemu-devel@nongnu.org>, Yan Vugenfirer <yan@daynix.com>, Ed Swierk <eswierk@skyportsystems.com>, lprosek@redhat.com

Hi Michael,

It looks like this was never applied.  Can it be, please?

On Wed, Dec 20, 2017 at 9:24 AM, Michael S. Tsirkin <mst@redhat.com> wrote:

> On Wed, Dec 13, 2017 at 10:07:12AM +0000, Stefan Hajnoczi wrote:
> > On Wed, Dec 13, 2017 at 12:26:44AM -0800, Ben Warren via Qemu-devel
> wrote:
> > > From: Ben Warren <ben@skyportsystems.com>
> > >
> > > Now that virtio-win guest drivers provided by non-Redhat vendors need
> to
> > > use a different Subsystem Vendor ID value, a way is needed to set this
> > > parameter on the host.  This works with all of the PCI-based devices,
> > > such as NetKVM, viostor, vioscsi, vioserial and balloon.
> > >
> > > Signed-off-by: Ben Warren <ben@skyportsystems.com>
> > > ---
> > >  hw/virtio/virtio-pci.c | 5 +++++
> > >  hw/virtio/virtio-pci.h | 1 +
> > >  2 files changed, 6 insertions(+)
> >
> > Is it possible to put this property in hw/pci/pci.c:pci_props[] so that
> > users can override the Subsystem Vendor ID for any PCI adapter, not just
> > virtio-pci?
>
> The difficulty is that some devices override the ID you would set,
> and there's no way for management to find out.
> So I think virtio is preferable for now.
>

thanks,
Ben
