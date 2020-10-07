Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADE40C4363D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F36E5206F0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 13:50:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F36E5206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQ9qL-0001D2-RW
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 09:50:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59822)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kQ9jU-0004MJ-9R; Wed, 07 Oct 2020 09:43:52 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:49811)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1kQ9jR-0006do-Rm; Wed, 07 Oct 2020 09:43:52 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.143.183])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id AC68469A89F9;
 Wed,  7 Oct 2020 15:43:38 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Wed, 7 Oct 2020
 15:43:37 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005b7bae41a-75d9-44d8-9bfc-b52c2f1faa19,
 A16E168222A5E88446A1C19725E79DC133334205) smtp.auth=groug@kaod.org
Date: Wed, 7 Oct 2020 15:43:35 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 6/6] spapr/xive: Introduce a new CAS value for the
 StoreEOI capability
Message-ID: <20201007154335.6914bbbc@bahia.lan>
In-Reply-To: <75092c78-6a20-4870-8c06-76aa93365418@kaod.org>
References: <20201005165147.526426-1-clg@kaod.org>
 <20201005165147.526426-7-clg@kaod.org>
 <20201006193909.617cc487@bahia.lan>
 <75092c78-6a20-4870-8c06-76aa93365418@kaod.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG2EX2.mxp5.local (172.16.2.12) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 4f66c924-5506-4a1e-8d5a-903f93225f4e
X-Ovh-Tracer-Id: 14269936894672542115
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrgeeigdeilecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveelhfdtudffhfeiveehhfelgeellefgteffteekudegheejfffghefhfeeuudffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopegtlhhgsehkrghougdrohhrgh
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 09:43:39
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

On Tue, 6 Oct 2020 19:56:20 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 10/6/20 7:39 PM, Greg Kurz wrote:
> > On Mon, 5 Oct 2020 18:51:47 +0200
> > C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> >=20
> >> When the StoreEOI capability is set to "cas", let CAS decide when
> >> StoreEOI should be advertised. StoreEOI is safe to use with a P10
> >> compat machine because the OS enforces load-after-store ordering but
> >> not with P9 compat.

Hmm... OS enforcing load-after-store based on a PVR ? I can't find
such a thing in the kernel sources. What I find is:

	if (offset =3D=3D XIVE_ESB_SET_PQ_10 && xd->flags & XIVE_IRQ_FLAG_STORE_EO=
I)
		offset |=3D XIVE_ESB_LD_ST_MO;

where xd->flags comes from H_INT_GET_SOURCE_INFO, so this essentially
depends on what the hypervisor advertises. For example a P9 compat
guest could use it if QEMU has an emulated XIVE, right ?

> >>
> >> The question now is : should we make "cas" the default at the machine
> >> level ?
> >>
> >=20
> > Hmm, spapr capabilities are knobs for the end user to provide a specific
> > and consistent behavior to the guest... so the "let CAS decide depending
> > on what the guest asked for" thing looks awkward...=20
>=20
> The guest doesn't ask for StoreEOI. The hypervisor will return StoreEOI
> if the kernel is P10 compat and will not if it's P9 to make sure that
> it can be migrated to a P9 host. =20
>=20

Yeah I know that the guest doesn't ask for StoreEOI. What I mean is that
the idea behind spapr capabilities is only about saying "this machine type
offers this feature and the host supports it". The fact that the guest
might use it or not is another matter. So I don't quite see how "cas" fits
into this model...

> > I mean that making
> > "cas" the default at the machine level looks like you don't really want
> > this to be a capability at all.
>=20
> It means that you are not forcing a behaviour "off" or "on". It depends
> on the guest support, P10 or P9, which is what we want as a default=20
> behavior to be in sync with pHyp.
>=20

I think there's confusion here. Setting the capability to "on"/"off"
doesn't mean your force anything. As said above, this isn't related
to what the guest supports but essentially to what the host supports.
"on" means that we can offer the feature to the guest in a reliable
manner because we have verified it can work, and "off" simply means
we don't offer the feature (but of course the guest is still free
to shoot itself in the foot).

The reference to what pHyp does is thus irrelevant here because we
won't ever migrate a guest between KVM and PowerVM. We could decide
to do nothing and let the OS only do "LoadEOI" operations as it does
today.

If we want StoreEOI to be usable by default, then the default value
should definitely be "on". This should be kept to "off" for older
machine types to stay compatible with existing setups.

Let's only consider the KVM case only because we don't explicitly
support KVM<->TCG migration. The availability of StoreEOI is:
- emulated XIVE on P9 system =3D> ok
- emulated XIVE on P10 system =3D> ok
- in-kernel XIVE on P10 system =3D> ok
- in-kernel XIVE on P9 system =3D> not ok

This means that on a P9 system we must fallback on emulated XIVE, like
we already do with bostons today. This might look sub-optimal from a
performance standpoint but this is the price to pay to guarantee
migration doesn't fail with the default settings.

> > If the user asked for StoreEOI but the guest chose a compat mode that
> > can't support it, QEMU should simply exit IMHO
> It's not like XICS. A P8 compat can not run on XIVE. A P9 compat can use=
=20
> StoreEOI. So it should be considered more like a mitigation. But anyhow,=
=20
> the P9 systems currenly shipped never activate StoreEOI. So you will get=
=20
> the error.
> =20
> > Or alternatively I guess you can just forget about the spapr capability
> > and do all the checks (XIVE interrupt controller, KVM support, guest
> > asked for P10) at CAS.
>=20
> That's how I did in the fisrt patches but then you loose the ability to=20
> switch it off on P10 and switch on on P9. Which is good to have for tests=
=20
> and performance and for possible issues if we ever have to handle a sourc=
e=20
> which has different charateristics. In that case, we would switch it off.=
=20
>=20

I understand that having fine grain knobs is cool for tests and performance
but keep in mind that we mostly target end-users who expect this to work
out of the box with the default settings. This being said, if some end-users
might hit a corner case where it would be valuable to switch it off, then
it makes sense to keep the ability to do so of course.

> Thanks,
>=20
> C.
>=20
>=20
> =20
> >> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> >> ---
> >>  include/hw/ppc/spapr.h      |  1 +
> >>  include/hw/ppc/spapr_xive.h |  1 +
> >>  hw/intc/spapr_xive.c        |  9 +++++++++
> >>  hw/ppc/spapr_caps.c         | 21 +++++++++++++++++----
> >>  hw/ppc/spapr_hcall.c        |  7 +++++++
> >>  5 files changed, 35 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> >> index b701c14b4e09..17e7d873e8dc 100644
> >> --- a/include/hw/ppc/spapr.h
> >> +++ b/include/hw/ppc/spapr.h
> >> @@ -87,6 +87,7 @@ typedef enum {
> >>  #define SPAPR_CAP_ON                    0x01
> >> =20
> >>  /* Custom Caps */
> >> +#define SPAPR_CAP_CAS                   0x02
> >> =20
> >>  /* Generic */
> >>  #define SPAPR_CAP_BROKEN                0x00
> >> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> >> index 26c8d90d7196..8b8aa586e44f 100644
> >> --- a/include/hw/ppc/spapr_xive.h
> >> +++ b/include/hw/ppc/spapr_xive.h
> >> @@ -75,6 +75,7 @@ void spapr_xive_map_mmio(SpaprXive *xive);
> >> =20
> >>  int spapr_xive_end_to_target(uint8_t end_blk, uint32_t end_idx,
> >>                               uint32_t *out_server, uint8_t *out_prio);
> >> +void spapr_xive_enable_store_eoi(SpaprXive *xive, bool enable);
> >> =20
> >>  /*
> >>   * KVM XIVE device helpers
> >> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> >> index 41f2719ff93a..f57a2681dd91 100644
> >> --- a/hw/intc/spapr_xive.c
> >> +++ b/hw/intc/spapr_xive.c
> >> @@ -1802,3 +1802,12 @@ void spapr_xive_hcall_init(SpaprMachineState *s=
papr)
> >>      spapr_register_hypercall(H_INT_SYNC, h_int_sync);
> >>      spapr_register_hypercall(H_INT_RESET, h_int_reset);
> >>  }
> >> +
> >> +void spapr_xive_enable_store_eoi(SpaprXive *xive, bool enable)
> >> +{
> >> +    if (enable) {
> >> +        xive->source.esb_flags |=3D XIVE_SRC_STORE_EOI;
> >> +    } else {
> >> +        xive->source.esb_flags &=3D ~XIVE_SRC_STORE_EOI;
> >> +    }
> >> +}
> >> diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> >> index 9251badbdc27..c55e1fccb9bc 100644
> >> --- a/hw/ppc/spapr_caps.c
> >> +++ b/hw/ppc/spapr_caps.c
> >> @@ -524,6 +524,13 @@ static void cap_fwnmi_apply(SpaprMachineState *sp=
apr, uint8_t val,
> >>      }
> >>  }
> >> =20
> >> +SpaprCapPossible cap_storeeoi_possible =3D {
> >> +    .num =3D 3,
> >> +    .vals =3D { "off", "on", "cas" },
> >> +    .help =3D "off - no StoreEOI, on - StoreEOI, "
> >> +            "cas - negotiated at CAS (POWER10 compat only)",
> >> +};
> >> +
> >>  static void cap_storeeoi_apply(SpaprMachineState *spapr, uint8_t val,
> >>                                 Error **errp)
> >>  {
> >> @@ -550,6 +557,11 @@ static void cap_storeeoi_apply(SpaprMachineState =
*spapr, uint8_t val,
> >>              return;
> >>          }
> >> =20
> >> +        /* CAS will decide to advertise StoreEOI (P10 compat kernels =
only) */
> >> +        if (val =3D=3D SPAPR_CAP_CAS) {
> >> +            return;
> >> +        }
> >> +
> >>          /*
> >>           * load-after-store ordering is not enforced on POWER9 CPUs
> >>           * and StoreEOI can be racy.
> >> @@ -671,11 +683,12 @@ SpaprCapabilityInfo capability_table[SPAPR_CAP_N=
UM] =3D {
> >>      },
> >>      [SPAPR_CAP_STOREEOI] =3D {
> >>          .name =3D "storeeoi",
> >> -        .description =3D "Implements XIVE StoreEOI feature",
> >> +        .description =3D "Implements XIVE StoreEOI feature (off, on, =
cas)",
> >>          .index =3D SPAPR_CAP_STOREEOI,
> >> -        .get =3D spapr_cap_get_bool,
> >> -        .set =3D spapr_cap_set_bool,
> >> -        .type =3D "bool",
> >> +        .get =3D spapr_cap_get_string,
> >> +        .set =3D spapr_cap_set_string,
> >> +        .type =3D "string",
> >> +        .possible =3D &cap_storeeoi_possible,
> >>          .apply =3D cap_storeeoi_apply,
> >>      },
> >>  };
> >> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> >> index 607740150fa2..158b122b9192 100644
> >> --- a/hw/ppc/spapr_hcall.c
> >> +++ b/hw/ppc/spapr_hcall.c
> >> @@ -1804,6 +1804,13 @@ target_ulong do_client_architecture_support(Pow=
erPCCPU *cpu,
> >>  "Guest requested unavailable interrupt mode (XIVE), try the ic-mode=
=3Dxive or ic-mode=3Ddual machine property");
> >>              exit(EXIT_FAILURE);
> >>          }
> >> +
> >> +        /* Advertise StoreEOI for a P10 compat guest. */
> >> +        if (spapr_get_cap(spapr, SPAPR_CAP_STOREEOI) =3D=3D SPAPR_CAP=
_CAS) {
> >> +            bool enable =3D ppc_check_compat(cpu, CPU_POWERPC_LOGICAL=
_3_10, 0,
> >> +                                           cpu->compat_pvr);
> >> +            spapr_xive_enable_store_eoi(spapr->xive, enable);
> >> +        }
> >>      } else {
> >>          if (!spapr->irq->xics) {
> >>              error_report(
> >=20
>=20


