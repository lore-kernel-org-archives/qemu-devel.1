Received: from eggs.gnu.org ([2001:4830:134:3::10]:48714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3ny9-0006Q3-Cf
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 14:16:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3ny5-0005yJ-4z
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 14:16:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d3ny4-0005x5-SP
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 14:16:41 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2ee4bc2b-9e75-5d82-789d-f9de8eaf8e6d@redhat.com>
Date: Thu, 27 Apr 2017 13:16:34 -0500
MIME-Version: 1.0
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oKllhIManBx25J1wJhCD195SBOaPaGRvQ"
Subject: Re: [Qemu-devel] [PATCH for-2.9 00/47] qapi: Put type information
 back into QMP documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oKllhIManBx25J1wJhCD195SBOaPaGRvQ
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com
Message-ID: <2ee4bc2b-9e75-5d82-789d-f9de8eaf8e6d@redhat.com>
Subject: Re: [PATCH for-2.9 00/47] qapi: Put type information back into QMP
 documentation
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
In-Reply-To: <1489385927-6735-1-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/13/2017 01:18 AM, Markus Armbruster wrote:
> I'm proposing this is 2.9 because it fixes a documentation regression.
> It affects only documentation; generated C code is unchanged except
> for the removal of trailing space in PATCH 46.
>=20

> Additionally, my series fixes a number of bugs and cleans up along the
> way.  In particular, it converts qapi2texi.py from parse trees to the
> visitor interface the other generators use.
>=20
> Future generated documentation work includes eliding types that aren't
> visible in QMP (like introspection does), and making uses of type
> names links in HTML.

Reporting here, so it doesn't get lost in IRC.  Other potential future
work: fix this poor error message:

  GEN     docs/qemu-qmp-qapi.texi
Traceback (most recent call last):
  File "/home/eblake/qemu/scripts/qapi2texi.py", line 300, in <module>
    main(sys.argv)
  File "/home/eblake/qemu/scripts/qapi2texi.py", line 296, in main
    print texi_schema(schema)
  File "/home/eblake/qemu/scripts/qapi2texi.py", line 279, in texi_schema=

    gen.symbol(doc, schema.lookup_entity(doc.symbol))
  File "/home/eblake/qemu/scripts/qapi2texi.py", line 263, in symbol
    entity.visit(self)
  File "/home/eblake/qemu/scripts/qapi.py", line 1448, in visit
    visitor.visit_event(self.name, self.info, self.arg_type, self.boxed)
  File "/home/eblake/qemu/scripts/qapi2texi.py", line 259, in visit_event=

    body=3Dtexi_entity(doc, 'Arguments'))
  File "/home/eblake/qemu/scripts/qapi2texi.py", line 200, in texi_entity=

    + texi_sections(doc))
  File "/home/eblake/qemu/scripts/qapi2texi.py", line 160, in texi_member=
s
    items +=3D member_func(section.member) + desc + '\n'
  File "/home/eblake/qemu/scripts/qapi2texi.py", line 138, in texi_member=

    typ =3D member.type.doc_type()
AttributeError: 'NoneType' object has no attribute 'type'
Makefile:706: recipe for target 'docs/qemu-qmp-qapi.texi' failed
make: *** [docs/qemu-qmp-qapi.texi] Error 1
make: *** Deleting file 'docs/qemu-qmp-qapi.texi'

caused by this small change (documenting an event member, but omitting
'data' for the event itself):

diff --git i/qapi/event.json w/qapi/event.json
index 6d22b02..8978b33 100644
--- i/qapi/event.json
+++ w/qapi/event.json
@@ -68,6 +68,8 @@
 #
 # Emitted when the virtual machine is stopped
 #
+# @bogus: new field
+#
 # Since: 0.12.0
 #
 # Example:


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--oKllhIManBx25J1wJhCD195SBOaPaGRvQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAjWCAAoJEKeha0olJ0NqQKIH/0GtJ7kWQHsS3ngPRWOiezxf
1+4F0tIsKgn54I5JsraCS4anDqIfwxYj84KbPOVLM5IUAvyurbaOw/9xzqD7bmFJ
eCh6eovkRaTPeFGE1beJ1c+yfaBAuQpNZvQ/x4C/y4e2rfmC0pR8zl9e7CTgcp2c
xGP28DSIsS+n3jGoTswQEolbndOa2IFWiVvzO4nlcGqG+YU5J/Q33pMC0Y3cM0o5
KcBxufI8INeJ3NsA0BuOXJzRcu/jm3R7Xga4ne423MPa2ctEaKThp/Akdq3p7jQn
Hipy4EWoITngs+lsJULZHO5Wqf5VF1jABDvJ9b3ugBqTGyOxpgt3OJNaAgJW6VM=
=EvPt
-----END PGP SIGNATURE-----

--oKllhIManBx25J1wJhCD195SBOaPaGRvQ--
