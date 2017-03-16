Received: from eggs.gnu.org ([2001:4830:134:3::10]:45302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coPpU-0002Kt-Q0
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coPpR-0005vP-Ld
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43720)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1coPpR-0005uv-FF
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:28:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 42CB3C04B945
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 07:28:09 +0000 (UTC)
Date: Thu, 16 Mar 2017 15:28:03 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170316072803.GB17296@stefanha-x1.localdomain>
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-31-eblake@redhat.com>
	<dbffcbd2-e614-884f-9a8f-77bf198d9d58@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yEPQxsgoJgBvi8ip"
Content-Disposition: inline
In-Reply-To: <dbffcbd2-e614-884f-9a8f-77bf198d9d58@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 30/30] trace: Force compiler
 warnings on trace parameter type mismatches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>


--yEPQxsgoJgBvi8ip
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 15, 2017 at 02:59:55PM -0500, Eric Blake wrote:
> On 03/13/2017 02:55 PM, Eric Blake wrote:
> > 2. there are still failures under 'make docker-test-mingw@fedora'
> > due to more type mismatches that still need to be squashed. I'm
> > still working on fixing those, but wanted to at least post this
> > series for initial review, especially so the maintainer can weigh
> > in on how much (or little) belongs in 2.9
>=20
> mingw is a nightmare.  Things like ntohl() having non-standard behavior
> on 32-bit mingw can only be worked around by hairy redefinitions in
> osdep.h or by casts at the callsites. See the conversation in 6/30, but
> I'm hoping gcc will give us a new knob to tone down the level of
> -Wformat warnings for two types that have different rank but the same
> width; if gcc gives us that, then we'd add a configure test, and
> conditionally generate the type-mismatch checking code ONLY when gcc is
> smart enough to not care about rank mismatch.  Until then, this RFC
> 30/30 proved useful for flushing out the earlier cleanups (many of which
> you can/should still accept), but should NOT be incorporated as-is, not
> even when 2.10 opens.

QEMU 2.9 regression fixes are appropriate at this stage in the release
process.

Fixes for bugs already in 2.8 are less likely to be merged as we head
towards -rc2/-rc3.

Stefan

--yEPQxsgoJgBvi8ip
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYyj6DAAoJEJykq7OBq3PI59EH/A5m3TieLqlGW4VwKgYtX7o8
wweMcx9XZ1HGFlx3798YJWsPXvWqjC7xII/jQ25qJePe8IFJiN2A+B6FOhB97E+4
2tLzdcn+UmULmM0aK2RdEAeU6DTLUk3Q7dunMaMnjHCnLvnvAfy57ihQkvNfSGTj
H7kmZxk1vrAl1HRi6JjeOvA4BriF3Grjde2hu3fDKa/aNSNomSKmIDHKi/UXXYcE
Glap/7CHgmsxrP49eqS8Xwx5QFILUHqfqpriwFw4GsRzBaRY6IGzXNlx3mLcfMmy
JlEP2+5DxpUi28aKQYg3DEHHmIZZS2uEJNPMzDj8Sa+ol2oUWjgTC7n923Jkc70=
=g+n5
-----END PGP SIGNATURE-----

--yEPQxsgoJgBvi8ip--
