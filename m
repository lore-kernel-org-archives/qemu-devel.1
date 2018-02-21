Received: from eggs.gnu.org ([2001:4830:134:3::10]:53406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eoVSe-0008Jt-HS
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 09:33:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eoVSa-0003lx-Jj
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 09:33:32 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46816 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eoVSa-0003l7-ES
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 09:33:28 -0500
Date: Wed, 21 Feb 2018 14:33:17 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180221143317.GU17096@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180220225904.16129-1-bsd@redhat.com>
	<20180220225904.16129-5-bsd@redhat.com>
	<20180221093524.GH17096@redhat.com>
	<20180221111100.kcfyhhlgfm2qbfgw@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180221111100.kcfyhhlgfm2qbfgw@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH v4 4/5] usb-mtp: Introduce write support
 for MTP objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Bandan Das <bsd@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org

On Wed, Feb 21, 2018 at 12:11:00PM +0100, Gerd Hoffmann wrote:
> > > +static void usb_mtp_write_data(MTPState *s)
> > > +{
> > > +    MTPData *d = s->data_out;
> > > +    MTPObject *parent =
> > > +        usb_mtp_object_lookup(s, s->dataset.parent_handle);
> > > +    char *path = NULL;
> > > +    int rc = -1;
> > > +    mode_t mask = 0644;
> > > +
> > > +    assert(d != NULL);
> > > +
> > 
> > 
> > Somewhere in here should surely be validating the "readonly" flag.
> > 
> > > +    if (parent == NULL || !s->write_pending) {
> 
> Does happens here.  With a readonly device write_pending should
> never be true.

Unless I'm mis-understanding the flow, the next patch appears to set
write_pending = true, in response to a guest command, without checking
the readonly flag.

> 
> > > +        usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
> > > +                             0, 0, 0, 0);
> > > +        return;
> > > +    }
> 
> But adding an "assert(!readonly)" here as double-check surely doesn't hurt.
> 
> cheers,
>   Gerd
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
