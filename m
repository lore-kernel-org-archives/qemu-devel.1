Received: from eggs.gnu.org ([208.118.235.92]:45826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfBQP-0004I3-SI
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 17:25:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfBQM-0006a6-OP
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 17:25:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gfBQM-0006XM-GM
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 17:25:10 -0500
References: <110999ea-0ab9-49cb-915f-6d08cccdea3c@linuxsystems.it>
	<47cfb9f8-5957-7935-063b-304e3c53c268@redhat.com>
	<9de9afbe-fc7b-48a0-9b2d-b756f146303d@linuxsystems.it>
	<254296205.54150897.1545827908434.JavaMail.zimbra@redhat.com>
	<04864360-b345-4d49-a842-8cde724b3c94@linuxsystems.it>
From: Eric Blake <eblake@redhat.com>
Message-ID: <87174d6c-2437-6331-e44b-93e2ecb8a572@redhat.com>
Date: Thu, 3 Jan 2019 16:25:00 -0600
MIME-Version: 1.0
In-Reply-To: <04864360-b345-4d49-a842-8cde724b3c94@linuxsystems.it>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="N7P68VnCvz5h22dXxcvfcWFXYbGetq6Ci"
Subject: Re: [Qemu-devel] [Spice-devel] Always get Invalid password while
 trying to connect to spice server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Niccol=c3=b2_Belli?= <darkbasic@linuxsystems.it>, Frediano Ziglio <fziglio@redhat.com>
Cc: Uri Lublin <uril@redhat.com>, mst@redhat.com, secalert@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, spice-devel@lists.freedesktop.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--N7P68VnCvz5h22dXxcvfcWFXYbGetq6Ci
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Niccol=c3=b2_Belli?= <darkbasic@linuxsystems.it>,
 Frediano Ziglio <fziglio@redhat.com>
Cc: Uri Lublin <uril@redhat.com>, mst@redhat.com, secalert@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, spice-devel@lists.freedesktop.org
Message-ID: <87174d6c-2437-6331-e44b-93e2ecb8a572@redhat.com>
Subject: Re: [Qemu-devel] [Spice-devel] Always get Invalid password while
 trying to connect to spice server
References: <110999ea-0ab9-49cb-915f-6d08cccdea3c@linuxsystems.it>
 <47cfb9f8-5957-7935-063b-304e3c53c268@redhat.com>
 <9de9afbe-fc7b-48a0-9b2d-b756f146303d@linuxsystems.it>
 <254296205.54150897.1545827908434.JavaMail.zimbra@redhat.com>
 <04864360-b345-4d49-a842-8cde724b3c94@linuxsystems.it>
In-Reply-To: <04864360-b345-4d49-a842-8cde724b3c94@linuxsystems.it>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/27/18 8:51 AM, Niccol=C3=B2 Belli wrote:
> On mercoled=C3=AC 26 dicembre 2018 13:38:28 CET, Frediano Ziglio wrote:=

>> Yes, this looks like a format string error in the upper (not into
>> spice) layer.
>>
>> This potentially is a security problem.
>=20
> Considering the spice server is exposed to the internet this is
> definitely worth investigating.
>=20
>> The specific '%' character could be the issue, can you try others
>> ('!', '@' and
>> so on) ?
>=20
> I tried several other special characters and they all seems to work,
> expect for "Password&&" which gets converted to "Password&amp;&amp;" (i=
f
> I type "Password&amp;&amp;" it works).

Could it be related to this patch where our JSON code mishandles %?
https://lists.gnu.org/archive/html/qemu-devel/2019-01/msg00108.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--N7P68VnCvz5h22dXxcvfcWFXYbGetq6Ci
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwui70ACgkQ3g5py3or
ov32Owf5AdNYHTdU0J+FGaQuZqbjba/HXCgRPRBR5JagEPiUizT/vEmeZxTlEzFK
7Q3yBjbS62gN2+lzMHLTObLKYVzEhSYSPfyqZe1ZlCBgGTylTjSu/Xt16aRAJpOD
3ymvxqmOULRAzA8j/HAeEVLr4Qs2zPS8ihIgeBHSDBEceGA2LW3YElmFoQCkSnyH
CgJ64Mu0/7Akl6Xp3GMT6QKebN7UQb1smQTztMnf7V0vg96wdQ0e3zWN5+mpZUo4
au9eWQMRQYAqn/NkiKe1MZ46A0183dJ8KmfRkz7nywVBCmZ7sSfGa/dBrecGfMri
JfkbCI9XxjQ7pcvG+AyzlGfYsBCqfA==
=qMnO
-----END PGP SIGNATURE-----

--N7P68VnCvz5h22dXxcvfcWFXYbGetq6Ci--
