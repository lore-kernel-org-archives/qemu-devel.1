Received: from eggs.gnu.org ([2001:4830:134:3::10]:37525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQvIt-0006rD-NR
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fQvIq-0002vc-KN
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 09:50:15 -0400
Date: Thu, 7 Jun 2018 14:49:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180607134953.GN2522@work-vm>
References: <61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
	<20180606143134.GG2660@work-vm>
	<39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606150507.GJ2660@work-vm>
	<66727986-1cf1-c12e-d78c-d56cc15eaf00@redhat.com>
	<20180606163246.GL3064@redhat.com>
	<f3914a591a46c9d489f2fa1ad2ac4fd0c5a9e5b6.camel@redhat.com>
	<20180607102257.GH28827@redhat.com>
	<2afb9305deb37c8ca4f930235eaf52486ab0153e.camel@redhat.com>
	<20180607123847.GL28827@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180607123847.GL28827@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] storing machine data in qcow images?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

* Daniel P. Berrang=E9 (berrange@redhat.com) wrote:
> On Thu, Jun 07, 2018 at 01:17:24PM +0200, Andrea Bolognani wrote:
> > On Thu, 2018-06-07 at 11:22 +0100, Daniel P. Berrang=E9 wrote:
> > > On Thu, Jun 07, 2018 at 12:02:29PM +0200, Andrea Bolognani wrote:
> > > > While hints might be considered a reasonable fit for qcow2, I thi=
nk
> > > > it's pretty hard to argue for embedding the NVRAM file in there,
> > > > which to me signals quite clearly that an archive containing the
> > > > disk image(s) *and* the configuration hints *and* other ancillary
> > > > files such as the NVRAM is the only way to build a solution that'=
s
> > > > not dead on arrival.
> > >=20
> > > On a similar theme, I can imagine users wanting to provide a TPM
> > > data blob too, and for AMD SEV we'd need to be able to provide a
> > > DH key, and session blob too IIUC.
> >=20
> > I'm not familiar with the technologies you're talking about, but
> > all that sounds like something very security sensitive and not
> > something eg. the Fedora project would want to bake into their
> > cloud images.
> >=20
> > Perhaps we should keep in mind that this kind of archive format
> > lends itself quite naturally to both generic ready-made images and
> > custom, fully configured images: in the former case it would only
> > contain the few things mentione above, while in the latter it might
> > also have security sensitive data that's specific to the deployment
> > it's going to be used against.
>=20
> I don't thonk there's any such distinction. A downstream user
> may build generic ready-made images, or fully configured app
> specific images. Both can contain the security sensitive data.

Including the nvram and efi makes me nervous; but I can see why together
they might work.  However, there's no guarantee that EFI has been tested
with the QEMU it's used on and ... that could be trouble.
Also, if we're going to start including the EFI rom then that would have
to be migrated with the VM so that after a restart on a different host
it's still using the right ROM that's compatible with it's varfile.

Dave

> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
