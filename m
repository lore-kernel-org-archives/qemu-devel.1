Received: from eggs.gnu.org ([2001:4830:134:3::10]:47904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fR2Jw-0001mv-Sf
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 17:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fR2Jv-00005H-Rl
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 17:19:48 -0400
Date: Fri, 8 Jun 2018 00:19:40 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180608001843-mutt-send-email-mst@kernel.org>
References: <61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
	<20180606143134.GG2660@work-vm>
	<39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606150507.GJ2660@work-vm>
	<66727986-1cf1-c12e-d78c-d56cc15eaf00@redhat.com>
	<20180606163246.GL3064@redhat.com>
	<f3914a591a46c9d489f2fa1ad2ac4fd0c5a9e5b6.camel@redhat.com>
	<20180607103218.GC1455@redhat.com>
	<20180607103620.GJ28827@redhat.com>
	<dd014be5c818e71d4f833e150fbae11e490e2325.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <dd014be5c818e71d4f833e150fbae11e490e2325.camel@redhat.com>
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
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

On Thu, Jun 07, 2018 at 12:54:33PM +0200, Andrea Bolognani wrote:
> On Thu, 2018-06-07 at 11:36 +0100, Daniel P. Berrang=E9 wrote:
> > On Thu, Jun 07, 2018 at 11:32:18AM +0100, Richard W.M. Jones wrote:
> > > Another problem which Laszlo mentioned is the varstore isn't portab=
le
> > > between UEFI implementations, or if the UEFI is compiled with
> > > different options.  You can even imagine shipping multiple
> > > varstores(!) which argues for a tar-like format.
> >=20
> > Could we perhaps imagine shipping the actual UEFI bios, rather
> > than only the varstore.  The bios blob runs in guest context,
> > so there shouldn't be able security concerns from hosting
> > vendors with running user provided bios. Mostly its a matter
> > of confidence that the interface between bios & qemu is stable
> > which feels easier than assuming varstore vs different bios is
> > portable.
>=20
> That sounds sensible, and further reinforces the idea that we
> need way more than a single string baked into the qcow2 file.

I don't think anyone said we want a single string.
What was proposed is a set of key value pairs with
values being binary blobs.

> --=20
> Andrea Bolognani / Red Hat / Virtualization
