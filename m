Received: from eggs.gnu.org ([2001:4830:134:3::10]:59217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjtFn-000146-QK
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:52:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjtFk-00046t-Ph
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:52:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cjtFk-00046a-GL
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 14:52:36 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D55DC04BD3D
	for <qemu-devel@nongnu.org>; Fri,  3 Mar 2017 19:52:36 +0000 (UTC)
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
	<1488544368-30622-6-git-send-email-armbru@redhat.com>
	<96e019e3-7fe9-7ce6-ea57-28dd77d0f7cb@redhat.com>
	<87h93ajgml.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2fe79534-01d9-a825-5b24-3291bda670aa@redhat.com>
Date: Fri, 3 Mar 2017 13:52:34 -0600
MIME-Version: 1.0
In-Reply-To: <87h93ajgml.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vMlLRbcR14vvEALcKGWjCiAjuLcVAK9ol"
Subject: Re: [Qemu-devel] [PATCH v4 05/28] qapi: Support multiple command
 registries per program
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
--vMlLRbcR14vvEALcKGWjCiAjuLcVAK9ol
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <2fe79534-01d9-a825-5b24-3291bda670aa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 05/28] qapi: Support multiple command
 registries per program
References: <1488544368-30622-1-git-send-email-armbru@redhat.com>
 <1488544368-30622-6-git-send-email-armbru@redhat.com>
 <96e019e3-7fe9-7ce6-ea57-28dd77d0f7cb@redhat.com>
 <87h93ajgml.fsf@dusky.pond.sub.org>
In-Reply-To: <87h93ajgml.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 01:37 PM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> On 03/03/2017 06:32 AM, Markus Armbruster wrote:
>>> The command registry encapsulates a single command list.  Give the
>>> functions using it a parameter instead.  Define suitable command list=
s
>>> in monitor, guest agent and test-qmp-commands.
>>>

>> ...or is this leftovers from your debugging?
>=20
> Corret.  I'll drop it.
>=20
>> The rest of the patch looks fine; it is converting a global variable
>> into a per-instance variable.
>=20
> Squashing in the obvious garbage collection.  May I add your R-by?
>=20

Yes, with that squashed in,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--vMlLRbcR14vvEALcKGWjCiAjuLcVAK9ol
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYucmCAAoJEKeha0olJ0NqKq4H/18lV+/9CP7VDKoQUQkczsFZ
Wn/W/lfXpQSx13pC5aBgpaf5a9joqa5v3+Eoqkoi4vaXXAfc+w2xKJbL9pAPYRHf
LkIO8eU4U3puEzgWRUjD7VVW6kWNxk+5F+dzJ+5c7AhT1i7GFjsHOx3chGJq/k/1
4J92Ica/N69QBw1SP9+vOolBbawa239WHodCYp4Hv87Mx1v2CgG3TomyVsTx8YU7
TzsLEylRdqVjOZt+iwwbmKza7dcwrWaijTne9WPD7gLlR27d74GoaQcEt4JbKYaK
OLlF0oxq12Z4xLFy5rHT1EIBttsTLzdYJZQEPpvPLWYGUJ90DV+Y55/4rjqz+bo=
=A3fT
-----END PGP SIGNATURE-----

--vMlLRbcR14vvEALcKGWjCiAjuLcVAK9ol--
