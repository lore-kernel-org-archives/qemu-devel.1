Received: from eggs.gnu.org ([2001:4830:134:3::10]:38625)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzlro-0005gE-V2
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:45:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dzlrk-0007aD-Cl
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:45:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59438)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dzlrk-0007ZI-3o
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 11:45:44 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2554179707
	for <qemu-devel@nongnu.org>; Wed,  4 Oct 2017 15:45:43 +0000 (UTC)
References: <20171004114008.14849-1-berrange@redhat.com>
	<20171004114008.14849-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <a0343309-ace9-d57f-352e-507141a92178@redhat.com>
Date: Wed, 4 Oct 2017 10:45:38 -0500
MIME-Version: 1.0
In-Reply-To: <20171004114008.14849-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="o8MOqjoDcxEF4nvNmIPdMnLNU2shcQQOi"
Subject: Re: [Qemu-devel] [PATCH v1 2/2] ide: support reporting of rotation
 rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--o8MOqjoDcxEF4nvNmIPdMnLNU2shcQQOi
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Message-ID: <a0343309-ace9-d57f-352e-507141a92178@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 2/2] ide: support reporting of rotation
 rate
References: <20171004114008.14849-1-berrange@redhat.com>
 <20171004114008.14849-3-berrange@redhat.com>
In-Reply-To: <20171004114008.14849-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/04/2017 06:40 AM, Daniel P. Berrange wrote:
> The Linux kernel will query the ATA IDENTITY DEVICE data, word 217
> to determine the rotations per minute of the disk. If this has
> the value 1, it is taken to be an SSD and so Linux sets the
> 'rotational' flag to 0 for the I/O queue and will stop using that
> disk as a source of random entropy. Other operating systems may
> also take into account rotation rate when setting up default
> behaviour.
>=20
> Mgmt apps should be able to set the rotation rate for virtualized
> block devices, based on characteristics of the host storage in use,
> so that the guest OS gets sensible behaviour out of the box. This
> patch thus adds a 'rotation-rate' parameter for 'ide-hd' device
> types.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  hw/ide/core.c             | 1 +

> +++ b/include/hw/ide/internal.h
> @@ -508,6 +508,14 @@ struct IDEDevice {
>      char *serial;
>      char *model;
>      uint64_t wwn;
> +    /*
> +     * 0x0000        - rotation rate not reported
> +     * 0x0001        - non-rotating medium (SSD)
> +     * 0x0002-0x0400 - reserved
> +     * 0x0401-0xffe  - rotations per minute

s/0xffe/0xfffe/

> +     * 0xffff        - reserved
> +     */
> +    uint16_t rotation_rate;
>  };
> =20
>  /* These are used for the error_status field of IDEBus */
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--o8MOqjoDcxEF4nvNmIPdMnLNU2shcQQOi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnVAiIACgkQp6FrSiUn
Q2omwAf/fkeVioL4nXMatq1Atf4TrXdDpVKhyaqXIAT3Kd8Y6X7L9fTDETMPC0KG
yjUG3uLLddcmyBTMYTN/jPPoJQD8gISrVdMN7YIe149RWL0otFb8cI5kefJHZRih
qNzX5SmmSD5W0Ynp3aCIEm9qK+p2k35kBxEDZplDdsilq7M9cfNX4/CJeMYEwYF/
EkIFSZL3+n+09zTre4r/Wb1BME19lUY0B26xAJ8f3/6dv/5hun8Q9ogPdy1vao0E
258Uhjr7dR2Z8q6wkDBPZrKPrkuLy6hMu34zMH0zGVAwPTaunHr2aVoLVb3FYzie
jAcdWtQPN0KZS/k0RNWtC0SKVQBCjA==
=HOLH
-----END PGP SIGNATURE-----

--o8MOqjoDcxEF4nvNmIPdMnLNU2shcQQOi--
