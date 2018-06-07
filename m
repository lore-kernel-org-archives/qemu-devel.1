Received: from eggs.gnu.org ([2001:4830:134:3::10]:46999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fQsZ3-0006YC-R7
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:54:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1fQsZ2-00061f-Uq
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 06:54:45 -0400
Message-ID: <dd014be5c818e71d4f833e150fbae11e490e2325.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Thu, 07 Jun 2018 12:54:33 +0200
In-Reply-To: <20180607103620.GJ28827@redhat.com>
References: <9e8b49fb-0162-bf35-21bb-acc0dc28555f@redhat.com>
	<20180606120050.GB2661@work-vm>
	<61a301dd-8e50-8799-8328-341d6ab744f5@redhat.com>
	<20180606143134.GG2660@work-vm>
	<39bcee27-329a-61d8-47fa-678b431b0a79@redhat.com>
	<20180606150507.GJ2660@work-vm>
	<66727986-1cf1-c12e-d78c-d56cc15eaf00@redhat.com>
	<20180606163246.GL3064@redhat.com>
	<f3914a591a46c9d489f2fa1ad2ac4fd0c5a9e5b6.camel@redhat.com>
	<20180607103218.GC1455@redhat.com> <20180607103620.GJ28827@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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
To: "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, armbru@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, stefanha@redhat.com, Max Reitz <mreitz@redhat.com>

On Thu, 2018-06-07 at 11:36 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Jun 07, 2018 at 11:32:18AM +0100, Richard W.M. Jones wrote:
> > Another problem which Laszlo mentioned is the varstore isn't portable
> > between UEFI implementations, or if the UEFI is compiled with
> > different options.  You can even imagine shipping multiple
> > varstores(!) which argues for a tar-like format.
>=20
> Could we perhaps imagine shipping the actual UEFI bios, rather
> than only the varstore.  The bios blob runs in guest context,
> so there shouldn't be able security concerns from hosting
> vendors with running user provided bios. Mostly its a matter
> of confidence that the interface between bios & qemu is stable
> which feels easier than assuming varstore vs different bios is
> portable.

That sounds sensible, and further reinforces the idea that we
need way more than a single string baked into the qcow2 file.

--=20
Andrea Bolognani / Red Hat / Virtualization
