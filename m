Received: from eggs.gnu.org ([2001:4830:134:3::10]:49124)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etcDU-0002Dh-VS
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:47:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1etcDT-0006Pf-Oj
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 11:47:01 -0500
References: <20180306204819.11266-1-stefanha@redhat.com>
	<20180306204819.11266-3-stefanha@redhat.com>
	<CANz-nerKaY_NG4enTxut9RuerWGL47sNKkgtJ_QpHws75ckO7A@mail.gmail.com>
	<CAJSP0QXzMf1UdehS3Cp3Yud6a7U4n-ixYTtCawyd8_wGLbWq0w@mail.gmail.com>
	<CANz-neoa1o-x+opbd6OLHdw0K1ROvwA462wXC-MOmXVPDDbu8g@mail.gmail.com>
	<CAJSP0QXt=Mrk8JdWJF4ewwELuP_kPuW1mBKn0BCVr349rpudBw@mail.gmail.com>
	<CANz-neqFk-kdLaWTj3syokjF6Kttsq-L1JvkqDS-uR3KixBkBQ@mail.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f9b85013-fd66-113b-aa59-dc79fe6b3e95@redhat.com>
Date: Wed, 7 Mar 2018 17:46:48 +0100
MIME-Version: 1.0
In-Reply-To: <CANz-neqFk-kdLaWTj3syokjF6Kttsq-L1JvkqDS-uR3KixBkBQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ix4boppCiQZ5d8cOiuykASbFZJDedxC80"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/2] iotests: add 208
 nbd-server + blockdev-snapshot-sync test case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Panella <spanella@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ix4boppCiQZ5d8cOiuykASbFZJDedxC80
From: Max Reitz <mreitz@redhat.com>
To: Stefano Panella <spanella@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>
Message-ID: <f9b85013-fd66-113b-aa59-dc79fe6b3e95@redhat.com>
Subject: Re: [Qemu-block] [PATCH 2/2] iotests: add 208 nbd-server +
 blockdev-snapshot-sync test case
References: <20180306204819.11266-1-stefanha@redhat.com>
 <20180306204819.11266-3-stefanha@redhat.com>
 <CANz-nerKaY_NG4enTxut9RuerWGL47sNKkgtJ_QpHws75ckO7A@mail.gmail.com>
 <CAJSP0QXzMf1UdehS3Cp3Yud6a7U4n-ixYTtCawyd8_wGLbWq0w@mail.gmail.com>
 <CANz-neoa1o-x+opbd6OLHdw0K1ROvwA462wXC-MOmXVPDDbu8g@mail.gmail.com>
 <CAJSP0QXt=Mrk8JdWJF4ewwELuP_kPuW1mBKn0BCVr349rpudBw@mail.gmail.com>
 <CANz-neqFk-kdLaWTj3syokjF6Kttsq-L1JvkqDS-uR3KixBkBQ@mail.gmail.com>
In-Reply-To: <CANz-neqFk-kdLaWTj3syokjF6Kttsq-L1JvkqDS-uR3KixBkBQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-07 17:43, Stefano Panella wrote:
>=20
>=20
> On Wed, Mar 7, 2018 at 4:16 PM, Stefan Hajnoczi <stefanha@gmail.com
> <mailto:stefanha@gmail.com>> wrote:
>>
>> On Wed, Mar 7, 2018 at 1:57 PM, Stefano Panella <spanella@gmail.com
> <mailto:spanella@gmail.com>> wrote:
>> > On Wed, Mar 7, 2018 at 10:55 AM, Stefan Hajnoczi <stefanha@gmail.com=

> <mailto:stefanha@gmail.com>> wrote:
>> >>
>> >> On Tue, Mar 6, 2018 at 11:25 PM, Stefano Panella
> <spanella@gmail.com <mailto:spanella@gmail.com>>
>> >> wrote:
>> >> > I have applied this patch and when I run the following qmp
> commands I I
>> >> > do
>> >> > not see the crash anymore but there is still something wrong beca=
use
>> >> > only
>> >> > /root/a is opened from qemu. It looks like nbd-server-stop is als=
o
>> >> > getting
>> >> > rid of the nodes added with blockdev-snapshot-sync, therfore is
> than not
>> >> > possible to do blockdev-del on /root/d because node-name is not f=
ound
>> >>
>> >> Nodes are reference counted.=C2=A0 If nothing holds a refcount then=
 the
>> >> node is freed.
>> > Thanks, that explains the behaviour
>> >>
>> >> The blockdev-add command holds a reference to the node.=C2=A0 The n=
ode will
>> >> stay alive until blockdev-del, which releases that reference.
>> >>
>> >> blockdev-snapshot-sync does not hold a reference.=C2=A0 Therefore s=
napshot
>> >> nodes are freed once nothing is using them anymore.=C2=A0 When the =
snapshot
>> >> node is created, the users of the parent node are updated to point =
to
>> >> the snapshot node instead.=C2=A0 This is why the NBD server switche=
s to the
>> >> snapshot mode after blockdev-snapshot-sync.
>> >>
>> >> This is why the snapshot nodes disappear after the NBD server is
>> >> stopped while /root/a stays alive.
>> >>
>> >> I'm not sure if the current blockdev-snapshot-sync behavior is usef=
ul.
>> >> Perhaps the presence of the "snapshot-node-name" argument should ca=
use
>> >> the snapshot node to be treated as monitor-owned, just like
>> >> blockdev-add.=C2=A0 This would introduce leaks for existing QMP cli=
ents
>> >> though, so it may be necessary to add yet another argument for this=

>> >> behavior.
>> > that would be nice, I mean to add an extra parameter so it is added
> to the
>> > monitor
>> >>
>> >> Anyway, I hope this explains the current behavior.=C2=A0 I don't se=
e a
>> >> problem with it, but it's something the API users need to be aware =
of.
>> >>
>> > Yes, I was not aware of that behaviour, the problem is that many
> examples
>> > refer
>> > to having a device associated with the blockdev-add'd node therefore=

> we do
>> > not
>> > see this problem.
>> >> If it is a problem for your use case, please explain what you are
> trying
>> >> to do.
>> >>
>> > It is not strictly a problem for my usecase but it would be nice to
> have the
>> > extra param to
>> > blockdev-snapshot-sync. That would also fix the problem of running
> multiple
>> > snap-sync
>> > after blockdev-add but before there is any user.
>>
>> Max Reitz mentioned that the 'blockdev-snapshot' command is preferred
>> over 'blockdev-snapshot-sync'. =C2=A0'blockdev-snapshot-sync' is a leg=
acy
>> command that implicitly creates the snapshot node.
>>
>> The difference is that 'blockdev-snapshot' requires that the user
>> first creates the snapshot file (e.g. using qemu-img create), then
>> uses 'blockdev-add' to add the snapshot node, and finally uses
>> 'blockdev-snapshot' to install the snapshot node.
>>
>> When 'blockdev-snapshot' is used, the user must delete snapshot nodes
>> using 'blockdev-del' since they created using 'blockdev-add'.
>>
> That is a very usefull info, I was not aware that blockdev-snapshot-syn=
c
> was not
> recommended.

Yeah, well...  Someone (O:-)) needs to go over all the block QMP
commands and see which are good and which should be deprecated at some
point.  I don't think we have a central list of everything yet...

> I will try to run some examples with blockdev-snapshot.
> In case I want to achieve
> A <- B
> and I do:
> blockdev_add A
> create external snapshot with qemu-img B with A as backing image
> blockdev_add B
> blockdev_snapshot B -> A
>=20
> What do I need to do to delete A and B?
> is it fine to just call blockdev_del B ?
> or should I call blockdev_del A as well?

You need to call both.  The basic idea is that you have to pair every
blockdev-add with a blockdev-del.

(You have to delete B first, though, because you cannot delete a node
while it is in use (and A is in use by B as long as B exists).)

Don't forget the '"backing": null" parameter for the blockdev-add B
command, or B will already have A opened as its backing image (which is
not good, you don't want qemu to open the same image twice).

(Or maybe blockdev-add B will not even work without '"backing": null'
because qemu figures out that you are trying to open the same image (A)
twice and prevent that.)

Max


--Ix4boppCiQZ5d8cOiuykASbFZJDedxC80
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqgF3gSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A9VEH/iAahyQP3iyWPKMmzOfYVAjdAh1H2OS/
ByCTDDgCmXrV0JuwE0PGIeh2ZxL9iwOo4RuskYDYVcRBdOKhuBHQBBVcFdAbkXjp
l1h6OkSrPA+x5yPNsVvG7UzUpDYtnCa4/Hd1QcBePiyAmlWU/fRr3JYf17c9V+zq
6c1Ru66e5RDFqn2R7iDGoB4GgT5+cnZcFYoH5JnUh/S30qPXvAwnlG7ENy8YA4gP
mEm2C9VlFkb7SkngVydTdNGnlmKFWmvxbkKhOaixWOjQuamCNhJryocCxg2ZFlSI
WSmbw6R9iuCjOwvYEMSogiXkPDW4bfjgItqQQSCBYqcpA5zjVybju+Y=
=1eCk
-----END PGP SIGNATURE-----

--Ix4boppCiQZ5d8cOiuykASbFZJDedxC80--
