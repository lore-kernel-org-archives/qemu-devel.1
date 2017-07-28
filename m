Received: from eggs.gnu.org ([2001:4830:134:3::10]:40393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db4yL-0003AF-B6
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:06:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1db4yG-0006q3-Pj
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:06:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1db4yG-0006om-GO
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:06:24 -0400
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-8-eblake@redhat.com>
	<20170728125759.GO12364@stefanha-x1.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eb01fea0-945e-d954-0737-dc3c748a7f94@redhat.com>
Date: Fri, 28 Jul 2017 08:06:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170728125759.GO12364@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="kdKUc8lNxdQhUI2MwncawoDaitMClSxQX"
Subject: Re: [Qemu-devel] [PATCH v3 07/12] qtest: Add a new helper qmp_cmd()
 and friends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kdKUc8lNxdQhUI2MwncawoDaitMClSxQX
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, armbru@redhat.com, stefanha@redhat.com
Message-ID: <eb01fea0-945e-d954-0737-dc3c748a7f94@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/12] qtest: Add a new helper qmp_cmd()
 and friends
References: <20170725211523.3998-1-eblake@redhat.com>
 <20170725211523.3998-8-eblake@redhat.com>
 <20170728125759.GO12364@stefanha-x1.localdomain>
In-Reply-To: <20170728125759.GO12364@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/28/2017 07:57 AM, Stefan Hajnoczi wrote:
> On Tue, Jul 25, 2017 at 04:15:18PM -0500, Eric Blake wrote:
>> +QDict *qtest_qmp_cmd(QTestState *s, const char *cmd, QObject *args)
>> +{
>> +    QDict *dict =3D qdict_new();
>> +
>> +    qdict_put_str(dict, "execute", cmd);
>> +    if (args) {
>> +        qdict_put_obj(dict, "arguments", args);
>> +    }
>> +    return qtest_qmp(s, "%p", QOBJECT(dict));
>> +}
>=20
> qtest_qmp(s, "%p", QOBJECT(dict)) takes ownership of dict?

Hmm, I documented that for qtest_qmp_cmd(), but you have a good
question.  I need to double-check that it is true for
qobject_from_jsonf("%p", obj), but my recollection is that yes, wrapping
one object inside the other means freeing the outer object also reclaims
the inner (that is, qobject_from_jsonf wasn't increasing refcount).  At
any rate, I'll probably have to submit a followup patch (either to fix
the leak if I'm wrong, or to improve the documentation about %p
reference management if I'm right).

>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--kdKUc8lNxdQhUI2MwncawoDaitMClSxQX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll7NsoACgkQp6FrSiUn
Q2pfXAf+LBk2/hzpR3G7yDuBLoxO6bpaUcrc3TBp38luYZNtULGIChkNktb7vgBO
yxHwPju6+koGjxqb/9wE/gg+4nvMK9mtgLCpX2pPRC/wyDhHtZyIiTsb3KhbwtZa
Yy4vQhMwDiHaPgvR6WCj7DktB0OQh7/I4Y7e0xTgmm0RLkXtWMYSYMJocz9OZbjf
zeUHvHUcuy+ofxqAYgY81OIZHuZ2liEinyrCLIqd1KW9jYP7PQRBdCyfJkl47ldK
TaYJyDtC+Njg/qSboLDDDl0ZjqumBpcAQd74qxi6HRr7IZkYVYWc9VlJBdbXtUCC
+EFw/6UqHiaoCe/S+Am1BhY9X86fIQ==
=4xdO
-----END PGP SIGNATURE-----

--kdKUc8lNxdQhUI2MwncawoDaitMClSxQX--
