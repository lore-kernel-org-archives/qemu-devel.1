Received: from eggs.gnu.org ([2001:4830:134:3::10]:37346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEeHY-00013q-1E
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:41:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEeHW-0004Yd-Vj
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 11:41:52 -0500
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
	<4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09ef1805-8361-5dff-300e-deede4863e55@redhat.com>
Date: Tue, 14 Nov 2017 10:41:39 -0600
MIME-Version: 1.0
In-Reply-To: <4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LrtUqwoq1nHwAHvBenxTenCxb3dE6e11U"
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
Cc: nbd list <nbd@other.debian.org>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LrtUqwoq1nHwAHvBenxTenCxb3dE6e11U
From: Eric Blake <eblake@redhat.com>
To: Wouter Verhelst <w@uter.be>, Bob Chen <a175818323@gmail.com>
Cc: nbd list <nbd@other.debian.org>, Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>
Message-ID: <09ef1805-8361-5dff-300e-deede4863e55@redhat.com>
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
 <4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
In-Reply-To: <4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[reviving an old thread]

On 01/23/2017 08:54 AM, Eric Blake wrote:

> I'm still thinking that allowing the client to query the current size i=
s
> useful.  Over the weekend, I was thinking of SEEK_SET/SEEK_END semantic=
s
> (SEEK_CUR doesn't really make sense, since we don't maintain a current
> offset), and wondering if we could improve the command as follows:
>=20
> If invoked without flags, it operates with SEEK_SET semantics (the
> offset is the new requested size); if invoked with
> NBD_CMD_FLAG_RELATIVE, it operates with SEEK_END semantics (the offset
> is added to the existing size, and can be treated as a signed 64-bit
> negative number to shrink).  Either way, on success, the command replie=
s
> with a structured reply containing the new 64-bit total size of the
> disk.  This would require the reply to be a structured reply, and the
> semantics of NBD_CMD_FLAG_RELATIVE with an offset of 0 becomes a way to=

> probe the existing disk size (thus enabling the server to resize withou=
t
> client request, and perhaps used with some out-of-band means for the
> client to know that it should query the server for an updated size).
> Also note that the server's reply of the current size may be slightly
> different than what was requested by the client (that is, we should
> allow the server to round the client's request up to an appropriate
> granularity) - we should probably require that the server can only roun=
d
> up (not down).
>=20
> Thoughts?

Another thought - with structured replies, we finally have a way to let
the client ask for the server to send resize information whenever the
server wants, rather than having to be polled by a new client request
all the time.  This is possible by having the server reply with a chunk
without the NBD_REPLY_FLAG_DONE bit, for as many times as it wants,
(that is, the server never officially ends the response to the single
client request for on-going status, until the client sends an
NBD_CMD_DISC).  I don't think the server should go into this mode
without a flag bit from the client requesting it (as it potentially ties
up a thread that could otherwise be used for parallel processing of
other requests), and that the server could reject a repeat command with
the flag if it is already serving a previous open-ended request.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--LrtUqwoq1nHwAHvBenxTenCxb3dE6e11U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloLHMMACgkQp6FrSiUn
Q2p5Iwf+P3nhsBksH0lQBIRfB+P4xKoos2raJJh44pWjqakCWkmR6DgUNJrCYf+u
jVuFSkffIYFjTyqjekCw1lwMv13yZc+oASwke70S1A9cz/YSMsyAFNXombKo4cex
o2Kpy+L1rGYcVEeh7VK8oivq8iCsmjTmtry7ZKtCVzNrJDQFrj5yXut3rP+7mMm0
Ug83UDpEqLoD7L1ptN2gVg3PyZV5HzWveC3IxOHjdi0Db7yCDsl47nUx42w0MtDv
mnybTyIForadFsOv20XSQmwQGhRAESkmb2ftZKx9kSuKUUh5zPUdB1ep+P0eIL2F
3Dn5vRWo9+JWBBw+RMKPx4uwV1YkGg==
=Ht+E
-----END PGP SIGNATURE-----

--LrtUqwoq1nHwAHvBenxTenCxb3dE6e11U--
