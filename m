Received: from eggs.gnu.org ([2001:4830:134:3::10]:38417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1du6CZ-00009F-89
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1du6CV-0006dY-62
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:15:47 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:38834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1du6CU-0006cw-W5
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 20:15:43 -0400
Received: by mail-pf0-x243.google.com with SMTP id q76so801681pfq.5
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 17:15:42 -0700 (PDT)
References: <20170918101709.30421-1-aik@ozlabs.ru>
	<20170918101709.30421-3-aik@ozlabs.ru>
	<05940475-2563-87fc-bdc5-5acb1bba4932@redhat.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <410e74f9-76c9-6b6a-3236-d7782a97520b@ozlabs.ru>
Date: Tue, 19 Sep 2017 10:15:34 +1000
MIME-Version: 1.0
In-Reply-To: <05940475-2563-87fc-bdc5-5acb1bba4932@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="w638gPifdl44jlVBRAV2gJo2oRMx2U55c"
Subject: Re: [Qemu-devel] [PATCH qemu v3 02/13] exec: Explicitely export
 target AS from address_space_translate_internal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w638gPifdl44jlVBRAV2gJo2oRMx2U55c
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <410e74f9-76c9-6b6a-3236-d7782a97520b@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH qemu v3 02/13] exec: Explicitely export
 target AS from address_space_translate_internal
References: <20170918101709.30421-1-aik@ozlabs.ru>
 <20170918101709.30421-3-aik@ozlabs.ru>
 <05940475-2563-87fc-bdc5-5acb1bba4932@redhat.com>
In-Reply-To: <05940475-2563-87fc-bdc5-5acb1bba4932@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19/09/17 00:28, Eric Blake wrote:
> On 09/18/2017 05:16 AM, Alexey Kardashevskiy wrote:
>=20
> Subject line: s/Explicitely/Explicitly/
>=20
>> This is not so mechanical change in order to move to shared FlatViews
>> so make it a separate patch.
>=20
> Hard to understand; it's unclear whether this is the mechanical additio=
n
> of a parameter before the next patch does shared FlatViews, or whether
> the next patch is mechanical by virtue of this patch doing the
> non-mechanical changes.  Maybe:
>=20
> Mechanical change to add a parameter to make it easier for the next
> patch to share FlatViews.

I was told in this list that "mechanical" is when simple 's/lalala/mememe=
/'
does the job, when it is bigger than this - then it is "this should not
cause any behavioural change" :) I'll add such note where applicable.

tbh only 1/13, 11/13 and 13/13 do cause a change in behaviour, others do =
not.

>=20
>> The first argument of
>> address_space_do_translate() will become a FlatView, however since
>> address_space_get_iotlb_entry() still wants AS, hence this change.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>  exec.c | 11 +++++++----
>>  1 file changed, 7 insertions(+), 4 deletions(-)
>>


--=20
Alexey


--w638gPifdl44jlVBRAV2gJo2oRMx2U55c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZwGGmDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5cFYP/j5W
Aqft3CfupnelE5w3vQLA8csKPosPeDeOdPbimatkqLvCimz94YR8+K5naoTcsD6j
7zUk1OaviBvCeNiMI2WnOc6MLn15bZ5kwUtVvms6bT/ybXy38AWWb0WIv7e2sDZS
MWtFoBK25C691fB4DGyogrh5ASgEywjob86dp4QBFHma8vyCoZcd0gEpt0IWvok/
2kBvnIQdV0KlOn6hZkpl7WNbHblr0SREgR1r/E/nDDuncBWwydP3mMRG3Ru8O8U/
ePSKAfECHrMAHw+WXfINHNBL7t/mAEH7gj9fdqoKlk+x2dG+OhcsS8BsseBcJ/6A
ymlq7oizsLi48iUO2JxcAJxKYT6ELN+oMMn2Gxyeq7nH+ubzDrzCJsLrKtJhmB3e
c4rNzsT5t6uMLZ/fpPxiKPcjvyRkL0OxMrl3w05RVNhB53Rzb8FClbQXaeLk0OXK
CqkayEgY3sblTgXcU4slnXSGU2VwOaV15q3lPdKtnM9kpFBOS1EPaBTxJBwlr0Z+
45cWAKmz2KVvTGwy2tItzWcz/jsZKReSEEPr/m96No/B7hQe4vME8IMWmMiCwh9a
aO3tVVFtnI0OfYmYW1cpw+lyoQEzyOdeHgNYGaSTRuYtoa0M8MoAv+PibHSFfCfJ
ez+QvSw4uJxlt5cJ31/6nS20ADjRPORtIgCNHvO0
=2Sgx
-----END PGP SIGNATURE-----

--w638gPifdl44jlVBRAV2gJo2oRMx2U55c--
