Received: from eggs.gnu.org ([2001:4830:134:3::10]:51883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYzEH-0002bD-I3
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:06:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eYzEG-0002ix-JF
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 14:06:33 -0500
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
	<20171207155102.66622-3-vsementsov@virtuozzo.com>
	<20171208173321.GR2403@work-vm>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8711ff94-3d7a-446e-6da1-2e6e2b82899a@redhat.com>
Date: Tue, 9 Jan 2018 13:06:22 -0600
MIME-Version: 1.0
In-Reply-To: <20171208173321.GR2403@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="thW2h3DLUR28UejUR2UGYVyixBW9t9f0P"
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qapi: add name parameter to
 nbd-server-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--thW2h3DLUR28UejUR2UGYVyixBW9t9f0P
From: Eric Blake <eblake@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, armbru@redhat.com,
 pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Message-ID: <8711ff94-3d7a-446e-6da1-2e6e2b82899a@redhat.com>
Subject: Re: [PATCH v2 2/6] qapi: add name parameter to nbd-server-add
References: <20171207155102.66622-1-vsementsov@virtuozzo.com>
 <20171207155102.66622-3-vsementsov@virtuozzo.com>
 <20171208173321.GR2403@work-vm>
In-Reply-To: <20171208173321.GR2403@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/08/2017 11:33 AM, Dr. David Alan Gilbert wrote:

>> @@ -2223,7 +2224,7 @@ void hmp_nbd_server_add(Monitor *mon, const QDic=
t *qdict)
>>      bool writable =3D qdict_get_try_bool(qdict, "writable", false);
>>      Error *local_err =3D NULL;
>> =20
>> -    qmp_nbd_server_add(device, true, writable, &local_err);
>> +    qmp_nbd_server_add(device, false, NULL, true, writable, &local_er=
r);
>=20
> I wont insist, but it would be nice if you wired up an optional
> parameter on HMP as well.

Can be done as a followup patch; I'm not sure how many people are
setting up NBD exports via HMP, and I'm also okay with just stating that
the full power requires use of QMP.  But I'll give such a followup patch
a quick try, to see whether it is easy after all.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--thW2h3DLUR28UejUR2UGYVyixBW9t9f0P
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpVEq4ACgkQp6FrSiUn
Q2r2cQf/ecppxC53Rc6LbZBIgABZ7ylHfQOYgoW/k/RPmrkBCMJi3Fv2Ia59SmJv
6gOWP+d+mptQskzyhEUgOrSItL5TxEojWSmgejPUxzEk1EPr6WR6CqIt4JZj4xNs
o5YlwYIXz8kIyWe6GxvyUIEkvAY4Y24iQtvzFL5+wznRQ4ya9AImCzYRTebCvkWw
/0SvCPcgdaZ8hMnCei5axWo/MPtjA9C467x77SRp4KygpMqx5vBv4QZbqEELIvJH
QQU/iczy994zx2aqsXe1SmWsCLLRWL3PW2AlFaUxErVJebkJSGKDB1KzBumy+Owb
A1lDbuXEuuL63prUVS+sqDuN/0x++w==
=qTU7
-----END PGP SIGNATURE-----

--thW2h3DLUR28UejUR2UGYVyixBW9t9f0P--
