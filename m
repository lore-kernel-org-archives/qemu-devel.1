Received: from eggs.gnu.org ([2001:4830:134:3::10]:59893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTD50-0006bk-76
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTD4z-0003X9-0t
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 14:36:34 -0500
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
	<e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
	<2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
	<CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
	<CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
	<90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
	<20170114144500.oxoqvrn5x4sdfo74@grep.be>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
Date: Mon, 16 Jan 2017 13:36:21 -0600
MIME-Version: 1.0
In-Reply-To: <20170114144500.oxoqvrn5x4sdfo74@grep.be>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xipmLk3hWtUKBDcubsqoUvIj1Itgp1LCa"
Subject: Re: [Qemu-devel] [Nbd] [Qemu-block] How to online resize qemu disk
 with nbd protocol?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Bob Chen <a175818323@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xipmLk3hWtUKBDcubsqoUvIj1Itgp1LCa
From: Eric Blake <eblake@redhat.com>
To: Wouter Verhelst <w@uter.be>
Cc: Bob Chen <a175818323@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>
Message-ID: <1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
Subject: Re: [Nbd] [Qemu-devel] [Qemu-block] How to online resize qemu disk
 with nbd protocol?
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
 <e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
 <2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
 <CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
 <CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
 <90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
 <20170114144500.oxoqvrn5x4sdfo74@grep.be>
In-Reply-To: <20170114144500.oxoqvrn5x4sdfo74@grep.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/14/2017 08:45 AM, Wouter Verhelst wrote:
> Hi Eric,
>=20
> (side note: my mutt tells me that the signature on your message does no=
t
> validate. Not sure what's going on, but something you might want to loo=
k
> into...)

Not my fault, but a well-known issue with mailman. It rewrites portions
of message bodies that look like headers, yet GPG signatures
intentionally include a portion of the body that includes a repeat of
the original headers in order to authenticate the original sender. Thus,
the rewritten message no longer has a valid signature :(

In the past I've compared a broken and pristine copy of my messages, and
it's fairly annoying that the difference is sometimes as subtle as a
space vs. a tab, due to the way the header line was rewritten.


>=20
> On Thu, Jan 12, 2017 at 12:45:56PM -0600, Eric Blake wrote:
>> For resize smaller, things are a lot trickier - how do you block acces=
s
>> to a portion of a file that the client still thinks exist, but which t=
he
>> server has truncated away?  Maybe the easy way out is to state that th=
e
>> server MUST NOT resize smaller.
>=20
> I would prefer something along the lines of "the server MUST NOT
> activate the 'resize smaller' command (which it received out of band
> from whereever) until the client asked for and was told the new size of=

> the device."
>=20
> That is (with A & X being offsets, and B & Y being sizes, A+B < X):
>=20
> client        			server			server mgmt
> READ A,B        		no error
>         						resize to X
> READ X,Y        		no error
> reread sizes
> READ X,Y        		ENOSPC
> READ A,B        		no error
>=20
> In that scenario, it should be the responsibility of the server to
> ensure there are no more readers; servers could implement that (if they=

> don't want to do the required bookkeeping and keep such requests as
> pending) by simply sending ESHUTDOWN or some such.

In other words, a resize-smaller request (outside of the NBD protocol)
can either force the server to tell the clients to disconnect, or else
is merely a hint that is at the mercy of the client actually being smart
enough to request the information.  I don't know how we'd specify that,
but the idea seems reasonable enough.

The sad part is that the NBD protocol (currently) lacks any way for the
server to send an unsolicited hint to the client.  I've seen other
protocols (such as libvirt) that include a hint mechanism; intentionally
designed where a client that ignores the hints is no worse for the wear,
but where the hints can allow the server to pass information to the
client faster than what is possible if the client never asks the right
question.

Maybe the structured reply proposal can be extended into this (reserve a
"reply" header that can be issued as many times as desired by the server
without the client ever having issued the request first, and where the
reply never uses the end-of-reply marker), but I'm not sure I want to go
that direction just yet.

>=20
> I agree with Alex that adding an active resize command to the NBD
> protocol feels like a layering violation. We should probably not do
> that.

Fair enough; for now it will just be a passive re-query command.

>=20
>> Should I spend time turning this idea into a more formal spec, along t=
he
>> lines of other NBD extension proposals?
>=20
> Feel free.

I'll see what I can come up with in the next day or so, at least into an
RFC-quality spec change.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--xipmLk3hWtUKBDcubsqoUvIj1Itgp1LCa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfSC1AAoJEKeha0olJ0Nqq9sH/2VUTWyh1fiigLYHV10X3pTF
R+2483FZL06mETMnhmXSL3M0uRlanmz8a6CxDJSD+BI6qXcyznJrMg0W2Y6y0cFa
OSpPJH9D8OdaaPg8YOWCvF7huwAHWaLr8FtupB4t9dcmd5XiG00Stqo0jga5G1Tq
Kjsy+xeJZ5iAhEOGimhrF8kyFCnl9PybFEbSslXsYGWgyfVi0WrodFxmAwcD7gB0
Qk38DDD4E153ep8AeoMxPZdNr5FfaSeLFmtKAGOpwAqF6V3HSxN/3tcezIb5KlmH
wCO3Uq8faet1F7DAgSxbGYQzSJOOHEPSRUZUV0ed+jKK1iqsnGI8anlv6DVLkcg=
=cecx
-----END PGP SIGNATURE-----

--xipmLk3hWtUKBDcubsqoUvIj1Itgp1LCa--
