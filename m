Received: from eggs.gnu.org ([2001:4830:134:3::10]:46714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daLKj-0006fw-Si
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daLKg-0003od-20
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:22:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53914)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daLKf-0003oO-OO
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:22:29 -0400
References: <150107094952.114.932926322923994155@5d477a5b5989>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e982b2c6-dab4-24a0-7db4-2e76c370d227@redhat.com>
Date: Wed, 26 Jul 2017 07:22:20 -0500
MIME-Version: 1.0
In-Reply-To: <150107094952.114.932926322923994155@5d477a5b5989>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ufXhCvTA4AXVbw8LGJtXDE70TRbucPThC"
Subject: Re: [Qemu-devel] [PATCH 0/5] ui: keymap fixes for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, no-reply@patchew.org, kraxel@redhat.com
Cc: famz@redhat.com, Markus Armbruster <armbru@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ufXhCvTA4AXVbw8LGJtXDE70TRbucPThC
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org, no-reply@patchew.org, kraxel@redhat.com
Cc: famz@redhat.com, Markus Armbruster <armbru@redhat.com>
Message-ID: <e982b2c6-dab4-24a0-7db4-2e76c370d227@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/5] ui: keymap fixes for 2.10
References: <150107094952.114.932926322923994155@5d477a5b5989>
In-Reply-To: <150107094952.114.932926322923994155@5d477a5b5989>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 07:09 AM, no-reply@patchew.org wrote:
> Hi,
>=20
> This series failed build test on s390x host. Please find the details be=
low.
>=20
> Message-id: 20170726115637.21558-1-kraxel@redhat.com
> Subject: [Qemu-devel] [PATCH 0/5] ui: keymap fixes for 2.10
> Type: series
>=20

>   GEN     docs/interop/qemu-ga-qapi.texi
>   GEN     qga/qapi-generated/qga-qapi-visit.h
>   GEN     qga/qapi-generated/qga-qmp-commands.h
>   GEN     qga/qapi-generated/qga-qapi-types.h
>   GEN     qga/qapi-generated/qga-qapi-types.c
>   GEN     qga/qapi-generated/qga-qapi-visit.c
>   GEN     qga/qapi-generated/qga-qmp-marshal.c
> Traceback (most recent call last):
>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py",=
 line 300, in <module>
>     main(sys.argv)
>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py",=
 line 296, in main
>     print texi_schema(schema)
>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py",=
 line 279, in texi_schema
>     gen.symbol(doc, schema.lookup_entity(doc.symbol))
>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py",=
 line 263, in symbol
>     entity.visit(self)
>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi.py", line=
 1137, in visit
>     self.member_names(), self.prefix)
>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py",=
 line 218, in visit_enum_type
>     member_func=3Dtexi_enum_value))
>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py",=
 line 200, in texi_entity
>     + texi_sections(doc))
>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py",=
 line 160, in texi_members
>     items +=3D member_func(section.member) + desc + '\n'
>   File "/var/tmp/patchew-tester-tmp-xs4657r8/src/scripts/qapi2texi.py",=
 line 133, in texi_enum_value
>     return '@item @code{%s}\n' % value.name
> AttributeError: 'NoneType' object has no attribute 'name'

Eww, we have a bug in our qapi generator (a stack dump instead of a nice
error message).  I suspect this is caused by your use of '@ac_*' instead
of spelling out all the ac_ members added in qapi-schema.json in 4/5 -
but it IS something that needs to be fixed on your end to quit tripping
up the doc generator.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ufXhCvTA4AXVbw8LGJtXDE70TRbucPThC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4iXwACgkQp6FrSiUn
Q2pmBgf+LlXWv4UBmoHk2ozCezLelg4vIoNPRzHAVkCH4HNTtSCjcpX+IEJW6Kcr
9UetoP2CqdnOH4o28/S07Y68Y4gsraT+oj619dKQzvoGu8H4KRb+DTqlOJA7fd4z
uwCLI1iZmyTWouqqYvBrAj08djLVgYLfrRjMTcqohPXH9Gnq+iXmK/S5h34Rir56
gSF8rMqw4XgWIrA86AOc9sG3aIZfhNd9G2Hso2TS2izlJDERQ5/eLObFXw0XHqZP
Opfa7LiDzz6RxAnC6f0FsUgBA6a/PeKQcIcPcGM+TbgFEjZXX+x23PN7mvr8H5+W
X7RVeFgnwIJjVE0kIBvQMajeSSmZQw==
=6nhD
-----END PGP SIGNATURE-----

--ufXhCvTA4AXVbw8LGJtXDE70TRbucPThC--
