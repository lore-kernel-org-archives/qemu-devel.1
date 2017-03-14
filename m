Received: from eggs.gnu.org ([2001:4830:134:3::10]:51700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnnZG-0006iJ-Pe
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cnnZC-0004aO-Vb
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:36:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cnnZC-0004ZP-Mf
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 10:36:50 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC9D85144F
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 14:36:50 +0000 (UTC)
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-7-eblake@redhat.com>
	<20170313200752.GG5512@work-vm>
	<89b9b8e6-b5ca-8056-783b-598e07bf5da0@redhat.com>
	<20170314113234.GE2445@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8f837495-f773-9cad-004b-1f1f592c4244@redhat.com>
Date: Tue, 14 Mar 2017 09:36:47 -0500
MIME-Version: 1.0
In-Reply-To: <20170314113234.GE2445@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6hgWLwJsg0KAm9C5LWw5PuRDk2kMXAVr4"
Subject: Re: [Qemu-devel] [PATCH v2 06/30] trace: Fix parameter types in
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Juan Quintela <quintela@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6hgWLwJsg0KAm9C5LWw5PuRDk2kMXAVr4
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com,
 Juan Quintela <quintela@redhat.com>
Message-ID: <8f837495-f773-9cad-004b-1f1f592c4244@redhat.com>
Subject: Re: [PATCH v2 06/30] trace: Fix parameter types in migration
References: <20170313195547.21466-1-eblake@redhat.com>
 <20170313195547.21466-7-eblake@redhat.com> <20170313200752.GG5512@work-vm>
 <89b9b8e6-b5ca-8056-783b-598e07bf5da0@redhat.com>
 <20170314113234.GE2445@work-vm>
In-Reply-To: <20170314113234.GE2445@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/14/2017 06:32 AM, Dr. David Alan Gilbert wrote:
> * Eric Blake (eblake@redhat.com) wrote:
>> On 03/13/2017 03:07 PM, Dr. David Alan Gilbert wrote:
>>> * Eric Blake (eblake@redhat.com) wrote:
>>>> An upcoming patch will let the compiler warn us when we are silently=

>>>> losing precision in traces; update the trace definitions to pass
>>>> through the full value at the callsite.
>>>>

>>>
>>> So why is a PRIx64 not the right way to print a __u64 ?
>>
>> Because __u64 is not the same type as uint64_t.  On 64-bit Linux, __u6=
4
>> is 'unsigned long long', while uint64_t is 'unsigned long'.
>>
>>> (I prefer %llx to the horrid PRIx64 syntax, but it still seems weird =
in this case)
>>
>> As it is, I'm not sure if __u64 is always 'unsigned long long' in ALL
>> Linux clients; an even-more-conservative patch would be to switch all
>> callers to use explicit casts to something (like uint64_t or unsigned
>> long long) that we have full control over, rather than passing __u64
>> where we have no control over what type it ultimately resolves to.
>=20
> That would be my preference - casting to (uint64_t) at the caller and
> keep this as PRIx64.  We know it's a 64bit value so we should never
> use unsigned long long anywhere for it.

Okay, my next version will insert an explicit cast in any caller that is
otherwise passing a __u64 (since we can't guarantee what type __u64
resolves to, and therefore what format string is appropriate for it).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6hgWLwJsg0KAm9C5LWw5PuRDk2kMXAVr4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYyAAAAAoJEKeha0olJ0NqZrMH/ROkk8lf1xUCvFf8T/VdcG12
ZQ8XQXNrX2TnZhzI3lki8kjXVIEygxGyS/xCbzmLtEorIkLFPvOwMIYmzDMDFoE6
rNL2IRma3W+38tM7Cxdh4ZAZMhtyhTUF03cQC4AYO4E2/oHnagAR4YvhnHNEheIG
k4B9KixstgUJLk2V4kRRCcRiUgfp1irPfaR9zuX0TGLvtsH+gLvdk1YpFpGnbWBa
X5zdURW8xOAKoIhavp/ahC4XCHYI0HomBoW3e+5iAwTMwLli0VteJhFZjINMxAng
ZxwRTgrrh5nPQXb87hQCb+yUKlOpvjNzET8Nx6SBajtFpjOakax0+vrqJJXo7hU=
=zHeq
-----END PGP SIGNATURE-----

--6hgWLwJsg0KAm9C5LWw5PuRDk2kMXAVr4--
