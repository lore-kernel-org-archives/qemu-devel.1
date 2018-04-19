Received: from eggs.gnu.org ([2001:4830:134:3::10]:50106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9Bke-0006G7-3l
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:45:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f9Bkb-0004D9-0H
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:45:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40194)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1f9Bka-0004Bz-Oa
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:45:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BCA7B3130656
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 15:45:31 +0000 (UTC)
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <86162f1a-842b-f7aa-7781-f4260309925f@redhat.com>
Date: Thu, 19 Apr 2018 10:45:18 -0500
MIME-Version: 1.0
In-Reply-To: <20180419150145.24795-1-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="gq36KPZIBZbP9eO2Xb554SQOPOxS5lxll"
Subject: Re: [Qemu-devel] [PATCH v6 0/5] Simplify qobject refcount
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--gq36KPZIBZbP9eO2Xb554SQOPOxS5lxll
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: berrange@redhat.com, armbru@redhat.com, pbonzini@redhat.com
Message-ID: <86162f1a-842b-f7aa-7781-f4260309925f@redhat.com>
Subject: Re: [PATCH v6 0/5] Simplify qobject refcount
References: <20180419150145.24795-1-marcandre.lureau@redhat.com>
In-Reply-To: <20180419150145.24795-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/19/2018 10:01 AM, Marc-Andr=C3=A9 Lureau wrote:
> Hi,
>=20
> This series aims to get rid of the distinction between QObject, that
> must use qobject_incref/qobject_decref and its various derived types
> that have to use QINCREF/QDECREF. Instead, replace it with
> qobject_ref/qobject_unref for all types.

Related question: should we do the same thing for qdict_put() vs.
qdict_put_obj()?  That is, now that we have an easy way to always use
QOBJECT(), it makes more sense to just have:

QObject *o;
QDict *d;
qdict_put(dict, key1, o);
qdict_put(dict, key2, d);

rather than having to distinguish based on the type of the third argument=
=2E

Similar for QList additions.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--gq36KPZIBZbP9eO2Xb554SQOPOxS5lxll
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrYuY4ACgkQp6FrSiUn
Q2p9Zgf+P+Irv0q4XMx/S2MOeHKUXs2mT9802hDywwml6+JPZdVsRBao6GoExCWF
e90J04UhzOTGqZNPFeG0qbFes+wo/rO10+QL0p3PSVG/m85JKrvied/ijda1UKzO
oBI2+FyAxTlPyjDx9IBMEl/Z/C9WWt2tfsDXFhJSMy4hLZKUuh4ZHImwBPckK1CK
RVSGNJkrtONsN/TVfcKUNfXH6SLDCsauo1hGyxN5qsQ8fqCFBF1+joH2VtXYp3N1
ocGNjbZlUNbg/D4eMapZPVfg50I6+wn7zwsDT8pZlkvGghcYSM7jL4/Opr+FYCFJ
QYHgv6SSzOMd3SsLTKnfHqF5aURUjg==
=zsVx
-----END PGP SIGNATURE-----

--gq36KPZIBZbP9eO2Xb554SQOPOxS5lxll--
