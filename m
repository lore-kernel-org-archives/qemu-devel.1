Received: from eggs.gnu.org ([2001:4830:134:3::10]:52495)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXRsz-0007dJ-Ky
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:22:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gXRst-0005QA-V4
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:22:45 -0500
Date: Thu, 13 Dec 2018 15:22:10 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181213142210.GE5427@linux.fritz.box>
References: <20181212220410.569069-1-eblake@redhat.com>
	<20181213101154.GA5171@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181213101154.GA5171@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, rjones@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 13.12.2018 um 11:11 hat Daniel P. Berrang=E9 geschrieben:
> On Wed, Dec 12, 2018 at 04:04:10PM -0600, Eric Blake wrote:
> > When a qemu-io command fails, it's best if the failure message
> > goes to stderr rather than stdout.
> >=20
> > Reported-by: Richard W.M. Jones <rjones@redhat.com>
> > Signed-off-by: Eric Blake <eblake@redhat.com>
> > ---
> >=20
> > RFC because at least iotest 60 (found by -qcow2 -g quick) breaks due
> > to reordering of output lines, and I'd rather know if we like this
> > idea before bothering to revisit all affected iotests (including
> > discovering if other slower ones have similar problems).
>=20
> I think the change is correct. Error messages should never go to stdout=
.

I'm not sure about this, to be honest. qemu-io is first and foremost an
interactive program, and spreading output across two streams, one
buffered and one unbuffered, in an interactive program feels like it has
to result in surprises.

Kevin
