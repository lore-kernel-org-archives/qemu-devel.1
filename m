Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56DD2C74A41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 02:43:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 020CE20838
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 02:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="e9xzZ6i/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 020CE20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlP3k-0008Dr-55
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 22:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58503)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1hlP2l-000731-6r
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 22:42:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1hlP2j-00070V-Px
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 22:42:47 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:41557)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1hlP2i-0006vX-JD; Wed, 10 Jul 2019 22:42:45 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45kgMC0XrJz9sBt; Thu, 11 Jul 2019 12:42:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1562812951;
 bh=UQpu+QAHjm+R/KS+U53KpebtPils0QuBocfRdz+x9pk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=e9xzZ6i/70/FpbkrX6lkOF9+OuM1YMGs7XlYgrBzBa0LgmYjdTeEvHAAnUKKfJSHL
 wULNcKRspwfWTejbj5kp7qBZLYC9gfATBB7VaBZ/yHV+tbAQdVEtcxubP4EtCmvkE7
 4cRznI6DQbvVq1fwECOnD4rWszLpeMk/TpCufuqg=
Date: Thu, 11 Jul 2019 11:31:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Bharata B Rao <bharata@linux.ibm.com>
Message-ID: <20190711013100.GC13271@umbus.fritz.box>
References: <20190710060621.16430-1-bharata@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
In-Reply-To: <20190710060621.16430-1-bharata@linux.ibm.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH v0] ppc/spapr: Support reboot of secure
 pseries guest
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


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2019 at 11:36:21AM +0530, Bharata B Rao wrote:
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
> * The ioctl implementation in the kernel can be found as part of this pat=
chset:
>   https://www.spinics.net/lists/linux-mm/msg184366.html
> * Updated linux-headers/linux/kvm.h here for completeness as the
>   definition of KVM_PPC_SVM_OFF isn't yet part of upstream kernel.

The qemu change looks good to me.  To actually merge this, the support
will need to go upstream in the kernel first, then we'll need an
update-kernel-headers as a separate patch.

>=20
>  hw/ppc/spapr.c            | 1 +
>  linux-headers/linux/kvm.h | 1 +
>  target/ppc/kvm.c          | 7 +++++++
>  target/ppc/kvm_ppc.h      | 6 ++++++
>  4 files changed, 15 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 821f0d4a49..6abf71f159 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1709,6 +1709,7 @@ static void spapr_machine_reset(MachineState *machi=
ne)
>      void *fdt;
>      int rc;
> =20
> +    kvmppc_svm_off();
>      spapr_caps_apply(spapr);
> =20
>      first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> diff --git a/linux-headers/linux/kvm.h b/linux-headers/linux/kvm.h
> index c8423e760c..9603fef9bf 100644
> --- a/linux-headers/linux/kvm.h
> +++ b/linux-headers/linux/kvm.h
> @@ -1327,6 +1327,7 @@ struct kvm_s390_ucas_mapping {
>  #define KVM_PPC_GET_RMMU_INFO	  _IOW(KVMIO,  0xb0, struct kvm_ppc_rmmu_i=
nfo)
>  /* Available with KVM_CAP_PPC_GET_CPU_CHAR */
>  #define KVM_PPC_GET_CPU_CHAR	  _IOR(KVMIO,  0xb1, struct kvm_ppc_cpu_cha=
r)
> +#define KVM_PPC_SVM_OFF           _IO(KVMIO, 0xb2)
> =20
>  /* ioctl for vm fd */
>  #define KVM_CREATE_DEVICE	  _IOWR(KVMIO,  0xe0, struct kvm_create_device)
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 8a06d3171e..079d83ce6c 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2953,3 +2953,10 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int=
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
> index 98bd7d5da6..0fd80e1100 100644
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
> +	return 0;
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

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0mkVQACgkQbDjKyiDZ
s5LwWhAAzsJ1JHay2X3kqEX2gNNcDGwcsogiii5jqAt0CXumikvGr2/CMBSkRxY0
0iHB7B28RF1sUN5GL9PIijsBBoo6dHMF2Ojl1RVSwQcJTSigwoVGnsxxO4olhrTm
mmVwDU9Qf3CNbBJ4S9GtEvZrDgoKkiDLmThPyfwnJurNtACaSd5Zg4GZOmEKGcPG
aTo1nMZvKgMBjMtAIuhjIyKjUnXv+gq+FGRNg4z916neyU+70wOaxzpPjcb1On/F
0xnz79KszHK+MQEvAf7nO3vUAPBEdZLx93Zbpb8cfTf91PnrL6MBbZS2HgMolxH4
JgsmbOw/syhEZFjxi3hKS+lt3xtgwf0u0sYWfDCRRKBY6veCtBogf+32DbFeYkP0
vg6bBZTEK0Xzmc+8Uu+cb9hucCzLQ3UhxIg4dM1gvsA+sIDg9KtwlSbeweAJiSRo
i/uHcQopFazmGF2FATs0l8/pYvn6qpJdnocoEPbXejf+T7NdD3IEKvTbQ1TOULe2
xOphxk/pABF30atg9JyKPDgEQnMVooctkONG7zLlBBakybTdnP/WifrNTiX4ylDh
UHyXqhVn7Ty0cbKGmEchvRWNiWh4OLO4HpgxEKN7rGUtus1D5f1ESnICkt3RZohX
3NM+gcPGOLSXPGDIr0ZiYoY9OsT1tmNp3Hg9QK81r6WXNG/oOP4=
=kDb0
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--

