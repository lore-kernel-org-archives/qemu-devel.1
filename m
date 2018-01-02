Received: from eggs.gnu.org ([2001:4830:134:3::10]:36393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWU18-0007Q3-KM
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:22:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWU14-00018Q-Dw
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:22:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eWU14-00017y-5G
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 16:22:34 -0500
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
	<CGME20171030131647eucas1p1b5fb0616e683e78fdca767d267400f50@eucas1p1.samsung.com>
	<1509369390-8285-3-git-send-email-a.perevalov@samsung.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <61064b31-b6d5-97b1-89a4-5af719223e5a@redhat.com>
Date: Tue, 2 Jan 2018 15:22:28 -0600
MIME-Version: 1.0
In-Reply-To: <1509369390-8285-3-git-send-email-a.perevalov@samsung.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GTEjKYR346biy4FC9gqHhbNgsf2t65vy2"
Subject: Re: [Qemu-devel] [PATCH v12 2/6] migration: add postcopy blocktime
 ctx into MigrationIncomingState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: heetae82.ahn@samsung.com, quintela@redhat.com, dgilbert@redhat.com, peterx@redhat.com, i.maximets@samsung.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GTEjKYR346biy4FC9gqHhbNgsf2t65vy2
From: Eric Blake <eblake@redhat.com>
To: Alexey Perevalov <a.perevalov@samsung.com>, qemu-devel@nongnu.org
Cc: heetae82.ahn@samsung.com, quintela@redhat.com, dgilbert@redhat.com,
 peterx@redhat.com, i.maximets@samsung.com
Message-ID: <61064b31-b6d5-97b1-89a4-5af719223e5a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v12 2/6] migration: add postcopy blocktime
 ctx into MigrationIncomingState
References: <1509369390-8285-1-git-send-email-a.perevalov@samsung.com>
 <CGME20171030131647eucas1p1b5fb0616e683e78fdca767d267400f50@eucas1p1.samsung.com>
 <1509369390-8285-3-git-send-email-a.perevalov@samsung.com>
In-Reply-To: <1509369390-8285-3-git-send-email-a.perevalov@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/30/2017 08:16 AM, Alexey Perevalov wrote:
> This patch adds request to kernel space for UFFD_FEATURE_THREAD_ID,
> in case when this feature is provided by kernel.

Either 'in the case when this feature' or 'in case this feature'.

>=20
> PostcopyBlocktimeContext is incapsulated inside postcopy-ram.c,

s/incapsulated/encapsulated/

> due to it's postcopy only feature.

s/it's postcopy only/it being a postcopy-only/

> Also it defines PostcopyBlocktimeContext's instance live time.
> Information from PostcopyBlocktimeContext instance will be provided
> much after postcopy migration end, instance of PostcopyBlocktimeContext=

> will live till QEMU exit, but part of it (vcpu_addr,
> page_fault_vcpu_time) used only during calculation, will be released
> when postcopy ended or failed.
>=20
> To enable postcopy blocktime calculation on destination, need to reques=
t
> proper capabiltiy (Patch for documentation will be at the tail of the p=
atch

s/capabiltiy/capability/

> set).
>=20
> As an example following command enable that capability, assume QEMU was=

> started with
> -chardev socket,id=3Dcharmonitor,path=3D/var/lib/migrate-vm-monitor.soc=
k
> option to control it
>=20
> [root@host]#printf "{\"execute\" : \"qmp_capabilities\"}\r\n \
> {\"execute\": \"migrate-set-capabilities\" , \"arguments\":   {
> \"capabilities\": [ { \"capability\": \"postcopy-blocktime\", \"state\"=
:
> true } ] } }" | nc -U /var/lib/migrate-vm-monitor.sock
>=20
> Or just with HMP
> (qemu) migrate_set_capability postcopy-blocktime on
>=20
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
> ---
--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--GTEjKYR346biy4FC9gqHhbNgsf2t65vy2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpL+BQACgkQp6FrSiUn
Q2rDNQf+INx7P7/n+qH9+cKiszxpDsJ8QD/IUfMgSuv7nWzcGQPU3NUQ+UGt+WXZ
FEjSVsuColSjImjRlbOFjjL69Cwtr4N78gQNdYCFwLPWLPf9h1GS94k/AsotNH8c
WRhJBFAntu92lwEezylOQOPk0TMI0iQy5+lEkNXTPbvS3+lMqHbt7IEFH99snq4t
paQF1oHfy9yunYZEFG1CRdhIDc7XBJdkaQpGGNj7d17G+GCzl8Oe1JFsZ/b05dM4
nJ7bVl7h2DhQw3Us1Vh25u1i2sIvENmgQjpwR2hLsNjdOOmr1fFx94GI9zdWIGHw
NTiTpgHYBSiECZaSAjS33KcvGJqL0g==
=Sb25
-----END PGP SIGNATURE-----

--GTEjKYR346biy4FC9gqHhbNgsf2t65vy2--
