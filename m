Received: from eggs.gnu.org ([2001:4830:134:3::10]:57855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpLFs-00011m-Uu
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 17:19:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dpLFo-0006MH-5G
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 17:19:32 -0400
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <809da3cc-4051-cb39-7f6a-2355013d3f9a@redhat.com>
Date: Tue, 5 Sep 2017 16:19:11 -0500
MIME-Version: 1.0
In-Reply-To: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6ijkiRs6wOgkSLPOdM9ervufAr2qio2dp"
Subject: Re: [Qemu-devel] [PATCH v10 0/6] fsdev: qmp interface for io
 throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, alberto garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org, "kwolf@redhat.com" <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6ijkiRs6wOgkSLPOdM9ervufAr2qio2dp
From: Eric Blake <eblake@redhat.com>
To: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, greg kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>,
 alberto garcia <berto@igalia.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org,
 "kwolf@redhat.com" <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>
Message-ID: <809da3cc-4051-cb39-7f6a-2355013d3f9a@redhat.com>
Subject: Re: [PATCH v10 0/6] fsdev: qmp interface for io throttling
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/04/2017 11:07 AM, Pradeep Jagadeesh wrote:
> These patches provide the qmp interface, to query the io throttle=20
> status of the all fsdev devices that are present in a vm.
> also, it provides an interface to set the io throttle parameters of a
> fsdev to a required value. some of the patches also remove the duplicat=
e
> code that was present in block and fsdev files.=20
>=20
> Pradeep Jagadeesh (6):
>   throttle: factor out duplicate code
>   qmp: Create IOThrottle structure
>   throttle: move out function to reuse the code
>   hmp: create a throttle initialization function for code reusability
>   fsdev: QMP interface for throttling
>   fsdev: hmp interface for throttling

I know you're already up to v10, but your code changes conflict with
Manos throttling work, which has now landed on Kevin's branch:

https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg01051.html

T: git git://repo.or.cz/qemu/kevin.git block

How hard is it for you to post a rebased v11 on top of Manos' work?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--6ijkiRs6wOgkSLPOdM9ervufAr2qio2dp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmvFM8ACgkQp6FrSiUn
Q2qIWQf8CA8dQkGAA1SLnHSaLg6WZUWtESNPKKxASKAT/eT9+WIhfA19AiDoUH/J
JOhlrpkAplCzm7NEESm4g7xN/dtL0ffJqCrDrc9RKiUf4SUfqKRig2Hkb3VznJu2
iUM+lcNlZPj3LDaW9ipYGohIEc4qbnOohHCir3NthIrwt+57XMgQqfzUMbEdnpDr
nGPMKvJ77NHcK4bcDylsKtYjtrONvlh8lPPrr4DnEzCFIUmLpOljZV4K1+YI/QzG
e4bOEkKIvKbmkrt9WaGgg+vLVoarDs7kr+1WkCHktDM2Ovcuz7VDoXGnGfrqu0NQ
cZghyHvB7xb/+kJCJFw5KjL/vpsoUQ==
=uhd7
-----END PGP SIGNATURE-----

--6ijkiRs6wOgkSLPOdM9ervufAr2qio2dp--
