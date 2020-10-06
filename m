Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D76EC41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:41:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86BF206CB
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86BF206CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPqxX-0000aX-Os
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 13:41:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46224)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kPqvo-0007iT-LJ; Tue, 06 Oct 2020 13:39:22 -0400
Received: from smtpout1.mo529.mail-out.ovh.net ([178.32.125.2]:54749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kPqvj-0007zj-Lo; Tue, 06 Oct 2020 13:39:20 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.15])
 by mo529.mail-out.ovh.net (Postfix) with ESMTPS id 87D9E62AF2D3;
 Tue,  6 Oct 2020 19:39:11 +0200 (CEST)
Received: from kaod.org (37.59.142.105) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Tue, 6 Oct 2020
 19:39:11 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G00633475554-bec9-4257-85df-59c8e5f31d11,
 ABBA5CC1B3A583228A496F54FDB0659883642288) smtp.auth=groug@kaod.org
Date: Tue, 6 Oct 2020 19:39:09 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 6/6] spapr/xive: Introduce a new CAS value for the
 StoreEOI capability
Message-ID: <20201006193909.617cc487@bahia.lan>
In-Reply-To: <20201005165147.526426-7-clg@kaod.org>
References: <20201005165147.526426-1-clg@kaod.org>
 <20201005165147.526426-7-clg@kaod.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.105]
X-ClientProxiedBy: DAG3EX2.mxp5.local (172.16.2.22) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: a6dc60b9-7d44-45d5-be8a-48f9ea55a24c
X-Ovh-Tracer-Id: 12375610301591493027
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrgeeggdduudegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfhisehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeevlefhtddufffhieevhefhleegleelgfetffetkedugeehjeffgfehhfefueduffenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=178.32.125.2; envelope-from=groug@kaod.org;
 helo=smtpout1.mo529.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 12:58:29
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

On Mon, 5 Oct 2020 18:51:47 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> When the StoreEOI capability is set to "cas", let CAS decide when
> StoreEOI should be advertised. StoreEOI is safe to use with a P10
> compat machine because the OS enforces load-after-store ordering but
> not with P9 compat.
>=20
> The question now is : should we make "cas" the default at the machine
> level ?
>=20

Hmm, spapr capabilities are knobs for the end user to provide a specific
and consistent behavior to the guest... so the "let CAS decide depending
on what the guest asked for" thing looks awkward... I mean that making
"cas" the default at the machine level looks like you don't really want
this to be a capability at all.

If the user asked for StoreEOI but the guest chose a compat mode that
can't support it, QEMU should simply exit IMHO.

Or alternatively I guess you can just forget about the spapr capability
and do all the checks (XIVE interrupt controller, KVM support, guest
asked for P10) at CAS.

> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/spapr.h      |  1 +
>  include/hw/ppc/spapr_xive.h |  1 +
>  hw/intc/spapr_xive.c        |  9 +++++++++
>  hw/ppc/spapr_caps.c         | 21 +++++++++++++++++----
>  hw/ppc/spapr_hcall.c        |  7 +++++++
>  5 files changed, 35 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> index b701c14b4e09..17e7d873e8dc 100644
> --- a/include/hw/ppc/spapr.h
> +++ b/include/hw/ppc/spapr.h
> @@ -87,6 +87,7 @@ typedef enum {
>  #define SPAPR_CAP_ON                    0x01
> =20
>  /* Custom Caps */
> +#define SPAPR_CAP_CAS                   0x02
> =20
>  /* Generic */
>  #define SPAPR_CAP_BROKEN                0x00
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index 26c8d90d7196..8b8aa586e44f 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -75,6 +75,7 @@ void spapr_xive_map_mmio(SpaprXive *xive);
> =20
>  int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
>                               uint32_t *out_server, uint8_t *out_prio);
> +void spapr_xive_enable_store_eoi(SpaprXive *xive, bool enable);
> =20
>  /*
>   * KVM XIVE device helpers
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 41f2719ff93a..f57a2681dd91 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -1802,3 +1802,12 @@ void spapr_xive_hcall_init(SpaprMachineState *spap=
r)
>      spapr_register_hypercall(H_INT_SYNC, h_int_sync);
>      spapr_register_hypercall(H_INT_RESET, h_int_reset);
>  }
> +
> +void spapr_xive_enable_store_eoi(SpaprXive *xive, bool enable)
> +{
> +    if (enable) {
> +        xive->source.esb_flags |=3D XIVE_SRC_STORE_EOI;
> +    } else {
> +        xive->source.esb_flags &=3D ~XIVE_SRC_STORE_EOI;
> +    }
> +}
> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> index 9251badbdc27..c55e1fccb9bc 100644
> --- a/hw/ppc/spapr_caps.c
> +++ b/hw/ppc/spapr_caps.c
> @@ -524,6 +524,13 @@ static void cap_fwnmi_apply(SpaprMachineState *spapr=
, uint8_t val,
>      }
>  }
> =20
> +SpaprCapPossible cap_storeeoi_possible =3D {
> +    .num =3D 3,
> +    .vals =3D { "off", "on", "cas" },
> +    .help =3D "off - no StoreEOI, on - StoreEOI, "
> +            "cas - negotiated at CAS (POWER10 compat only)",
> +};
> +
>  static void cap_storeeoi_apply(SpaprMachineState *spapr, uint8_t val,
>                                 Error **errp)
>  {
> @@ -550,6 +557,11 @@ static void cap_storeeoi_apply(SpaprMachineState *sp=
apr, uint8_t val,
>              return;
>          }
> =20
> +        /* CAS will decide to advertise StoreEOI (P10 compat kernels onl=
y) */
> +        if (val =3D=3D SPAPR_CAP_CAS) {
> +            return;
> +        }
> +
>          /*
>           * load-after-store ordering is not enforced on POWER9 CPUs
>           * and StoreEOI can be racy.
> @@ -671,11 +683,12 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_NUM]=
 =3D {
>      },
>      [SPAPR_CAP_STOREEOI] =3D {
>          .name =3D "storeeoi",
> -        .description =3D "Implements XIVE StoreEOI feature",
> +        .description =3D "Implements XIVE StoreEOI feature (off, on, cas=
)",
>          .index =3D SPAPR_CAP_STOREEOI,
> -        .get =3D spapr_cap_get_bool,
> -        .set =3D spapr_cap_set_bool,
> -        .type =3D "bool",
> +        .get =3D spapr_cap_get_string,
> +        .set =3D spapr_cap_set_string,
> +        .type =3D "string",
> +        .possible =3D &cap_storeeoi_possible,
>          .apply =3D cap_storeeoi_apply,
>      },
>  };
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 607740150fa2..158b122b9192 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1804,6 +1804,13 @@ target_ulong do_client_architecture_support(PowerP=
CCPU *cpu,
>  "Guest requested unavailable interrupt mode (XIVE), try the ic-mode=3Dxi=
ve or ic-mode=3Ddual machine property");
>              exit(EXIT_FAILURE);
>          }
> +
> +        /* Advertise StoreEOI for a P10 compat guest. */
> +        if (spapr_get_cap(spapr, SPAPR_CAP_STOREEOI) =3D=3D SPAPR_CAP_CA=
S) {
> +            bool enable =3D ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_=
10, 0,
> +                                           cpu->compat_pvr);
> +            spapr_xive_enable_store_eoi(spapr->xive, enable);
> +        }
>      } else {
>          if (!spapr->irq->xics) {
>              error_report(


