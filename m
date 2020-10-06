Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F53C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:44:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADFF0206D4
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 16:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADFF0206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPq4E-0002AW-EZ
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 12:43:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kPq35-0001JM-I6; Tue, 06 Oct 2020 12:42:47 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:59537)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kPq31-0001IO-35; Tue, 06 Oct 2020 12:42:47 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.138.210])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 44CA9695535C;
 Tue,  6 Oct 2020 18:42:37 +0200 (CEST)
Received: from kaod.org (37.59.142.96) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 6 Oct 2020
 18:42:37 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-96R00124e8f4bd-0220-489c-84be-518f19850b7e,
 ABBA5CC1B3A583228A496F54FDB0659883642288) smtp.auth=groug@kaod.org
Date: Tue, 6 Oct 2020 18:42:36 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 1/6] spapr/xive: Introduce a StoreEOI capability
Message-ID: <20201006184236.62523fdc@bahia.lan>
In-Reply-To: <20201005165147.526426-2-clg@kaod.org>
References: <20201005165147.526426-1-clg@kaod.org>
 <20201005165147.526426-2-clg@kaod.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.96]
X-ClientProxiedBy: DAG9EX2.mxp5.local (172.16.2.82) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 8b856d1d-9397-4810-a754-05c1d5537b51
X-Ovh-Tracer-Id: 11420284232345360803
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrgeeggddutddvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeevlefhtddufffhieevhefhleegleelgfetffetkedugeehjeffgfehhfefueduffenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddrleeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegtlhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 11:30:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Gustavo Romero <gromero@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Oct 2020 18:51:42 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> When an interrupt has been handled, the OS notifies the interrupt
> controller with an EOI sequence. On the XIVE interrupt controller
> (POWER9 and POWER10), this can be done with a load or a store
> operation on the ESB interrupt management page of the interrupt. The
> StoreEOI operation has less latency and improves interrupt handling
> performance but it was deactivated during the POWER9 DD2.0 time-frame
> because of ordering issues. POWER9 systems use the LoadEOI instead.
> POWER10 has fixed the issue with a special load command which enforces
> Load-after-Store ordering and StoreEOI can be safely used.
>=20
> The new StoreEOI capability adds StoreEOI support to the flags
> returned by the hcall H_INT_GET_SOURCE_INFO. When the machine is using
> an emulated interrupt controller, TCG or without kernel IRQ chip,
> there are no limitations and activating StoreEOI is not an issue.
> However, when running with a kernel IRQ chip, some verification needs
> to be done on the host. This is done through the DT, which tells us
> that firmware has configured the HW for StoreEOI, but a new KVM
> capability would be cleaner.
>=20

Cleaner and even required... a user could possibly run an older
KVM that doesn't know about StoreEOI on a POWER10 host and QEMU
would wrongly assume the feature is supported. Also, I guess this
should rather be an attribute of the XIVE KVM device rather than a
plain KVM property.

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr.h |  4 +++-
>  target/ppc/kvm_ppc.h   |  6 ++++++
>  hw/ppc/spapr.c         |  1 +
>  hw/ppc/spapr_caps.c    | 30 ++++++++++++++++++++++++++++++
>  target/ppc/kvm.c       | 18 ++++++++++++++++++
>  5 files changed, 58 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index bba8736269f4..b701c14b4e09 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -74,8 +74,10 @@ typedef enum {
>  #define SPAPR_CAP_CCF_ASSIST            0x09
>  /* Implements PAPR FWNMI option */
>  #define SPAPR_CAP_FWNMI                 0x0A
> +/* Implements XIVE StoreEOI feature */
> +#define SPAPR_CAP_STOREEOI              0x0B

The name should mention XIVE, ie. SPAPR_CAP_XIVE_STOREEOI

>  /* Num Caps */
> -#define SPAPR_CAP_NUM                   (SPAPR_CAP_FWNMI + 1)
> +#define SPAPR_CAP_NUM                   (SPAPR_CAP_STOREEOI + 1)
> =20
>  /*
>   * Capability Values
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index 72e05f1cd2fc..c5a487dbba13 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -64,6 +64,7 @@ bool kvmppc_has_cap_htm(void);
>  bool kvmppc_has_cap_mmu_radix(void);
>  bool kvmppc_has_cap_mmu_hash_v3(void);
>  bool kvmppc_has_cap_xive(void);
> +bool kvmppc_has_cap_xive_storeeoi(void);
>  int kvmppc_get_cap_safe_cache(void);
>  int kvmppc_get_cap_safe_bounds_check(void);
>  int kvmppc_get_cap_safe_indirect_branch(void);
> @@ -346,6 +347,11 @@ static inline bool kvmppc_has_cap_xive(void)
>      return false;
>  }
> =20
> +static inline bool kvmppc_has_cap_xive_storeeoi(void)
> +{
> +    return false;
> +}
> +
>  static inline int kvmppc_get_cap_safe_cache(void)
>  {
>      return 0;
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 4256794f3bed..e83de0580142 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -4447,6 +4447,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      smc->default_caps.caps[SPAPR_CAP_LARGE_DECREMENTER] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_CCF_ASSIST] =3D SPAPR_CAP_ON;
>      smc->default_caps.caps[SPAPR_CAP_FWNMI] =3D SPAPR_CAP_ON;
> +    smc->default_caps.caps[SPAPR_CAP_STOREEOI] =3D SPAPR_CAP_OFF;
>      spapr_caps_add_properties(smc);
>      smc->irq =3D &spapr_irq_dual;
>      smc->dr_phb_enabled =3D true;
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 9341e9782a3f..57c62c22e4cc 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -524,6 +524,26 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr=
, uint8_t val,
>      }
>  }
> =20
> +static void cap_storeeoi_apply(SpaprMachineState *spapr, uint8_t val,
> +                               Error **errp)
> +{
> +    ERRP_GUARD();

=46rom "qapi/error.h":

 * =3D Why, when and how to use ERRP_GUARD() =3D
 *
 * Without ERRP_GUARD(), use of the @errp parameter is restricted:
 * - It must not be dereferenced, because it may be null.
 * - It should not be passed to error_prepend() or
 *   error_append_hint(), because that doesn't work with &error_fatal.
 * ERRP_GUARD() lifts these restrictions.
 *
 * To use ERRP_GUARD(), add it right at the beginning of the function.
 * @errp can then be used without worrying about the argument being
 * NULL or &error_fatal.
 *
 * Using it when it's not needed is safe, but please avoid cluttering
 * the source with useless code.
 *

So for this ERRP_GUARD() to be justified, you should come up with
a hint, otherwise you should drop it.

> +    MachineState *machine =3D MACHINE(spapr);
> +    bool kvm_storeeoi =3D kvmppc_has_cap_xive_storeeoi();
> +
> +    if (!val) {
> +        return; /* Disabled by default */
> +    }
> +
> +    /* Check host support when the KVM device is in use */
> +    if (kvm_irqchip_in_kernel()) {

Hmm... checking kvm_irqchip_in_kernel() is imprecise because
it returns true if either the XIVE or XICS KVM device has
been open, regardless of the flavor we're going to use. This
really depends on the ic-mode setting:

1) xics: we really don't care whether StoreEOI is available or not.
   This is very similar to the case of POWER8 in patch 2. Spit a
   warning and return.

2) xive: at this point the XIVE KVM device is open and we can check
   the availability of StoreEOI with kvm_device_check_attr().

3) dual: this one is problematic because at this point the XICS KVM
   device is open but XIVE KVM won't be open until CAS.

So I think we can only do something sensible for cases 1) and 2),
eg:

    if (!spapr->irq->xive) {
        warn_report(...);
        return;
    }

    if (spapr_xive_in_kernel(spapr->xive)) {
        !kvm_device_check_attr(spapr->xive->fd, ...) {
        error_setg(errp, "StoreEOI not supported by XIVE KVM");
        return;
    }

Case 3) requires a similar check in CAS if the guest asked for XIVE
and cap-xive-storeeoi=3Don.

> +        if (!kvm_storeeoi) {
> +            error_setg(errp, "StoreEOI not supported by KVM");
> +            return;
> +        }
> +    }
> +}
> +
>  SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =3D {
>      [SPAPR_CAP_HTM] =3D {
>          .name =3D "htm",
> @@ -632,6 +652,15 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM] =
=3D {
>          .type =3D "bool",
>          .apply =3D cap_fwnmi_apply,
>      },
> +    [SPAPR_CAP_STOREEOI] =3D {
> +        .name =3D "storeeoi",
> +        .description =3D "Implements XIVE StoreEOI feature",
> +        .index =3D SPAPR_CAP_STOREEOI,
> +        .get =3D spapr_cap_get_bool,
> +        .set =3D spapr_cap_set_bool,
> +        .type =3D "bool",
> +        .apply =3D cap_storeeoi_apply,
> +    },
>  };
> =20
>  static SpaprCapabilities default_caps_with_cpu(SpaprMachineState *spapr,
> @@ -772,6 +801,7 @@ SPAPR_CAP_MIG_STATE(nested_kvm_hv, SPAPR_CAP_NESTED_K=
VM_HV);
>  SPAPR_CAP_MIG_STATE(large_decr, SPAPR_CAP_LARGE_DECREMENTER);
>  SPAPR_CAP_MIG_STATE(ccf_assist, SPAPR_CAP_CCF_ASSIST);
>  SPAPR_CAP_MIG_STATE(fwnmi, SPAPR_CAP_FWNMI);
> +SPAPR_CAP_MIG_STATE(storeeoi, SPAPR_CAP_STOREEOI);
> =20
>  void spapr_caps_init(SpaprMachineState *spapr)
>  {
> diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
> index d85ba8ffe00b..9ad637151070 100644
> --- a/target/ppc/kvm.c
> +++ b/target/ppc/kvm.c
> @@ -2448,6 +2448,24 @@ bool kvmppc_has_cap_xive(void)
>      return cap_xive;
>  }
> =20
> +/*
> + * TODO: Introduce a new KVM capability
> + */

Is there anything that prevents to add such a capability
or KVM device attribute before modifying QEMU ?

> +bool kvmppc_has_cap_xive_storeeoi(void)
> +{
> +    static const char *compat =3D "ibm,opal-xive-pe";
> +    void *host_fdt;
> +    int xive_node;
> +
> +    host_fdt =3D load_device_tree_from_sysfs();
> +    xive_node =3D fdt_node_offset_by_compatible(host_fdt, -1, compat);
> +    if (xive_node < 0) {
> +        return false;
> +    }
> +
> +    return !!fdt_getprop(host_fdt, xive_node, "store-eoi-support", NULL);
> +}
> +
>  static void kvmppc_get_cpu_characteristics(KVMState *s)
>  {
>      struct kvm_ppc_cpu_char c;


