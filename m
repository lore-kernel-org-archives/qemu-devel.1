Received: from eggs.gnu.org ([2001:4830:134:3::10]:45923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYZPZ-0005rJ-9l
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYZPT-0002Qq-Fc
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:00:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49844)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dYZPT-0002Pj-6a
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 11:00:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D808D804E3
	for <qemu-devel@nongnu.org>; Fri, 21 Jul 2017 15:00:05 +0000 (UTC)
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
	<1500645206-13559-7-git-send-email-armbru@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c092a949-fd51-93a2-c94a-bed10697efaa@redhat.com>
Date: Fri, 21 Jul 2017 10:00:02 -0500
MIME-Version: 1.0
In-Reply-To: <1500645206-13559-7-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TpnceI6S6a1McjNlPDKmdDIFD7DF0jAMx"
Subject: Re: [Qemu-devel] [PATCH 6/9] tests/libqos/pci: Clean up string
 interpolation into QMP input
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
--TpnceI6S6a1McjNlPDKmdDIFD7DF0jAMx
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <c092a949-fd51-93a2-c94a-bed10697efaa@redhat.com>
Subject: Re: [PATCH 6/9] tests/libqos/pci: Clean up string interpolation into
 QMP input
References: <1500645206-13559-1-git-send-email-armbru@redhat.com>
 <1500645206-13559-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1500645206-13559-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/21/2017 08:53 AM, Markus Armbruster wrote:
> Leaving interpolation into JSON to qmp() is more robust than building
> QMP input manually, as explained in the commit before previous.
>=20
> The case in qpci_plug_device_test() is a bit complicated: it
> interpolates several JSON object members, not just a value.  Clean it
> up by passing them in as QDict rather than string, so we can leave
> interpolation to qmp() here and to qobject_from_jsonf() in callers.
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---

>=20
> +    response =3D qmp("{'execute': 'device_add', 'arguments': %p }", ar=
gs);
> +

I like this; in fact, in my earlier series attempting to remove
qobject_from_jsonf(), I heavily relied on %p being useful, to the point
that I even added a helper function to make it easier (off-hand, it was
something like qmp_execute(const char *command, QDict *arguments))

> @@ -674,6 +676,7 @@ static void pci_hotplug(void)
>      if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=3D=
 0) {
>          qpci_unplug_acpi_device_test("drv1", PCI_SLOT_HP);
>      }
> +
>      qtest_shutdown(qs);

Spurious whitespace addition?

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TpnceI6S6a1McjNlPDKmdDIFD7DF0jAMx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAllyFvMACgkQp6FrSiUn
Q2q+/Af+K8Tva1MPpWoA3TSv4VAQVQttSSJf99wUxopuFep37mRGyH2PV0s/uQRO
QmrAa8132+gO8dPJII+9uJU2cXrMXQNuAI1K7lZlyXULHbjVvvdDholTp1zAV6/P
rPWiWOq826bANugcKM7aFHoUXQOHNixKowHAhXbeAZmr1FIo4GjjF8dJ0a6IiT5d
bFWSkG8VsmGP6ozm5M490zEyqT5RZLpyg9ayt1qq2yJYxDUvcutwMnCn4dbB3jWP
4KZ8h+7MPPS93X7NNkqbw/5dG9KoEwmzc0Urs2PiU9CZVT9lHRHj3RP0reb2/sbm
bO6+quNdimCZdXwplVdbmeGa26QP6Q==
=/gM5
-----END PGP SIGNATURE-----

--TpnceI6S6a1McjNlPDKmdDIFD7DF0jAMx--
