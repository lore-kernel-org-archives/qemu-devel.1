Received: from eggs.gnu.org ([2001:4830:134:3::10]:50027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cVg1L-000143-N0
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:55:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cVg1K-0005Da-KA
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 09:54:59 -0500
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
	<e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
	<2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
	<CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
	<CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
	<90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
	<20170114144500.oxoqvrn5x4sdfo74@grep.be>
	<1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
	<20170118080126.nyldkjhxdsxd4u2b@grep.be>
	<CAMxP3BTjBSQEhycavgyfWXEA6pTg=sxfHe5sf+nxVY9ejXWMXQ@mail.gmail.com>
	<20170122114339.l3ijhy3uymsru4ed@grep.be>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
Date: Mon, 23 Jan 2017 08:54:48 -0600
MIME-Version: 1.0
In-Reply-To: <20170122114339.l3ijhy3uymsru4ed@grep.be>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bcTdRAlac8Oo8GOhc2qQfvg6ogACEDVIU"
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
To: Wouter Verhelst <w@uter.be>, Bob Chen <a175818323@gmail.com>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Stefan Hajnoczi <stefanha@gmail.com>, qemu block <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bcTdRAlac8Oo8GOhc2qQfvg6ogACEDVIU
From: Eric Blake <eblake@redhat.com>
To: Wouter Verhelst <w@uter.be>, Bob Chen <a175818323@gmail.com>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>,
 Stefan Hajnoczi <stefanha@gmail.com>, qemu block <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
Subject: Re: [Nbd] [Qemu-devel] [Qemu-block] How to online resize qemu disk
 with nbd protocol?
References: <CAMxP3BT7ncDLePmP7QfXMtbodJ81+9Frc01aCkipya3-BNL6AA@mail.gmail.com>
 <e6e26ad1-3fdf-85ac-0dc4-f4027123af6b@redhat.com>
 <2EAE3C4F-58AF-4594-A284-A69D8BC3EA8F@alex.org.uk>
 <CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
 <CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
 <90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
 <20170114144500.oxoqvrn5x4sdfo74@grep.be>
 <1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
 <20170118080126.nyldkjhxdsxd4u2b@grep.be>
 <CAMxP3BTjBSQEhycavgyfWXEA6pTg=sxfHe5sf+nxVY9ejXWMXQ@mail.gmail.com>
 <20170122114339.l3ijhy3uymsru4ed@grep.be>
In-Reply-To: <20170122114339.l3ijhy3uymsru4ed@grep.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/22/2017 05:43 AM, Wouter Verhelst wrote:
>=20
> Having given this some more thought, I'm not entirely sure anymore that=

> an active resize from the NBD layer is necessarily a layering violation=
=2E
> There might be other cases where this is useful, and e.g., the Linux
> kernel also supports active resizes of block devices in some cases
> (e.g., LVM). We'll also need to define what happens in case the resize
> operation isn't possible for some reason (e.g., the size increase asks
> for more space than the server's storage has available).
>=20
> I suggest the following semantics:
>=20
> - Add a transmission flag to indicate resize is possible for
>   transmission phase (NBD_FLAG_SEND_RESIZE, flag 10). I don't see any
>   need for an NBD_OPT_RESIZE or some such; just the flag should suffice=
=2E

Except that in previous threads, you've argued that burning per-export
flags is rather expensive if it is instead soemthing that an NBD_OPT
exchange could enable.  On the other hand, I could definitely see it
being a per-export setting (not all exports have the ability to be
resized), so it doesn't hurt my feelings to burn a per-export flag on
this bit of information.

> - NBD_CMD_RESIZE (command 7): resize the export. The "offset" field
>   contains the new size, "length" is reserved (why not the other way
>   around? offset is 64 bits, length is 32)
> - resize command can fail with:
>   EPERM: server configuration does not allow this resize, or
>   (optionally) other clients are using the same export and the request
>   was for a smaller size.
>   EIO: I/O error while trying to resize the device
>   ENOSPC: new export size requires more space than is available
>   ESHUTDOWN: server is shutting down
>=20
> I've added an "extension-resize" branch with the above. If that works
> for you, then run with it. If not, just implement what you want and sen=
d
> updates as you go along.

You have at least one problem in there:

+    If the resize was successful, clients MAY now issue other requests
+    up to the new size as requested in the request header. If the new
+    size is larger than it was before the request, requests beyond the
+    new size but not beyond the old one MUST fail with ENOSPC.

You probably want "if the new size is _smaller_ than it was before", as
it is not possible to have requests beyond the new size but not beyond
the old if the new size is larger than the old.


I'm still thinking that allowing the client to query the current size is
useful.  Over the weekend, I was thinking of SEEK_SET/SEEK_END semantics
(SEEK_CUR doesn't really make sense, since we don't maintain a current
offset), and wondering if we could improve the command as follows:

If invoked without flags, it operates with SEEK_SET semantics (the
offset is the new requested size); if invoked with
NBD_CMD_FLAG_RELATIVE, it operates with SEEK_END semantics (the offset
is added to the existing size, and can be treated as a signed 64-bit
negative number to shrink).  Either way, on success, the command replies
with a structured reply containing the new 64-bit total size of the
disk.  This would require the reply to be a structured reply, and the
semantics of NBD_CMD_FLAG_RELATIVE with an offset of 0 becomes a way to
probe the existing disk size (thus enabling the server to resize without
client request, and perhaps used with some out-of-band means for the
client to know that it should query the server for an updated size).
Also note that the server's reply of the current size may be slightly
different than what was requested by the client (that is, we should
allow the server to round the client's request up to an appropriate
granularity) - we should probably require that the server can only round
up (not down).

Thoughts?

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--bcTdRAlac8Oo8GOhc2qQfvg6ogACEDVIU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYhhk4AAoJEKeha0olJ0NqWPQH/1Be5uU5NsVZnp8YsYEC4PWy
UUZriyHeOVx6NDDerc7w27Yu0gnYsfviiQL+i9xJrltcGJn4gnujgHE1hmNH+19+
nZbQ66tYe6KMxRktC/Ka1RRmF5d+8TnuNSAd8AJ0O+QNvPCI6tNqwfU46WyvA2m/
7EdChWHlHofcwQWBgvJiindi6Amf5JQdd6Bj4enPEXiAE9E9vAlqxwFRI/mZ/uZH
q+QhKNgPbIctRVE3XrJeT+3VQ3FUY0AMj0j5YB/LOfdtbQOBn+iGqFUJjDJH1X86
B6Wf3DSfOeF4f3y7Uq526YxB8qkw3lgllHICmq0JlkymKX0Uvi5JedIg24sxJHk=
=LbCy
-----END PGP SIGNATURE-----

--bcTdRAlac8Oo8GOhc2qQfvg6ogACEDVIU--
