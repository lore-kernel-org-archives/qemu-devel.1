Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0959CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:18:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54D32083E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 08:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54D32083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ5ep-0006RP-JR
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 04:18:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iQ5cz-0005RT-Hn
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iQ5cy-00016p-8N
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:16:21 -0400
Received: from 11.mo4.mail-out.ovh.net ([46.105.34.195]:58544)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iQ5cy-0000M8-2F
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 04:16:20 -0400
Received: from player734.ha.ovh.net (unknown [10.108.57.53])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 568AF20DFC1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 09:16:07 +0100 (CET)
Received: from kaod.org (unknown [91.217.168.176])
 (Authenticated sender: groug@kaod.org)
 by player734.ha.ovh.net (Postfix) with ESMTPSA id D7B24B86F47D;
 Thu, 31 Oct 2019 08:15:58 +0000 (UTC)
Date: Thu, 31 Oct 2019 09:15:56 +0100
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] spapr/kvm: Set default cpu model for all machine classes
Message-ID: <20191031091556.1c25fbe1@bahia.lan>
In-Reply-To: <20191030163243.10644-1-david@gibson.dropbear.id.au>
References: <20191030163243.10644-1-david@gibson.dropbear.id.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 10972457546266089958
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedruddtgedguddvtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.34.195
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
Cc: david@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Igor Mammedov <imammedo@redhat.com>, jdenemar@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 30 Oct 2019 17:32:43 +0100
David Gibson <david@gibson.dropbear.id.au> wrote:

> We have to set the default model of all machine classes, not just for the
> active one. Otherwise, "query-machines" will indicate the wrong CPU model
> ("qemu-s390x-cpu" instead of "host-s390x-cpu") as "default-cpu-type".
>=20

A PPC cpu model might be better.

> s390x already fixed this in de60a92e "s390x/kvm: Set default cpu model for
> all machine classes".  This patch applies a similar fix for the pseries-*
> machine types on ppc64.
>=20
> Doing a
>     {"execute":"query-machines"}
> under KVM now results in
>     {
>       "hotpluggable-cpus": true,
>       "name": "pseries-4.2",
>       "numa-mem-supported": true,
>       "default-cpu-type": "host-powerpc64-cpu",
>       "is-default": true,
>       "cpu-max": 1024,
>       "deprecated": false,
>       "alias": "pseries"
>     },
>     {
>       "hotpluggable-cpus": true,
>       "name": "pseries-4.1",
>       "numa-mem-supported": true,
>       "default-cpu-type": "host-powerpc64-cpu",
>       "cpu-max": 1024,
>       "deprecated": false
>     },
>     ...
>=20
> Libvirt probes all machines via "-machine none,accel=3Dkvm:tcg" and will
> currently see the wrong CPU model under KVM.
>=20
> Reported-by: Ji=C5=99i Denemark <jdenemar@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>

Missing S-o-b.

With these fixed.

Reviewed-by: Greg Kurz <groug@kaod.org>

> ---
>  target/ppc/kvm.c | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
>=20
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index 7d2e8969ac..c77f9848ec 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -100,7 +100,7 @@ static bool kvmppc_is_pr(KVMState *ks)
>      return kvm_vm_check_extension(ks, KVM_CAP_PPC_GET_PVINFO) !=3D 0;
>  }
> =20
> -static int kvm_ppc_register_host_cpu_type(MachineState *ms);
> +static int kvm_ppc_register_host_cpu_type(void);
>  static void kvmppc_get_cpu_characteristics(KVMState *s);
>  static int kvmppc_get_dec_bits(void);
> =20
> @@ -147,7 +147,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
>          exit(1);
>      }
> =20
> -    kvm_ppc_register_host_cpu_type(ms);
> +    kvm_ppc_register_host_cpu_type();
> =20
>      return 0;
>  }
> @@ -2534,13 +2534,19 @@ PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
>      return pvr_pcc;
>  }
> =20
> -static int kvm_ppc_register_host_cpu_type(MachineState *ms)
> +static void pseries_machine_class_fixup(ObjectClass *oc, void *opaque)
> +{
> +    MachineClass *mc =3D MACHINE_CLASS(oc);
> +
> +    mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;
> +}
> +
> +static int kvm_ppc_register_host_cpu_type(void)
>  {
>      TypeInfo type_info =3D {
>          .name =3D TYPE_HOST_POWERPC_CPU,
>          .class_init =3D kvmppc_host_cpu_class_init,
>      };
> -    MachineClass *mc =3D MACHINE_GET_CLASS(ms);
>      PowerPCCPUClass *pvr_pcc;
>      ObjectClass *oc;
>      DeviceClass *dc;
> @@ -2552,10 +2558,9 @@ static int kvm_ppc_register_host_cpu_type(MachineS=
tate *ms)
>      }
>      type_info.parent =3D object_class_get_name(OBJECT_CLASS(pvr_pcc));
>      type_register(&type_info);
> -    if (object_dynamic_cast(OBJECT(ms), TYPE_SPAPR_MACHINE)) {
> -        /* override TCG default cpu type with 'host' cpu model */
> -        mc->default_cpu_type =3D TYPE_HOST_POWERPC_CPU;
> -    }
> +    /* override TCG default cpu type with 'host' cpu model */
> +    object_class_foreach(pseries_machine_class_fixup, TYPE_SPAPR_MACHINE,
> +                         false, NULL);
> =20
>      oc =3D object_class_by_name(type_info.name);
>      g_assert(oc);


