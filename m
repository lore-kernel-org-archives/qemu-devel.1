Received: from eggs.gnu.org ([2001:4830:134:3::10]:43912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5rpO-0000ER-3v
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:52:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1f5rpL-0001dq-00
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:52:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33948 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1f5rpK-0001dP-OW
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:52:42 -0400
Date: Tue, 10 Apr 2018 12:52:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180410115218.GT5155@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180407000117.25640-1-lersek@redhat.com>
	<20180409084940.GE18283@redhat.com>
	<3381bdf1-62ea-9da7-c654-032c0c11fb4e@redhat.com>
	<20180410091832.GG5155@redhat.com>
	<dbb6c144-d8ce-3525-1c9c-7d45b47cc7bc@redhat.com>
	<20180410113444.GR5155@redhat.com>
	<CAFEAcA8pOM=Ck+vek1Ww7juWF_Y-N0LQ-YChsYUr2BUgKj29Ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8pOM=Ck+vek1Ww7juWF_Y-N0LQ-YChsYUr2BUgKj29Ng@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [qemu RFC] qapi: add "firmware.json"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Libvirt <libvir-list@redhat.com>, Alexander Graf <agraf@suse.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, David Gibson <dgibson@redhat.com>, Eric Blake <eblake@redhat.com>, Gary Ching-Pang Lin <glin@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Michal Privoznik <mprivozn@redhat.com>, Peter Krempa <pkrempa@redhat.com>, Thomas Huth <thuth@redhat.com>

On Tue, Apr 10, 2018 at 12:48:28PM +0100, Peter Maydell wrote:
> On 10 April 2018 at 12:34, Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
> > On Tue, Apr 10, 2018 at 01:27:18PM +0200, Laszlo Ersek wrote:
> >
> >> Please go through the rest of the emails in this thread, and advise:
> >> - if the firmware descriptor schema may perhaps live in the libvirt =
tree,
> >> - accordingly, if the schema could be expressed as an XSD (and firmw=
are
> >> packages should provide the descriptor documents as XMLs)
> >> - if you agree that the descriptor document can uniquely reference
> >> mapping methods implemented in libvirtd by simple enum constants (wi=
th
> >> necessary parameters provided).
> >
> > No to all three. This is the responsibility of QEMU to define, becaus=
e
> > this information is relevant to anything managing QEMU not just libvi=
rt.
>=20
> (Please consider this as more of a grenade lobbed into the conversation
> rather than a carefully thought out proposal...)
>=20
> My inclination is to say that it's not really the responsibility
> of QEMU to define either -- we provide emulated models of hardware,
> and it's up to the user or the management layer or the provider
> of the firmware to specify what guest code they want to run and how
> it needs to run on that emulated hardware...
>=20
> Where the QEMU upstream itself is providing firmware blobs
> (in tarballs etc) it's probably our job to specify how they work,
> but if the firmware is compiled and provided by the distro (as eg happe=
ns
> for Arm UEFI blobs at the moment) then I don't see how upstream QEMU
> can reliably define how that firmware needs to be loaded.

QEMU should not provide the actual metadata files themselves - it just
has to the define the file format. The relevant firmware upstreams and
or distros, can provide the metadata files for the blobs they choose
to ship for use with QEMU.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
