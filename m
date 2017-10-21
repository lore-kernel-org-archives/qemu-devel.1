Received: from eggs.gnu.org ([2001:4830:134:3::10]:39024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e6bGJ-0002ne-Ce
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:51:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e6bGD-0003Zk-Tb
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:51:19 -0400
References: <20171019222637.17890-1-eblake@redhat.com>
	<20171019222637.17890-7-eblake@redhat.com>
	<fc70554b-fe64-0b33-af5f-142259d56036@virtuozzo.com>
	<ae7945f3-c0c0-2238-7ad6-0f92cffaa816@redhat.com>
	<821df5a9-bc7d-a2d9-140f-4bd4e0bd72b1@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5e3d7dc8-a186-fa1f-4f0f-9e4ee20bf187@redhat.com>
Date: Sat, 21 Oct 2017 11:02:15 -0500
MIME-Version: 1.0
In-Reply-To: <821df5a9-bc7d-a2d9-140f-4bd4e0bd72b1@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ODaf6pf7KGPuj2udMq6TO9886ReKEVvi9"
Subject: Re: [Qemu-devel] [PATCH v5 06/11] nbd: Minimal structured read for
 server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ODaf6pf7KGPuj2udMq6TO9886ReKEVvi9
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org
Message-ID: <5e3d7dc8-a186-fa1f-4f0f-9e4ee20bf187@redhat.com>
Subject: Re: [PATCH v5 06/11] nbd: Minimal structured read for server
References: <20171019222637.17890-1-eblake@redhat.com>
 <20171019222637.17890-7-eblake@redhat.com>
 <fc70554b-fe64-0b33-af5f-142259d56036@virtuozzo.com>
 <ae7945f3-c0c0-2238-7ad6-0f92cffaa816@redhat.com>
 <821df5a9-bc7d-a2d9-140f-4bd4e0bd72b1@virtuozzo.com>
In-Reply-To: <821df5a9-bc7d-a2d9-140f-4bd4e0bd72b1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/20/2017 02:30 PM, Vladimir Sementsov-Ogievskiy wrote:

>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } else if (client->structured_reply) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_negotiate_send_=
rep_err(
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cli=
ent->ioc, NBD_REP_ERR_INVALID, option,
>>>> errp,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "st=
ructured reply already negotiated");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } else {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_negotiate_send_=
rep(client->ioc,
>>>> NBD_REP_ACK,
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opt=
ion, errp);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>>> you've dropped "if (ret < 0) { return ret }", but the following two
>>> lines should not be
>>> executed if ret < 0.. May be it doesn't matter (we will abort connect=
ion
>>> anyway after switch {}) but
>>> it looks strange.
>>>
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 client->structured_reply =3D true;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 myflags |=3D NBD_FLAG_SEND_DF;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;
>> Indeed, these two lines are harmless due to the catch-all 'ret < 0'
>> after the switch at the tail end of the loop (which is why I dropped t=
he
>> 'if' here).
>>
>>
>=20
> yes. but it looks strange) Anyway,
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20

On second thought, modifying client->structured_reply when we
successfully replied with an error is wrong.  So v6 will hoist the
modifications into the last else branch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--ODaf6pf7KGPuj2udMq6TO9886ReKEVvi9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnrb4cACgkQp6FrSiUn
Q2qzYQf8CQGpG5D52A/VEGfD7rOOE/RTxJ1EySZdYW05Slhm9QXeI24ISbjwN28f
Puhf9bJS5PMWxjHCCyyAJcuFzvrUTi+gDFHcdiy6uHJgd5vwU0zkE/Hxe7IRZxhL
OnzkfdNeFSwiO0AEsITbGuGk5VpR7AoWN+cvqehP2si/msdRcKJK81jQNbsyFmlT
hQ895EDBzeM3xij0fMrGAW2iaxFIOQSlZJGKMauZ0UE6EiKm8zultlCiVrPR+UP3
Y86DtkGk7XLuS0M/MFpf7l5Hecm6XMBmm6SOO+Rhmy9MJB1Q6QH5YM3L7kYlnBvj
ocrpj/uH+ibz0UNr4YcWzzSAr1cCYw==
=atnI
-----END PGP SIGNATURE-----

--ODaf6pf7KGPuj2udMq6TO9886ReKEVvi9--
