Received: from eggs.gnu.org ([2001:4830:134:3::10]:42048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJM1M-0005vz-H8
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:40:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dJM1H-0007Tb-Um
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:40:20 -0400
References: <20170609152017.7286-1-eblake@redhat.com>
	<20170609152017.7286-2-eblake@redhat.com>
	<CAJ+F1CJL04MkrYmnhM3rLaSAuEXYo7JsZwyDLeXA35bV6dvqqA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f502b8ea-a3b0-1c9c-0c55-5a8b9cdecda6@redhat.com>
Date: Fri, 9 Jun 2017 10:40:12 -0500
MIME-Version: 1.0
In-Reply-To: <CAJ+F1CJL04MkrYmnhM3rLaSAuEXYo7JsZwyDLeXA35bV6dvqqA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="T1gWRGVnUhhsaOO3Ugom6cXJBMJIMT7us"
Subject: Re: [Qemu-devel] [PATCH 1/2] qobject: Update coccinelle script to
 catch Q{INC, DEC}REF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T1gWRGVnUhhsaOO3Ugom6cXJBMJIMT7us
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com
Message-ID: <f502b8ea-a3b0-1c9c-0c55-5a8b9cdecda6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] qobject: Update coccinelle script to
 catch Q{INC, DEC}REF
References: <20170609152017.7286-1-eblake@redhat.com>
 <20170609152017.7286-2-eblake@redhat.com>
 <CAJ+F1CJL04MkrYmnhM3rLaSAuEXYo7JsZwyDLeXA35bV6dvqqA@mail.gmail.com>
In-Reply-To: <CAJ+F1CJL04MkrYmnhM3rLaSAuEXYo7JsZwyDLeXA35bV6dvqqA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/09/2017 10:28 AM, Marc-Andr=C3=A9 Lureau wrote:

> sadly, coccinelle is unabarebly slow on my machine,

Odd.  It's pretty fast for this series:

$ time spatch --sp-file scripts/coccinelle/qobject.cocci \
  --macro-file scripts/cocci-macro-file.h --dir . --in-place 2>/dev/null

real	0m2.136s
user	0m2.003s
sys	0m0.125s

This is on Fedora 25.  Although I _will_ grant that the time taken is
also dependent on the complexity of the script it is running on (some
scripts are inherently slower than others, and coccinelle takes
shortcuts like grepping for which files to even fully analyze, but not
all scripts are conducive to those shortcuts).

> not easy to grasp, and
> thereby fails to catch a lot of cases..

I agree with the 'not easy to grasp'. As for not catching cases, you
HAVE to use the --macro-file scripts/cocci-macro-file.h to avoid a lot
of skipped files.  But even so, you're probably right that it still
misses some things (although it often catches far more than "grep in
anger" is able to do).

> I am looking at alternative from
> clang tools/lib, by curiosity.

I'll be interested to see if it produces any (easy-to-reproduce) cleanup
results.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--T1gWRGVnUhhsaOO3Ugom6cXJBMJIMT7us
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZOsFcAAoJEKeha0olJ0Nqk6IH/2M4NC88AqHgkSIsbxkUP6Fx
6tdfffI/T6fgN0H7gNB6q9UI8xlUHaOlefFCsNrmyCNP9EebajutF5fPVuovNA0W
pNjIlNjJ/81bkgo85CXE8ZTi73Hpec3oUy15Mgs/3abkaPu2/w9Ve9grha/AnUzX
m4Sb1iezld/rdEnTsIEH6C8hOSvRgVeox/IPdAmctYmSDLqJZxK4Spk8jmuB+AQN
EnAnHcYB9kDhQ28TSYqikpeMbjROiKhW2kr624OKk/o6WqIaohQAmFG6ipQ0bMN+
ax0zP+ur/SAZ0Z6Xu2pDzY2k92MikypZo0y7/dsz0R6fYzyXc6m/gkJ8Qus6X4M=
=/tyD
-----END PGP SIGNATURE-----

--T1gWRGVnUhhsaOO3Ugom6cXJBMJIMT7us--
