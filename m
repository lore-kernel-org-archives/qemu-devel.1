Received: from eggs.gnu.org ([2001:4830:134:3::10]:60612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cQvxP-0000j3-LP
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:55:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cQvxM-0004oB-Ln
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:55:19 -0500
Received: from mx5-phx2.redhat.com ([209.132.183.37]:58567)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cQvxM-0004nt-Dc
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:55:16 -0500
Date: Tue, 10 Jan 2017 07:55:15 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <724269411.621337.1484052915061.JavaMail.zimbra@redhat.com>
In-Reply-To: <87wpe3qf2a.fsf@dusky.pond.sub.org>
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
	<20170109143437.30554-13-marcandre.lureau@redhat.com>
	<87wpe3qf2a.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 12/21] qapi.py: fix line break before
 binary operator pep8
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

Hi

----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > Python code style accepts both form, but pep8 complains. Better to clea=
n
> > up the single warning for now, so new errors stand out more easily.
> >
> > Fix scripts/qapi.py:1539:21: W503 line break before binary operator
>=20
> PEP 8 permits both, but prefers line break before binary operator.
> Thus, this warning is clearly bogus.  What version of pep8 do you use?
> Mine doesn't warn.

I tried both 1.6.2 and 1.7.0
