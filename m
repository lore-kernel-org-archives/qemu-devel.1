Received: from eggs.gnu.org ([2001:4830:134:3::10]:49001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyJZ7-00007S-E9
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:48:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cyJZ2-0007q7-RX
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:48:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cyJZ2-0007nq-J0
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 10:48:08 -0400
References: <20170406210917.6896-1-eblake@redhat.com>
	<877f2pnb2t.fsf@dusky.pond.sub.org>
	<70ca7ebd-f538-1721-c500-9e106225959c@redhat.com>
	<87vaq97mxf.fsf@dusky.pond.sub.org>
	<480c1dd8-fcd1-212c-a2c0-8170da3a7629@redhat.com>
	<87zifl3dcs.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a2b472b4-6ec6-6f23-87e4-22b95169834b@redhat.com>
Date: Wed, 12 Apr 2017 09:48:06 -0500
MIME-Version: 1.0
In-Reply-To: <87zifl3dcs.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="S8Ss2j5mpeSqE9W25RlaqfEjdaEwvFhVX"
Subject: Re: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S8Ss2j5mpeSqE9W25RlaqfEjdaEwvFhVX
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Stefan Weil <sw@weilnetz.de>
Message-ID: <a2b472b4-6ec6-6f23-87e4-22b95169834b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] event: Add signal information to SHUTDOWN
References: <20170406210917.6896-1-eblake@redhat.com>
 <877f2pnb2t.fsf@dusky.pond.sub.org>
 <70ca7ebd-f538-1721-c500-9e106225959c@redhat.com>
 <87vaq97mxf.fsf@dusky.pond.sub.org>
 <480c1dd8-fcd1-212c-a2c0-8170da3a7629@redhat.com>
 <87zifl3dcs.fsf@dusky.pond.sub.org>
In-Reply-To: <87zifl3dcs.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2017 09:33 AM, Markus Armbruster wrote:

>>> Additional ways to terminate QEMU: HMP and QMP command "quit", and th=
e
>>> various GUI controls such "close SDL window".
>>
>> Good points. I have no idea what exit path those take (if they
>> raise(SIGINT) internally, it's quite easy - but if they go through som=
e
>> other exit path, then I'll need to wire in something else).
>=20
> Chasing down all host-initiated terminations looks like a fool's errand=

> to me.  But if we can reliably detect guest-initiated, we don't have to=
,
> do we?

I don't know if we can reliably detect guest-initiated. Host-signal
initiated was easy because of the modification to a global variable.
But hopefully I'll find some easy common point, and maybe have to add
another global variable to track whether we went through that point (as
the reporting point is different than the request point).  At any rate,
this conversation is useful, to make sure I find the right place.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--S8Ss2j5mpeSqE9W25RlaqfEjdaEwvFhVX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY7j4mAAoJEKeha0olJ0Nq7osH/jwqeVHb3YHJj2D4oxz090b+
HFrn9+BokhJm41/2c+XtEo8O5H0djGZ7yp5AdTTr09xBmBPzHoqiSzLgtua4n0Ms
xYU/2zrZKUFvZlguK5pRG13CyElyf+x5/VanBiAoRdWzmk/0I9Uf8tG6l/whz++C
yQ72+1GmGMN5VLdfrD08A6N784sgb03XN0cE/dtONG/ECkwIhpF3YgpH6KBSREAj
DlxK4ImdOThlaVByp15/yNCxd1b8tkCLD+ry5KFvZxtkxENsUhRRuY0iU13bqlFa
OVlxMGppiJY8DxxrXx2Dl4yWRtkj+lrtHCiLvaQ3DyNm67FpxDkajNHT92nnmPQ=
=TlB3
-----END PGP SIGNATURE-----

--S8Ss2j5mpeSqE9W25RlaqfEjdaEwvFhVX--
