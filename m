Received: from eggs.gnu.org ([209.51.188.92]:53246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gugEo-0006NP-Vj
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gugEo-0001Wx-01
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:21:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gugEn-0001Vh-L7
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 11:21:17 -0500
References: <20181107131000.27744-1-danielhb413@gmail.com>
	<20181107131000.27744-2-danielhb413@gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d8764234-8c52-a24f-c07f-da3655bf2293@redhat.com>
Date: Fri, 15 Feb 2019 10:21:06 -0600
MIME-Version: 1.0
In-Reply-To: <20181107131000.27744-2-danielhb413@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AHnfPKqKw7hmqpDQaDKyRliY8c0jvzLF5"
Subject: Re: [Qemu-devel] [PATCH for-3.2 v3 1/3] block/snapshot.c: eliminate
 use of ID input in snapshot operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, dgilbert@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AHnfPKqKw7hmqpDQaDKyRliY8c0jvzLF5
From: Eric Blake <eblake@redhat.com>
To: Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 mreitz@redhat.com
Message-ID: <d8764234-8c52-a24f-c07f-da3655bf2293@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.2 v3 1/3] block/snapshot.c: eliminate
 use of ID input in snapshot operations
References: <20181107131000.27744-1-danielhb413@gmail.com>
 <20181107131000.27744-2-danielhb413@gmail.com>
In-Reply-To: <20181107131000.27744-2-danielhb413@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/7/18 7:09 AM, Daniel Henrique Barboza wrote:
> At this moment, QEMU attempts to create/load/delete snapshots
> by using either an ID (id_str) or a name. The problem is that the code
> isn't consistent of whether the entered argument is an ID or a name,
> causing unexpected behaviors.
>=20

>  STEXI
> -@item savevm [@var{tag}|@var{id}]
> +@item savevm @var{tag}
>  @findex savevm
>  Create a snapshot of the whole virtual machine. If @var{tag} is
>  provided, it is used as human readable identifier. If there is already=

> -a snapshot with the same tag or ID, it is replaced. More info at
> +a snapshot with the same tag, it is replaced. More info at
>  @ref{vm_snapshots}.
> +
> +Since 3.2, savevm stopped allowing the snapshot id to be set, acceptin=
g

s/3.2/4.0/

> +only @var{tag} as parameter.

> +Since 3.2, delvm stopped deleting snapshots by snapshot id, accepting
> +only @var{tag} as parameter.

and again

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--AHnfPKqKw7hmqpDQaDKyRliY8c0jvzLF5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxm5vIACgkQp6FrSiUn
Q2qJJAf8Dke1yEa9DJFMEBiGog496lTced4lC2k4HSAYMmJis4MudFZ632kNCPTc
tRLEQNd7CXszmEoWlViBhcyWuZdGU3w2Xhscc/yjF6nGw5rmYfCZJCPxcGB1UX03
T45ghbkjxnNL3BTXd0JVFvWSDnipJ7IUv2+epbTPEQxXDa/iZKNH7fcLTHx8BtcA
QIZqUCdUMcL3kRk1XQh4BAGMAJPVvq3VL1qoJyeqh6Lz0wfNjzP/z7pI1wRmBa4r
Vhp9brUz+Lhx/CLtkafH/+yCM/HyVllzI78l0Fn0WczeuixwXnTQFMdl0CIYkwZR
MsYUzLSjdo3l5WjbXQOJJh5BIvlZCQ==
=PB7p
-----END PGP SIGNATURE-----

--AHnfPKqKw7hmqpDQaDKyRliY8c0jvzLF5--
