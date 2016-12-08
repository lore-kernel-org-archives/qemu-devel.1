Received: from eggs.gnu.org ([2001:4830:134:3::10]:58263)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cF16h-0001hX-AA
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:59:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cF16c-0001nw-Ge
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:59:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cF16c-0001nm-7m
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 10:59:34 -0500
References: <1480073296-6931-1-git-send-email-vsementsov@virtuozzo.com>
	<F075D231-9CBE-437C-B9F0-0DE2AB98007B@alex.org.uk>
	<ed5f8fc7-c7c8-c678-668f-17047dbe0b23@redhat.com>
	<4329D951-F1D0-4B0B-99AB-9F1B7D3DA99B@alex.org.uk>
	<C9D4A99C-1E81-4144-976B-289FF959430B@alex.org.uk>
	<20161208094436.7o4rm54ob2xh4eui@grep.be>
	<42260F0E-9D94-44D4-A5FF-EE8F5962ADA0@alex.org.uk>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d0ce8e00-5875-d3c9-f040-b9d5daebbb2c@redhat.com>
Date: Thu, 8 Dec 2016 09:59:26 -0600
MIME-Version: 1.0
In-Reply-To: <42260F0E-9D94-44D4-A5FF-EE8F5962ADA0@alex.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xM4bSFDA3NToVRrXL80bePf2jrdj8v82s"
Subject: Re: [Qemu-devel] [Nbd] [PATCH v3] doc: Add NBD_CMD_BLOCK_STATUS
 extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "Stefan stefanha@redhat. com" <stefanha@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>, Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xM4bSFDA3NToVRrXL80bePf2jrdj8v82s
From: Eric Blake <eblake@redhat.com>
To: Alex Bligh <alex@alex.org.uk>, Wouter Verhelst <w@uter.be>
Cc: "nbd-general@lists.sourceforge.net" <nbd-general@lists.sourceforge.net>,
 Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Stefan stefanha@redhat. com" <stefanha@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Pavel Borzenkov <pborzenkov@virtuozzo.com>, "Denis V. Lunev"
 <den@openvz.org>, Markus Pargmann <mpa@pengutronix.de>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <d0ce8e00-5875-d3c9-f040-b9d5daebbb2c@redhat.com>
Subject: Re: [Qemu-devel] [Nbd] [PATCH v3] doc: Add NBD_CMD_BLOCK_STATUS
 extension
References: <1480073296-6931-1-git-send-email-vsementsov@virtuozzo.com>
 <F075D231-9CBE-437C-B9F0-0DE2AB98007B@alex.org.uk>
 <ed5f8fc7-c7c8-c678-668f-17047dbe0b23@redhat.com>
 <4329D951-F1D0-4B0B-99AB-9F1B7D3DA99B@alex.org.uk>
 <C9D4A99C-1E81-4144-976B-289FF959430B@alex.org.uk>
 <20161208094436.7o4rm54ob2xh4eui@grep.be>
 <42260F0E-9D94-44D4-A5FF-EE8F5962ADA0@alex.org.uk>
In-Reply-To: <42260F0E-9D94-44D4-A5FF-EE8F5962ADA0@alex.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2016 08:40 AM, Alex Bligh wrote:

>>> + metadata context is the basic "exists at all" metadata context.
>>>
>>> Disagree. You're saying that if a server supports metadata contexts
>>> at all, it must support this one.
>>
>> No, I'm trying to say that this metadata context exposes whether the
>> *block* exists at all (i.e., it exports NBD_STATE_HOLE). I should
>> probably clarify that wording then, if you misunderstood it in that wa=
y.
>=20
> Ah. Perhaps 'exists at all' itself is misleading. 'Occupies storage
> space'. Or 'is not a hole'?
>=20
>> No server MUST implement it (although we might want to make it a SHOUL=
D)
>=20
> Don't see why it should even be a 'SHOULD' to be honest. An nbd
> server cooked up for a specific purpose, or with a backend that
> can't provide that (or where there is never a hole) shouldn't
> be criticised.
>=20
>>> I think the last sentence is probably meant to read something like:
>>>
>>> If a server supports the "BASE:allocation" metadata context, then
>>> writing to an extent which has `NBD_STATE_HOLE` clear MUST NOT fail
>>> with ENOSPC.
>>
>> No, it can't.
>>
>> Other metadata contexts may change the semantics to the extent that if=

>> the block is allocated at the BASE:allocation context, it would still
>> need to space on another plane. In that case, writing to an area which=

>> is not STATE_HOLE might still fail.

Not just that, but it is ALWAYS permissible to report NBD_STATE_HOLE as
clear (just not always optimal) - to allow servers that can't determine
sparseness information, but DO know how to communicate extents to the
client.  Yes, it is boring to communicate a single extent that the
entire file is data, and clients can't optimize their usage in that
case, but it should always be considered semantically correct to do so,
since the presence and knowledge of holes is merely an optimization
opportunity, not a data correctness issue.


>>> Why 512 bytes as opposed to 'minimum block size' (or is it because
>>> that is also an experimental extension)?
>>
>> Yes, and this extension does not depend on that one. Hence why it is
>> also a SHOULD and not a MUST.
>=20
> OK. As a separate discussion I think we should talk about promoting
> WRITE_ZEROES and INFO. The former has a reference implementation,
> I think Eric did a qemu implementation, and I did a gonbdserver
> implementation. The latter I believe lacks a reference implementation.

Yes, I still have reference qemu patches for INFO; they did not make it
into qemu 2.8 (while WRITE_ZEROES did), but should make it into 2.9.

I also hope to get structured reads into qemu 2.9, but that's a bigger
task, as I don't have reference patches complete yet.  On the other
hand, since BLOCK_STATUS depends on structured reply, I have all the
more reason to complete it soon.

>>> +    A client SHOULD NOT read from an area that has both `NBD_STATE_H=
OLE`
>>> +    set and `NBD_STATE_ZERO` clear.
>>>
>>> That makes no sense, as normal data has both these bits clear! This
>>> also implies that to comply with this SHOULD, a client needs to
>>> request block status before any read, which is ridiculous. This
>>> should be dropped.
>>
>> No, it should not, although it may need rewording. It clarifies that
>> having STATE_HOLE set (i.e., there's no valid data in the given range)=

>> and STATE_ZERO clear (i.e., we don't assert that it would read as
>> all-zeroes) is not an invalid thing for a server to set. The spec here=

>> clarifies what a client should do with that information if it gets it
>> (i.e., "don't read it, it doesn't contain anything interesting").
>=20
> That's fair enough until the last bit in brackets. Rather than saying
> a client SHOULD NOT read it, it should simply say that a read on
> such areas will succeed but the data read is undefined (and may
> not be stable).

We should use similar wording to whatever we already say about what a
client would see when reading data cleared by NBD_CMD_TRIM.  After all,
the status of STATE_HOLE set and STATE_ZERO clear is what you logically
get when TRIM cannot guarantee reads-as-zero.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--xM4bSFDA3NToVRrXL80bePf2jrdj8v82s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYSYNeAAoJEKeha0olJ0NqVfIIAIJBNc2GXZgqv1nx02Lw6+AJ
f9U0losabBvwvKVujTiGwJYdlvoCVLEnecMZbYcgLU03nEh+xj4u9mfQwMEv8pW4
/71AdQPeBGrrSqISIeJ6Rw5zXfYd1bl3fLy6srZYC9nBcT9GIjPzZGozipQ+JVhH
zY34ijgdNw9w3JyHVyowK3VBjIeOCLd5KF8MPOGlckOkSOmCg0y346RPbf+ATUtW
yxLW0lHPj/nVfED4IYbz6nNBxbWOnXfURzxIf9P8WY66HvGIU2nMiMw7MeiFKGZN
dKvIgDL70ECDnblkndNNRe/WMqVrhjcIpbwA71i/stej086ggPE8SWHPbzQTSRs=
=XGGC
-----END PGP SIGNATURE-----

--xM4bSFDA3NToVRrXL80bePf2jrdj8v82s--
