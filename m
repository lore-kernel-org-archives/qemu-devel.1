Received: from eggs.gnu.org ([209.51.188.92]:56785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gj1V9-0007cO-6y
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:37:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gj1V8-0001Bz-K6
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:37:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gj1V8-0001An-E7
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 07:37:58 -0500
Date: Mon, 14 Jan 2019 13:37:53 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190114123753.h6sedkqlswxkikus@sirius.home.kraxel.org>
References: <20190111093116.17188-1-kraxel@redhat.com>
	<20190111093116.17188-6-kraxel@redhat.com>
	<06341f73-6063-8cc3-dc1a-e5022ef2e032@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06341f73-6063-8cc3-dc1a-e5022ef2e032@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] [debug] some logging
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, intel-gvt-dev@lists.freedesktop.org

On Fri, Jan 11, 2019 at 09:33:40AM -0600, Eric Blake wrote:
> On 1/11/19 3:31 AM, Gerd Hoffmann wrote:
> > ---
> >  hw/vfio/display.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/hw/vfio/display.c b/hw/vfio/display.c
> > index a3a710b3ee..96b5474243 100644
> > --- a/hw/vfio/display.c
> > +++ b/hw/vfio/display.c
> > @@ -42,6 +42,8 @@ static void vfio_display_edid_link_up(void *opaque)
> >      VFIOPCIDevice *vdev = opaque;
> >      VFIODisplay *dpy = vdev->dpy;
> >  
> > +    fprintf(stderr, "%s:\n", __func__);
> 
> Why fprintf() instead of trace points?

Easier for temporary stuff.  I don't plan to actually merge this one.

cheers,
  Gerd
