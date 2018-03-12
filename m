Received: from eggs.gnu.org ([2001:4830:134:3::10]:49698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evLSy-0003Uj-8K
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:18:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1evLSu-0001fL-6j
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:18:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46486 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1evLSu-0001eC-0o
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:18:04 -0400
Date: Mon, 12 Mar 2018 11:17:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180312111756.GF3493@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180307144951.d75lo5rgzi2vf27z@eukaryote>
	<90ba320e-2a05-8962-dc6b-252b3e15d1b7@redhat.com>
	<20180308154730.GZ4718@redhat.com>
	<c455f46b-dc25-fe7e-acc8-140f4a703e94@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c455f46b-dc25-fe7e-acc8-140f4a703e94@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] Defining firmware (OVMF,
 et al) metadata format & file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Kashyap Chamarthy <kchamart@redhat.com>, qemu-devel@nongnu.org, libvir-list@redhat.com, kraxel@redhat.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>

On Thu, Mar 08, 2018 at 09:47:27PM +0100, Laszlo Ersek wrote:
> On 03/08/18 16:47, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Mar 08, 2018 at 12:10:30PM +0100, Laszlo Ersek wrote:
>=20
> >> I suggest (or agree) that the property list be composed of free-form
> >> name=3Dvalue pairs (at least conceptually). I understand Gerd is pro=
posing
> >> a QAPI schema for this, so maybe do { property_name : "foo",
> >> property_value : "bar" }, or similar. The registry of properties (na=
mes,
> >> possible values, meanings) should be kept separate (although possibl=
y
> >> still under QEMU).
> >>
> >> For OVMF (x86), I guess the initial set of properties should come fr=
om
> >> the "-D FOO[=3DBAR]" build flags that OVMF currently supports. (The =
list
> >> might grow or change incompatibly over time, so this is just a raw
> >> starter idea.)
> >=20
> > I really don't want to see us using firmware implementation specific
> > property names in these files. It means libvirt will require knowledg=
e
> > of what each different firmware's property names mean.
> >=20
> > We need to have some core standardized set of property names that can
> > be provided by any firmware implementation using the same terminology=
.
> >=20
> > If we want to /also/ provide some extra firmeware-specific property
> > names that would be ok for informative purposes, but when lbivirt is
> > picking which firmware file to use, it would only ever look at the
> > standardized property names/values.
>=20
> This is a reasonable requirement from the libvirt side.
>=20
> Unfortunately (or not), it requires someone (or a tight group of people=
)
> to collect the features of all virtual firmwares in existence, and
> extract a common set of properties that maps back to each firmware one
> way or another. This is not unusual (basically this is how all standard=
s
> bodies work that intend to codify existing practice), it just needs a
> bunch of work and coordination. We'll have to maintain a registry.
>=20
> Personally I can't comment on anything else than OVMF and the ArmVirt
> firmwares.

I don't think it is actually a big problem. Today there is a very small
set of features we'll care about when selecting between firmware files.
For most architectures/firmwares, I expect there will just be a single
firmware image, tagged with architecture name, and possibly machine
type.

I think EFI will be the only case we have to start off with, where we
need to define a few extra standard features (for the SMM + secureboot
essentially).  We can just iterate on this as more use cases / features
come to light.


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
