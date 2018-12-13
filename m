Received: from eggs.gnu.org ([2001:4830:134:3::10]:34234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gXTRZ-0004CG-5L
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1gXTRT-0004cg-6W
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 11:02:33 -0500
Date: Thu, 13 Dec 2018 16:02:07 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20181213160207.GJ27120@redhat.com>
References: <20181212220410.569069-1-eblake@redhat.com>
	<20181213101154.GA5171@redhat.com>
	<20181213142210.GE5427@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181213142210.GE5427@linux.fritz.box>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] qemu-io: Prefer stderr for error
 messages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu, Dec 13, 2018 at 03:22:10PM +0100, Kevin Wolf wrote:
> Am 13.12.2018 um 11:11 hat Daniel P. Berrang=C3=A9 geschrieben:
> > On Wed, Dec 12, 2018 at 04:04:10PM -0600, Eric Blake wrote:
> > > When a qemu-io command fails, it's best if the failure message
> > > goes to stderr rather than stdout.
> > >=20
> > > Reported-by: Richard W.M. Jones <rjones@redhat.com>
> > > Signed-off-by: Eric Blake <eblake@redhat.com>
> > > ---
> > >=20
> > > RFC because at least iotest 60 (found by -qcow2 -g quick) breaks du=
e
> > > to reordering of output lines, and I'd rather know if we like this
> > > idea before bothering to revisit all affected iotests (including
> > > discovering if other slower ones have similar problems).
> >=20
> > I think the change is correct. Error messages should never go to stdo=
ut.
>=20
> I'm not sure about this, to be honest. qemu-io is first and foremost an
> interactive program, and spreading output across two streams, one
> buffered and one unbuffered, in an interactive program feels like it ha=
s
> to result in surprises.

Just for the record we're using qemu-io extensively for testing
nbdkit, and it's always used non-interactively (ie. =E2=80=98qemu-io -c=E2=
=80=99).
The bug (if it is such) was found because I was using qemu-io to test
for expected errors.

https://github.com/libguestfs/nbdkit/search?q=3Dqemu-io

Rich.

--=20
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rj=
ones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v
