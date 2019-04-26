Received: from eggs.gnu.org ([209.51.188.92]:38020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJzcL-0002gM-AV
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hJzcK-0001BA-5j
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:06:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hJzcJ-00015C-W2
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 08:06:12 -0400
Date: Fri, 26 Apr 2019 14:05:58 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190426120558.vh66gugqtvcc6tm5@sirius.home.kraxel.org>
References: <20190423132004.13725-1-marcandre.lureau@redhat.com>
	<20190423132004.13725-6-marcandre.lureau@redhat.com>
	<20190426072446.r7b7wsm4qghd7pzr@sirius.home.kraxel.org>
	<CAJ+F1CKbgb_TkoS_a10qGw7kkTO+EkC4uhreCkOu=k2ut5CAig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKbgb_TkoS_a10qGw7kkTO+EkC4uhreCkOu=k2ut5CAig@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v6 05/11] vhost-user: add
 vhost_user_gpu_set_socket()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

  Hi,

> > > +Wire format
> > > +===========
> > > +
> > > +Unless specified differently, numbers are in the machine native byte
> > > +order.
> > > +
> > > +A vhost-user-gpu request consists of 2 header fields and a payload.
> > > +
> > > ++---------+------+---------+
> > > +| request | size | payload |
> > > ++---------+------+---------+
> > > +
> > > +Header
> > > +------
> > > +
> > > +:request: ``u32``, type of the request
> > > +
> > > +:size: ``u32``, size of the payload
> > > +
> > > +A reply consists only of a payload, whose content depends on the request.
> >
> > I'd suggest to use the same format for replies, only with "request"
> > meaning "status" in replies.  Allows for OK/ERROR status in replies,
> > and having a size field in replies too should make things more robust.
> > Also allows for an empty reply (status=ok,size=0).
> 
> 
> That brings more questions and ambiguity imho.

What questions for example?

> Can we leave that for future protocol extensions negotiated with
> GET/SET_PROTOCOL_FEATURES ?

I don't think negotiating such a basic protocol change is a good idea.

cheers,
  Gerd
