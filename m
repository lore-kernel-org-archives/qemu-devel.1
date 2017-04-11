Received: from eggs.gnu.org ([2001:4830:134:3::10]:57751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxzov-0001iK-4V
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 13:43:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cxzou-0005hW-1P
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 13:43:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cxzot-0005hM-Op
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 13:43:11 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDBB97AEA1
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 17:43:10 +0000 (UTC)
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-7-eblake@redhat.com>
	<87o9w250xe.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <efe80be3-03ff-9581-b6a7-435330b03a2c@redhat.com>
Date: Tue, 11 Apr 2017 12:43:09 -0500
MIME-Version: 1.0
In-Reply-To: <87o9w250xe.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hvi9SHlra3FwtVMEapvDwF1UN45UJKq0k"
Subject: Re: [Qemu-devel] [PATCH v3 06/13] qobject: Add helper macros for
 common scalar insertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hvi9SHlra3FwtVMEapvDwF1UN45UJKq0k
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <efe80be3-03ff-9581-b6a7-435330b03a2c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 06/13] qobject: Add helper macros for
 common scalar insertions
References: <20170405194741.18956-1-eblake@redhat.com>
 <20170405194741.18956-7-eblake@redhat.com>
 <87o9w250xe.fsf@dusky.pond.sub.org>
In-Reply-To: <87o9w250xe.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2017 12:06 PM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Rather than making lots of callers wrap a scalar in a QInt, QString,
>> or QBool, provide helper macros that do the wrapping automatically.
>>
>> Update the Coccinelle script to make mass conversions easy, although
>> the conversion itself will be done as a separate patches to ease
>> review and backport efforts.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  include/qapi/qmp/qdict.h         |  8 ++++++++
>>  include/qapi/qmp/qlist.h         |  8 ++++++++
>>  scripts/coccinelle/qobject.cocci | 22 ++++++++++++++++++++++
>>  3 files changed, 38 insertions(+)
>>
>> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
>> index fe9a4c5..9d9f9a3 100644
>> --- a/include/qapi/qmp/qdict.h
>> +++ b/include/qapi/qmp/qdict.h
>> @@ -52,6 +52,14 @@ void qdict_destroy_obj(QObject *obj);
>>  #define qdict_put(qdict, key, obj) \
>>          qdict_put_obj(qdict, key, QOBJECT(obj))
>>
>> +/* Helpers for int, bool, and const char*. */
>=20
> "char *." looks awkward.  What about
>=20
>    /* Helpers for int, bool, and const char * */
>=20
> or
>=20
>    /* Helpers for int, bool, string */

That does look nicer.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hvi9SHlra3FwtVMEapvDwF1UN45UJKq0k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7RWtAAoJEKeha0olJ0Nqol8H/3cv4LHSH/CTiYN3uY/r01kQ
mGoNG+UHlOdqcOipcY77iz4GtldQDbrZaqAZ66uFtn6NVla4hTCn+DkWfhFZnN0O
5ZKxO1VjiNS6IAaJYuyD0OyFIelcSUhfcMqx2I6fItdq3UqF7+j43CJGrhn4xW8R
dYvLCoU43lbg0m5OyFuIymCIOKi1ZZStLYO4XT9iXYGHpOfj5fboOTQMlA6qsE04
l/dTY8kExD3Q67JlQrNEsbhTadTPIQGwohbrk32X1irGSY5lMBSob4cscXaZIIQ7
2ZTe27WlfsBCrnPQlQlI6QIGThvh396s9KuNjlRuM9T588QJOpr2n4NeUpLd4NM=
=7a4l
-----END PGP SIGNATURE-----

--hvi9SHlra3FwtVMEapvDwF1UN45UJKq0k--
