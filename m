Received: from eggs.gnu.org ([2001:4830:134:3::10]:47248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cGXPI-0005in-3L
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 15:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cGXPE-0002Km-QJ
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 15:41:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cGXPE-0002K6-IT
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 15:41:04 -0500
References: <20161212182119.dceppkzqb7gftsl5@grep.be>
	<bbdb71c7-540e-f5d9-c779-adddf4a0c79c@redhat.com>
	<20161212202615.llsqhojp2xztfao3@grep.be>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3bb94659-23a7-84d6-9572-98ea1d9cd697@redhat.com>
Date: Mon, 12 Dec 2016 14:40:55 -0600
MIME-Version: 1.0
In-Reply-To: <20161212202615.llsqhojp2xztfao3@grep.be>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pTToPnfQlLWkPBiD42DIdnUEWP1UX9sei"
Subject: Re: [Qemu-devel] [Nbd] [PATCH v4] doc: Add NBD_CMD_BLOCK_STATUS
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>, "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "Denis V. Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pTToPnfQlLWkPBiD42DIdnUEWP1UX9sei
From: Eric Blake <eblake@redhat.com>
To: Wouter Verhelst <w@uter.be>
Cc: Alex Bligh <alex@alex.org.uk>,
 "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Pavel Borzenkov <pborzenkov@virtuozzo.com>,
 "Stefan stefanha@redhat. com" <stefanha@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <3bb94659-23a7-84d6-9572-98ea1d9cd697@redhat.com>
Subject: Re: [Nbd] [PATCH v4] doc: Add NBD_CMD_BLOCK_STATUS extension
References: <20161212182119.dceppkzqb7gftsl5@grep.be>
 <bbdb71c7-540e-f5d9-c779-adddf4a0c79c@redhat.com>
 <20161212202615.llsqhojp2xztfao3@grep.be>
In-Reply-To: <20161212202615.llsqhojp2xztfao3@grep.be>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/12/2016 02:26 PM, Wouter Verhelst wrote:

>>> =20
>>>  This section describes the value and meaning of constants (other tha=
n
>>> @@ -768,8 +814,6 @@ The field has the following format:
>>>    to that command to the client. In the absense of this flag, client=
s
>>
>> drive-by typo fix applicable to the main branch:
>> s/absense/absence/
>=20
> Isn't that a matter of en_US vs en_GB?

Not in this instance - both countries use absence.  (If it helps, I'm US
but my wife is UK, so I generally have a good feel for which words have
different spellings across the pond)


>>> then the server MUST send all the metadata
>>> +      contexts it knows about. If specified, this query string MUST
>>> +      start with a name that uniquely identifies a server
>>> +      implementation; e.g., the reference implementation that
>>> +      accompanies this document would support query strings starting=

>>> +      with 'nbd-server:'
>>
>> 'nbd-server:' or 'base:' ?  [oh, I see more on this below]
>=20
> Indeed. It might certainly make sense to clarify that a bit, or I could=

> just decide that I take the "base:" context, and that everyone else can=

> register their own names ;->

I'd be fine with the reference implementation taking 'base:' :)


>>> +
>>> +    Even if the client did not use the `NBD_CMD_FLAG_REQ_ONE` flag i=
n
>>> +    its request, the server MAY return less descriptors in the reply=

>>> +    than would be required to fully specify the whole range of reque=
sted
>>> +    information to the client, if the number of descriptors would be=

>>> +    over 16 otherwise and looking up the information would be too
>>> +    resource-intensive for the server.
>>
>> Do we still want to require servers to always send 16 extents (when no=
t
>> limited to exactly 1), or is it better to just state that as long as t=
he
>> server sends at least one extent (so that the client can make progress=
),
>> then the server can shorten the reply if it is resource-intensive to
>> provide details over the entire client request?
>=20
> Hrm, I wanted to drop that (I did drop another reference to that thing,=

> I though), but apparently I forgot.

It looks like elsewhere you make the point that there is always at least
one extent on success, and I think that's sufficient (whether a server
stops at 1, stops at 16, or always provides as much as the client
requests, is then a quality-of-implementation decision on the server; a
client already has to be prepared for a short answer, and should also be
prepared to cache a long answer rather than repeating a query that is
redundant; and a server should tolerate a client that doesn't cache thing=
s).

> There were actually more things that I defined multiple times, and I
> thought I'd dropped them all, but apparently not so. I'll fix that up
> ASAP.
>=20
> (sorry about the "noise" in that I didn't double-check everything. I'll=

> do better next time, honest ;-)

That's okay.  The inter-branch diff is indeed the best way to review the
current state of the changes in relation to the master branch, rather
than trying to follow one patch at a time.  I'm grateful that you've
stepped in to try and nail down some of the wordings, and doing a qemu
proof-of-concept implementation is indeed on my plate of things to
tackle soon (well, structured replies first...)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--pTToPnfQlLWkPBiD42DIdnUEWP1UX9sei
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYTwtXAAoJEKeha0olJ0Nq1poH/1vw7RnAg/leI7XyC5FnpkI6
MCMMO5B4hMH7R/dC0LFkBAQqgqSRTvl1pejjwiyrv176q61E1npMvHFAhub5WCBv
SIJpT3kvBcmnttRx3Y2gm96t2pyzn9X5ymzVTA6Z0nJIacvcNdPy/uv0TyWdSnZo
gBaai6K/IB0RvEKuH6zfLUNDxc9zb2GPNHHix5yyBcbdkgUKVGo7uWbvjHVHUQCR
BSUO4fhtQHSlKYq2l6skOk4io1+7G5dl8VvHDJem3S4ikkuWYyq74Z2EMQQln4wN
wqQXMwHudCcwXeLu9JekKHGml7pQZwCtE/7TdnBwz79rRzN0Og81Rg9MRvBGpog=
=H/Ak
-----END PGP SIGNATURE-----

--pTToPnfQlLWkPBiD42DIdnUEWP1UX9sei--
