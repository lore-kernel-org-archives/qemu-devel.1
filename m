Received: from eggs.gnu.org ([2001:4830:134:3::10]:43500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gJbT9-0005Gx-0i
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 04:46:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lhrazky@redhat.com>) id 1gJbT3-0002mg-Gg
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 04:46:50 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52430)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lhrazky@redhat.com>) id 1gJbSz-0007s4-6R
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 04:46:43 -0500
Received: by mail-wm1-f68.google.com with SMTP id l66-v6so1429339wml.2
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 01:46:33 -0800 (PST)
Message-ID: <1541411191.16655.479.camel@redhat.com>
From: =?UTF-8?Q?Luk=C3=A1=C5=A1_Hr=C3=A1zk=C3=BD?= <lhrazky@redhat.com>
Date: Mon, 05 Nov 2018 10:46:31 +0100
In-Reply-To: <300817282.40470623.1541407597782.JavaMail.zimbra@redhat.com>
References: <20181017143604.5194-1-lhrazky@redhat.com>
	<20181017143604.5194-2-lhrazky@redhat.com>
	<1506037511.34884353.1539846969311.JavaMail.zimbra@redhat.com>
	<1540208764.16655.240.camel@redhat.com>
	<1541087251.16655.419.camel@redhat.com>
	<20181105065258.4mpdv5w4rp3eui5p@sirius.home.kraxel.org>
	<300817282.40470623.1541407597782.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
To: Frediano Ziglio <fziglio@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Cc: spice-devel@lists.freedesktop.org, qemu-devel@nongnu.org

On Mon, 2018-11-05 at 03:46 -0500, Frediano Ziglio wrote:
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

I'm not sure -1 will be practically helpful for anything? What will
happen if we use 0 for it? We still aren't sure how we want to handle
the VNC console anyway, should we wait untill we know?

Maybe I should use int32_t instead of uint32_t to have the option to
use -1 if we need it later?

Cheers,
Lukas

> Frediano
