Received: from eggs.gnu.org ([2001:4830:134:3::10]:41228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcXvd-0007k6-L7
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:13:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dcXvZ-00078X-EA
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:13:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56640)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dcXvZ-00075S-4g
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 10:13:41 -0400
References: <20170725211523.3998-1-eblake@redhat.com>
	<20170725211523.3998-8-eblake@redhat.com>
	<20170728125759.GO12364@stefanha-x1.localdomain>
	<eb01fea0-945e-d954-0737-dc3c748a7f94@redhat.com>
	<7e291686-0242-5bd3-8f83-00145be9d9ee@redhat.com>
	<871soxaumw.fsf@dusky.pond.sub.org>
	<8317179a-da8a-a8b9-433e-b527fc6688f5@redhat.com>
	<42893913-795b-afb8-b87f-66d0be3abc75@redhat.com>
	<8760e7zvmw.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0abf5603-d60f-e647-5fd5-71b430136bec@redhat.com>
Date: Tue, 1 Aug 2017 09:13:30 -0500
MIME-Version: 1.0
In-Reply-To: <8760e7zvmw.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lptxSQcPh2nTcMcn5FpEFf1B9PRGIBP6P"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, stefanha@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lptxSQcPh2nTcMcn5FpEFf1B9PRGIBP6P
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
 stefanha@redhat.com
Message-ID: <0abf5603-d60f-e647-5fd5-71b430136bec@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/12] qtest: Add a new helper qmp_cmd()
 and friends
References: <20170725211523.3998-1-eblake@redhat.com>
 <20170725211523.3998-8-eblake@redhat.com>
 <20170728125759.GO12364@stefanha-x1.localdomain>
 <eb01fea0-945e-d954-0737-dc3c748a7f94@redhat.com>
 <7e291686-0242-5bd3-8f83-00145be9d9ee@redhat.com>
 <871soxaumw.fsf@dusky.pond.sub.org>
 <8317179a-da8a-a8b9-433e-b527fc6688f5@redhat.com>
 <42893913-795b-afb8-b87f-66d0be3abc75@redhat.com>
 <8760e7zvmw.fsf@dusky.pond.sub.org>
In-Reply-To: <8760e7zvmw.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/01/2017 12:48 AM, Markus Armbruster wrote:

>> Hmm. What if we assert that qobject_from_jsonf() can never fail halfwa=
y
>> through?


> I don't buy the "primarily for the testsuite argument".  It's for
> whatever finds it useful.  Safer than formatting the JSON text (no JSON=

> injection accidents), much easier to read than building a QObject to
> pass to the JSON output visitor.
>=20
> I'd be willing to buy a "passing syntactically incorrect JSON to
> qobject_from_jsonf() is a programming error" argument.  Assertion
> failure is the appropriate way to deal with programming errors.  Needs
> to be spelled out in function contracts, of course, starting with
> json_parser_parse_err(), which (scandalously!) has none.

In fact, qobject_from_jsonf() _does_ assert if it is handed ill-formed
input.  Only qobject_from_jsonv() does not.  That will be fixed in my
next series, along with some documentation comments.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lptxSQcPh2nTcMcn5FpEFf1B9PRGIBP6P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmAjIoACgkQp6FrSiUn
Q2qJzAf9EhcSQ8QrZniWpQ+fFXTB3qW09hIBB4Lp4AAHftlhML/xKOlYkKt+FdRm
JfKWLstbvY73OmThIhBQtqjiqOjVXQ89POMYzXbQty+M1WfrMhuio792kiWGxhQM
Fa7+/JUMCvC4sMjE6sYCJPrPY/wzapTvkcWY0Co3FTEh5KpU9eNtPLMgb3RlRf3Q
vbVDcA+L82Iisg64em2DmHk2xbHnZU6OUm3gKwelrSX1IBXsFFvbBOV+6Ngs4sJv
PCpZHnx+I7+74iKSzbewQwv7A0p1L7OZ4ZrmIjJQ2ZtsXqDzg47o1By+v6dIDwQz
Q/EGRK0BEG3uUBZc6PWotRTz5F8Ygw==
=NA1S
-----END PGP SIGNATURE-----

--lptxSQcPh2nTcMcn5FpEFf1B9PRGIBP6P--
