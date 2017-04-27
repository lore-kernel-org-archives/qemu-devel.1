Received: from eggs.gnu.org ([2001:4830:134:3::10]:44291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3jEY-0001oy-3m
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:13:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3jES-0007T7-8L
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:13:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42324)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d3jES-0007So-0M
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 09:13:16 -0400
References: <1493282486-28338-1-git-send-email-armbru@redhat.com>
	<1493282486-28338-5-git-send-email-armbru@redhat.com>
	<CAJ+F1CL2=cjEJ40tJ0nKtWD=DbG9aAmFkoRDT2y0+zaHFZbe0w@mail.gmail.com>
	<8760hqceh7.fsf@dusky.pond.sub.org>
	<CAJ+F1CL=BH2wqKMi3U0iZp4ujw_kHAGszL3KXJHJp9+mF3fmXg@mail.gmail.com>
	<87lgqm83yl.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ef786534-615d-da52-e506-78a0a413f18d@redhat.com>
Date: Thu, 27 Apr 2017 08:13:13 -0500
MIME-Version: 1.0
In-Reply-To: <87lgqm83yl.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MIl3RPxPm7H2wgFBQKoRUJbM6LJxlBVhB"
Subject: Re: [Qemu-devel] [PATCH 4/4] qobject-input-visitor: Catch misuse of
 end_struct vs. end_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MIl3RPxPm7H2wgFBQKoRUJbM6LJxlBVhB
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com
Message-ID: <ef786534-615d-da52-e506-78a0a413f18d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] qobject-input-visitor: Catch misuse of
 end_struct vs. end_list
References: <1493282486-28338-1-git-send-email-armbru@redhat.com>
 <1493282486-28338-5-git-send-email-armbru@redhat.com>
 <CAJ+F1CL2=cjEJ40tJ0nKtWD=DbG9aAmFkoRDT2y0+zaHFZbe0w@mail.gmail.com>
 <8760hqceh7.fsf@dusky.pond.sub.org>
 <CAJ+F1CL=BH2wqKMi3U0iZp4ujw_kHAGszL3KXJHJp9+mF3fmXg@mail.gmail.com>
 <87lgqm83yl.fsf@dusky.pond.sub.org>
In-Reply-To: <87lgqm83yl.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2017 06:50 AM, Markus Armbruster wrote:

>>>>
>>>> It would be more obvious with a check for qobject_type(tos->obj), no=
?
>>>
>>> --verbose?
>>>
>>
>> Instead of assert(tos->h) assert(qobject_type(tos->obj) =3D=3D QTYPE_Q=
DICT) ?
>=20
> The two conditions imply each other.  We can assert either one, or even=

> both.  Eric, got a preference?

Asserting both might make it easier to come up to speed when reading the
code a year from now.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MIl3RPxPm7H2wgFBQKoRUJbM6LJxlBVhB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAe5pAAoJEKeha0olJ0Nq9vEH/jYkEZggIxfF/8uk3CFlrmKi
4RJuiBINoXrONenvq15e81tGPXCl9lcN5GPSmZil9YpRmyzpVssmsp9l7PI+hBrL
TG1j7Z/DEUPNYbwe4ygvSwCGW8fjJ5nSD9E/mr42x/lwNfNSA8sTOpkV5KATIdjC
0LvKIT4wRsQ8c893Ysm2jHaKx0gbMH5JL005e1OqsmTnyjAP4COXUswdhw3rQ+Nl
AlV7w4jJNgD1+qvRO6BOQRpMzxeDQwVyy8h0nIivqqzEZrpMakYNsp/fQRljmUow
c1mEoOlcvtvNCzdLL4hOnaiiKn+nxRClBWSTuvpOyvkCEbOro0GD5tthOwjRI8U=
=Wb+B
-----END PGP SIGNATURE-----

--MIl3RPxPm7H2wgFBQKoRUJbM6LJxlBVhB--
