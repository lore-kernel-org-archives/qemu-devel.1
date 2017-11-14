Received: from eggs.gnu.org ([2001:4830:134:3::10]:39287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEgXU-0003Ws-Ml
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 14:06:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eEgXT-0004PX-5f
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 14:06:28 -0500
References: <CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
	<CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
	<90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
	<20170114144500.oxoqvrn5x4sdfo74@grep.be>
	<1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
	<20170118080126.nyldkjhxdsxd4u2b@grep.be>
	<CAMxP3BTjBSQEhycavgyfWXEA6pTg=sxfHe5sf+nxVY9ejXWMXQ@mail.gmail.com>
	<20170122114339.l3ijhy3uymsru4ed@grep.be>
	<4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
	<09ef1805-8361-5dff-300e-deede4863e55@redhat.com>
	<20171114173745.egvtklxyrcprlcdn@grep.be>
From: Eric Blake <eblake@redhat.com>
Message-ID: <cd864bff-b429-20aa-7fc9-2f9296581470@redhat.com>
Date: Tue, 14 Nov 2017 13:06:17 -0600
MIME-Version: 1.0
In-Reply-To: <20171114173745.egvtklxyrcprlcdn@grep.be>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r6HuFGDgtVkKivOoxRrBcgF7iJ7qhon2h"
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
Cc: Bob Chen <a175818323@gmail.com>, nbd list <nbd@other.debian.org>, Stefan Hajnoczi <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r6HuFGDgtVkKivOoxRrBcgF7iJ7qhon2h
From: Eric Blake <eblake@redhat.com>
To: Wouter Verhelst <w@uter.be>
Cc: Bob Chen <a175818323@gmail.com>, nbd list <nbd@other.debian.org>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>
Message-ID: <cd864bff-b429-20aa-7fc9-2f9296581470@redhat.com>
Subject: Re: [Nbd] [Qemu-devel] [Qemu-block] How to online resize qemu disk
 with nbd protocol?
References: <CAJSP0QWXF2tS5q-BpmxR9ti0osjzZCFiRxdRDho4pDBLkD3UUQ@mail.gmail.com>
 <CAMxP3BQeUWwFLmb42=-XExRzdLe0egCaEUEF4kXLQ9khH9neWg@mail.gmail.com>
 <90b32a89-6dd8-1f83-4f6f-01bb5479252e@redhat.com>
 <20170114144500.oxoqvrn5x4sdfo74@grep.be>
 <1ef924f8-1e58-fe54-dabc-06873a531412@redhat.com>
 <20170118080126.nyldkjhxdsxd4u2b@grep.be>
 <CAMxP3BTjBSQEhycavgyfWXEA6pTg=sxfHe5sf+nxVY9ejXWMXQ@mail.gmail.com>
 <20170122114339.l3ijhy3uymsru4ed@grep.be>
 <4a5a82d6-7d66-cfb4-bd42-cea596115f6f@redhat.com>
 <09ef1805-8361-5dff-300e-deede4863e55@redhat.com>
 <20171114173745.egvtklxyrcprlcdn@grep.be>
In-Reply-To: <20171114173745.egvtklxyrcprlcdn@grep.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/14/2017 11:37 AM, Wouter Verhelst wrote:
> On Tue, Nov 14, 2017 at 10:41:39AM -0600, Eric Blake wrote:
>> Another thought - with structured replies, we finally have a way to le=
t
>> the client ask for the server to send resize information whenever the
>> server wants, rather than having to be polled by a new client request
>> all the time.  This is possible by having the server reply with a chun=
k
>> without the NBD_REPLY_FLAG_DONE bit, for as many times as it wants,
>> (that is, the server never officially ends the response to the single
>> client request for on-going status, until the client sends an
>> NBD_CMD_DISC).
>=20
> Hrm, yeah, that could work.
>=20
> Minor downside of this would be that a client would now be expected to
> continue listening "forever" (probably needs to do a blocking read() or=

> a select() on the socket), whereas with the current situation a client
> could get away with only reading for as long as it expects data.
>=20
> I don't think that should be a blocker, but it might be something we
> might want to document.
>=20
>> I don't think the server should go into this mode without a flag bit
>> from the client requesting it (as it potentially ties up a thread that=

>> could otherwise be used for parallel processing of other requests),
>=20
> Yeah. I think we should probably initiate this with a BLOCK_STATUS
> message that has a flag with which we mean "don't stop sending data on
> the given region for contexts that support it".

Now we're mixing NBD_CMD_BLOCK_STATUS and NBD_CMD_RESIZE; I was thinking
of the open-ended command for being informed of all
server-side-initiated size changes in response to RESIZE; but your
mention of an open-ended BLOCK_STATUS has an interesting connotation of
being able to get live updates as sections of a file are dirtied.

I also remember from talking with Vladimir during KVM Forum last month
that one of the shortfalls of the NBD protocol is that you can only ever
send a length of up to 32 bits on the command side (unless we introduce
structured commands in addition to our current work to add structured
replies); even querying the full status of a 1TB volume would require at
least 256 NBD_CMD_BLOCK_STATUS calls.  But having a special case of a
length of 0 meaning to report status as long as the server is interested
could reduce the number of round trips by letting the server report more
than 4G of status in response to one client query.  There was also a
thread a while ago about the possibility of a per-export flag denoting a
volume is known to contain all-zeroes on startup, which can be used as a
handy shortcut to having to query block status over each slice of the
file; we weren't sure about burning a per-export flag on that
information, but having it be a special mode of NBD_CMD_BLOCK_STATUS may
be easy enough to codify.

>=20
> However, I could imagine that there might be some cases wherein a serve=
r
> might be able to go into such a mode for two or more metadata contexts,=

> and where a client might want to go into that mode for one of them but
> not all of them, while still wanting some information from them.
>=20
> This could be covered with metadata context syntax, but it's annoying
> and shouldn't be necessary.
>=20
> I'm starting to think I made a mistake when I said NBD_CMD_BLOCK_STATUS=

> can't take a metadata context ID. Okay, there's no space for it, but
> that shouldn't have been a blocker.
>=20
> Thoughts?

Nothing says the server has to reply the same length of information when
replying for multiple selected metadata contexts; but if we allow
different reply sizes all in one query, we may also need some way to
easily tell that the server has stopped sending metadata for one context
even though it is still providing additional replies for another context.=


And maybe we do want to someday start thinking about structured
requests; where being able to do per-command selection of metadata
contexts (instead of per-export selection) may indeed be the first use ca=
se.

>=20
>> and that the server could reject a repeat command with the flag if it
>> is already serving a previous open-ended request.
>=20
> Right.
>=20
> On the other hand, I can imagine that a client might also want to tell
> the server that it is no longer interested in an outstanding request. I=
n
> such a case, it should be able to cancel it.

Good point - if we allow the client to request an open-ended reply, it's
also nice to let the client decide how long that open-endedness should la=
st.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--r6HuFGDgtVkKivOoxRrBcgF7iJ7qhon2h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloLPqkACgkQp6FrSiUn
Q2q/lwf+Pjw6ebX3UL2RBJkqWTP8yRD1NKCrnpuJV1uvkMr8ofz5W5PxEef1luy1
3tVKFm4JdEVZJ7AC33hJkn4d05GircysurYE6IJzAQgGtBW/bhrugWoLgp5BFX0d
gMMFw9503ePMB6tuNTtXiR46Rs1qjO5ZNz+RRAMzuqU0dhUOFIjXt7t0D/dmG6Zs
zhw2eSA/Orx8T0XtXPsupiTGHglw3eO4RM8SF4LyBKF/xG+DY9EGk55PXBimVem7
a1+WoeMeqaL/xzFdDP5Ql0w9VVlJAYtKZD7Ec0hbCDRGC9n83cC2WS9zEHKrpqsY
cHpabM6WqPxDCheWC9Swa8meFAX+sA==
=UHhf
-----END PGP SIGNATURE-----

--r6HuFGDgtVkKivOoxRrBcgF7iJ7qhon2h--
