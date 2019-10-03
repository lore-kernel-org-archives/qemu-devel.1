Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36F3C32792
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC69220862
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 12:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC69220862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iG0HM-0002M5-G1
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 08:32:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iG0F3-0001BE-Q8
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:29:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iG0F2-0000cp-NH
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:29:57 -0400
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:51435)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iG0F2-0000aJ-HB
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 08:29:56 -0400
Received: from player699.ha.ovh.net (unknown [10.108.42.174])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id C1C811E1B33
 for <qemu-devel@nongnu.org>; Thu,  3 Oct 2019 14:29:52 +0200 (CEST)
Received: from kaod.org (lfbn-1-2229-223.w90-76.abo.wanadoo.fr [90.76.50.223])
 (Authenticated sender: clg@kaod.org)
 by player699.ha.ovh.net (Postfix) with ESMTPSA id 5257AA8650C4;
 Thu,  3 Oct 2019 12:29:47 +0000 (UTC)
Subject: Re: [PATCH 5/7] spapr/xics: Configure number of servers in KVM
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157010404888.246126.9768030542733152637.stgit@bahia.lan>
 <157010410405.246126.5846482955650460662.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f73f91b3-175f-b0c5-6ebb-93cff15940e6@kaod.org>
Date: Thu, 3 Oct 2019 14:29:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <157010410405.246126.5846482955650460662.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 16843462609405578048
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrgeekgdehgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.36.150
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/10/2019 14:01, Greg Kurz wrote:
> The XICS-on-XIVE KVM devices now has an attribute to configure the numb=
er
> of interrupt servers. This allows to greatly optimize the usage of the =
VP
> space in the XIVE HW, and thus to start a lot more VMs.
>=20
> Only set this attribute if available in order to support older POWER9 K=
VM
> and pre-POWER9 XICS KVM devices.
>=20
> The XICS-on-XIVE KVM device now reports the exhaustion of VPs upon the
> connection of the first VCPU. Check that in order to have a chance to
> provide an hint to the user.

That part would have been better in its own patch. Simpler to review.
=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Anyhow, if you split or not :

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/intc/xics_kvm.c |   24 ++++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index ba90d6dc966c..12d9524cc432 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -165,8 +165,15 @@ void icp_kvm_realize(DeviceState *dev, Error **err=
p)
> =20
>      ret =3D kvm_vcpu_enable_cap(cs, KVM_CAP_IRQ_XICS, 0, kernel_xics_f=
d, vcpu_id);
>      if (ret < 0) {
> -        error_setg(errp, "Unable to connect CPU%ld to kernel XICS: %s"=
, vcpu_id,
> -                   strerror(errno));
> +        Error *local_err =3D NULL;
> +
> +        error_setg(&local_err, "Unable to connect CPU%ld to kernel XIC=
S: %s",
> +                   vcpu_id, strerror(errno));
> +        if (errno =3D=3D ENOSPC) {
> +            error_append_hint(&local_err, "Try -smp maxcpus=3DN with N=
 < %u\n",
> +                              MACHINE(qdev_get_machine())->smp.max_cpu=
s);
> +        }
> +        error_propagate(errp, local_err);
>          return;
>      }
>      enabled_icp =3D g_malloc(sizeof(*enabled_icp));
> @@ -344,6 +351,7 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int =
val)
> =20
>  int xics_kvm_connect(SpaprMachineState *spapr, Error **errp)
>  {
> +    ICSState *ics =3D spapr->ics;
>      int rc;
>      CPUState *cs;
>      Error *local_err =3D NULL;
> @@ -397,6 +405,18 @@ int xics_kvm_connect(SpaprMachineState *spapr, Err=
or **errp)
>          goto fail;
>      }
> =20
> +    /* Tell KVM about the # of VCPUs we may have (POWER9 and newer onl=
y) */
> +    if (kvm_device_check_attr(rc, KVM_DEV_XICS_GRP_CTRL,
> +                              KVM_DEV_XICS_NR_SERVERS)) {
> +        uint32_t nr_servers =3D xics_nr_servers(ics->xics);
> +
> +        if (kvm_device_access(rc, KVM_DEV_XICS_GRP_CTRL,
> +                              KVM_DEV_XICS_NR_SERVERS, &nr_servers, tr=
ue,
> +                              &local_err)) {
> +            goto fail;
> +        }
> +    }
> +
>      kernel_xics_fd =3D rc;
>      kvm_kernel_irqchip =3D true;
>      kvm_msi_via_irqfd_allowed =3D true;
>=20


