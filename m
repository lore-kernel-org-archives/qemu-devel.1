Received: from eggs.gnu.org ([2001:4830:134:3::10]:36238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQEjM-0006Hw-Ad
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:22:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQEjL-0002d3-6F
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:22:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42176 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fQEjL-0002cr-1R
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 12:22:43 -0400
Date: Tue, 5 Jun 2018 17:22:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180605162239.GU32286@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180603092749.107476-1-marcel.apfelbaum@gmail.com>
	<20180604042928-mutt-send-email-mst@kernel.org>
	<23040757-b561-e0bf-a41d-38d3c44555ee@gmail.com>
	<20180605072746.v6xxabsbewiuw7ka@sirius.home.kraxel.org>
	<20180605084300.GF32286@redhat.com>
	<20180605130646.GF7451@localhost.localdomain>
	<20180605131232.GG32286@redhat.com>
	<20180605191539-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180605191539-mutt-send-email-mst@kernel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] libvirt default machine-type guarantees? (was Re:
 [PATCH RFC] hw/pc: set q35 as the default x86 machine)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, libvir-list@redhat.com

On Tue, Jun 05, 2018 at 07:16:56PM +0300, Michael S. Tsirkin wrote:
> On Tue, Jun 05, 2018 at 02:12:32PM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > eg old OS versions that only work with PC, or more commonly pre-exist=
ing
> > cloud disk images that were built against PC can't be assumed to just
> > work against q35, even if the OS in the image supports it.
>=20
> I don't understand that part - when using libvirt domain xml records th=
e
> machine type used for the install, so it seems that installed images
> won't be affected.

There's no libvirt XML for distributed cloud images, it is created whenev=
er
the image is instantiated. Libvirt also doesn't require use of its persis=
tent
guest feature - it is possible to create so called "transient" guests wit=
h
libvirt where you just provide an XML doc at each boot up, and libvirt do=
es
not save this XML between boots. Even if an app is using persistent libvi=
rt
XML they might not boot the VM on the same host each time, so the previou=
s
persistent XML may not be available at next boot up. So there's many ways
existing deployed guests can be affected by changes in defaults, even whe=
n
libvirt records info in the XML.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
