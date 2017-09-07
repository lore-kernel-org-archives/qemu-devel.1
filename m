Received: from eggs.gnu.org ([2001:4830:134:3::10]:46675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dq4Nh-0000fU-42
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 17:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dq4Nc-00062P-CN
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 17:30:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dq4Nc-00062H-38
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 17:30:32 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EADBA81DE3
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 21:30:30 +0000 (UTC)
References: <20170901180340.30009-1-eblake@redhat.com>
	<20170901180340.30009-25-eblake@redhat.com>
	<941b7e45-7dfc-8e35-18e0-12b247481d1e@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c127b8de-4973-3c0c-503e-f060080f2a16@redhat.com>
Date: Thu, 7 Sep 2017 16:30:25 -0500
MIME-Version: 1.0
In-Reply-To: <941b7e45-7dfc-8e35-18e0-12b247481d1e@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nlpSDa6snG1odAvUnr0hGs3j758Jg9B0w"
Subject: Re: [Qemu-devel] [PATCH v6 24/29] bios-tables-test: Drop dependence
 on global_qtest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>, armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nlpSDa6snG1odAvUnr0hGs3j758Jg9B0w
From: Eric Blake <eblake@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, Igor Mammedov <imammedo@redhat.com>,
 armbru@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <c127b8de-4973-3c0c-503e-f060080f2a16@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 24/29] bios-tables-test: Drop dependence
 on global_qtest
References: <20170901180340.30009-1-eblake@redhat.com>
 <20170901180340.30009-25-eblake@redhat.com>
 <941b7e45-7dfc-8e35-18e0-12b247481d1e@redhat.com>
In-Reply-To: <941b7e45-7dfc-8e35-18e0-12b247481d1e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/05/2017 05:59 AM, Thomas Huth wrote:
> On 01.09.2017 20:03, Eric Blake wrote:
>> As a general rule, we prefer avoiding implicit global state
>> because it makes code harder to safely copy and paste without
>> thinking about the global state.  Although bios-tables-test does
>> not maintain parallel qtest connections, it's just as easy to be
>> explicit about the state; once all tests have been cleaned up, a
>> later patch can then get rid of global_qtest and a layer of
>> wrappers in libqtest.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  tests/bios-tables-test.c | 78 +++++++++++++++++++++++++--------------=
---------
>>  1 file changed, 40 insertions(+), 38 deletions(-)
>>
>> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>> index 75b29df493..976792f2c5 100644
>> --- a/tests/bios-tables-test.c
>> +++ b/tests/bios-tables-test.c
>> @@ -38,6 +38,7 @@ typedef struct {
>>      struct smbios_21_entry_point smbios_ep_table;
>>      uint8_t *required_struct_types;
>>      int required_struct_types_len;
>> +    QTestState *qts;
>>  } test_data;
>=20
> Ah, well, ok, here it is. Please merge this with the previous patch!

Sure, I'll merge the two.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nlpSDa6snG1odAvUnr0hGs3j758Jg9B0w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmxunEACgkQp6FrSiUn
Q2omsgf/bpIkrI9dfqPOzoeGrF+uKQ6xIBgINyur32f2wKHb9MX/3Rh98e2gJRCl
30Ccw0U9ojs6U78/pbl+w5/+K/1rdS1zafhOkvVRy5p41a6YpYjlIP07VNsACmMP
G9OptFT0IQx/PiR6MtXXxiSuNpuUuMRYwrjQZXMoy8Gib4lDb+yhoeTgdhOKNJ/i
8lkeJRpavHtB2WeYc3Qxr3yQRdRkpLck2qgNKO54GkQ4dUUAqcLiZ8sd7PxfbEBc
fkyjkCd0lBmISFi5U8Y0SlifTsmvvSS9/GGuCu06HCYUXB0PO8uzTa/zAiYXMtIA
S/m3FYWatMp309OOXgALuj0CTB5mmA==
=PNUY
-----END PGP SIGNATURE-----

--nlpSDa6snG1odAvUnr0hGs3j758Jg9B0w--
