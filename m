Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72995C742A5
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 06:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 449BD20863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 06:47:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="I/i51U5Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 449BD20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlpKp-0004O6-TL
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 02:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54084)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hlpKO-0002z8-If
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hlpKM-0004DA-Pt
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:46:44 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:44131 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hlpKI-00047G-PS; Fri, 12 Jul 2019 02:46:41 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45lNkC0rZ7z9s8m; Fri, 12 Jul 2019 16:46:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562913987;
 bh=FwNp8ibIuNsKhWXCMwA4DZ4zzrmmE39fQjSCRrTr/VY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=I/i51U5QMJRJdpp5rprhX2WOKQ9pUHKj2C8uks9oFANPVcnZ7sVUrFAsD9WyAqWub
 zGn9lfFMaChEDhwDPEsoFkAGMb2IqIdOHIz6MAQW2p/nQuyDevSca/3JRwcVIPpL6/
 j2dudMSRH3zZ4qeEDsqUnM7KJNvbYSW1X7T2fsRo=
Date: Fri, 12 Jul 2019 16:40:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Message-ID: <20190712064027.GF2561@umbus.fritz.box>
References: <20190712011934.29863-1-mdroth@linux.vnet.ibm.com>
 <20190712011934.29863-2-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Content-Disposition: inline
In-Reply-To: <20190712011934.29863-2-mdroth@linux.vnet.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [PATCH 1/2] docs/specs: initial spec summary for
 Ultravisor-related hcalls
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
Cc: linuxram@us.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2019 at 08:19:33PM -0500, Michael Roth wrote:
> For now this only covers hcalls relating to TPM communication since
> it's the only one particularly important from a QEMU perspective atm,
> but others can be added here where it makes sense.
>=20
> The full specification for all hcalls/ucalls will eventually be made
> available in the public/OpenPower version of the PAPR specification.
>=20
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>

Thanks for adding this documentation.  Is there a PAPR extension
proposal which covers this, which we could cite as the source?

> ---
>  docs/specs/ppc-spapr-uv-hcalls.txt | 74 ++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 docs/specs/ppc-spapr-uv-hcalls.txt
>=20
> diff --git a/docs/specs/ppc-spapr-uv-hcalls.txt b/docs/specs/ppc-spapr-uv=
-hcalls.txt
> new file mode 100644
> index 0000000000..0278f89190
> --- /dev/null
> +++ b/docs/specs/ppc-spapr-uv-hcalls.txt
> @@ -0,0 +1,74 @@
> +On PPC64 systems supporting Protected Execution Facility (PEF), system
> +memory can be placed in a secured region where only an "ultravisor"
> +running in firmware can provide to access it. pseries guests on such
> +systems can communicate with the ultravisor (via ultracalls) to switch t=
o a
> +secure VM mode (SVM) where the guest's memory is relocated to this secur=
ed
> +region, making its memory inaccessible to normal processes/guests runnin=
g on
> +the host.
> +
> +The various ultracalls/hypercalls relating to SVM mode are currently
> +only documented internally, but are planned for direct inclusion into the
> +public OpenPOWER version of the PAPR specification (LoPAPR/LoPAR). An in=
ternal
> +ACR has been filed to reserve a hypercall number range specific to this
> +use-case to avoid any future conflicts with the internally-maintained PA=
PR
> +specification. This document summarizes some of these details as they re=
late
> +to QEMU.
> +
> +=3D=3D hypercalls needed by the ultravisor =3D=3D
> +
> +Switching to SVM mode involves a number of hcalls issued by the ultravis=
or
> +to the hypervisor to orchestrate the movement of guest memory to secure
> +memory and various other aspects SVM mode. The below documents the hcalls
> +relevant to QEMU.
> +
> +- H_TPM_COMM (0xef10)
> +
> +  For TPM_COMM_OP_EXECUTE operation:
> +    Send a request to a TPM and receive a response, opening a new TPM se=
ssion
> +    if one has not already been opened.
> +
> +  For TPM_COMM_OP_CLOSE_SESSION operation:
> +    Close the existing TPM session, if any.
> +
> +  Arguments:
> +
> +    r3 : H_TPM_COMM (0xef10)
> +    r4 : TPM operation, one of:
> +         TPM_COMM_OP_EXECUTE (0x1)
> +         TPM_COMM_OP_CLOSE_SESSION (0x2)
> +    r5 : in_buffer, guest physical address of buffer containing the requ=
est
> +         - Caller may use the same address for both request and response
> +    r6 : in_size, size of the in buffer, must
> +         - Must be less than or equal to 4KB
> +    r7 : out_buffer, guest physical address of buffer to store the respo=
nse
> +         - Caller may use the same address for both request and response
> +    r8 : out_size, size of the out buffer
> +         - Must be at least 4KB, as this is the maximum request/response=
 size
> +           supported by most TPM implementations, including the TPM Reso=
urce
> +           Manager in the linux kernel.
> +
> +  Return values:
> +
> +    r3 : H_Success    request processed successfully
> +         H_PARAMETER  invalid TPM operation
> +         H_P2         in_buffer is invalid
> +         H_P3         in_size is invalid
> +         H_P4         out_buffer is invalid
> +         H_P5         out_size is invalid
> +         H_RESOURCE   TPM is unavailable
> +    r4 : For TPM_COMM_OP_EXECUTE, the size of the response will be store=
d here
> +         upon success.
> +
> +  Use-case/notes:
> +
> +    SVM filesystems are encrypted using a symmetric key. This key is then
> +    wrapped/encrypted using the public key of a trusted system which has=
 the
> +    private key stored in the system's TPM. An Ultravisor will use this
> +    hcall to unwrap/unseal the symmetric key using the system's TPM devi=
ce
> +    or a TPM Resource Manager associated with the device.
> +
> +    The Ultravisor sets up a separate session key with the TPM in advance
> +    during host system boot. All sensitive in and out values will be
> +    encrypted using the session key. Though the hypervisor will see the =
'in'
> +    and 'out' buffers in raw form, any sensitive contents will generally=
 be
> +    encrypted using this session key.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0oK1cACgkQbDjKyiDZ
s5LkYQ/+LTyKhwqD05nQ0LDKUkC26mmtz2F7BXtkrmVHylLz2HM4WyUdcOpa8jFY
wRENkaZ7Od7it2C/LH/2uwdxrm5aTZemXOuSOFfuyT4M9bNy4o1XnQf4iiRHt6WF
jglwpBy4DIBZMHuLK67KFXiM/Qe0Gdr/OCsSboELUcQIUgzLUjaHetm4Crx5nWE9
fClbIb9EcyjC8v7XQye5dHEbT97/x2ixpMlr0XjOk3e95g+x/Fbi+cEQCws/PSGS
z2gHeG+FvSwwpGDUZxaGJYGFPswO48kmftbYxWn3K1g+cAfI2w8TARx7f8ZAky1O
XLBwfw6y32zatQ0lchOjKfHi2LYbnpjvvfvjB2m02VUVTkfvN8rQynUR50JWWGfS
2K5az65xp9xd5CMzCKpf3G/598+1GDm8wQtT60+5GN7V5NbU0g1bdILST22JFTGy
Gmew64TLigH5wRvvn6i/XFrSG/7JB3UD2qzEAzLtK0etLzXGSREf6R42mSddiO7l
b1Z6X3RRnA85wWEr1/OUZYrvHkoh19Z/GUut6SSbCKN8be44J+S5LkGRB0cm4jOQ
8ETq6dHSGDT6c8v0ilYtBzyPG0N8XfYWq+tK7oTVLtnO4qIOHg+uwbzYRWbWogQl
hnhv3JP0curKnffGvx0NHPjpXIw9/oGyEnSJCbDjUDhAeUKrYPw=
=bEVl
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--

