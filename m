Received: from eggs.gnu.org ([2001:4830:134:3::10]:50774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyI9d-0004el-NM
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyI9Y-0000ey-U7
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:17:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cyI9Y-0000en-LP
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 09:17:44 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C5AB7128D
	for <qemu-devel@nongnu.org>; Wed, 12 Apr 2017 13:17:43 +0000 (UTC)
References: <20170411185034.13460-1-eblake@redhat.com>
	<20170411185034.13460-7-eblake@redhat.com>
	<87r30yw2ko.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <57dfecb1-f7d7-4ae7-4d80-c350909883ba@redhat.com>
Date: Wed, 12 Apr 2017 08:17:42 -0500
MIME-Version: 1.0
In-Reply-To: <87r30yw2ko.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="16m9aWDRM37e9llM4tP31rfDqwTrp5KOb"
Subject: Re: [Qemu-devel] [PATCH v4 06/13] qobject: Add helper macros for
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
--16m9aWDRM37e9llM4tP31rfDqwTrp5KOb
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <57dfecb1-f7d7-4ae7-4d80-c350909883ba@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 06/13] qobject: Add helper macros for
 common scalar insertions
References: <20170411185034.13460-1-eblake@redhat.com>
 <20170411185034.13460-7-eblake@redhat.com>
 <87r30yw2ko.fsf@dusky.pond.sub.org>
In-Reply-To: <87r30yw2ko.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2017 01:40 AM, Markus Armbruster wrote:
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
>>
>> ---
>> v4: tweak comment wording
>> v3: new patch
>> ---
>>  include/qapi/qmp/qdict.h         |  8 ++++++++
>>  include/qapi/qmp/qlist.h         |  8 ++++++++
>>  scripts/coccinelle/qobject.cocci | 22 ++++++++++++++++++++++
>>  3 files changed, 38 insertions(+)
>>
>> diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
>> index fe9a4c5..f70d435 100644
>> --- a/include/qapi/qmp/qdict.h
>> +++ b/include/qapi/qmp/qdict.h
>> @@ -52,6 +52,14 @@ void qdict_destroy_obj(QObject *obj);
>>  #define qdict_put(qdict, key, obj) \
>>          qdict_put_obj(qdict, key, QOBJECT(obj))
>>
>> +/* Helpers for int, bool, and string. */
>=20
> Nitpick: this isn't a sentence, so why the period?

Hmm, there's no period on the comment just before:
/* Helper to qdict_put_obj(), accepts any object */

I'm fine if you touch it up on commit.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--16m9aWDRM37e9llM4tP31rfDqwTrp5KOb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7ij2AAoJEKeha0olJ0NqS3gH/Rrf4tFeVbsxTGHscWE1FRHX
FloZ0IN0/eW3/PLY7d9R1LRxxd3jz5SBCv3WiXwIg1UDqkEXKYbXdQ8NIWiQRRx/
aQkw0cQDCLbG0mCEE5GcaMC+ZNooQTd5m6RfM0cL0+fK3n3GAv9wX3n/mEzYaGH4
1JQl8qRcsSIJjwv/CiaE/uEYxK05pybylopCfW9YDHRd2Yq4b8TuPo1RL/HQpqaf
xRow5M/7IwXiW+tlQ6wSTeG7y0ExaviO0gYM/ESH9QFcYJ5lpSImY1Q39Uz00LYw
No8d1Wso5qifmkmzGdy4yGd1AUDi7ef5pvqWE0JOTQEInyo7hFmSHdX2mnEu+vk=
=Q2L5
-----END PGP SIGNATURE-----

--16m9aWDRM37e9llM4tP31rfDqwTrp5KOb--
