Received: from eggs.gnu.org ([2001:4830:134:3::10]:51601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cHCZ6-0008DO-2W
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:38:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cHCZ2-0006Fx-52
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 11:38:00 -0500
References: <20161205234235.5728-1-eblake@redhat.com>
	<20161212181237.3aymdmenxeu2kwjj@grep.be>
	<20161213073812.GA4443@noname.str.redhat.com>
	<20161213121856.b7fmjwjfkoeufz4g@grep.be>
	<f354bb95-fcbe-c59d-d5b1-479d76764d9d@redhat.com>
	<20161214082246.dwzqsu3tzmjmiem6@grep.be>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0376b5a6-8840-48aa-d1f2-d72c6b570f6d@redhat.com>
Date: Wed, 14 Dec 2016 10:37:43 -0600
MIME-Version: 1.0
In-Reply-To: <20161214082246.dwzqsu3tzmjmiem6@grep.be>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PLJJUQCQtWB9872DRdpQmH14TsdlQBFo4"
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
Cc: Kevin Wolf <kwolf@redhat.com>, nbd-general@lists.sourceforge.net, xieyingtai@huawei.com, subo7@huawei.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PLJJUQCQtWB9872DRdpQmH14TsdlQBFo4
From: Eric Blake <eblake@redhat.com>
To: Wouter Verhelst <w@uter.be>
Cc: Kevin Wolf <kwolf@redhat.com>, nbd-general@lists.sourceforge.net,
 xieyingtai@huawei.com, subo7@huawei.com, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, pbonzini@redhat.com
Message-ID: <0376b5a6-8840-48aa-d1f2-d72c6b570f6d@redhat.com>
Subject: Re: [Nbd] [Qemu-devel] [Qemu-block] [PATCH] doc: Propose
 NBD_FLAG_INIT_ZEROES extension
References: <20161205234235.5728-1-eblake@redhat.com>
 <20161212181237.3aymdmenxeu2kwjj@grep.be>
 <20161213073812.GA4443@noname.str.redhat.com>
 <20161213121856.b7fmjwjfkoeufz4g@grep.be>
 <f354bb95-fcbe-c59d-d5b1-479d76764d9d@redhat.com>
 <20161214082246.dwzqsu3tzmjmiem6@grep.be>
In-Reply-To: <20161214082246.dwzqsu3tzmjmiem6@grep.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/14/2016 02:22 AM, Wouter Verhelst wrote:
> Hi Eric,
>=20
> On Tue, Dec 13, 2016 at 04:36:08PM -0600, Eric Blake wrote:
>> On 12/13/2016 06:18 AM, Wouter Verhelst wrote:
>>> On Tue, Dec 13, 2016 at 08:38:12AM +0100, Kevin Wolf wrote:
>>>> Am 12.12.2016 um 19:12 hat Wouter Verhelst geschrieben:
>>>>> I'm not opposed to this proposal, per se, but there seems to be som=
e
>>>>> disagreement (by Kevin, for instance) on whether this extension is =
at
>>>>> all useful.
>>>>
>>>> FWIW, I'm not opposed to adding the flag. I don't think it can hurt,=
 but
>>>> I wanted to ask the question so that we don't end up adding a featur=
e
>>>> that noone actually uses. Ultimately it's your call as a maintainer
>>>> anyway how conservative you want to be with spec additions.
>>>
>>> I'm not opposed either, but I do agree with you that we shouldn't add=

>>> such a feature if it doesn't end up getting used. Especially so if it=

>>> burns a flag in the (16-bit) "transmission flags" field, where space =
is
>>> at a premium.
>>
>> No, it is NOT a "transmission flag", as it is a per-export property
>> (where we currently have 64 bits).
>=20
> That may be what you meant, but the patch you sent uses a flag in the
> transmission flags field.
>=20
> If you meant to use something else, you'll have to clarify what your
> patch should have been like ;-)

/me goes back and re-reads spec - I shouldn't reply to mails purely off
of memory...

Okay, I'm crossing terms here.  "Transmission flags" ARE the per-export
flags - and are sent in response to NBD_OPT_EXPORT_NAME or NBD_OPT_INFO
or NBD_OPT_GO.  And you are right that we only have 16 bits in the
current spec, but that they can differ between exports (case in point:
NBD_FLAG_READ_ONLY).  So my proposal of bit 10 as NBD_FLAG_INIT_ZEROES
is potentially in the right place - it is a per-export property (a
server may support multiple named exports for the client to choose from,
of which only a subset are known to be all zero content at the time of
export).  But your argument that 16 bits is at a premium may be worth
considering an alternative representation for the same information.

Possibility 1: when we run out of our current 16 transmission flags,
we'll need a way to extend the protocol to support more than that.  To
do that, we'd probably want a new Handshake flag
NBD_FLAG_LARGE_TRANSMISSION_FLAGS sent by the server, and which must be
answered by the client sending a new Client flag
NBD_FLAG_C_LARGE_TRANSMISSION_FLAGS, so that both sides know that all
subsequent places in the protocol that send transmission flags will now
send 64 bits instead of 16 bits (old-style negotiation cannot benefit
from this, and is permanently stuck at 16 bits, but we discourage
old-style negotiation).  We'd still want to prioritize which bits land
in the first 16 positions, for maximum compatibility with older servers
or clients (where the higher bit positions are used for data that is
more suited for optimizations, rather than controlling correct usage) -
thus NBD_FLAG_INIT_ZEROES would serve as an example to live in the
extended positions.

Possibility 2: Leverage the extension-info branch: Add a new
NBD_INFO_INIT_ZERO information datum.  NBD_BLOCK_INFO already exists to
let server and client exchange as much per-export information as they
want during handshake without burning any new transmission flags, and
with a specification that gracefully ignores unknown requests from the
client and unknown advertisements from the server.  There's the drawback
that the server can't advertise the known-zero-init optimization to
clients that don't use NBD_OPT_GO, but that's not too bad (especially if
qemu is the first client with code to actually make use of the
optimization, since I am already trying to get qemu to be one of the
first adopters of NBD_OPT_GO).

We'll probably have to eventually use something along the lines of
possibility 1 for more transmission flags for some other reason down the
road (since we have lately been adding one flag per new command/command
group as we add extensions), but I agree that it is a bit heavy for now.
 So it sounds like I should rework the proposal along the lines of
possibility 2, which also implies that we should get extension-info
ready for promotion to current.  And that means that my current proposal
to the extension-write-zeroes branch is probably not ideal, but it
reopens the question of whether extension-write-zeroes as it currently
stands is ready for promotion to stable now that qemu 2.8 implements it.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--PLJJUQCQtWB9872DRdpQmH14TsdlQBFo4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYUXVXAAoJEKeha0olJ0NqMrgH/3UiNBH+M9inHQYq+f1gUepg
p8B2mezZDh8Pri3bWns1o0JUFbltqgiMNNInKheAC/txaeTkKaHwh/nZ2HUM2E7q
MjoR7LYE4nnVdCsmoVoXCsN9hBEgKMo2w0vb/oCPJBiXGwO4TviQvsT8XxDrCCgu
8IhVvD3KR+cZQBWeZB99wKF9XM9RUiJRWABnEAEYIQ6BIrrC0ceDKWTS4xpM394X
eJ4YS5yPYjpBjGz9K4h/KGIrGwGJBII+q1gUXmNfLET+6iRxAGb4M79yEGE1T9O0
dz5tTi2cdTe5AoTwm0BLL9LNXIU8gfE5iJsBFG5OOXhaPOkZFwz2eCsCLUqWXhE=
=nNd2
-----END PGP SIGNATURE-----

--PLJJUQCQtWB9872DRdpQmH14TsdlQBFo4--
