Received: from eggs.gnu.org ([2001:4830:134:3::10]:48439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ch2Dp-00062y-V5
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:50:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ch2Dm-0003fa-ST
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:50:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ch2Dm-0003fE-Gz
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 17:50:46 -0500
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
	<1487886317-27400-2-git-send-email-armbru@redhat.com>
	<12466fb1-5182-e97c-f82c-40d124fbbbcb@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f0f8abd7-18e8-f0b2-5232-f505866590f0@redhat.com>
Date: Thu, 23 Feb 2017 16:50:44 -0600
MIME-Version: 1.0
In-Reply-To: <12466fb1-5182-e97c-f82c-40d124fbbbcb@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cKjDAPO9FKfKBQLdmwpf30jVxtfxNiFUQ"
Subject: Re: [Qemu-devel] [PATCH 01/21] qga: Fix crash on non-dictionary QMP
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cKjDAPO9FKfKBQLdmwpf30jVxtfxNiFUQ
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <f0f8abd7-18e8-f0b2-5232-f505866590f0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/21] qga: Fix crash on non-dictionary QMP
 argument
References: <1487886317-27400-1-git-send-email-armbru@redhat.com>
 <1487886317-27400-2-git-send-email-armbru@redhat.com>
 <12466fb1-5182-e97c-f82c-40d124fbbbcb@redhat.com>
In-Reply-To: <12466fb1-5182-e97c-f82c-40d124fbbbcb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/23/2017 04:46 PM, Eric Blake wrote:
> On 02/23/2017 03:44 PM, Markus Armbruster wrote:
>> The value of key 'arguments' must be a JSON object.  qemu-ga neglects
>> to check, and crashes.  To reproduce, send
>>
>>     { 'execute': 'guest-sync', 'arguments': [] }
>>
>> to qemu-ga.
>>
>> do_qmp_dispatch() uses qdict_get_qdict() to get the arguments.  When
>> not a JSON object, this gets a null pointer, which flows through the
>> generated marshalling function to qobject_input_visitor_new(), where
>> it fails the assertion.  qmp_dispatch_check_obj() needs to catch this
>> error.
>>
>> QEMU isn't affected, because it runs qmp_check_input_obj() first,
>> which basically duplicates qmp_check_input_obj()'s checks, plus the

This sentence is weird (func A can't duplicate func A's checks; you're
missing a func B, but I'm not sure which instance is wrong, nor what B
should be).

>> missing one.
>>
>> Fix by copying the missing one from qmp_check_input_obj() to
>> qmp_dispatch_check_obj().
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
>> ---
>>  qapi/qmp-dispatch.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--cKjDAPO9FKfKBQLdmwpf30jVxtfxNiFUQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYr2dEAAoJEKeha0olJ0NqhekIAJdspHc84stZ4zdYrOW7bIUp
9ibdpj6EY9UddAU20UKDODtEFpaGMTRyjkLw2+rSo/HerMtD+83Qi3bJfMQREp0M
nBjRYY3v9Oq9HG8mRZ+OGAeVJ2TanrMbMuVCGOqBeJBY2HYP18xKAq42KbfFhS2n
xuB1+9ZKgVuSJZuCNysqseJTVl2rfkhE8dfNjMLsT9Yb3bQY1em3NtJA4yhjKJQ6
JMCIQaWrDcbl6DE8FtQk7+AaDxOoGju74ftpXOMZI1MMdQxMB94dnM8Dv0CPFlnZ
n8cjna+Jt15/UW6scmJe/Wb0u7a7YnrFjrO8RZf6wOt0C3EAgXzqYUNjYaKYvS4=
=Vgx5
-----END PGP SIGNATURE-----

--cKjDAPO9FKfKBQLdmwpf30jVxtfxNiFUQ--
