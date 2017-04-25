Received: from eggs.gnu.org ([2001:4830:134:3::10]:39213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d360e-00072E-BB
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:20:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d360Y-00035L-93
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 15:20:24 -0400
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
	<0ffa427b-9f38-c673-ded9-b6f17742f5ca@redhat.com>
	<CAOGPPbced2TTLkU8VmaQVGmAatpckd+T=2+uue-=drOkVd4rLg@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f4bac29a-23e1-a2fb-e4ae-fb6298c04984@redhat.com>
Date: Tue, 25 Apr 2017 14:20:08 -0500
MIME-Version: 1.0
In-Reply-To: <CAOGPPbced2TTLkU8VmaQVGmAatpckd+T=2+uue-=drOkVd4rLg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QbPixTTWr7QnPPuWNxGOX9tGUkpg8U4pN"
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-img: make sure contain the
 consecutive number of zero bytes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Lidong Chen <lidongchen@tencent.com>, qemu block <qemu-block@nongnu.org>, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QbPixTTWr7QnPPuWNxGOX9tGUkpg8U4pN
From: Eric Blake <eblake@redhat.com>
To: 858585 jemmy <jemmy858585@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>,
 Lidong Chen <lidongchen@tencent.com>, qemu block <qemu-block@nongnu.org>,
 mreitz@redhat.com
Message-ID: <f4bac29a-23e1-a2fb-e4ae-fb6298c04984@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qemu-img: make sure contain the
 consecutive number of zero bytes
References: <1492957997-28587-1-git-send-email-lidongchen@tencent.com>
 <0ffa427b-9f38-c673-ded9-b6f17742f5ca@redhat.com>
 <CAOGPPbced2TTLkU8VmaQVGmAatpckd+T=2+uue-=drOkVd4rLg@mail.gmail.com>
In-Reply-To: <CAOGPPbced2TTLkU8VmaQVGmAatpckd+T=2+uue-=drOkVd4rLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/24/2017 08:50 PM, 858585 jemmy wrote:
> On Mon, Apr 24, 2017 at 10:43 PM, Eric Blake <eblake@redhat.com> wrote:=

>> On 04/23/2017 09:33 AM, jemmy858585@gmail.com wrote:
>>> From: Lidong Chen <lidongchen@tencent.com>
>>>
>>> is_allocated_sectors_min don't guarantee to contain the
>>> consecutive number of zero bytes. this patch fixes this bug.
>>
>> This message was sent without an 'In-Reply-To' header pointing to a 0/=
2
>> cover letter.  When sending a series, please always thread things to a=

>> cover letter; you may find 'git config format.coverletter auto' to be
>> helpful.
>=20
> Thanks for your kind advises.
>=20

>>
>> I seem to recall past attempts to try and patch this function, which
>> were then turned down, although I haven't scrubbed the archives for a
>> quick URL to point to. I'm worried that there are more subtleties here=

>> than what you realize.
>=20
> Hi Eric:
> Do you mean this URL?
> https://lists.gnu.org/archive/html/qemu-block/2017-01/msg00306.html

Yes, that's probably the one.

>=20
> But I think the code is not consistent with qemu-img --help.
> qemu-img --help
>   '-S' indicates the consecutive number of bytes (defaults to 4k) that =
must
>        contain only zeros for qemu-img to create a sparse image during
>        conversion. If the number of bytes is 0, the source will not be
> scanned for
>        unallocated or zero sectors, and the destination image will alwa=
ys be
>        fully allocated.

If you still think this patch is needed, the best way to convince me of
it is accompany your patch by a qemu-iotests enhancement that covers the
change in behavior (running the test pre-patch would show that we are
broken without the patch, and having the test ensures we can't later
regress).  That's a lot more work than the vague two lines of the commit
message body.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QbPixTTWr7QnPPuWNxGOX9tGUkpg8U4pN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY/6FoAAoJEKeha0olJ0Nqf00H/1ykMvUQc7D3WaeHvM9BLB+b
BbjVc/1sLDuH/wAY0hUWE9AXilcqFo7S6p49eOxGlemZUTl7A0ke3ARnctIcWA5u
1DX/q87zFwyd/wXQPCyw0KPNaVdTxsaaxj8NlmcZ+zxU4/Ga2tUDtkfuru/rdK6W
Rwkmg6QzlRqhfkU95xEwhW83Amf0r0aq34IVyptgyqbL3jmd48kR8CZnP43Ec3FR
/8W5feb9sbXvsZi9X4KSS7MMF2o6qbCQi5I3Q/oT/HCtLZ6PBn6qcHLR1BY/HYUB
hO74ZB8mNeuAy3DxQuKB0Ni8xNhbisRvQ0+BMVqr5ayr6yk4EMMsxNE0PNRKmlo=
=y2xL
-----END PGP SIGNATURE-----

--QbPixTTWr7QnPPuWNxGOX9tGUkpg8U4pN--
