Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65400C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:46:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38F5521582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 08:46:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F5521582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihUyR-0004Bf-Ay
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 03:46:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49876)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1ihUjw-0000Fa-4G
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1ihUju-0001uh-Jy
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:31:27 -0500
Received: from 8.mo68.mail-out.ovh.net ([46.105.74.219]:35563)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1ihUju-0001sR-Cn
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 03:31:26 -0500
Received: from player761.ha.ovh.net (unknown [10.108.16.88])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id EDED9153B5A
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 09:31:23 +0100 (CET)
Received: from kaod.org (lfbn-tou-1-1227-223.w90-76.abo.wanadoo.fr
 [90.76.50.223]) (Authenticated sender: clg@kaod.org)
 by player761.ha.ovh.net (Postfix) with ESMTPSA id AACAFD6ECCCE;
 Wed, 18 Dec 2019 08:31:15 +0000 (UTC)
Subject: Re: [PATCH v3 ppc-for-5.0 2/2] ppc/spapr: Support reboot of secure
 pseries guest
To: Bharata B Rao <bharata@linux.ibm.com>, qemu-devel@nongnu.org
References: <20191218043208.28613-1-bharata@linux.ibm.com>
 <20191218043208.28613-3-bharata@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8bd76cda-ec66-4f96-3d3f-9e5b2802aa33@kaod.org>
Date: Wed, 18 Dec 2019 09:31:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191218043208.28613-3-bharata@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 16418716868425518054
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvddtkedguddvfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdeltddrjeeirdehtddrvddvfeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeeiuddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegtlhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.74.219
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
Cc: paulus@ozlabs.org, qemu-ppc@nongnu.org, linuxram@us.ibm.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/12/2019 05:32, Bharata B Rao wrote:
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
> This ioctl has no effect when invoked for a normal guest. If this ioctl
> fails for a secure guest, the guest is terminated.
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.ibm.com>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/ppc/spapr.c       |  1 +
>  target/ppc/kvm.c     | 15 +++++++++++++++
>  target/ppc/kvm_ppc.h |  6 ++++++
>  3 files changed, 22 insertions(+)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index f11422fc41..e62c89b3dd 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -1597,6 +1597,7 @@ static void spapr_machine_reset(MachineState *mac=
hine)
>      void *fdt;
>      int rc;
> =20
> +    kvmppc_svm_off(&error_fatal);
>      spapr_caps_apply(spapr);
> =20
>      first_ppc_cpu =3D POWERPC_CPU(first_cpu);
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 7406d18945..ae920ec310 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2900,3 +2900,18 @@ void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, i=
nt64_t tb_offset)
>          kvm_set_one_reg(cs, KVM_REG_PPC_TB_OFFSET, &tb_offset);
>      }
>  }
> +
> +/*
> + * Don't set error if KVM_PPC_SVM_OFF ioctl is invoked on kernels
> + * that don't support this ioctl.
> + */
> +void kvmppc_svm_off(Error **errp)
> +{
> +    int rc;
> +    KVMState *s =3D KVM_STATE(current_machine->accelerator);
> +
> +    rc =3D kvm_vm_ioctl(s, KVM_PPC_SVM_OFF);
> +    if (rc && rc !=3D -ENOTTY) {
> +        error_setg(errp, "KVM_PPC_SVM_OFF ioctl failed");
> +    }
> +}
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 47b08a4030..9a9bca1b72 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -37,6 +37,7 @@ int kvmppc_booke_watchdog_enable(PowerPCCPU *cpu);
>  target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
>                                       bool radix, bool gtse,
>                                       uint64_t proc_tbl);
> +void kvmppc_svm_off(Error **errp);
>  #ifndef CONFIG_USER_ONLY
>  bool kvmppc_spapr_use_multitce(void);
>  int kvmppc_spapr_enable_inkernel_multitce(void);
> @@ -201,6 +202,11 @@ static inline target_ulong kvmppc_configure_v3_mmu=
(PowerPCCPU *cpu,
>      return 0;
>  }
> =20
> +static inline void kvmppc_svm_off(Error **errp)
> +{
> +    return;
> +}
> +
>  static inline void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu,
>                                               unsigned int online)
>  {
>=20


