Received: from eggs.gnu.org ([2001:4830:134:3::10]:49142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eANCC-0002SG-34
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 17:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eANCB-0008Do-9H
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 17:38:40 -0400
References: <20171102120223.GI32533@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <50b7935f-c02f-7d7d-4e8e-fc8967e85d2e@redhat.com>
Date: Thu, 2 Nov 2017 22:38:16 +0100
MIME-Version: 1.0
In-Reply-To: <20171102120223.GI32533@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="M8IkkgB4AaaHtf58FHJm97niU7bflfRox"
Subject: Re: [Qemu-devel] [Qemu-block] RFC: use case for adding QMP,
 block jobs & multiple exports to qemu-nbd ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--M8IkkgB4AaaHtf58FHJm97niU7bflfRox
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <50b7935f-c02f-7d7d-4e8e-fc8967e85d2e@redhat.com>
Subject: Re: [Qemu-block] RFC: use case for adding QMP, block jobs & multiple
 exports to qemu-nbd ?
References: <20171102120223.GI32533@redhat.com>
In-Reply-To: <20171102120223.GI32533@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-02 13:02, Daniel P. Berrange wrote:
[...]
> One alternative approach to doing this would be to suggest that we shou=
ld
> instead just spawn qemu-system-x86_64 with '--machine none' and use tha=
t
> as a replacement for qemu-nbd, since it already has a built-in NBD serv=
er
> which can do many exports at once and arbitrary block jobs.

As far as I know, we had wanted to add QMP support to qemu-nbd maybe one
or two years ago, but nobody ever did it.

I've had some discussions about this with Markus and Kevin at KVM Forum.
 They appeared to strongly prefer this approach.  I agree with them that
design-wise, a qemu with no machine at all (and not even -M none) and
early QMP is the way we want to go anyway, and then this would be the
correct tool to use.

> I'm concerned that this could end up being a be a game of whack-a-mole
> though, constantly trying to cut out/down all the bits of system emulat=
ion
> in the machine emulators to get its resource overhead to match the low
> overhead of standalone qemu-nbd.

However, I personally share your concern.  Especially, I think that
getting to a point where we can have no machine at all and early QMP
will take much longer than just adding QMP to qemu-nbd -- or adding a
qmp command to qemu-img (because you can add NBD exports through QMP, so
qemu-nbd's hardcoded focus on NBD exports seems kind of weird then)[1].

I'm very much torn here.  There are two approaches: Stripping fat qemu
down, or fattening lean qemu-img (?) up.  The latter is very simple.
The former is what we want anyway.

Markus says it's not too hard to strip down qemu.  If that is true,
there is no point in fattening qemu-img now.  I personally am not
convinced at all, but he knows the state of that project much better
than me, so I cannot reasonably disagree.

So my mail is more of a CC to Markus and Kevin -- but I think both are
on PTO right now.

I guess the main question is: If someone were to introduce a qemu-img
QMP subcommand -- would it be accepted? :-)

Max


[1] Also, adding QMP should trivially add block jobs and multiple
exports to whatever tool we are talking about (in fact, qemu-img already
does perform the mirror block job for committing).


--M8IkkgB4AaaHtf58FHJm97niU7bflfRox
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAln7kEgSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7B8H/3Orabqp0dR88JIZp3piI4Nr2s9mgdy2
IjZI0JqodA9Uzm9Gw1fc/eQajG2ou7rZaaeKfJ6cmsw7lY/dCE/h3ux1uckrRvH3
B3cGB2RfaloipOu0Txrr+LXqY5AIRd7k5RUlZ8hYP4zdBTG7wZYb0pMYV/lNx5W6
73aTtXAELexYbfkqJEKjgjqSmGOXvXRMEPKbTuGO9OucE0i6IqwtpUmWWCxuinEB
dTueQbT80Fr7N6834His5NqOoy+AyepxexYmjQ7XiboRh6HIkKTrvj9ZPYxnlR/C
uEELXlZOs3XyDjpERtuGOwwu8MHlJR3fmdheDTh6tOYToqI3mmFWrbg=
=hskL
-----END PGP SIGNATURE-----

--M8IkkgB4AaaHtf58FHJm97niU7bflfRox--
