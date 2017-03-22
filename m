Received: from eggs.gnu.org ([2001:4830:134:3::10]:49731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqkEU-0003wn-3C
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:39:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cqkEQ-00076D-6n
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:39:38 -0400
References: <149020412706.102.14127530188115538412@6c512846dbc7>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0feec7b2-27f5-76e5-5bf1-f6f020c574df@redhat.com>
Date: Wed, 22 Mar 2017 12:39:29 -0500
MIME-Version: 1.0
In-Reply-To: <149020412706.102.14127530188115538412@6c512846dbc7>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mGwbG3pHdF9NMnS1e9bKNtSqlU7E9Rw5U"
Subject: Re: [Qemu-devel] [PATCH] fixup! qom: Avoid unvisited
 'id'/'qom-type' in user_creatable_add_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, lvivier@redhat.com, armbru@redhat.com, afaerber@suse.de, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mGwbG3pHdF9NMnS1e9bKNtSqlU7E9Rw5U
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, lvivier@redhat.com, armbru@redhat.com, afaerber@suse.de,
 qemu-stable@nongnu.org
Message-ID: <0feec7b2-27f5-76e5-5bf1-f6f020c574df@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] fixup! qom: Avoid unvisited 'id'/'qom-type'
 in user_creatable_add_opts
References: <149020412706.102.14127530188115538412@6c512846dbc7>
In-Reply-To: <149020412706.102.14127530188115538412@6c512846dbc7>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/22/2017 12:35 PM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details be=
low.
>=20
> Type: series
> Subject: [Qemu-devel] [PATCH] fixup! qom: Avoid unvisited 'id'/'qom-typ=
e' in user_creatable_add_opts
> Message-id: 20170322173023.22654-1-eblake@redhat.com
>=20

> /var/tmp/patchew-tester-tmp-5drz5kus/src/qom/object_interfaces.c: In fu=
nction =E2=80=98user_creatable_add_opts=E2=80=99:
> /var/tmp/patchew-tester-tmp-5drz5kus/src/qom/object_interfaces.c:125:16=
: error: passing argument 1 of =E2=80=98g_free=E2=80=99 discards =E2=80=98=
const=E2=80=99 qualifier from pointer target type [-Werror=3Ddiscarded-qu=
alifiers]
>          g_free(type);
>                 ^~~~

Silly patchew. Maybe we should teach you that any patch with 'fixup!' in
the title is _probably_ not going to compile on its own, because it is a
fixup to be sqaushed to an (as-yet) uncommitted patch.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--mGwbG3pHdF9NMnS1e9bKNtSqlU7E9Rw5U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0rbRAAoJEKeha0olJ0NqploIAIu4VAXql3nMJxCCRs2CDdIk
T3qzo3H/sJuKBIXDDppYW+lvRc2wsheBw4Zl/ZLc9d8LM8srguObkRmSLCsp/MKx
P+vedEQww7fdxG8qxEYTxzwNO0BGrx70X2N3L8pWqI40z35pE8zMVnF5z6X4tXOr
lqpB3ixE2V7KkXOMAiE1JGBNRGo0BUWAdKvybrSyUdPxJz+JI4OHbbpJCDVb/axb
aUTwUEsyVMdXGGeZ2in90amssPKKP13LOrqX31ScbdPWMLDjqKthihUv5tOzBxGH
8jxI6OQ8TZb7mCrf0EmQAWgIFWRof/iEYQXMs+Yyi/LXRobweqLG8gmypDdtDoQ=
=bDjX
-----END PGP SIGNATURE-----

--mGwbG3pHdF9NMnS1e9bKNtSqlU7E9Rw5U--
