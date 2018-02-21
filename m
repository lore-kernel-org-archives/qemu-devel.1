Received: from eggs.gnu.org ([2001:4830:134:3::10]:36929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoSIl-0008Ro-SP
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eoSIh-0001ec-Pg
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:11:07 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38942 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eoSIh-0001dG-L3
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 06:11:03 -0500
Date: Wed, 21 Feb 2018 12:11:00 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180221111100.kcfyhhlgfm2qbfgw@sirius.home.kraxel.org>
References: <20180220225904.16129-1-bsd@redhat.com>
	<20180220225904.16129-5-bsd@redhat.com>
	<20180221093524.GH17096@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180221093524.GH17096@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Bandan Das <bsd@redhat.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org

> > +static void usb_mtp_write_data(MTPState *s)
> > +{
> > +    MTPData *d = s->data_out;
> > +    MTPObject *parent =
> > +        usb_mtp_object_lookup(s, s->dataset.parent_handle);
> > +    char *path = NULL;
> > +    int rc = -1;
> > +    mode_t mask = 0644;
> > +
> > +    assert(d != NULL);
> > +
> 
> 
> Somewhere in here should surely be validating the "readonly" flag.
> 
> > +    if (parent == NULL || !s->write_pending) {

Does happens here.  With a readonly device write_pending should
never be true.

> > +        usb_mtp_queue_result(s, RES_INVALID_OBJECTINFO, d->trans,
> > +                             0, 0, 0, 0);
> > +        return;
> > +    }

But adding an "assert(!readonly)" here as double-check surely doesn't hurt.

cheers,
  Gerd
