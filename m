Received: from eggs.gnu.org ([2001:4830:134:3::10]:39336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQs4Y-00011q-Ao
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:23:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fQs4V-0003tV-4C
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:23:14 -0400
Date: Thu, 7 Jun 2018 11:22:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180607102257.GH28827@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180606111406.GD2660@work-vm>
	<9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
	<20180606120050.GB2661@work-vm>
	<61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
	<20180606143134.GG2660@work-vm>
	<39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606150507.GJ2660@work-vm>
	<66727986-1cf1-c12e-d78c-d56cc15eaf00@redhat.com>
	<20180606163246.GL3064@redhat.com>
	<f3914a591a46c9d489f2fa1ad2ac4fd0c5a9e5b6.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f3914a591a46c9d489f2fa1ad2ac4fd0c5a9e5b6.camel@redhat.com>
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
To: Andrea Bolognani <abologna@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

On Thu, Jun 07, 2018 at 12:02:29PM +0200, Andrea Bolognani wrote:
> On Wed, 2018-06-06 at 17:32 +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Wed, Jun 06, 2018 at 10:36:20AM -0500, Eric Blake wrote:
> > > But for the new config to be useful, you have to modify at least on=
e tool in
> > > the path.  At which point, it is just as easy to say: "libvirt is n=
ow smart
> > > enough to read the config file out of a .qcow2 to know that it shou=
ld prefer
> > > a q35 machine" as it is to say "libvirt is now smart enough to trea=
t a .tar
> > > file containing .qcow2 and a config file that states that it should=
 prefer a
> > > q35 machine", and either approach requires just a single file for t=
he user
> > > to download.
> >=20
> > Just to be clear, libvirt isn't going to do either of those things.
> >=20
> > Whether there is metadata stuffed inside qcow2, or in a metdata file
> > inside a tar file, libvirt is not going to look inside either of them=
.
> > The XML is the only place libvirt deals with the hardware config.
> >=20
> > Extracting machine type is always going to be a job for the layer abo=
ve
> > such as OpenStack/OVirt/Virt-manager/etc. They will then decide wheth=
er
> > or not they want to honour that info, and if so, put it into the XML
> > they give to libvirt.
> >=20
> > As mentioned elsewhere, IMHO, it is more friendly to those tools
> > to use pre-existing formats, eg TAR and XML/JSON, for which
> > their respective programming langauges already have APIs/parsers.
>=20
> Something that I haven't seen mentioned in the thread - and this
> looks like as good a point as any to jump in - is that for q35
> guests using EFI as well as aarch64 guests the "one click import"
> experience requires not only hints about the machine (and firmware!)
> type, but also a copy of the EFI variable store:
>=20
>   $ virt-builder fedora-27 --arch aarch64 --notes
>   Fedora=C2=AE 27 Server (aarch64)
>=20
>   [...]
>=20
>   You will need to use the associated UEFI NVRAM variables file:
>     http://libguestfs.org/download/builder/fedora-27-aarch64-nvram.xz
>=20
> While hints might be considered a reasonable fit for qcow2, I think
> it's pretty hard to argue for embedding the NVRAM file in there,
> which to me signals quite clearly that an archive containing the
> disk image(s) *and* the configuration hints *and* other ancillary
> files such as the NVRAM is the only way to build a solution that's
> not dead on arrival.

On a similar theme, I can imagine users wanting to provide a TPM
data blob too, and for AMD SEV we'd need to be able to provide a
DH key, and session blob too IIUC.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
