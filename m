Received: from eggs.gnu.org ([2001:4830:134:3::10]:59433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBMNl-0008NY-LG
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:26:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBMNg-00048F-04
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:26:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dBMNf-000481-N7
	for qemu-devel@nongnu.org; Thu, 18 May 2017 10:26:19 -0400
References: <1495134895-7814-1-git-send-email-yang.zhong@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0a9fd54f-241a-912f-eabb-2f65fd26d7ee@redhat.com>
Date: Thu, 18 May 2017 09:26:16 -0500
MIME-Version: 1.0
In-Reply-To: <1495134895-7814-1-git-send-email-yang.zhong@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7JwF78TN99qVhAIgH17lCBXf9Wva9aah3"
Subject: Re: [Qemu-devel] [PATCH 1/4] split the tcg accelerator from accel.c
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, pbonzini@redhat.com
Cc: anthony.xu@intel.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7JwF78TN99qVhAIgH17lCBXf9Wva9aah3
From: Eric Blake <eblake@redhat.com>
To: Yang Zhong <yang.zhong@intel.com>, pbonzini@redhat.com
Cc: anthony.xu@intel.com, qemu-devel@nongnu.org
Message-ID: <0a9fd54f-241a-912f-eabb-2f65fd26d7ee@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] split the tcg accelerator from accel.c
 file
References: <1495134895-7814-1-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1495134895-7814-1-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/18/2017 02:14 PM, Yang Zhong wrote:
> there are two accelerators in qemu, kvm and tcg.  kvm
> accelerator is defined in kvm-all.c, but tcg accelerator
> is defined in accel.c file. we split tcg accelerator from
> accel.c file and create one new accel directory,which will

space after comma in English.

> include kvm and tcg accel files.
>=20

Please remember to send a 0/4 cover letter when sending a series; our
automated tooling works better that way.  You can  use 'git config
format.coverletter auto' to make git do the right thing.

> Signed-off-by: Yang Zhong <yang.zhong@intel.com>
> ---
>  Makefile.objs           |   1 -
>  Makefile.target         |   1 +
>  accel.c                 | 155 ----------------------------------------=
--------
>  accel/Makefile.objs     |   2 +
>  accel/accel.c           | 128 +++++++++++++++++++++++++++++++++++++++
>  accel/tcg/Makefile.objs |   1 +
>  accel/tcg/tcg-all.c     |  61 +++++++++++++++++++
>  7 files changed, 193 insertions(+), 156 deletions(-)
>  delete mode 100644 accel.c
>  create mode 100644 accel/Makefile.objs
>  create mode 100644 accel/accel.c
>  create mode 100644 accel/tcg/Makefile.objs
>  create mode 100644 accel/tcg/tcg-all.c

You may also want to set 'git config diff.renames true' to make code
motion patches take up less bandwidth (assuming that the new
accel/accel.c is close enough for git to detect it as a rename from the
old accel.c).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--7JwF78TN99qVhAIgH17lCBXf9Wva9aah3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHa8IAAoJEKeha0olJ0NqaUIIAKGTWFWTaGiGYib2HYFhAa9u
N/o+1ogL0LerOfiq3eReHAX/bGCheP86cjaQ1x3zoy2vmwAnObs9QbrMNU4HJp3t
KKgB2UhrFsrXPtza8eoKKa7Y7trGR+nKJ6VX62T85o17N4eggxJ7+4tCLMhZdq9Y
kUMKT0XdCcVdERwU8Nte48v2nIPFkldVSBB/DQ9dtwOhhvRm/VwLjdwOHqpMUTeE
6CzujQxBIvAuW5mXJfdlYFC4U7LFAsaibiHqbwZHbRMtkXI6WKJrtW7U96smjr2q
QrsdYOjSBThpAyv67538lYJkmh+8yaN5Nm1IGoMDNoKQoRoom0+bYQ9U0DkTNy0=
=nC+L
-----END PGP SIGNATURE-----

--7JwF78TN99qVhAIgH17lCBXf9Wva9aah3--
