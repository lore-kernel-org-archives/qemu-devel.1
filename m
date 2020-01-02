Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCC4C3276C
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 07:43:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA04E21655
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 07:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="etVKSjZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA04E21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37827 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imv8O-0000YL-12
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 02:43:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35677)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1imv7g-0008QJ-05
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 02:42:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1imv7e-000828-Cq
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 02:42:23 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:50331)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1imv7d-0007l2-Cv; Thu, 02 Jan 2020 02:42:22 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47pKkG37gGz9sRV; Thu,  2 Jan 2020 18:42:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1577950934;
 bh=idxKJmxb6qkPy7f5JDBONeOB/I16z0+STcnRJy7TWIQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=etVKSjZPhD21ukainL3/VQO9FEMkEyIPniPhGhjoeYZeitKe8TEocim9l3g0/nuTq
 /ZUPT0QC9i9uPOmfNe6Bx0dhaieDR3ShQvBMQ5yLxSa+w6AePhXghCUNNfgAAYr9QT
 +NjzJLG1Ut69zctS2mBCzajCo6ArW+Zup2CURxFA=
Date: Thu, 2 Jan 2020 16:52:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH ppc-for-5.0 1/1] ppc/spapr: Don't call KVM_SVM_OFF ioctl
 on TCG
Message-ID: <20200102055255.GK2098@umbus>
References: <20200102054155.13175-1-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="q6mBvMCt6oafMx9a"
Content-Disposition: inline
In-Reply-To: <20200102054155.13175-1-bharata@linux.ibm.com>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--q6mBvMCt6oafMx9a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 02, 2020 at 11:11:55AM +0530, Bharata B Rao wrote:
> Invoking KVM_SVM_OFF ioctl for TCG guests will lead to a QEMU crash.
> Fix this by ensuring that we don't call KVM_SVM_OFF ioctl on TCG.
>=20
> Reported-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> Fixes: 4930c1966249 ("ppc/spapr: Support reboot of secure pseries guest")
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>

Applied to ppc-for-5.0, thanks.

> ---
>  target/ppc/kvm.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index b64916dc37..ae2f3c57c0 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2902,9 +2902,12 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int=
64_t tb_offset)
>  void kvmppc_svm_off(Error **errp)
>  {
>      int rc;
> -    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> =20
> -    rc =3D kvm_vm_ioctl(s, KVM_PPC_SVM_OFF);
> +    if (!kvm_enabled()) {
> +        return;
> +    }
> +
> +    rc =3D kvm_vm_ioctl(KVM_STATE(current_machine->accelerator), KVM_PPC=
_SVM_OFF);
>      if (rc && rc !=3D -ENOTTY) {
>          error_setg_errno(errp, -rc, "KVM_PPC_SVM_OFF ioctl failed");
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--q6mBvMCt6oafMx9a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl4NhTUACgkQbDjKyiDZ
s5KAyQ//S7ShIwx/8/DMNthLNIpGe/im1A+XeT79jZxBGr1miX/Yq+pg7MmtaaHG
xgseNwDJtu+XLLPaph6Bq3CuLM1Wa7BnjIaGmTXbxQ/px6tINAQsbjM3YLA1vBf8
cnsNDc0dL/seYFrJdDPUObMLYrqQMixsmHB+5cPgfopS/N4Im28J3ugZChLIRXTz
+JJbx4k3H3WKu776VnyFmA388NsVOUdIgOPgGzznayr+NqGeib/dyXCgLaCAADYa
kZxWz6vnV8HHwTmKzjvO3T7DD5xUFzmXfud+LmqOs7AerssRnICzn2PmlEuFR0s5
vKzaCFyDd76CRcRdFFUpJqChnr/nUtRdg7Ohch2L2iOskNRDE7qGSDj32LEPi6kN
GaELoflen0XW4jsheht1J+QaYCdlmwTpfBdsiKvN6D1XsLjtwb6tyW4e8LzLRg6n
qQMbtvLB+1dDPrizE135uedqCwRJnchS3koJNjf83zXsXJ51Gl+F+XLTU6iOpvQB
ASCZJWbLYS7PLW+5mh+lH/36onHApqxO+pMUVEorYtSUBjfoAJiNfKxlQfjhvbgz
f5BSX7nwKZLUtYr0PAer3zhkT/O5ri6yzAvEsuXz6N6hCJNvS1VwSIKkfc/9SZGC
UEpbHg5EcyX6iNUDVuOw4UBsGZP2ifHsrVu3N30ANJN3R51A6Gw=
=hyNb
-----END PGP SIGNATURE-----

--q6mBvMCt6oafMx9a--

