Received: from eggs.gnu.org ([2001:4830:134:3::10]:51257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYRp3-00089f-7m
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ldoktor@redhat.com>) id 1dYRp0-0002vE-63
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:54:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ldoktor@redhat.com>) id 1dYRoz-0002ui-SI
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 02:53:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 97D1E883A0
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 06:53:56 +0000 (UTC)
References: <20170720162815.19802-1-ldoktor@redhat.com>
	<20170720162815.19802-10-ldoktor@redhat.com>
	<20170720183832.GY2757@localhost.localdomain>
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
Message-ID: <c964cd15-16f6-e330-ebac-f7e71918471d@redhat.com>
Date: Fri, 21 Jul 2017 08:53:49 +0200
MIME-Version: 1.0
In-Reply-To: <20170720183832.GY2757@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lG97SnAt8Oqs3Hss1X2wnDpxlH9q1QvHu"
Subject: Re: [Qemu-devel] [PATCH 09/11] qmp.py: Avoid overriding a builtin
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lG97SnAt8Oqs3Hss1X2wnDpxlH9q1QvHu
From: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: apahim@redhat.com, qemu-devel@nongnu.org, famz@redhat.com,
 armbru@redhat.com, mreitz@redhat.com
Message-ID: <c964cd15-16f6-e330-ebac-f7e71918471d@redhat.com>
Subject: Re: [PATCH 09/11] qmp.py: Avoid overriding a builtin object
References: <20170720162815.19802-1-ldoktor@redhat.com>
 <20170720162815.19802-10-ldoktor@redhat.com>
 <20170720183832.GY2757@localhost.localdomain>
In-Reply-To: <20170720183832.GY2757@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dne 20.7.2017 v 20:38 Eduardo Habkost napsal(a):
> On Thu, Jul 20, 2017 at 06:28:13PM +0200, Luk=C3=A1=C5=A1 Doktor wrote:=

>> The "id" is a builtin method to get object's identity and should not b=
e
>> overridden. This might bring some issues in case someone was directly
>> calling "cmd(..., id=3Did)" but I haven't found such usage on brief se=
arch
>> for "cmd\(.*id=3D".
>>
>> Signed-off-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
>> ---
>>  scripts/qmp/qmp.py | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
>> index a14b001..c3e0206 100644
>> --- a/scripts/qmp/qmp.py
>> +++ b/scripts/qmp/qmp.py
>> @@ -177,19 +177,19 @@ class QEMUMonitorProtocol(object):
>>              print >>sys.stderr, "QMP:<<< %s" % resp
>>          return resp
>> =20
>> -    def cmd(self, name, args=3DNone, id=3DNone):
>> +    def cmd(self, name, args=3DNone, cmd_id=3DNone):
>>          """
>>          Build a QMP command and send it to the QMP Monitor.
>> =20
>>          @param name: command name (string)
>>          @param args: command arguments (dict)
>> -        @param id: command id (dict, list, string or int)
>> +        @param cmd_id: command id (dict, list, string or int)
>>          """
>>          qmp_cmd =3D {'execute': name}
>>          if args:
>>              qmp_cmd['arguments'] =3D args
>> -        if id:
>> -            qmp_cmd['id'] =3D id
>> +        if cmd_id:
>> +            qmp_cmd['cmd_id'] =3D cmd_id
>=20
> The member sent through the monitor should still be called "id".
> i.e.:
>=20
>     qmp_cmd['id'] =3D cmd_id
>=20
Oups, sorry, automatic rename changed it and I forgot to fix this one bac=
k. I'll address this in v2. The main problem with this patch is it could =
break named arguments (`cmd(..., id=3Did)` calls) so I'm not sure it's wo=
rth including. But as mentioned in commit message I grepped full sources =
so we better fix this before someone starts using it.

Luk=C3=A1=C5=A1

>=20
>>          return self.cmd_obj(qmp_cmd)
>> =20
>>      def command(self, cmd, **kwds):
>> --=20
>> 2.9.4
>>
>=20



--lG97SnAt8Oqs3Hss1X2wnDpxlH9q1QvHu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEwBAEBCAAaBQJZcaT+ExxsZG9rdG9yQHJlZGhhdC5jb20ACgkQJrNi5H/PIsGO
8gf/eTbPZg1w92F1+tvXg9JqiGft9dxs/Ch3CSe8RglTcquw0hvZJ3VgmLxfIXVq
ozqCqtvv/shPjBEX06FNFj6BP+bHh9h0fPGWt6K6xR6mrnBbX2EQxnfD98Kdfwe6
4P/1VWXsUqnS4KB9BumSWVVQ3uf4NuPx4diJ/iAqd10b2hpk3jYehNhRY4EFzJ3C
ePPFag+InX/oa1jCAsFw42uO05yfyhyQTodbAO8CaVk/VpHHJDYqx1aC4i9KDm7X
2kt8sZCDTDuLI59EvMij/WrdH3DR91w6N2zAM3gm9mUX/xopKK43ljnjKkYAzi7u
uHwdLMOx5vNKj71hD1sXsHteMA==
=Y76U
-----END PGP SIGNATURE-----

--lG97SnAt8Oqs3Hss1X2wnDpxlH9q1QvHu--
