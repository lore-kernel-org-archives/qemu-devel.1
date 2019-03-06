Received: from eggs.gnu.org ([209.51.188.92]:44155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1ZZM-0000cg-Cy
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:39:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1h1ZZI-0007Nv-7w
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:38:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1h1ZZF-0007Kg-Mj
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 11:38:54 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A76A980472
	for <qemu-devel@nongnu.org>; Wed,  6 Mar 2019 16:38:48 +0000 (UTC)
References: <1551889825-227155-1-git-send-email-imammedo@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f31071b6-2e89-2c95-5f5e-c42b77023c91@redhat.com>
Date: Wed, 6 Mar 2019 10:38:40 -0600
MIME-Version: 1.0
In-Reply-To: <1551889825-227155-1-git-send-email-imammedo@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="BbPLAWspBDriGXf4m7GKG2ro7Itr1QsuL"
Subject: Re: [Qemu-devel] [PATCH] numa: warn if numa 'mem' option or default
 RAM splitting between nodes is used.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, libvir-list@redhat.com, berrange@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BbPLAWspBDriGXf4m7GKG2ro7Itr1QsuL
From: Eric Blake <eblake@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, libvir-list@redhat.com, berrange@redhat.com
Message-ID: <f31071b6-2e89-2c95-5f5e-c42b77023c91@redhat.com>
Subject: Re: [PATCH] numa: warn if numa 'mem' option or default RAM splitting
 between nodes is used.
References: <1551889825-227155-1-git-send-email-imammedo@redhat.com>
In-Reply-To: <1551889825-227155-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 3/6/19 10:30 AM, Igor Mammedov wrote:
> Ammend -numa option docs and print warnings if 'mem' option or default =
RAM

s/Ammend/Amend/

> splitting between nodes is used. It's intended to discourage users from=
 using
> configuration that allows only to fake NUMA on guest side while leading=

> to reduced performance of the guest due to inability to properly config=
ure
> VM's RAM on the host.
>=20
> In NUMA case, it's recommended to always explicitly configure guest RAM=

> using -numa node,memdev=3D{backend-id} option.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  numa.c          |  5 +++++
>  qemu-options.hx | 12 ++++++++----
>  2 files changed, 13 insertions(+), 4 deletions(-)
>=20

> @@ -407,6 +409,9 @@ void numa_complete_configuration(MachineState *ms)
>          if (i =3D=3D nb_numa_nodes) {
>              assert(mc->numa_auto_assign_ram);
>              mc->numa_auto_assign_ram(mc, numa_info, nb_numa_nodes, ram=
_size);
> +            warn_report("Default splitting of RAM between nodes is obs=
olete,"
> +                        " Use '-numa node,memdev' to explictly define =
RAM"

s/explictly/explicitly/


> +++ b/qemu-options.hx
> @@ -206,10 +206,14 @@ For example:
>  -numa cpu,node-id=3D0,socket-id=3D0 -numa cpu,node-id=3D1,socket-id=3D=
1
>  @end example
> =20
> -@samp{mem} assigns a given RAM amount to a node. @samp{memdev}
> -assigns RAM from a given memory backend device to a node. If
> -@samp{mem} and @samp{memdev} are omitted in all nodes, RAM is
> -split equally between them.
> +@samp{memdev} assigns RAM from a given memory backend device to a node=
=2E
> +
> +Legacy options/behaviour: @samp{mem} assigns a given RAM amount to a n=
ode.
> +If @samp{mem} and @samp{memdev} are omitted in all nodes, RAM is split=
 equally
> +between them. Option @samp{mem} and default RAM splitting are obsolete=
 as they
> +do not provide means to manage RAM on host side and only allow QEMU to=
 fake

s/on host/on the host/

> +NUMA support which in practice could degrade VM performance.
> +It's advised to always explicitly configure NUMA RAM using @samp{memde=
v} option.

s/using/by using the/

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--BbPLAWspBDriGXf4m7GKG2ro7Itr1QsuL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlx/95EACgkQp6FrSiUn
Q2o17ggAgGh9FO4lf/XMjvhMbXu+5IWvrzwWoLGrV3xqsE4PeSC5f3KaweviKkA0
F+9PDwRr06L4ITnLMYtitkakAd5kkNex+qpxTwzSaSqAvYmPSOLSl3MZVhkrubkX
7c0jluKBx6A7P3k1cyrprsnbpmIDZPBiC+8uUCadbZUJtjSxU19KR/0HS1KshaGN
GCuzCiIVeAhwgRhMgHLb5Ins35wa/986U1uoBNKvmPUodw5eanskhaPV5ORBqsTS
8VTqOf3ndJpvMQBXpquZv3grsIIiu5WrmKX62yUHinfwy1uY+nZTk5xxEs9eGgiy
06byJbKCbaiSwMrsYMbgbAze/N/CBg==
=Phhu
-----END PGP SIGNATURE-----

--BbPLAWspBDriGXf4m7GKG2ro7Itr1QsuL--
