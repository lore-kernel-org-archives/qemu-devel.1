Received: from eggs.gnu.org ([2001:4830:134:3::10]:60229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkbIJ-0003Qc-Q8
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkbII-0002Lp-O6
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 15:26:27 -0400
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-9-eblake@redhat.com>
	<e44a3300-cbe9-c9d7-ae49-b223f638d7ea@redhat.com>
	<da3712de-986d-8130-7a97-e9f1071d2a03@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c665235d-8bec-627a-f750-4dc2798c3d8c@redhat.com>
Date: Wed, 23 Aug 2017 14:26:17 -0500
MIME-Version: 1.0
In-Reply-To: <da3712de-986d-8130-7a97-e9f1071d2a03@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4C48ah00Q34BKILi9wb3X6thfhDQGHufV"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 08/13] tests: Rely more on
 global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, "open list:Floppy" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4C48ah00Q34BKILi9wb3X6thfhDQGHufV
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, "open list:Floppy" <qemu-block@nongnu.org>
Message-ID: <c665235d-8bec-627a-f750-4dc2798c3d8c@redhat.com>
Subject: Re: [Qemu-block] [PATCH v5 08/13] tests: Rely more on global_qtest
References: <20170818211542.5380-1-eblake@redhat.com>
 <20170818211542.5380-9-eblake@redhat.com>
 <e44a3300-cbe9-c9d7-ae49-b223f638d7ea@redhat.com>
 <da3712de-986d-8130-7a97-e9f1071d2a03@redhat.com>
In-Reply-To: <da3712de-986d-8130-7a97-e9f1071d2a03@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/19/2017 11:34 AM, Paolo Bonzini wrote:
> On 18/08/2017 23:33, John Snow wrote:
>>> Before the next few patches
>>> get rid of the qtest_* layer, we first need to update the remaining
>>> few spots that were using the long form where we can instead rely
>>> on the short form.
>>>
>> Not a big fan of globals and implicit state, but I do at least agree
>> that we don't need two sets of functions.
>=20
> I agree with using the short form where possible, but I disagree on
> removing the long forms.  Rather, global_qtest in my opinion should hav=
e
> been static (though I'm not proposing that you do this); inlining the
> wrappers is not needed for performance.

But no one outside of libqtest.c is using the long form.  Maintaining a
long form that isn't used is counter-productive, if the short form is
good enough for everything we need.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--4C48ah00Q34BKILi9wb3X6thfhDQGHufV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmd1tkACgkQp6FrSiUn
Q2o2gggAnZV7D5PrhFhuSLNgtiNU5kxh0OJ6DzgE5ot5f/BX3bsfi7AiiE/vLl3q
LAs1Qyqh3RkfuIxBEmoWoLNC8Q4DSekW4RkbeUyvl/SyLlHvY9ezu6O/JgYJ108C
8MM92fqPV9s69a09i2CrNHKROxQOEWI/rM+EfLJqQtsrg+Vibt9+1WaEoLgO1xVq
hMASvkLMZdipaxd21R/F7JzzasCtvNKYfrycK2wtoBvi0dwMjbzA0lJGYPQr8CgJ
591Xni/3YUnu6u9u6HnINtMRTMSxjqs19xizdEbjlEPeEQvq1Pj6BYIuRPdIQ3Aj
llwLzYKB2V7rQztUuxAyN4xxysqieA==
=/qne
-----END PGP SIGNATURE-----

--4C48ah00Q34BKILi9wb3X6thfhDQGHufV--
