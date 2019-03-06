Received: from eggs.gnu.org ([209.51.188.92]:33947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1Sf6-0000fP-9P
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:16:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1h1Sf4-0006sn-Mu
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:16:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58838)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1h1Sf4-0006b3-8b
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:16:26 -0500
Date: Wed, 6 Mar 2019 09:10:08 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190306091008.GC20806@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20181205195704.17605-1-ehabkost@redhat.com>
	<3571700849fab25a1bc69960ca24284f0760fe02.camel@redhat.com>
	<20190305143801.lq4gpetubspftkda@sirius.home.kraxel.org>
	<81d22ed88833ed22a1c3781c3c0c1eafad99b280.camel@redhat.com>
	<20190306074148.GA9131@angien.pipo.sk> <20190306083032.GZ1252@lpt>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190306083032.GZ1252@lpt>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH for-4.0 v4 0/2] virtio: Provide
 version-specific variants of virtio PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?J=C3=A1n?= Tomko <jtomko@redhat.com>
Cc: Peter Krempa <pkrempa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, libvir-list@redhat.com, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Andrea Bolognani <abologna@redhat.com>, Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org, Max@angien.pipo.sk, Cleber Rosa <crosa@redhat.com>, Gonglei <arei.gonglei@huawei.com>, Gerd Hoffmann <kraxel@redhat.com>, Laine Stump <laine@redhat.com>, Caio Carrara <ccarrara@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Reitz <mreitz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>

On Wed, Mar 06, 2019 at 09:30:32AM +0100, J=C3=A1n Tomko wrote:
> On Wed, Mar 06, 2019 at 08:41:48AM +0100, Peter Krempa wrote:
> > On Tue, Mar 05, 2019 at 16:56:43 +0100, Andrea Bolognani wrote:
> > > On Tue, 2019-03-05 at 15:38 +0100, Gerd Hoffmann wrote:
> >=20
> > [...]
> >=20
> > > So I agree neither scenario is exactly perfect, but I still think
> > > adding non-transitional alias devices would overall be more
> > > user-friendly.
> >=20
> > I don't think it makes sense to add it at the qemu level. From libvir=
t's
> > point of view users should be shielded from any qemu impl detail or
> > inconsistency as libvirt is the 'user friendly'[1] layer. In qemu the
> > devices would be the same and thus does not make sense to do that
> > because it would be more confusing.
> >=20
> > You can argue that we should add the alias at the libvirt level thoug=
h.
> >=20
>=20
> You can, but please don't.

Indeed, at the libvirt level we've always tried to take the view that
there should be one way to expressing each concept/feature. Adding
new names / xml elements that duplicate existing supported concepts
to make things "consistent" is a slippery slope becasue there are
100's of places to which that can apply when you have hindsight.

It is not going to make a significant difference to how "user friendly"
libvirt is - that is not a core goal in its own right at the API / XML
schema level. It is can be a factor in deciding between multiple competin=
g
designs when first adding a feature, but it isn't a reason to add duplica=
tion
in the API / XML.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
