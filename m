Received: from eggs.gnu.org ([2001:4830:134:3::10]:57587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIun2-0001WO-GB
	for qemu-devel@nongnu.org; Wed, 16 May 2018 07:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIun1-0007GS-Rn
	for qemu-devel@nongnu.org; Wed, 16 May 2018 07:40:16 -0400
References: <20180511222052.8734-1-ehabkost@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5ff26983-9cda-89c0-0972-1f7c268f8c14@redhat.com>
Date: Wed, 16 May 2018 13:39:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180511222052.8734-1-ehabkost@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tL4mfc3z1JlqNJc8dztkmg8ijEYrXtQXp"
Subject: Re: [Qemu-devel] [RFC 00/10] [TESTING NEEDED] python: futurize
 --stage1 (Python 3 compatibility)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Cleber Rosa <crosa@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tL4mfc3z1JlqNJc8dztkmg8ijEYrXtQXp
From: Max Reitz <mreitz@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>,
 Juan Quintela <quintela@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, "Dr. David Alan Gilbert"
 <dgilbert@redhat.com>, qemu-block@nongnu.org
Message-ID: <5ff26983-9cda-89c0-0972-1f7c268f8c14@redhat.com>
Subject: Re: [RFC 00/10] [TESTING NEEDED] python: futurize --stage1 (Python 3
 compatibility)
References: <20180511222052.8734-1-ehabkost@redhat.com>
In-Reply-To: <20180511222052.8734-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-12 00:20, Eduardo Habkost wrote:
> TESTING NEEDED: Due to the amount of changes, I didn't test all
> scripts touched by this series.  If you are responsible for any
> of the touched files, I would appreciate help on testing the
> series.

All the iotests* still pass, so for my part:

Tested-by: Max Reitz <mreitz@redhat.com>


*That is, the ones I run, which includes all Python tests but 149.


--tL4mfc3z1JlqNJc8dztkmg8ijEYrXtQXp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr8GIoACgkQ9AfbAGHV
z0AnUgf8CdKK26sAY64oR4yyXAtffB6m2BHjCxpyQkz46yvR/RSVtN+oPw6IUAJK
ufChZfp9zNr8vTf+Pa4X/fZR0Vw1V48r5+eXSAab/c7j3pudCI1Wa55cOXVCa1AQ
CPe2lCjdfm0nsk0amdJDYGpeWQqbKdHoCEW18090+xp1zzV0sQSmht3jrMj6v6QX
oAu6ZM8EqNWDbPPqn4O0WwGY2YONB2WAyw+jMJMbLMt0LWYLTKRh0CnfH+RZvq6i
+aNEgi0yfPdJ4vKJhYonGwjTL24/v9KwmuFpjGF4CXD2Zor2A0MNYd5hA9nlwFc7
VC5OU5tpvxCB6YFHcbou4dY3LBrtgg==
=YUYj
-----END PGP SIGNATURE-----

--tL4mfc3z1JlqNJc8dztkmg8ijEYrXtQXp--
