Received: from eggs.gnu.org ([2001:4830:134:3::10]:38499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkbrm-0005eK-Tt
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dkbrm-0003ru-6q
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 16:03:06 -0400
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-9-eblake@redhat.com>
	<e44a3300-cbe9-c9d7-ae49-b223f638d7ea@redhat.com>
	<da3712de-986d-8130-7a97-e9f1071d2a03@redhat.com>
	<c665235d-8bec-627a-f750-4dc2798c3d8c@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5d84655b-d82a-956a-f434-023961b23552@redhat.com>
Date: Wed, 23 Aug 2017 22:02:50 +0200
MIME-Version: 1.0
In-Reply-To: <c665235d-8bec-627a-f750-4dc2798c3d8c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Cha4BgUivLM8AcEp2aNM35fkLocm735jA"
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
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, "open list:Floppy" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cha4BgUivLM8AcEp2aNM35fkLocm735jA
From: Paolo Bonzini <pbonzini@redhat.com>
To: Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, "open list:Floppy" <qemu-block@nongnu.org>
Message-ID: <5d84655b-d82a-956a-f434-023961b23552@redhat.com>
Subject: Re: [Qemu-block] [PATCH v5 08/13] tests: Rely more on global_qtest
References: <20170818211542.5380-1-eblake@redhat.com>
 <20170818211542.5380-9-eblake@redhat.com>
 <e44a3300-cbe9-c9d7-ae49-b223f638d7ea@redhat.com>
 <da3712de-986d-8130-7a97-e9f1071d2a03@redhat.com>
 <c665235d-8bec-627a-f750-4dc2798c3d8c@redhat.com>
In-Reply-To: <c665235d-8bec-627a-f750-4dc2798c3d8c@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23/08/2017 21:26, Eric Blake wrote:
>> I agree with using the short form where possible, but I disagree on
>> removing the long forms.  Rather, global_qtest in my opinion should ha=
ve
>> been static (though I'm not proposing that you do this); inlining the
>> wrappers is not needed for performance.
> But no one outside of libqtest.c is using the long form.  Maintaining a=

> long form that isn't used is counter-productive, if the short form is
> good enough for everything we need.

Well, whatever is assigning to global_qtest should be using the long form=
=2E

Paolo


--Cha4BgUivLM8AcEp2aNM35fkLocm735jA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlmd32oACgkQv/vSX3jH
roND1wgAmu30ZXPjmhPDuhP1cVA2zbKjzOxyozEFQzPs5rf3zM8Aer0SeTkl4u2T
t1oHsxqfHXqN7L99I7u48gijLBw9L9Oe9wI9MgTj2blX4DjrEzOmbISHMpnlf4/L
EsvM0HURBZt+eazvzE/FJ7h0LuhMfVq0dyrbO2DQcPy8+hXuzEkTKvcLr5GCIIgJ
MWMgPZbCEkc66b9WAmoum0cMjP8KV4uKw/HTvrKwx9liVtrV2HZ/RZJKAn7g6Ma4
neXsp5qWTn+A79n4W8ZNyA2MJ5dRfZPn+Iapp/88+hVsypbaTTqZvFq9+tEQK2lb
skyp670CYIs0T3hzGxuIC8gr5rQU8w==
=2YJq
-----END PGP SIGNATURE-----

--Cha4BgUivLM8AcEp2aNM35fkLocm735jA--
