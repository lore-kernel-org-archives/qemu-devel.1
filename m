Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2006C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 21:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92368217D7
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 21:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="OxWFiomw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92368217D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSSdd-0002M9-Kq
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 16:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52627)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iSScp-0001vD-GO
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 16:14:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iSScn-0002aY-EC
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 16:13:58 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:60559 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iSScm-0002VA-AV; Wed, 06 Nov 2019 16:13:57 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 477fQz4vsjz9sPK; Thu,  7 Nov 2019 08:13:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1573074827;
 bh=JWL0M5EexUUQDSCwFbFi2MIKcLtbhoQzRHfovQ1nlMM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OxWFiomwGTn0f9v2Qj9rQe1ee7+4Y2wqc5dirds6sLjcPkZIjRy0ILRdr1j8WRUKV
 eueisM4Cp20XxiowcKkqgkaGLJY121Lus4qtZlc0ZeW0d2An4TlQ5ywUMS9phJ+faK
 HOqDho42hpLWq1fUIj8cYD8PBGe6iqHx8bfsUXRY=
Date: Wed, 6 Nov 2019 22:12:36 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PATCH] global: Squash 'the the'
Message-ID: <20191106211236.GL3552@umbus.metropole.lan>
References: <20191104185202.102504-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NzNDI+ywLU1Yk1Ay"
Content-Disposition: inline
In-Reply-To: <20191104185202.102504-1-dgilbert@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, sstabellini@kernel.org, qemu-trivial@nongnu.org,
 mjt@tls.msk.ru, qemu-devel@nongnu.org, laurent@vivier.eu,
 marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NzNDI+ywLU1Yk1Ay
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 04, 2019 at 06:52:02PM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> 'the' has a tendency to double up; squash them back down.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  disas/libvixl/vixl/invalset.h       | 2 +-
>  docs/interop/pr-helper.rst          | 2 +-


>  docs/specs/ppc-spapr-hotplug.txt    | 2 +-
>  docs/specs/ppc-xive.rst             | 2 +-

These two,
Acked-by: David Gibson <david@gibson.dropbear.id.au>


>  docs/specs/tpm.txt                  | 2 +-
>  include/hw/xen/interface/io/blkif.h | 2 +-
>  scripts/dump-guest-memory.py        | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)

>=20
> diff --git a/disas/libvixl/vixl/invalset.h b/disas/libvixl/vixl/invalset.h
> index ffdc0237b4..ef5e49d6fe 100644
> --- a/disas/libvixl/vixl/invalset.h
> +++ b/disas/libvixl/vixl/invalset.h
> @@ -102,7 +102,7 @@ template<TEMPLATE_INVALSET_P_DECL> class InvalSet {
>    size_t size() const;
> =20
>    // Returns true if no elements are stored in the set.
> -  // Note that this does not mean the the backing storage is empty: it c=
an still
> +  // Note that this does not mean the backing storage is empty: it can s=
till
>    // contain invalid elements.
>    bool empty() const;
> =20
> diff --git a/docs/interop/pr-helper.rst b/docs/interop/pr-helper.rst
> index 9f76d5bcf9..e926f0a6c9 100644
> --- a/docs/interop/pr-helper.rst
> +++ b/docs/interop/pr-helper.rst
> @@ -10,7 +10,7 @@ can delegate implementation of persistent reservations =
to an external
>  restricting access to block devices to specific initiators in a shared
>  storage setup.
> =20
> -For a more detailed reference please refer the the SCSI Primary
> +For a more detailed reference please refer to the SCSI Primary
>  Commands standard, specifically the section on Reservations and the
>  "PERSISTENT RESERVE IN" and "PERSISTENT RESERVE OUT" commands.
> =20
> diff --git a/docs/specs/ppc-spapr-hotplug.txt b/docs/specs/ppc-spapr-hotp=
lug.txt
> index cc7833108e..859d52cce6 100644
> --- a/docs/specs/ppc-spapr-hotplug.txt
> +++ b/docs/specs/ppc-spapr-hotplug.txt
> @@ -385,7 +385,7 @@ Each LMB list entry consists of the following element=
s:
>    is used to retrieve the right associativity list to be used for this
>    LMB.
>  - A 32bit flags word. The bit at bit position 0x00000008 defines whether
> -  the LMB is assigned to the the partition as of boot time.
> +  the LMB is assigned to the partition as of boot time.
> =20
>  ibm,dynamic-memory-v2
> =20
> diff --git a/docs/specs/ppc-xive.rst b/docs/specs/ppc-xive.rst
> index 148d57eb6a..83d43f658b 100644
> --- a/docs/specs/ppc-xive.rst
> +++ b/docs/specs/ppc-xive.rst
> @@ -163,7 +163,7 @@ Interrupt Priority Register (PIPR) is also updated us=
ing the IPB. This
>  register represent the priority of the most favored pending
>  notification.
> =20
> -The PIPR is then compared to the the Current Processor Priority
> +The PIPR is then compared to the Current Processor Priority
>  Register (CPPR). If it is more favored (numerically less than), the
>  CPU interrupt line is raised and the EO bit of the Notification Source
>  Register (NSR) is updated to notify the presence of an exception for
> diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
> index 5d8c26b1ad..9c8cca042d 100644
> --- a/docs/specs/tpm.txt
> +++ b/docs/specs/tpm.txt
> @@ -89,7 +89,7 @@ TPM upon reboot. The PPI specification defines the oper=
ation requests and the
>  actions the firmware has to take. The system administrator passes the op=
eration
>  request number to the firmware through an ACPI interface which writes th=
is
>  number to a memory location that the firmware knows. Upon reboot, the fi=
rmware
> -finds the number and sends commands to the the TPM. The firmware writes =
the TPM
> +finds the number and sends commands to the TPM. The firmware writes the =
TPM
>  result code and the operation request number to a memory location that A=
CPI can
>  read from and pass the result on to the administrator.
> =20
> diff --git a/include/hw/xen/interface/io/blkif.h b/include/hw/xen/interfa=
ce/io/blkif.h
> index 8b1be50ce8..d07fa1e078 100644
> --- a/include/hw/xen/interface/io/blkif.h
> +++ b/include/hw/xen/interface/io/blkif.h
> @@ -341,7 +341,7 @@
>   *      access (even when it should be read-only). If the frontend hits =
the
>   *      maximum number of allowed persistently mapped grants, it can fal=
lback
>   *      to non persistent mode. This will cause a performance degradatio=
n,
> - *      since the the backend driver will still try to map those grants
> + *      since the backend driver will still try to map those grants
>   *      persistently. Since the persistent grants protocol is compatible=
 with
>   *      the previous protocol, a frontend driver can choose to work in
>   *      persistent mode even when the backend doesn't support it.
> diff --git a/scripts/dump-guest-memory.py b/scripts/dump-guest-memory.py
> index 2c587cbefc..9371e45813 100644
> --- a/scripts/dump-guest-memory.py
> +++ b/scripts/dump-guest-memory.py
> @@ -170,7 +170,7 @@ class ELF(object):
>          self.ehdr.e_phnum +=3D 1
> =20
>      def to_file(self, elf_file):
> -        """Writes all ELF structures to the the passed file.
> +        """Writes all ELF structures to the passed file.
> =20
>          Structure:
>          Ehdr

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--NzNDI+ywLU1Yk1Ay
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3DN0EACgkQbDjKyiDZ
s5JQyA//YrFSfw89W2oYCPQGUXaHEmhQndS8XGke6N+vRWH0pxmrFPO2ytqnUo/7
GgMHfQXBqJM2I2oUAZRg/MLNpa4Ki404Vuotd6zzcjhd3s2f3/sVlZjGVnTN2w56
ySOUrCcTxdHajMIJ+jwAT0LI2uR6luaxCx0Urfm1Y0CDzwCysDyq1mPdNYyniwoz
M/wVAUn0rRIqvYy6ckDJ4OXd7xQxll6Je0iCo91pzN5teWJWOy4gNyuTF6t0Oe7X
H8aXeCIQ+ndamqzD3eDXf9UhBjmgeqZfr9R1ijd0Jy35NDe0Ipbq1bYDDF9EASJc
6Xhulqpi+xvfXP1mzFNW77DT6q9mOTbHDjgS29S7/Y3ykQZg8lLndS/ZoSs6hjZJ
+HSSp1Wc2sMjLY2vxbvgocU6ZGutkEE/2GjnEnzLe8Cub6QEylvfb9bDr89r5HKd
2SR3hd0lrptrGBzTddMZnXjdLMWSiB2QFuNcAhGmwjmUC/yUV1fII7xew74spX0B
TVVCn1d/aYIvd07ldBev+RMWRAdE8qSTbAj75MrZlGFAccvDuWJEV8zvI1MdVMQy
hzlH2j40NsodaDcaVe+H2CSEhm5WFiE3Y0oN7VBVJobjtrOzcM4mo95wZnsA2k0F
+4wCkmALu1eUoWpOeAws5ZkgH5IQjnkBE+XbDHk1WJkr6bzQnNY=
=AViM
-----END PGP SIGNATURE-----

--NzNDI+ywLU1Yk1Ay--

