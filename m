Received: from eggs.gnu.org ([2001:4830:134:3::10]:50653)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZkTA-0000UW-PB
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 15:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZkT9-0005WX-OF
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 15:28:32 -0500
References: <87bmukmlau.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <bfb329d2-245f-8175-7f02-7f806d022d99@redhat.com>
Date: Fri, 3 Feb 2017 21:28:22 +0100
MIME-Version: 1.0
In-Reply-To: <87bmukmlau.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d44Nd0TuAricdnP39riWTe1EO8pmVrx9L"
Subject: Re: [Qemu-devel] [Qemu-block] Non-flat command line option argument
 syntax
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d44Nd0TuAricdnP39riWTe1EO8pmVrx9L
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange"
 <berrange@redhat.com>, qemu-block@nongnu.org
Message-ID: <bfb329d2-245f-8175-7f02-7f806d022d99@redhat.com>
Subject: Re: [Qemu-block] Non-flat command line option argument syntax
References: <87bmukmlau.fsf@dusky.pond.sub.org>
In-Reply-To: <87bmukmlau.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

I like both JSON and dot syntax. But I like them differently in
different places.

I love JSON when it's in some file where I can turn out syntax
highlighting and let my $EDITOR match brackets and braces.

I hate JSON when it's on the command line. You have to escape, you get
strings in strings, and at least for QMP you sometimes even get strings
in strings in strings (yes, I like my "echo | qemu -qmp stdio" with
human-monitor-command). Apart from that, usually I don't format anything
nicely on the command line anyway, so JSON and dot syntax are equally
illegible then.

JSON is great for reading, when formatted correctly. If it's not
formatted nicely and you don't have a good editor with highlighting,
it's pretty bad.
It's good for writing in an editor. It's not so nice for writing in a she=
ll.

OTOH, it's hard to read dot syntax when formatted correctly and it's
just as bad as JSON when it isn't. But even if you have an editor at
hand, you can't make it better.
It's very easy to write dot syntax, however. Just write down what you
want. Oh, forgot a parameter for that dict three arrays ago? Just write
it down now. Doesn't matter where you put it. How many braces do I need
to close now? Oh, right, I don't need to close any. Nice!

So dot syntax is pretty much a write-only syntax. But it's very good at
that.

On the command line I absolutely adore the dot syntax. It doesn't force
you to quote, you can put everything anywhere and you don't need to
count braces. I love it.

However, nobody can read what you wrote. Usually doesn't matter. But for
docs, that's bad. For scripts, it depends, but again, it usually is bad.
For configuration files, there is pretty much no excuse. So in general,
I'm very skeptic about dot syntax in files, to say the least.


So I think it would be good to allow full-JSON configuration. Put it in
a file, great.

But at the same time, I do not think that JSON is good for the command
line. Dot syntax works fine and in my opinion it often doesn't actually
matter whether it's legible or not.


I don't like structured values very much because to me they are just
"JSON light". Well, you don't have to quote keys and values (so no
"string in string" mess), but other than that you still have to quote
everything and you still have to count braces.

Max


PS: I personally actually think that structured representations such as
JSON may in some situations be less legible than the dot syntax if you
do not have syntax highlighting and it's not formatted nicely; and
that's because you have to count braces not just when writing but also
when reading. Imagine the following:

a.b.c.d.e.f=3D42,a.b.c.g=3D23

{"a":{"b":{"c":{"d":{"e":{"f":42}}},"g":23}}}

I can read the first one much better than the second one. Of course,
that's different with nice formatting and a good editor, but the above
is how I would write it on the command line.

I know it's a fabricated example and you'd just need to switch "g" and
"d", but "}}}}}}" actually makes me a bit dizzy, so that may be even
worse. Anyway, I just wanted to make the point that I think that compact
JSON and dot syntax are both pretty much illegible.


--d44Nd0TuAricdnP39riWTe1EO8pmVrx9L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliU5+YSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AfxMIAIVL84RD9NzaB+HZAfcCFp/7P4sTCih2
s4UAidu6yQUwJScZtVk3zLd7mUKMyzRsAtqMqU8p6htupzSrgBRuBBnpz4Reyz6Q
OxOmy5kjxNt6VI1CQlh/Ts2kV7xRXXow76y+EJ2Azf5mf3Vea08oKd5OV0Vu2ZOF
h1cMyWW6ICKvL/zmwYK5yMFo8/oK9NATjSFDs3hAcJBo5RVfZMrytlncJzlTQ5ZV
7xS+XettB41DqxXQvME16LcSfehXz3xiG3y14DOdkAwEc67ZrB8ffARkJUd1PmRK
ME+P+hTfW8D22O6VPQhwVvPN7d6j7262ue5j/XC+Zg2yo8HG6UKe9V4=
=5MoT
-----END PGP SIGNATURE-----

--d44Nd0TuAricdnP39riWTe1EO8pmVrx9L--
