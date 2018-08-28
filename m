Received: from eggs.gnu.org ([2001:4830:134:3::10]:39288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fubTX-0001vg-A6
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:43:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fubHe-00063s-RN
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:31:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54838 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fubHe-00063W-MD
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 06:31:38 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E498C87A82
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 10:31:37 +0000 (UTC)
Date: Tue, 28 Aug 2018 11:31:27 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180828103127.GG25114@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180822095421.11765-8-quintela@redhat.com>
	<0d3a215b-4916-b0a6-5654-5d64fcf6c996@redhat.com>
	<87y3cyo4ax.fsf@trasno.org>
	<20180823074321.wx7wix7jwsfrcbk5@sirius.home.kraxel.org>
	<9cb5f027-e49c-d943-7ffa-9e744537f174@redhat.com>
	<20180823094850.zycuwtjndmztgcm4@sirius.home.kraxel.org>
	<20180823095359.GH23703@redhat.com>
	<20180827105321.5qeclqhsopqtutjv@sirius.home.kraxel.org>
	<20180828081920.GA25114@redhat.com>
	<20180828102002.wri67kcvzkta7et3@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180828102002.wri67kcvzkta7et3@sirius.home.kraxel.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 07/10] check: Only test boot-serial when
 sga is compiled in
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, lvivier@redhat.com, Juan Quintela <quintela@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, peterx@redhat.com, dgilbert@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On Tue, Aug 28, 2018 at 12:20:02PM +0200, Gerd Hoffmann wrote:
> On Tue, Aug 28, 2018 at 09:19:20AM +0100, Daniel P. Berrang=C3=A9 wrote=
:
> > On Mon, Aug 27, 2018 at 12:53:21PM +0200, Gerd Hoffmann wrote:
> > >   Hi,
> > >=20
> > > > The only way we can stop using "-device sga" is if we either have
> > > > something explicit in the XML saying whether to use it or not, or
> > > > alternatively have some indicator associated with the next versio=
ned
> > > > machine type that we can hook off.
> > >=20
> > > How does libvirt query the machine type properties?
> >=20
> > libvirt is able to query properties against i440FX-pcihost and
> > q35-pcihost devices - currently we only look for one prop:
> >=20
> > static struct virQEMUCapsStringFlags virQEMUCapsDevicePropsI440FXPCIH=
ost[] =3D {
> >     { "pci-hole64-size", QEMU_CAPS_I440FX_PCI_HOLE64_SIZE },
> > };
> >=20
> > static struct virQEMUCapsStringFlags virQEMUCapsDevicePropsQ35PCIHost=
[] =3D {
> >     { "pci-hole64-size", QEMU_CAPS_Q35_PCI_HOLE64_SIZE },
> > };
> >=20
> > Not sure if that's the kind of thing you're looking for ?
>=20
> Looking for way for libvirt to figure whenever a specific machine type
> has sga deprecated or not.  So, if libvirt can query device properties,
> can we just add a "deprecated" property to sga and flip that to true fo=
r
> 3.1+ machine types?

Unfortunately not, because libvirt probes everthing with '-machine none'

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
