Received: from eggs.gnu.org ([2001:4830:134:3::10]:41907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJctD-00057l-FN
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:17:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gJct8-0007vN-FM
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:17:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gJct8-0007kO-7N
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:17:46 -0500
Date: Mon, 5 Nov 2018 12:17:44 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181105111744.xk4jxh2dqkc2ghlx@sirius.home.kraxel.org>
References: <20181017143604.5194-1-lhrazky@redhat.com>
	<20181017143604.5194-2-lhrazky@redhat.com>
	<1506037511.34884353.1539846969311.JavaMail.zimbra@redhat.com>
	<1540208764.16655.240.camel@redhat.com>
	<1541087251.16655.419.camel@redhat.com>
	<20181105065258.4mpdv5w4rp3eui5p@sirius.home.kraxel.org>
	<300817282.40470623.1541407597782.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <300817282.40470623.1541407597782.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH spice v2 1/2] QXL interface: add
 functions to identify monitors in the guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: =?utf-8?B?THVrw6HFoSBIcsOhemvDvQ==?= <lhrazky@redhat.com>, spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

On Mon, Nov 05, 2018 at 03:46:37AM -0500, Frediano Ziglio wrote:
> > 
> > > 2. Have a single function as follows:
> > > 
> > > void spice_qxl_set_device_info(QXLInstance *instance,
> > >                                const char *device_address,
> > >                                uint32_t device_display_id_start,
> > >                                uint32_t device_display_id_count);
> > 
> > How about:
> > 
> > void spice_qxl_set_device_info(QXLInstance *instance,
> >                                const char *device_address,
> >                                uint32_t device_display_id);
> > 
> > I don't think we need start+count:
> > 
> >  * For single-head devices device_display_id will be zero.
> >  * For one-channel-per-head multihead devices (i.e. virtio-gpu)
> >    device_display_id will enumerate the heads (so everybody can figure
> >    which channel is which head).
> >  * For one-channel-per-device multihead devices (i.e. qxl/linux)
> >    device_display_id will be zero too.  Number of heads is set via
> >    spice_qxl_set_max_monitors().
> > 
> > cheers,
> >   Gerd
> > 
> 
> What about "Console VNC" case? Passing a dummy (like -1) value for device_display_id ?
> Kind of "I don't know which output is."

I'd use zero, assuming in case only one of multiple heads shows up as
vnc console it'll be the primary head.

But using -1 kind-of makes sense too.

cheers,
  Gerd
