Received: from eggs.gnu.org ([2001:4830:134:3::10]:40659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cnQ1M-0006oV-9a
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cnQ1J-0001r3-4i
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:28:20 -0400
Received: from mx6-phx2.redhat.com ([209.132.183.39]:52582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cnQ1I-0001qa-SK
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:28:17 -0400
Date: Mon, 13 Mar 2017 09:28:14 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <1815445054.3686730.1489411694165.JavaMail.zimbra@redhat.com>
In-Reply-To: <7da78125-495b-4a2b-6383-d0ae22ba282b@redhat.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
	<20170311132256.22951-5-marcandre.lureau@redhat.com>
	<84148275-6410-68f7-4da0-345b635c42f3@redhat.com>
	<87h92xk5p7.fsf@dusky.pond.sub.org>
	<7da78125-495b-4a2b-6383-d0ae22ba282b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/21] qobject: add quint type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, pbonzini@redhat.com, anderson@redhat.com, mdroth@linux.vnet.ibm.com, lersek@redhat.com

Hi

----- Original Message -----
> On 03/13/2017 02:15 AM, Markus Armbruster wrote:
> > Eric Blake <eblake@redhat.com> writes:
> >=20
> >> On 03/11/2017 07:22 AM, Marc-Andr=C3=A9 Lureau wrote:
> >>> The type is not used at all yet. Add some tests to exercice it.
> >>
> >> s/exercice/exercise/
> >>
> >> I wonder if we need this patch at all.
> >>
> >> I've been thinking about a possible alternative representation, such
> >> that a single QInt type can cover _both_ signed and unsigned types, by
> >> having QInt track a sign bit bool in addition to a uint64_t value.
> >>
>=20
> > You say you've been thinking about extending QInt's range to cover
> > uint64_t.  I've been thinking even more radically: replace both QInt an=
d
> > QFloat by QNumber.  This is how JSON *actually* works.
> >=20
> > The new QNumber type provides constructors from double, int64_t and
> > uint64_t.  It also provides conversion functions to double, int64_t and
> > uint64_t.  The latter two can fail.
>=20
> Interesting - I like it, as it takes my idea and goes one step further.
> You'd want to track 64 bits of precision rather than just 53, when the
> input was integral, but the idea seems to have some merit (we have some
> special case in the testsuite for what happens in alternates with
> various combinations of 'number' vs. 'int' that may need tweaking when
> they are no longer distinguishable as QInt vs QFloat, but that's not too
> onerous).
>=20

I wonder the benefits from hiding the real type behind a QNumber "superclas=
s", then having to type check at a lower level. QType is not only used for =
json, so I see some benefits from having a bit stricter type declaration an=
d compile-time check. But I don't have a very good idea of what it would me=
an to have a generic QNumber type, I could try to implement it to have a mo=
re informed opinion.

> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>=20
>=20
