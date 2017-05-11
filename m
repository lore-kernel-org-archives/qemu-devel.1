Received: from eggs.gnu.org ([2001:4830:134:3::10]:53195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8snH-0003WY-Uz
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:26:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d8snF-0007oV-Dl
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:26:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42224)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d8snF-0007mg-4f
	for qemu-devel@nongnu.org; Thu, 11 May 2017 14:26:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 216CE80C0C
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 18:26:28 +0000 (UTC)
References: <1494505358-15287-1-git-send-email-peterx@redhat.com>
	<1494505358-15287-5-git-send-email-peterx@redhat.com>
	<d938d532-6d11-0ec5-a24a-0a44519bc021@redhat.com>
	<87lgq3ntis.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <83dec552-7f69-74ef-6756-0ce3180ef225@redhat.com>
Date: Thu, 11 May 2017 13:26:24 -0500
MIME-Version: 1.0
In-Reply-To: <87lgq3ntis.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PeXdQOq5wOQs4K4AM8E8l6RpqUpr29egs"
Subject: Re: [Qemu-devel] [PATCH v7 4/4] utils: remove assert in
 size_to_str()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PeXdQOq5wOQs4K4AM8E8l6RpqUpr29egs
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <83dec552-7f69-74ef-6756-0ce3180ef225@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 4/4] utils: remove assert in size_to_str()
References: <1494505358-15287-1-git-send-email-peterx@redhat.com>
 <1494505358-15287-5-git-send-email-peterx@redhat.com>
 <d938d532-6d11-0ec5-a24a-0a44519bc021@redhat.com>
 <87lgq3ntis.fsf@dusky.pond.sub.org>
In-Reply-To: <87lgq3ntis.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/11/2017 01:22 PM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 05/11/2017 07:22 AM, Peter Xu wrote:
>>> It's not very safe to assert in size_to_str(). Let's be inclusive.
>>>
>>> It naturally allows negative values. Now it won't even limit on the
>>> size, as long as double would allow.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>  util/cutils.c | 9 +++++++--
>>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> Since you just introduced this in 2/4, I'd rather see the two squashed=

>> together if we decide this is the interface we want to support.
>=20
> PATCH 2 factors it out of print_type_size().  Doing just that and
> improving only on top makes some sense.

Okay. (Moral of the story: I should have done more than just glance at 2
before commenting on 4)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PeXdQOq5wOQs4K4AM8E8l6RpqUpr29egs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZFKzQAAoJEKeha0olJ0Nq6uIIAKH0SrNL0/RuUSwj+r5bBorb
jKSLvn02dNtuwlWYdxsJqeBQTHkKsA/pOg9dj5WhN1/ohDUh5T72eZ4KKC6pxvcp
C/rx7iqyKFogk7SUAyDntzYqIPngaS5xBSH+RV0uZxpc5vZJx3j4sYTjNW0962BP
k27r3yKjNdNHAVe4s3+MXvkT1zFWnmQ8oZGt1EHpCGWYSR7DTwyJkLGGlSytvQAl
w2OFa3XGPoEREXM0KppFyScUx6gTwlum0FZbPnZy1AUtNQP/IM16C3r2MrgF0Bgp
rmg1hVfL2zSr3s37eLmUl+j440JtduKiw1CFeB+q6WyETRiODiuB477yWJ8F3I0=
=Qp12
-----END PGP SIGNATURE-----

--PeXdQOq5wOQs4K4AM8E8l6RpqUpr29egs--
