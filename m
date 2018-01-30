Received: from eggs.gnu.org ([2001:4830:134:3::10]:59322)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egaEU-0008GG-JP
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1egaDQ-0002ne-L1
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:02:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1egaDQ-0002mf-BG
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 13:01:04 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8F071A916
	for <qemu-devel@nongnu.org>; Tue, 30 Jan 2018 18:01:03 +0000 (UTC)
References: <20180130102202.28519-1-armbru@redhat.com>
	<20180130102202.28519-18-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <9a4044b9-5f4c-bc7e-c99b-85ee683be7e1@redhat.com>
Date: Tue, 30 Jan 2018 12:01:02 -0600
MIME-Version: 1.0
In-Reply-To: <20180130102202.28519-18-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OCFWkBn34dHyv5xiNxOofexhMyzUAF9k5"
Subject: Re: [Qemu-devel] [PATCH 17/18] Drop superfluous includes of
 qapi/qmp/qjson.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--OCFWkBn34dHyv5xiNxOofexhMyzUAF9k5
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <9a4044b9-5f4c-bc7e-c99b-85ee683be7e1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 17/18] Drop superfluous includes of
 qapi/qmp/qjson.h
References: <20180130102202.28519-1-armbru@redhat.com>
 <20180130102202.28519-18-armbru@redhat.com>
In-Reply-To: <20180130102202.28519-18-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/30/2018 04:22 AM, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  balloon.c                           | 1 -
>  block/nbd.c                         | 1 -
>  block/quorum.c                      | 1 -
>  blockjob.c                          | 1 -
>  hw/core/qdev.c                      | 1 -
>  hw/net/virtio-net.c                 | 1 -
>  hw/pci/pcie_aer.c                   | 1 -
>  target/s390x/kvm.c                  | 1 -
>  tests/test-qobject-output-visitor.c | 1 -
>  ui/spice-core.c                     | 1 -
>  vl.c                                | 1 -
>  11 files changed, 11 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--OCFWkBn34dHyv5xiNxOofexhMyzUAF9k5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpwst4ACgkQp6FrSiUn
Q2oQbAf+Nuk9F23evgSxelIqKJup1kjovyIymzQCgCDuESOQNg04oXRWbgBvs6Jq
Y79HX1j60zvhXn5md0hLnnXt8WDh6Xuwixr64HWsIgaGt1NUHmTAjUupOEvxoNUz
4WQSDg6MxYkPGDrO1YEEfCKUD6E/inejC5hr4p/KTAzkDBneVpoWtahT1RfJbUCL
UQc8h+lbaJtBkG3BjKqa43v2O4N+C1JOqFmIy+X2vUkjgoCBN3nDrKEZ0KrJnxUP
q7NBRXHGrMQ+WGbjr7ny4oIb+sxQM9iORIDiC2blcfYSxEyJZzBYo0yVUnf+mEK4
DBjb7ljIyKN6lV/cLugomVScg+jrww==
=ZvNj
-----END PGP SIGNATURE-----

--OCFWkBn34dHyv5xiNxOofexhMyzUAF9k5--
