Received: from eggs.gnu.org ([2001:4830:134:3::10]:41549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daLDF-0002fH-Bb
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:14:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1daLDB-0007h2-41
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:14:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1daLDA-0007gK-Tb
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 08:14:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 076DFC0B2C52
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 12:14:44 +0000 (UTC)
References: <20170726115637.21558-1-kraxel@redhat.com>
	<20170726115637.21558-3-kraxel@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <bb3e5891-04de-0afd-84a7-42e3a4e2a20c@redhat.com>
Date: Wed, 26 Jul 2017 07:14:38 -0500
MIME-Version: 1.0
In-Reply-To: <20170726115637.21558-3-kraxel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hfnb0fQ1jJh8JTAwkroogrWVmVqV620j9"
Subject: Re: [Qemu-devel] [PATCH 2/5] ui: move qemu_input_linux_to_qcode()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hfnb0fQ1jJh8JTAwkroogrWVmVqV620j9
From: Eric Blake <eblake@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Message-ID: <bb3e5891-04de-0afd-84a7-42e3a4e2a20c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/5] ui: move qemu_input_linux_to_qcode()
References: <20170726115637.21558-1-kraxel@redhat.com>
 <20170726115637.21558-3-kraxel@redhat.com>
In-Reply-To: <20170726115637.21558-3-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/26/2017 06:56 AM, Gerd Hoffmann wrote:
> Move from input-linux.c to input-keymap.c and export it,
> so the function is available elsewhere too.
>=20
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  include/ui/input.h |   1 +
>  ui/input-keymap.c  | 115 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  ui/input-linux.c   | 113 ---------------------------------------------=
-------
>  3 files changed, 116 insertions(+), 113 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--hfnb0fQ1jJh8JTAwkroogrWVmVqV620j9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAll4h68ACgkQp6FrSiUn
Q2r4zAf/TZzgCJsIOKT1jKX8EGbLAnsHKMgedO1y/+wJcIAgMFapGZhGl+8NFq9+
E3KNLQM8zt8nnCA5XjwxeQPMdtD26g8Jk1Y/8g3hIyH2PV5iuk9XRazruRzy6h8U
9Gh/WCIDPJIZP+VjWy1+movHJDDxfj8zKyBPF+SQDrHCq+OC8Rl2AyHz6HccGB8P
Cl3dt1ciKXIRysAHDXeUDeV+02KEQyEaGsL7XRA6bY0kclPwsE3JZUgI9JG0O6HP
gAkv2WHJbmeBBSAiHUes0fCjc1+6kXoeQ8XfRleFn0XQ1IFR+xt2RDiK6d0/NT1f
eXiiPn0DYtcqQkmtCayV8NvOqfaEeA==
=DMUL
-----END PGP SIGNATURE-----

--hfnb0fQ1jJh8JTAwkroogrWVmVqV620j9--
