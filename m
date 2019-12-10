Return-Path: <SRS0=2P1T=2A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB66C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 03:29:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B6D206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2019 03:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="nLGVfc6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B6D206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieWDi-0005Bv-Ji
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 22:29:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53545)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1ieWCw-0004Kf-2m
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 22:29:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1ieWCu-00046O-K9
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 22:29:05 -0500
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:36343 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1ieWCt-00042k-KP; Mon, 09 Dec 2019 22:29:04 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47X5Bd1wbsz9sRH; Tue, 10 Dec 2019 14:28:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1575948537;
 bh=gGYyRP7Z1SDDi9c/C1rgZVkGuXX3P3A1T7SqFDs5UH4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nLGVfc6qvaMPoAyqbf0wTtSbzae/uJ76cWW76B/nl/QbIjBRNqXwZI8jzFyuoIADR
 Keyw2pZxFSeOSegtd0tFPU4g9/AdWDdlwFK8hHafKh1jIsN7xv+vV4NZ2JQJ97rrvt
 48FbTsv1t9zilcZ2ksHLZqkY5VV+kPepHdipjpkw=
Date: Tue, 10 Dec 2019 14:28:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Bharata B Rao <bharata@linux.ibm.com>
Subject: Re: [PATCH v1 ppc-for-5.0 2/2] ppc/spapr: Support reboot of secure
 pseries guest
Message-ID: <20191210032851.GC207300@umbus.fritz.box>
References: <20191209070012.14766-1-bharata@linux.ibm.com>
 <20191209070012.14766-3-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <20191209070012.14766-3-bharata@linux.ibm.com>
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
Cc: linuxram@us.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2019 at 12:30:12PM +0530, Bharata B Rao wrote:
> A pseries guest can be run as a secure guest on Ultravisor-enabled
> POWER platforms. When such a secure guest is reset, we need to
> release/reset a few resources both on ultravisor and hypervisor side.
> This is achieved by invoking this new ioctl KVM_PPC_SVM_OFF from the
> machine reset path.
>=20
> As part of this ioctl, the secure guest is essentially transitioned
> back to normal mode so that it can reboot like a regular guest and
> become secure again.
>=20
> This ioctl has no effect when invoked for a normal guest.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>
> ---
>  hw/ppc/spapr.c       | 1 +
>  target/ppc/kvm.c     | 7 +++++++
>  target/ppc/kvm_ppc.h | 6 ++++++
>  3 files changed, 14 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f11422fc41..4c7ad3400d 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1597,6 +1597,7 @@ static void spapr_machine_reset(MachineState *machi=
ne)
>      void *fdt;
>      int rc;
> =20
> +    kvmppc_svm_off();

If you're going to have this return an error value, you should really
check it here.

>      spapr_caps_apply(spapr);
> =20
>      first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 7406d18945..1a86fa4f0c 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2900,3 +2900,10 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int=
64_t tb_offset)
>          kvm_set_one_reg(cs, KVM_REG_PPC_TB_OFFSET, &tb_offset);
>      }
>  }
> +
> +int kvmppc_svm_off(void)
> +{
> +    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> +
> +    return kvm_vm_ioctl(s, KVM_PPC_SVM_OFF);
> +}
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 47b08a4030..5cc812e486 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -37,6 +37,7 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
>  target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
>                                       bool radix, bool gtse,
>                                       uint64_t proc_tbl);
> +int kvmppc_svm_off(void);
>  #ifndef CONFIG_USER_ONLY
>  bool kvmppc_spapr_use_multitce(void);
>  int kvmppc_spapr_enable_inkernel_multitce(void);
> @@ -201,6 +202,11 @@ static inline target_ulong kvmppc_configure_v3_mmu(P=
owerPCCPU *cpu,
>      return 0;
>  }
> =20
> +static inline int kvmppc_svm_off(void)
> +{
> +    return 0;
> +}
> +
>  static inline void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu,
>                                               unsigned int online)
>  {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3vEPMACgkQbDjKyiDZ
s5KEWg/6Askq4DWnesqxCiJuHr2TLbEVW9jedcxtbs3JWeQQ0YdFuDobt46zAVf7
K4aXNqQigkWV2WlG/8mNLOjym2G+5Eb6crDzurv8BryzWksMXuth1vxugayMuvUS
CdcjiNeAwI06TYJqXQDFWGkhTMxzUzqe9TW+NhbsWmiUU9yOLPMQrwGgBF3okF+s
TwfmxLQ0QcPaDOn7R9fPanfhbCYbTOdOLQmmmRWWyaO6FBUKShwTiFBGHlotPWEw
pQbH/6AHsgVbfzttHntHkjA392d7Ys1mRJRRe9YbJIcYYziC2HRaNYE0L1tEjZ+P
5sBGDxsmeXaj1x64d66ys95343Zt8D+RB53Qs6Q1zO5upUW3maBjzgrolCKbpFbg
9C7adSrsPHN/jxI+CD3kKcP92aaohx7Y9Ji2U3iJ1vRFFuEGhDSbIcdgg60YOJaU
pNaTKdH3UCBH9/IaAZ8ZuDM8ojW73lkTnwWbeKNNf4yXHKk+MkV8H7gtWJEJiLUF
ShY01DC9I1rIr37F/N6DEKO1zSs5PNTrjRklw2NJGurwXV0tTW+uMSws18aCHEpn
4IidWoTd2riyMkQEUELfg0VybPt8UKva0GLe6IwHQavrQBYPeGPe46fXlmQfw84X
wncKZ30mQRTiqgTBCMKeQaTkYCRompYWQrr8vk2MpQsDVGLutVw=
=HI9K
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--

