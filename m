Received: from eggs.gnu.org ([2001:4830:134:3::10]:54885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d47Sr-0006mQ-MC
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:05:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d47Sn-0001j7-2d
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:05:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34574)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d47Sm-0001ia-Pf
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 11:05:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 90A7680063
	for <qemu-devel@nongnu.org>; Fri, 28 Apr 2017 15:05:39 +0000 (UTC)
References: <20170427165526.19836-1-dgilbert@redhat.com>
	<87fugsfyfq.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <31823d2a-c25f-9c14-39f0-736cf46f6fbb@redhat.com>
Date: Fri, 28 Apr 2017 10:05:37 -0500
MIME-Version: 1.0
In-Reply-To: <87fugsfyfq.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AoitafIujO6buPw54nTjmexLwd88WDQAF"
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Disallow glib asserts in main
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AoitafIujO6buPw54nTjmexLwd88WDQAF
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org
Message-ID: <31823d2a-c25f-9c14-39f0-736cf46f6fbb@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] checkpatch: Disallow glib asserts in main
 code
References: <20170427165526.19836-1-dgilbert@redhat.com>
 <87fugsfyfq.fsf@dusky.pond.sub.org>
In-Reply-To: <87fugsfyfq.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/28/2017 08:34 AM, Markus Armbruster wrote:

>>
>> Ban most of the glib assertion functions (basically everything except
>> g_assert and g_assert_not_reached) except in tests/

You'll also want to exclude scripts/ and possible include/glib-compat.h..=
=2E


> If these are screwy enough to warrant rejecting them in new code,
> they're probably screwy enough to purge them from existing code:
>=20
>     $ git-grep -E 'g_assert_cmpstr|g_assert_cmpint|g_assert_cmpuint|g_a=
ssert_cmphex|g_assert_cmpfloat|g_assert_true|g_assert_false|g_assert_nonn=
ull|g_assert_null|g_assert_no_error|g_assert_error|g_test_assert_expected=
_messages|g_test_trap_assert_passed|g_test_trap_assert_stdout|g_test_trap=
_assert_stdout_unmatched|g_test_trap_assert_stderr|g_test_trap_assert_std=
err_unmatched' | grep -v ^tests/
>     hw/ide/ahci.c:        g_assert_cmpint(size, >, 1);
>     hw/ppc/spapr_ovec.c:    g_assert_cmpint(bitnr, <, OV_MAXBITS);
>     hw/ppc/spapr_ovec.c:    g_assert_cmpint(bitnr, <, OV_MAXBITS);
>     hw/ppc/spapr_ovec.c:    g_assert_cmpint(bitnr, <, OV_MAXBITS);
>     hw/ppc/spapr_ovec.c:    g_assert_cmpint(vector, >=3D, 1); /* vector=
 numbering starts at 1 */
>     hw/ppc/spapr_ovec.c:    g_assert_cmpint(vector_len, <=3D, OV_MAXBYT=
ES);
>     hw/ppc/spapr_ovec.c:    g_assert_cmpint(vec_len, <=3D, OV_MAXBYTES)=
;

Those should go.

>     include/glib-compat.h:#ifndef g_assert_true
>     include/glib-compat.h:#define g_assert_true(expr)                  =
                                  \
>     include/glib-compat.h:#ifndef g_assert_false
>     include/glib-compat.h:#define g_assert_false(expr)                 =
                                  \
>     include/glib-compat.h:#ifndef g_assert_null
>     include/glib-compat.h:#define g_assert_null(expr)                  =
                                  \
>     include/glib-compat.h:#ifndef g_assert_nonnull
>     include/glib-compat.h:#define g_assert_nonnull(expr)               =
                                  \

We still need these until we can require glib 2.38 or even 2.40.

>     qom/object.c:        g_assert_cmpint(parent->class_size, <=3D, ti->=
class_size);
>     qom/object.c:    g_assert_cmpint(type->instance_size, >=3D, sizeof(=
Object));
>     qom/object.c:    g_assert_cmpint(size, >=3D, type->instance_size);
>     qom/object.c:    g_assert_cmpint(obj->ref, =3D=3D, 0);
>     qom/object.c:    g_assert_cmpint(obj->ref, >, 0);

These should go.

>     scripts/cocci-macro-file.h:#define g_assert_cmpint(a, op, b)   g_as=
sert(a op b)
>     scripts/cocci-macro-file.h:#define g_assert_cmpuint(a, op, b)   g_a=
ssert(a op b)
>     scripts/cocci-macro-file.h:#define g_assert_cmphex(a, op, b)   g_as=
sert(a op b)
>     scripts/cocci-macro-file.h:#define g_assert_cmpstr(a, op, b)   g_as=
sert(strcmp(a, b) op 0)

These must stay permanently.

>     util/qht.c:    g_assert_cmpuint(new->n_buckets, !=3D, old->n_bucket=
s);
>=20
> Volunteers?
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--AoitafIujO6buPw54nTjmexLwd88WDQAF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZA1pBAAoJEKeha0olJ0Nq8WwH/juoCKgSHs0q91OWXqUsw9OR
Qyq/T1RCfRN4811iyduAG7/V89i+qqvK8RtMOzLJqpW3lh1N41qOlcwhsUgDuQ/i
ZKP5nA0cr7P0S8YwoZozylfWFOp+AiupVjvBu8vJ5pepAH2CrOywiBqXw5+2/nAh
BbZSWmVAjguIjsmJSWbukZv40z5vXHFXtmKVYLleavug0ZK2eqsxXFeN28GdWiNO
yUIQS+HpYtBBTvIfblVXRIqKsovLsq8OkTAl3aP2HxyhOlAvBZHj/FRfi3BqAIZS
viDsw7N+Z/gqQXilG0qJQ9+KgYcpVCFkNGKMbol0TLNuA1ZCZsaSNlIBYqtaUkM=
=5Qpb
-----END PGP SIGNATURE-----

--AoitafIujO6buPw54nTjmexLwd88WDQAF--
