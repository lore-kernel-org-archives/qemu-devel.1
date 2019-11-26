Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9105C43141
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 17:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE52120722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 17:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE52120722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZeMG-0007jQ-OE
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 12:10:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42157)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iZeEQ-0001dK-8U
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 12:02:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iZeEK-0001Ha-Qc
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 12:02:30 -0500
Received: from 9.mo178.mail-out.ovh.net ([46.105.75.45]:60373)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iZeEH-0001Fr-6Y
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 12:02:22 -0500
Received: from player750.ha.ovh.net (unknown [10.108.57.38])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 6449A82E97
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 18:02:19 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player750.ha.ovh.net (Postfix) with ESMTPSA id 992F2C8CE468;
 Tue, 26 Nov 2019 17:02:14 +0000 (UTC)
Subject: Re: [for-5.0 PATCH v2 4/4] spapr/xive: Configure number of servers in
 KVM
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157478677206.67101.11965554900825793694.stgit@bahia.tlslab.ibm.com>
 <157478679392.67101.7843580591407950866.stgit@bahia.tlslab.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6a0731e6-22de-3ba7-2cfc-b289b019d5c9@kaod.org>
Date: Tue, 26 Nov 2019 18:02:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157478679392.67101.7843580591407950866.stgit@bahia.tlslab.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6528812087663561536
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeifedgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejhedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.75.45
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

On 26/11/2019 17:46, Greg Kurz wrote:
> The XIVE KVM devices now has an attribute to configure the number of
> interrupt servers. This allows to greatly optimize the usage of the VP
> space in the XIVE HW, and thus to start a lot more VMs.
>=20
> Only set this attribute if available in order to support older POWER9
> KVM.
>=20
> The XIVE KVM device now reports the exhaustion of VPs upon the
> connection of the first VCPU. Check that in order to have a chance
> to provide a hint to the user.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/intc/spapr_xive_kvm.c |   23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/intc/spapr_xive_kvm.c b/hw/intc/spapr_xive_kvm.c
> index 46c7609bd8d0..32b2809210a0 100644
> --- a/hw/intc/spapr_xive_kvm.c
> +++ b/hw/intc/spapr_xive_kvm.c
> @@ -152,7 +152,8 @@ void kvmppc_xive_cpu_synchronize_state(XiveTCTX *tc=
tx, Error **errp)
> =20
>  void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error **errp)
>  {
> -    SpaprXive *xive =3D SPAPR_MACHINE(qdev_get_machine())->xive;
> +    MachineState *ms =3D MACHINE(qdev_get_machine());
> +    SpaprXive *xive =3D SPAPR_MACHINE(ms)->xive;
>      unsigned long vcpu_id;
>      int ret;
> =20
> @@ -171,8 +172,16 @@ void kvmppc_xive_cpu_connect(XiveTCTX *tctx, Error=
 **errp)
>      ret =3D kvm_vcpu_enable_cap(tctx->cs, KVM_CAP_PPC_IRQ_XIVE, 0, xiv=
e->fd,
>                                vcpu_id, 0);
>      if (ret < 0) {
> -        error_setg(errp, "XIVE: unable to connect CPU%ld to KVM device=
: %s",
> +        Error *local_err =3D NULL;
> +
> +        error_setg(&local_err,
> +                   "XIVE: unable to connect CPU%ld to KVM device: %s",
>                     vcpu_id, strerror(errno));
> +        if (errno =3D=3D ENOSPC) {
> +            error_append_hint(&local_err, "Try -smp maxcpus=3DN with N=
 < %u\n",
> +                              ms->smp.max_cpus);
> +        }
> +        error_propagate(errp, local_err);
>          return;
>      }
> =20
> @@ -758,6 +767,16 @@ int kvmppc_xive_connect(SpaprInterruptController *=
intc, uint32_t nr_servers,
>          return -1;
>      }
> =20
> +    /* Tell KVM about the # of VCPUs we may have */
> +    if (kvm_device_check_attr(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
> +                              KVM_DEV_XIVE_NR_SERVERS)) {
> +        if (kvm_device_access(xive->fd, KVM_DEV_XIVE_GRP_CTRL,
> +                              KVM_DEV_XIVE_NR_SERVERS, &nr_servers, tr=
ue,
> +                              &local_err)) {
> +            goto fail;
> +        }
> +    }
> +
>      /*
>       * 1. Source ESB pages - KVM mapping
>       */
>=20


