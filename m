Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42504C76186
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 17:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1970920840
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 17:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1970920840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqKtw-0001uG-CP
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 13:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51373)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hqKtl-0001QV-Fv
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 13:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hqKtj-0003pR-7l
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 13:17:53 -0400
Received: from 1.mo69.mail-out.ovh.net ([178.33.251.173]:45984)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hqKtj-0003fy-21
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 13:17:51 -0400
Received: from player726.ha.ovh.net (unknown [10.108.57.18])
 by mo69.mail-out.ovh.net (Postfix) with ESMTP id C9C756394A
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 19:17:47 +0200 (CEST)
Received: from kaod.org (deibp9eh1--blueice1n4.emea.ibm.com [195.212.29.166])
 (Authenticated sender: clg@kaod.org)
 by player726.ha.ovh.net (Postfix) with ESMTPSA id C597D8343CCD;
 Wed, 24 Jul 2019 17:17:43 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <156398742921.546975.8822387598242513827.stgit@bahia.lan>
 <156398744035.546975.7029414194633598474.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <5da9f5f5-2df6-3526-ea4f-0abe5f10151b@kaod.org>
Date: Wed, 24 Jul 2019 19:17:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156398744035.546975.7029414194633598474.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10573044554224667475
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrkedtgddutdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.251.173
Subject: Re: [Qemu-devel] [PATCH for-4.1 2/2] xics/kvm: Fix fallback to
 emulated XICS
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

On 24/07/2019 18:57, Greg Kurz wrote:
> Commit 4812f2615288 tried to fix rollback path of xics_kvm_connect() bu=
t
> it isn't enough. If we fail to create the KVM device, the guest fails
> to boot later on with:
>=20
> [    0.010817] pci 0000:00:00.0: Adding to iommu group 0
> [    0.010863] irq: unknown-1 didn't like hwirq-0x1200 to VIRQ17 mappin=
g (rc=3D-22)
> [    0.010923] pci 0000:00:01.0: Adding to iommu group 0
> [    0.010968] irq: unknown-1 didn't like hwirq-0x1201 to VIRQ17 mappin=
g (rc=3D-22)
> [    0.011543] EEH: No capable adapters found
> [    0.011597] irq: unknown-1 didn't like hwirq-0x1000 to VIRQ17 mappin=
g (rc=3D-22)
> [    0.011651] audit: type=3D2000 audit(1563977526.000:1): state=3Dinit=
ialized audit_enabled=3D0 res=3D1
> [    0.011703] ------------[ cut here ]------------
> [    0.011729] event-sources: Unable to allocate interrupt number for /=
event-sources/epow-events
> [    0.011776] WARNING: CPU: 0 PID: 1 at arch/powerpc/platforms/pseries=
/event_sources.c:34 request_event_sources_irqs+0xbc/0x150
> [    0.011828] Modules linked in:
> [    0.011850] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.1.17-300.fc3=
0.ppc64le #1
> [    0.011886] NIP:  c0000000000d4fac LR: c0000000000d4fa8 CTR: c000000=
0018f0000
> [    0.011923] REGS: c00000001e4c38d0 TRAP: 0700   Not tainted  (5.1.17=
-300.fc30.ppc64le)
> [    0.011966] MSR:  8000000002029033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 2=
8000284  XER: 20040000
> [    0.012012] CFAR: c00000000011b42c IRQMASK: 0
> [    0.012012] GPR00: c0000000000d4fa8 c00000001e4c3b60 c0000000015fc40=
0 0000000000000051
> [    0.012012] GPR04: 0000000000000001 0000000000000000 000000000000008=
1 772d6576656e7473
> [    0.012012] GPR08: 000000001edf0000 c0000000014d4830 c0000000014d483=
0 6e6576652f20726f
> [    0.012012] GPR12: 0000000000000000 c0000000018f0000 c000000000010bf=
0 0000000000000000
> [    0.012012] GPR16: 0000000000000000 0000000000000000 000000000000000=
0 0000000000000000
> [    0.012012] GPR20: 0000000000000000 0000000000000000 000000000000000=
0 0000000000000000
> [    0.012012] GPR24: 0000000000000000 0000000000000000 c000000000ebbf0=
0 c0000000000d5570
> [    0.012012] GPR28: c000000000ebc008 c00000001fff8248 000000000000000=
0 0000000000000000
> [    0.012372] NIP [c0000000000d4fac] request_event_sources_irqs+0xbc/0=
x150
> [    0.012409] LR [c0000000000d4fa8] request_event_sources_irqs+0xb8/0x=
150
> [    0.012445] Call Trace:
> [    0.012462] [c00000001e4c3b60] [c0000000000d4fa8] request_event_sour=
ces_irqs+0xb8/0x150 (unreliable)
> [    0.012513] [c00000001e4c3bf0] [c000000001042848] __machine_initcall=
_pseries_init_ras_IRQ+0xc8/0xf8
> [    0.012563] [c00000001e4c3c20] [c000000000010810] do_one_initcall+0x=
60/0x254
> [    0.012611] [c00000001e4c3cf0] [c000000001024538] kernel_init_freeab=
le+0x35c/0x444
> [    0.012655] [c00000001e4c3db0] [c000000000010c14] kernel_init+0x2c/0=
x148
> [    0.012693] [c00000001e4c3e20] [c00000000000bdc4] ret_from_kernel_th=
read+0x5c/0x78
> [    0.012736] Instruction dump:
> [    0.012759] 38a00000 7c7f1b78 7f64db78 2c1f0000 2fbf0000 78630020 41=
80002c 409effa8
> [    0.012805] 7fa4eb78 7f43d378 48046421 60000000 <0fe00000> 3bde0001 =
2c1e0010 7fde07b4
> [    0.012851] ---[ end trace aa5785707323fad3 ]---
>=20
> This happens because QEMU fell back on XICS emulation but didn't unregi=
ster
> the RTAS calls from KVM. The emulated RTAS calls are hence never called=
 and
> the KVM ones return an error to the guest since the KVM device is absen=
t.
>=20
> The sanity checks in xics_kvm_disconnect() are abusive since we're free=
ing
> the KVM device. Simply drop them.
>=20
> Fixes: 4812f2615288 "xics/kvm: Add proper rollback to xics_kvm_init()"
> Signed-off-by: Greg Kurz <groug@kaod.org>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/intc/xics_kvm.c |   11 -----------
>  1 file changed, 11 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 2df1f3e92c7e..65c35f90f9af 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -430,17 +430,6 @@ fail:
> =20
>  void xics_kvm_disconnect(SpaprMachineState *spapr, Error **errp)
>  {
> -    /* The KVM XICS device is not in use */
> -    if (kernel_xics_fd =3D=3D -1) {
> -        return;
> -    }
> -
> -    if (!kvm_enabled() || !kvm_check_extension(kvm_state, KVM_CAP_IRQ_=
XICS)) {
> -        error_setg(errp,
> -                   "KVM and IRQ_XICS capability must be present for KV=
M XICS device");
> -        return;
> -    }
> -
>      /*
>       * Only on P9 using the XICS-on XIVE KVM device:
>       *
>=20


