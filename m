Received: from eggs.gnu.org ([2001:4830:134:3::10]:55230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv38A-0008EJ-HT
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:38:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cv387-0001KV-Dp
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 10:38:54 -0400
Date: Mon, 3 Apr 2017 15:38:47 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170403143847.GB3539@stefanha-x1.localdomain>
References: <20170324123458.yk3rj3g47e5xr33i@eukaryote>
	<6fb77120-dcab-042f-bb51-20ccbaa38354@redhat.com>
	<20170328152934.rebdzsjfsfc6ajrh@eukaryote>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
In-Reply-To: <20170328152934.rebdzsjfsfc6ajrh@eukaryote>
Subject: Re: [Qemu-devel] [Qemu-block] Making QMP 'block-job-cancel'
 transactionable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kashyap Chamarthy <kchamart@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org


--cmJC7u66zC7hs+87
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 28, 2017 at 05:29:34PM +0200, Kashyap Chamarthy wrote:
> On Tue, Mar 28, 2017 at 09:49:40AM -0500, Eric Blake wrote:
> > On 03/24/2017 07:34 AM, Kashyap Chamarthy wrote:
> > > While debugging some other issue, I happened to stumble across an old
> > > libvirt commit[*] that adds support for pivot (whether QEMU should
> > > switch to a target copy or not) operation as a result of issuing QMP
> > > 'block-job-cancel' to a 'drive-mirror' (in libvirt parlance, "block
> > > copy").
> > >=20
> > > In the libvirt commit message[*] Eric Blake writes:
> > >=20
> > >     "[...] There may be potential improvements to the snapshot code to
> > >     exploit block copy over multiple disks all at one point in time.
> > >     And, if 'block-job-cancel' were made part of 'transaction', you
> > >     could copy multiple disks at the same point in time without pausi=
ng
> > >     the domain. [...]"
> > >=20
> > > I realize that 'block-job-cancel' is currently not part of the
> > > @TransactionAction.  Is it worthwhile to do so?
> >=20
> > Yes, it is still worthwhile to make that improvement, although it is
> > now 2.10 material.
>=20
> Thanks for looking, didn't imply that it's for 2.9 (which is in Release
> Candidate phase) -- I realize most people are busy with it.  Further
> discussion could be had when 2.10 tree opens up.

Thanks for the discussion.  I have added this task to the block layer
todo list:

http://wiki.qemu-project.org/ToDo/Block#Atomic_block-job-cancel

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY4l53AAoJEJykq7OBq3PI4FUH/3dfKOkuJURhjER5dlxtOuHO
v46g70ExlUpZGSRZ8YMt/irdmrrpsM2qvEsG2+AIYRzCgw7BQDBD/GgoUlDrD1z6
2QnNWrPlIEBmgpaybsLLi09cYmEWY8cWdN4CkodKi3tqxq868uiCref7tKSRLPgC
ICR1Lm/eSnzukB0awHI83Q4YOFZvYOZnorGXfpx+CD6HybrlHqfNlJgnwqQPghSk
Q1TjxdNLoAuKrS1I4WUO/x/eJRjvZ8bXxRaiF/CjdGvhEnaVAYibGvYAlgMnDqG+
zpXUqJdpU5kJe9OnGvQYLnRq2YFzDlLgFdPUhVEqeJcLa8aJ5X5yc6JI6ooP68M=
=xM8m
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
