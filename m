Received: from eggs.gnu.org ([2001:4830:134:3::10]:47722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=4790f0bb5=Paul.Durrant@citrix.com>)
	id 1eCjAn-0006jl-JA
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=4790f0bb5=Paul.Durrant@citrix.com>)
	id 1eCjAk-0004kH-G4
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:30:57 -0500
Received: from smtp.citrix.com.au ([103.14.252.240]:1771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=4790f0bb5=Paul.Durrant@citrix.com>)
	id 1eCjAj-0004dZ-Pr
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 04:30:54 -0500
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Thu, 9 Nov 2017 09:30:45 +0000
Message-ID: <fd24582135514408b2e25d2606a77e31@AMSPEX02CL03.citrite.net>
References: <20171107104653.8913-1-paul.durrant@citrix.com>
	<20171108174227.GC8403@stefanha-x1.localdomain>
In-Reply-To: <20171108174227.GC8403@stefanha-x1.localdomain>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v3] xen-disk: use an IOThread per instance
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Stefan Hajnoczi' <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Anthony
	Perard <anthony.perard@citrix.com>, Kevin Wolf <kwolf@redhat.com>, Stefano
	Stabellini <sstabellini@kernel.org>, Max Reitz <mreitz@redhat.com>

> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> Sent: 08 November 2017 17:42
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; xen-devel@lists.xenproject.org; Anthony
> Perard <anthony.perard@citrix.com>; Kevin Wolf <kwolf@redhat.com>;
> Stefano Stabellini <sstabellini@kernel.org>; Max Reitz <mreitz@redhat.com=
>
> Subject: Re: [Qemu-devel] [PATCH v3] xen-disk: use an IOThread per
> instance
>=20
> On Tue, Nov 07, 2017 at 05:46:53AM -0500, Paul Durrant wrote:
> > This patch allocates an IOThread object for each xen_disk instance and
> > sets the AIO context appropriately on connect. This allows processing
> > of I/O to proceed in parallel.
> >
> > The patch also adds tracepoints into xen_disk to make it possible to
> > follow the state transtions of an instance in the log.
>=20
> virtio-blk and virtio-scsi allow the user to specify an IOThread object.
> This allows users to configure the device<->IOThread mapping any way
> they like (e.g. 1:1, M:N).  Are you sure you want to hard-code the
> IOThread mapping?

Stefan,

  Realistically it's the only option at the moment. Xen PV backends are not=
 configured bu QAPI... so no ability to control them from the command line =
or QMP. This is something I seriously intend to address in the near future =
but, for now, I simply want to unlock the performance boost that IOThread c=
an provide.

  Cheers,

    Paul
