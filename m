Received: from eggs.gnu.org ([2001:4830:134:3::10]:54982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctx7j-0002Ts-6K
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ctx7f-0006CB-5x
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:01:55 -0400
References: <1490894892-8055-1-git-send-email-minyard@acm.org>
	<0715ab2d-f367-03ef-1674-4c1e67756f85@redhat.com>
	<71b59e1b-caf0-d7b0-0648-b98d62e66c6b@acm.org>
	<f99214c2-6a18-5ab0-c6af-75590cc8d5fd@redhat.com>
	<f0dd4986-add0-b3d5-745e-e56ca0d23a22@acm.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7ba4f927-8d0b-2387-c324-42670c8265f3@redhat.com>
Date: Fri, 31 Mar 2017 09:01:48 -0500
MIME-Version: 1.0
In-Reply-To: <f0dd4986-add0-b3d5-745e-e56ca0d23a22@acm.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6kwjxMPUfJfB43Sd09vWGRrUJllTx1bn2"
Subject: Re: [Qemu-devel] [PATCH for-2.9? v2 resend] ipmi: Fix macro issues
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Ed Maste <emaste@freebsd.org>, Corey Minyard <cminyard@mvista.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6kwjxMPUfJfB43Sd09vWGRrUJllTx1bn2
From: Eric Blake <eblake@redhat.com>
To: minyard@acm.org, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Ed Maste <emaste@freebsd.org>,
 Corey Minyard <cminyard@mvista.com>
Message-ID: <7ba4f927-8d0b-2387-c324-42670c8265f3@redhat.com>
Subject: Re: [PATCH for-2.9? v2 resend] ipmi: Fix macro issues
References: <1490894892-8055-1-git-send-email-minyard@acm.org>
 <0715ab2d-f367-03ef-1674-4c1e67756f85@redhat.com>
 <71b59e1b-caf0-d7b0-0648-b98d62e66c6b@acm.org>
 <f99214c2-6a18-5ab0-c6af-75590cc8d5fd@redhat.com>
 <f0dd4986-add0-b3d5-745e-e56ca0d23a22@acm.org>
In-Reply-To: <f0dd4986-add0-b3d5-745e-e56ca0d23a22@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/31/2017 08:32 AM, Corey Minyard wrote:

>> Note, on the other hand, that a call such as
>> IPMI_BT_SET_HBUSY(ib->control_reg, 2) would result in writing 0 to the=

>> HBUSY bit. In other words, the IPMI_BT_SET_HBUSY() macro is rather wei=
rd
>> in that it sets or clears the HBUSY bit based solely on whether its v
>> parameter is even or odd, rather than the more usual semantics of
>> whether the v parameter is 0 or non-zero.  We could change that if we
>> wanted - by having the macro expand to "(left | (!!(v) << shift))"
>> instead of our current expansion of "(left | (((v) & 1) << shift))" -
>> but I still don't think it would change the semantics of any existing
>> caller.
>=20
> Yeah, that would be better.  Should I do another patch?

Up to you; I'm fine with either the existing patch as proposed or with
reviewing a v4 (interesting that you resent v2, even though you had also
posted a v3 at one point, where the only difference seems to have been
adding my R-b).

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--6kwjxMPUfJfB43Sd09vWGRrUJllTx1bn2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY3mFMAAoJEKeha0olJ0Nqho4H/2h5D9IMW/ahVHWPUEmPd2y6
LC5qriPUs/5H9xwavpgtCwekKS7npWLqAkm8yR6/Fq66ws75tNA8JQqnl5VXKDhH
hCrKRZuyBk2FDjgEHxssEQO7kP7tb3xi/rGiGZ2Ry83w2eaX9FQJQOBtKLuqSFBq
FFwKr+eDyKFUp+GFBDaISOtofGElNoq8qpyveOBzR0gSpdt1PrvU3Bj3I9GNY/H0
viiekm+97SETLRN7XobDWikQiAokR4VCNUTZzXtQfY+ZogHtxvB64DqZfsVIytc+
dsJlHGExjl5VrVpMkc9b3Z8v6HpcVpqT6gx9cGB7gfDCHXJ4OGE8KhICMbzm+Vs=
=+DiS
-----END PGP SIGNATURE-----

--6kwjxMPUfJfB43Sd09vWGRrUJllTx1bn2--
