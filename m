Received: from eggs.gnu.org ([2001:4830:134:3::10]:52072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dwP6g-0004V6-Fe
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dwP6d-0007uJ-7O
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:51:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dwP6d-0007tn-1o
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:51:11 -0400
Date: Mon, 25 Sep 2017 09:51:00 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170925085100.GC20236@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <mailman.3351.1506066493.14747.qemu-devel@nongnu.org>
	<726A2123-0371-407B-9270-6672DF66D511@gmail.com>
	<20170922124405.GB32000@lemon>
	<D76563D8-D9EB-47E2-9479-DC1A6C34DA3E@gmail.com>
	<1506324675.18120.6.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1506324675.18120.6.camel@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 28/36] tests: Add ubuntu.i386 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Programmingkid <programmingkidx@gmail.com>, Fam Zheng <famz@redhat.com>, "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

On Mon, Sep 25, 2017 at 09:31:15AM +0200, Gerd Hoffmann wrote:
>   Hi,
>=20
> > Mac OS X is built on top of Darwin. Darwin is completely open source
> > and free. There are no copyright issues because it is released under
> > the Apple Public Source License.=C2=A0
>=20
> As far I know cocoa is not open source though.
>=20
> So, can you actually build qemu on darwin?
> And if so, it will probably be GUI-less?

I guess even a GUI-less build would be beneficial to catch any portabilit=
y
concerns in the of the code. The majority of people submitting patches to
cocoa GUI will have tested OS-X builds directly themselves. It is all the
patches to non-cocoa code that are greatest risk of regressions and least
likely to have been tested on OS-X by the patch author.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
