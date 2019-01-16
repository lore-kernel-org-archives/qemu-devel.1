Received: from eggs.gnu.org ([209.51.188.92]:53031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjhb2-0006Y8-Ks
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:34:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gjhb0-00081x-Ml
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:34:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45166)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gjhb0-0007v8-G6
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:34:50 -0500
Date: Wed, 16 Jan 2019 09:34:36 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190116093436.GE20275@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190115145256.9593-1-berrange@redhat.com>
	<20190115145256.9593-7-berrange@redhat.com>
	<7aa007ec-126d-2a97-aa45-91468f7f8ad4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7aa007ec-126d-2a97-aa45-91468f7f8ad4@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/12] chardev: remove unused 'sioc'
 variable & cleanup paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Yongji Xie <elohimes@gmail.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Wed, Jan 16, 2019 at 06:24:49AM +0100, Thomas Huth wrote:
> On 2019-01-15 15:52, Daniel P. Berrang=C3=A9 wrote:
> > The 'sioc' variable in qmp_chardev_open_socket was unused since
> >=20
> >   commit 3e7d4d20d3a528b1ed10b1dc3d83119bfb0c5f24
> >   Author: Peter Xu <peterx@redhat.com>
> >   Date:   Tue Mar 6 13:33:17 2018 +0800
> >=20
> >     chardev: use chardev's gcontext for async connect
> [...]
> > -error:
> > -    if (sioc) {
> > -        object_unref(OBJECT(sioc));
> > -    }
>=20
> So who is doing the object_unref() now in case of errors? That commit
> did not take care of it ... so it sounds like we could be leaving
> references behind in case of errors here?

As shown in the patch diff chunks, no code is ever setting "sioc" in
this method, so it can't ever be non-NULL

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
