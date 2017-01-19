Received: from eggs.gnu.org ([2001:4830:134:3::10]:54839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUDvN-0003Kd-So
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:42:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cUDvI-00053m-VH
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:42:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cUDvI-00053T-Mc
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 09:42:44 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D2EDB7E9C2
	for <qemu-devel@nongnu.org>; Thu, 19 Jan 2017 14:42:44 +0000 (UTC)
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-7-eblake@redhat.com>
	<8737gffkhy.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f5618def-ca46-72e7-c872-85e6d79a17b5@redhat.com>
Date: Thu, 19 Jan 2017 08:42:42 -0600
MIME-Version: 1.0
In-Reply-To: <8737gffkhy.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sOjj506jk06bEDiSfp11edQS1vbiLo71o"
Subject: Re: [Qemu-devel] [PATCH v2 6/6] qapi: Promote
 blockdev-change-medium arguments to QAPI type
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
--sOjj506jk06bEDiSfp11edQS1vbiLo71o
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <f5618def-ca46-72e7-c872-85e6d79a17b5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] qapi: Promote blockdev-change-medium
 arguments to QAPI type
References: <20170118161653.19296-1-eblake@redhat.com>
 <20170118161653.19296-7-eblake@redhat.com>
 <8737gffkhy.fsf@dusky.pond.sub.org>
In-Reply-To: <8737gffkhy.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/19/2017 03:48 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20
>> Having a named rather than anonymous C type will make it easier
>> to improve the testsuite in a later patch.
>=20
> Post it together with said later patch then.

It was that way in the v1 series, but I had enough else going on with
removal of dynamic JSON parsing that I thought I could pick this one
early.  But I have no problems omitting it in a v3 respin, and saving it
for the dynamic JSON work (if we even want to revisit that discussion).


>    # @format:          #optional, format to open the new image with (de=
faults to
>    #                   the probed format)
>    #
>    # @read-only-mode:  #optional, change the read-only mode of the devi=
ce; defaults
>    #                   to 'retain'
>    #
>    # Since: 2.5
>=20
> Isn't Since: 2.5 misleading?  The anonymous type goes back to 2.5, but
> the name doesn't.

It matches what we've done elsewhere - when refactoring .json files to
create a new type, but where the new type doesn't represent anything
different over the wire than what was previously sent, we've documented
the new struct name as of the older release where the wire format was
introduced.  But as long as the command says 'since 2.5', I'm okay if we
want to mark the struct as 'since 2.9', if that's easier to think about.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--sOjj506jk06bEDiSfp11edQS1vbiLo71o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYgNBiAAoJEKeha0olJ0Nqi6EH/i7vv7W1BNqpxPwFtDDLPXCn
daU7ep2XGhyBxJ6aY2ULGCnET71gJWfYkGm6HnuLW+I8TE51CKtX9LSlQIeYTYHV
InQH0anbqJJbge4QaiWnn1jt8wQ4DHnUVu9FLY9dL3SMicAivC0oYcZHLTgxKbu5
vBVTFsPpXzibJVBaACVrBy28Bgg/Ot3SGWjrCubdz++XM8UsfS2pnFbPlJUPrMMQ
Z2pURJbmFi6KeZIeXiafxxMim3255wvm25MwXxoxqBKLEO4Iethh/mxqEtDO0hfq
yqDlLBYD0VQrqwFZNCGcbVckDRJZIWuvfjPlHlcl1yMaBjVN6SZ4uYzcFBnChOc=
=LhF9
-----END PGP SIGNATURE-----

--sOjj506jk06bEDiSfp11edQS1vbiLo71o--
