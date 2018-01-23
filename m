Received: from eggs.gnu.org ([2001:4830:134:3::10]:38262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ee3z0-0001Dw-Qe
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 14:11:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ee3yw-00071F-Qc
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 14:11:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1ee3yw-00070Q-HP
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 14:11:42 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6C8F68553F
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 19:11:41 +0000 (UTC)
References: <20180123164718.12714-1-berrange@redhat.com>
	<20180123164718.12714-2-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <574ca3f0-b30e-a3de-b9ee-c49c756e30c1@redhat.com>
Date: Tue, 23 Jan 2018 13:11:30 -0600
MIME-Version: 1.0
In-Reply-To: <20180123164718.12714-2-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XpnCIryuhAicND8xiRNLxMMrJAeNvUaVK"
Subject: Re: [Qemu-devel] [PATCH v1 1/2] Revert "build-sys: silence make by
 default or V=0"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XpnCIryuhAicND8xiRNLxMMrJAeNvUaVK
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Message-ID: <574ca3f0-b30e-a3de-b9ee-c49c756e30c1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 1/2] Revert "build-sys: silence make by
 default or V=0"
References: <20180123164718.12714-1-berrange@redhat.com>
 <20180123164718.12714-2-berrange@redhat.com>
In-Reply-To: <20180123164718.12714-2-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/23/2018 10:47 AM, Daniel P. Berrange wrote:
> This reverts commit 42a77f1ce4934b243df003f95bda88530631387a.
>=20
> The primary intention of this change was to silence messages
> like
>=20
>   make[1]: '/home/berrange/src/virt/qemu/capstone/libcapstone.a' is up =
to date.
>=20
> which we get when calling make recursively with explicit
> targets.
>=20
> The problem is that this change affected every make target,
> not merely the targets that triggered these "is up to date"
> messages. As a result any targets that were not invoking
> commands via "$(call quiet-command ...)" suddenly become
> silent. This is particularly bad for "make install" which
> now appears todo nothing.
>=20
> Rather than go through every make rule and try to identify
> places where we now need to explicitly print a message to
> show work taking place, just revert the change.
>=20
> To address the original problem of silencing "is up to date"
> messages, we simply add --quiet to the SUBDIR_MAKEVARS
> variable, so it only affects us on recursive make calls.

As for solving the original intended issue, this patch silences the
message about libcapstone, and reverting back to a known state is more
conservative, so I'm okay with this going in.

Tested-by: Eric Blake <eblake@redhat.com>


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--XpnCIryuhAicND8xiRNLxMMrJAeNvUaVK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpniOIACgkQp6FrSiUn
Q2qg3Qf/cCINfMJQQDdsHxWF19jnlRgpSVlJZm/XTWsXpt8w7sypX2PD33Ea80aK
o7R8WZHRn89gmxvB/NDQL60e9/2yE4VtohsBXiqolbT/qjGnpd3McV3o7YKshWUk
TnVMmDaGKTqVL7LNwTdzvKRUYbbkemGoMkI/ywZ74EpuXzHYPNG9GPpw5MkpIeAs
q8TB8uwYHTFmlGkW6p7+bNYFIpPkKUZ5vExUvv5c6WJ8xEVPD6t4tAqtVlMpvnx2
o9FWAukzoxmbCwrCpfNgnkpP5fcgvBTbxPyx9ufX+n0Nu9fSOSJEKFWOL9acHvqc
IsLku2iabmc408VQD2H93AZkj1TGvg==
=RLfP
-----END PGP SIGNATURE-----

--XpnCIryuhAicND8xiRNLxMMrJAeNvUaVK--
