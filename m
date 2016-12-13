Received: from eggs.gnu.org ([2001:4830:134:3::10]:38339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cGmzy-0000J1-Lm
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:20:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex@alex.org.uk>) id 1cGmzx-0000Ra-A9
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:20:02 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Alex Bligh <alex@alex.org.uk>
In-Reply-To: <20161213121856.b7fmjwjfkoeufz4g@grep.be>
Date: Tue, 13 Dec 2016 13:19:52 +0000
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF52A49A-7A71-4B2A-B24D-253151E291AF@alex.org.uk>
References: <20161205234235.5728-1-eblake@redhat.com>
	<20161212181237.3aymdmenxeu2kwjj@grep.be>
	<20161213073812.GA4443@noname.str.redhat.com>
	<20161213121856.b7fmjwjfkoeufz4g@grep.be>
Subject: Re: [Qemu-devel] [Nbd] [Qemu-block] [PATCH] doc: Propose
 NBD_FLAG_INIT_ZEROES extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>, Kevin Wolf <kwolf@redhat.com>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, xieyingtai@huawei.com, subo7@huawei.com, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>


> On 13 Dec 2016, at 12:18, Wouter Verhelst <w@uter.be> wrote:
>=20
> I'm not opposed either, but I do agree with you that we shouldn't add
> such a feature if it doesn't end up getting used. Especially so if it
> burns a flag in the (16-bit) "transmission flags" field, where space =
is
> at a premium.

I did suggest a few non-Qemu uses (see below). I think it might be
an idea if the reference implementation supported it before
merging (which per below should be trivial).

--=20
Alex Bligh


> Begin forwarded message:
>=20
> From: Alex Bligh <alex@alex.org.uk>
> Subject: Re: [Nbd] [Qemu-block] [PATCH] doc: Propose =
NBD_FLAG_INIT_ZEROES extension
> Date: 6 December 2016 at 10:29:41 United Kingdom Time
> To: Kevin Wolf <kwolf@redhat.com>
> Cc: Alex Bligh <alex@alex.org.uk>, Eric Blake <eblake@redhat.com>, =
"nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, =
xieyingtai@huawei.com, subo7@huawei.com, qemu block =
<qemu-block@nongnu.org>, "qemu-devel@nongnu.org" =
<qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
>=20
>=20
>> On 6 Dec 2016, at 09:25, Kevin Wolf <kwolf@redhat.com> wrote:
>>=20
>> Am 06.12.2016 um 00:42 hat Eric Blake geschrieben:
>>> While not directly related to NBD_CMD_WRITE_ZEROES, the qemu
>>> team discovered that it is useful if a server can advertise
>>> whether an export is in a known-all-zeroes state at the time
>>> the client connects.
>>=20
>> Does a server usually have the information to set this flag, other =
than
>> querying the block status of all blocks at startup?=20
>=20
> The server may have other ways of knowing this, for instance
> that it has just created the file (*), or that it stat'd the file
> before opening it (not unlikely) and noticed it had 0 allocated
> size. The latter I suspect would be trivial to implement in nbd-server
>=20
> (*) =3D e.g. I had one application where nbd use the export path
> to signify it wanted to open a temporary file, the path consisting
> of a UUID and an encoded length. If the file was not present already
> it created it with ftruncate(). That could trivially have used this.
>=20
>> If so, the client could just query this by itself.
>=20
> Well there's no currently mainlined extension to do that, but yes
> it could. On the other hand I see no issue passing complete
> zero status back to the client if it's so obvious from a stat().
>=20
> --=20
> Alex Bligh
>=20
>=20
>=20
>=20
