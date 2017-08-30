Received: from eggs.gnu.org ([2001:4830:134:3::10]:58073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnBae-0004Wy-3S
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnBac-0004hg-UE
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:36:04 -0400
References: <cover.1504111803.git.jcody@redhat.com>
	<aba8a2b58f34b56281e63e5e9404eb0aab016836.1504111803.git.jcody@redhat.com>
	<1646044f-3c57-c415-f261-463c74ea45b8@redhat.com>
	<2690a268-b5be-7974-e8ef-c5a2f09c72a5@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8f38ba5-5170-d3c8-99ca-24030f900e53@redhat.com>
Date: Wed, 30 Aug 2017 17:35:51 -0500
MIME-Version: 1.0
In-Reply-To: <2690a268-b5be-7974-e8ef-c5a2f09c72a5@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OnT6MpXJeFeaeWROaU7btgmxC72Jeu89C"
Subject: Re: [Qemu-devel] [PATCH v3 4/5] qemu-iotests: make python tests
 attempt to leave intermediate files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, armbru@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OnT6MpXJeFeaeWROaU7btgmxC72Jeu89C
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, Jeff Cody <jcody@redhat.com>,
 qemu-devel@nongnu.org
Cc: stefanha@redhat.com, kwolf@redhat.com, armbru@redhat.com,
 qemu-block@nongnu.org
Message-ID: <c8f38ba5-5170-d3c8-99ca-24030f900e53@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/5] qemu-iotests: make python tests
 attempt to leave intermediate files
References: <cover.1504111803.git.jcody@redhat.com>
 <aba8a2b58f34b56281e63e5e9404eb0aab016836.1504111803.git.jcody@redhat.com>
 <1646044f-3c57-c415-f261-463c74ea45b8@redhat.com>
 <2690a268-b5be-7974-e8ef-c5a2f09c72a5@redhat.com>
In-Reply-To: <2690a268-b5be-7974-e8ef-c5a2f09c72a5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/30/2017 05:28 PM, John Snow wrote:

> I'm a little iffy on this patch; I know that ./check can take care of
> our temp files for us now, but because each python test is itself a
> little mini-harness, I'm a little leery of moving the teardown to setup=

> and trying to pre-clean the confetti before the test begins.
>=20
> What's the benefit? We still have to clean up these files per-test, but=

> now it's slightly more error-prone and in a weird place.
>=20
> If we want to try to preserve the most-recent-failure-files, perhaps we=

> can define a setting in the python test-runner that allows us to
> globally skip file cleanup.

On the other hand, since each test is a mini-harness, globally skipping
cleanup will make a two-part test fail on the second because of garbage
left behind by the first.

Patch 5 adds a comment with another possible solution: teach the python
mini-harness to either clean all files in the directory, or to relocate
the directory according to test name, so that each mini-test starts with
a fresh location, and cleanup is then handled by the harness rather than
spaghetti pre-cleanup.  But any solution is better than our current
situation of nothing, so that's why I'm still okay with this patch as-is
as offering more (even if not perfect) than before.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OnT6MpXJeFeaeWROaU7btgmxC72Jeu89C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmnPccACgkQp6FrSiUn
Q2radwf9GtwyKVaQZ1gWp0GhBlm1y747S/NWxoHgB80IWeJmTAXK8bmOq6STOBIW
OzYM5PG+D4q7LU+OgFJ7uKsXL38tebrgjcl5eOFZFQpkFsx8ANq5kKGQ9Pqb/7ej
+9IbztoVYPwhU+NhrV3M/bPL4TzgLqGeeMxuvF2O52CFkd0enlB3YVU/f1gStbI/
+J+1uD6tCP2usgkjwO1CQ1WzxVVD5BU0Vka5mUyqHAjnWbHPDfaPRGHABybisACI
P59rTbw0qU6uunfTSuMC2hIA61IflkKqwd4bSszzq5klhsnbs516uQ3mg7SkIKxq
9XZwQ+VePg76K96xnKJKGudRb8dYEw==
=lWTN
-----END PGP SIGNATURE-----

--OnT6MpXJeFeaeWROaU7btgmxC72Jeu89C--
