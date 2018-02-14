Received: from eggs.gnu.org ([2001:4830:134:3::10]:41853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elyUZ-0002t1-Ud
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:57:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1elyUZ-0002PV-97
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 09:57:04 -0500
References: <18b3a8c6-4f5c-3623-a781-5beb94375331@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ad975a6-7624-cb63-ce1e-2dadf9b1c40e@redhat.com>
Date: Wed, 14 Feb 2018 08:56:49 -0600
MIME-Version: 1.0
In-Reply-To: <18b3a8c6-4f5c-3623-a781-5beb94375331@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] BLOCK_STATUS extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Wouter Verhelst <w@uter.be>, nbd list <nbd@other.debian.org>, Alex Bligh <alex@alex.org.uk>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

[using the updated nbd list email]

On 02/14/2018 08:35 AM, Vladimir Sementsov-Ogievskiy wrote:
> Hi all.
>=20
> Just note: looks like we allow zero-sized metadata context name. Is it =
ok?
>=20
>  =C2=A0*
>=20
>  =C2=A0=C2=A0 |NBD_REP_META_CONTEXT| (4)
>=20
>  =C2=A0=C2=A0 A description of a metadata context. Data:
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0 o 32 bits, NBD metadata context ID.
>  =C2=A0=C2=A0=C2=A0=C2=A0 o String, name of the metadata context. This =
is not required to be
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a human-readable string, but it M=
UST be valid UTF-8 data.

No; elsewhere we state:

>=20
> Metadata contexts are identified by their names. The name MUST consist =
of a namespace, followed by a colon, followed by a leaf-name. The namespa=
ce must consist entirely of printable non-whitespace UTF-8 characters oth=
er than colons, and be non-empty. The entire name (namespace, colon, and =
leaf-name) MUST follow the restrictions for strings as laid out earlier i=
n this document.
>=20
> Namespaces MUST be consist of one of the following:
>=20
>     base, for metadata contexts defined by this document;
>     nbd-server, for metadata contexts defined by the implementation tha=
t accompanies this document (none currently);
>     x-*, where * can be replaced by an arbitrary string not containing =
colons, for local experiments. This SHOULD NOT be used by metadata contex=
ts that are expected to be widely used.
>     A third-party namespace from the list below.
>=20

So a name must be at least 2 bytes (for a one-byte namespace, if someone=20
ever registers one - and supposing that namespace has zero-byte leaf=20
names), but will more commonly be even longer.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
