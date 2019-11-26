Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C70C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 17:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701BA20722
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 17:11:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701BA20722
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZeNI-0000Hc-Ka
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 12:11:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42200)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <clg@kaod.org>) id 1iZeEY-0001gb-21
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 12:02:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1iZeEV-0001Lz-0y
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 12:02:37 -0500
Received: from 4.mo2.mail-out.ovh.net ([87.98.172.75]:45930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1iZeEU-0001Kn-PD
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 12:02:34 -0500
Received: from player711.ha.ovh.net (unknown [10.109.146.1])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 6AE9E1B6448
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2019 18:02:32 +0100 (CET)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player711.ha.ovh.net (Postfix) with ESMTPSA id B54F2C75C8AB;
 Tue, 26 Nov 2019 17:02:27 +0000 (UTC)
Subject: Re: [for-5.0 PATCH v2 3/4] spapr/xics: Configure number of servers in
 KVM
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <157478677206.67101.11965554900825793694.stgit@bahia.tlslab.ibm.com>
 <157478678846.67101.9660531022460517710.stgit@bahia.tlslab.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <682c6644-066d-02dd-7695-9633138cad43@kaod.org>
Date: Tue, 26 Nov 2019 18:02:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <157478678846.67101.9660531022460517710.stgit@bahia.tlslab.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 6532471262125919040
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeifedgleejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdqfffguegfifdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthekredttdefjeenucfhrhhomhepveorughrihgtpgfnvggpifhorghtvghruceotghlgheskhgrohgurdhorhhgqeenucfkpheptddrtddrtddrtddpudelhedrvdduvddrvdelrdduieeinecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejuddurdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.172.75
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
> provide a hint to the user.
> `
> Signed-off-by: Greg Kurz <groug@kaod.org>


Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

> ---
>  hw/intc/xics_kvm.c |   21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index a1f1b7b0d37c..8d6156578fbc 100644
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
> @@ -399,6 +406,16 @@ int xics_kvm_connect(SpaprInterruptController *int=
c, uint32_t nr_servers,
>          goto fail;
>      }
> =20
> +    /* Tell KVM about the # of VCPUs we may have (POWER9 and newer onl=
y) */
> +    if (kvm_device_check_attr(rc, KVM_DEV_XICS_GRP_CTRL,
> +                              KVM_DEV_XICS_NR_SERVERS)) {
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


