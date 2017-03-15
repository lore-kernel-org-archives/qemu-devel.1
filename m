Received: from eggs.gnu.org ([2001:4830:134:3::10]:38125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co7UY-0000rq-BN
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1co7UU-0005sC-EI
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:53:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1co7UU-0005rb-5v
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 07:53:18 -0400
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<1489385927-6735-8-git-send-email-armbru@redhat.com>
	<1617dab3-b1cd-c24b-5084-e39af4683ed8@redhat.com>
	<874lyvt3ta.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <759ad1bb-21a5-ed8d-1d66-ca6d17829120@redhat.com>
Date: Wed, 15 Mar 2017 06:53:15 -0500
MIME-Version: 1.0
In-Reply-To: <874lyvt3ta.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IGx0WlfEmHKrr3sqTcFsN3b33KwNBGl5S"
Subject: Re: [Qemu-devel] [PATCH for-2.9 07/47] qapi: Clean up build of
 generated documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, mdroth@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IGx0WlfEmHKrr3sqTcFsN3b33KwNBGl5S
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com,
 mdroth@linux.vnet.ibm.com
Message-ID: <759ad1bb-21a5-ed8d-1d66-ca6d17829120@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 07/47] qapi: Clean up build of
 generated documentation
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
 <1489385927-6735-8-git-send-email-armbru@redhat.com>
 <1617dab3-b1cd-c24b-5084-e39af4683ed8@redhat.com>
 <874lyvt3ta.fsf@dusky.pond.sub.org>
In-Reply-To: <874lyvt3ta.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/15/2017 02:08 AM, Markus Armbruster wrote:

>>> +++ b/.gitignore
>>> @@ -103,11 +103,11 @@
>>>  /docs/qemu-ga-ref.txt
>>
>> [1]
>>
>>>  /docs/qemu-qmp-ref.html
>>>  /docs/qemu-qmp-ref.txt
>>> -docs/qemu-ga-ref.info*
>>> -docs/qemu-qmp-ref.info*
>>> -/qemu-ga-qapi.texi
>>> -/qemu-qapi.texi
>>> -/version.texi
>>> +/docs/qemu-ga-ref.info*
>>
>> worth sorting this line up by [1]?
>=20
> Fine with me, except I think we should either not mess with the order,
> or go all the way, i.e. ...
>=20
>>> +/docs/qemu-qmp-ref.info*
>>> +/docs/qemu-ga-qapi.texi
>=20
> ... move this one, too.  Feeding to sort leads to this incremental
> patch:
>=20
> @@ -99,14 +99,14 @@
>  /pc-bios/optionrom/kvmvapic.img
>  /pc-bios/s390-ccw/s390-ccw.elf
>  /pc-bios/s390-ccw/s390-ccw.img
> +/docs/qemu-ga-qapi.texi
>  /docs/qemu-ga-ref.html
> +/docs/qemu-ga-ref.info*
>  /docs/qemu-ga-ref.txt
> +/docs/qemu-qmp-qapi.texi
>  /docs/qemu-qmp-ref.html
> -/docs/qemu-qmp-ref.txt
> -/docs/qemu-ga-ref.info*
>  /docs/qemu-qmp-ref.info*
> -/docs/qemu-ga-qapi.texi
> -/docs/qemu-qmp-qapi.texi
> +/docs/qemu-qmp-ref.txt
>  /docs/version.texi
>  *.tps
>  .stgit-*

Works for me (I always find fully-sorted lists easier to modify, because
I don't have to guess whether inserting new stuff is grouped sanely).


>>>  MAKEINFO=3Dmakeinfo
>>> -MAKEINFOFLAGS=3D--no-split --number-sections
>>> +MAKEINFOFLAGS=3D--no-split --number-sections -I docs
>>
>> Will this cause grief on any older makinfo versions (such as RHEL 6)? =
 I
>> didn't test myself on those setups.  I guess if a buildbot doesn't fla=
g
>> you, it's okay.
>=20
> RHEL-6 has texinfo 4.13, and its manual page documents -I.  No mention
> in NEWS, which goes back to 2.2.

Phew, we're safe then.

>=20
>> The sorting issue is worth fixing, but trivial, so you can add:
>>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20
> Thanks!
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--IGx0WlfEmHKrr3sqTcFsN3b33KwNBGl5S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYySsrAAoJEKeha0olJ0Nqe14H/0S9QRm7OS39ovxXYaI/EpKe
5ke2ky23j3Xqh1UI1bcZoxQ/B8GoCkDTBpisQeTyVTIf51UnFCgWMthEI3Zh9bEF
xpEdvI7lAX8lBIYaCiEZjFqsTOMQpDfbGeK8nab3uYcaIzqNKwO/POXdF244drx4
doAN64rpWwrqd2wbbzG7ADLw3TZvyinZ1/S7+k8lb1Od7HXeO0CbZGAxZj1QTR01
Ngd981YP+tDZSJtLSzQGnZDQATOKidZAtmVt1uVvzmTqgpi/0DLgLYUdxXT8WCM1
j+M5sgyf4TxuaUi92WHw1njgvk9USEh5zIPKuME7syzoIGKqCgEzParANzHZ7WY=
=EtOa
-----END PGP SIGNATURE-----

--IGx0WlfEmHKrr3sqTcFsN3b33KwNBGl5S--
