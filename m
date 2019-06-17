Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D17C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:30:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52D412084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52D412084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48000 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcsel-0000fh-La
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42479)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hcsUM-0002gY-2Y
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:20:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hcsUK-0007Ov-Nd
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:20:01 -0400
Received: from 7.mo2.mail-out.ovh.net ([188.165.48.182]:32769)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hcsUJ-0007Hm-Qm
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:20:00 -0400
Received: from player730.ha.ovh.net (unknown [10.108.35.90])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 05CEB19FB12
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 16:19:45 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player730.ha.ovh.net (Postfix) with ESMTPSA id E607B6CE7EFB;
 Mon, 17 Jun 2019 14:19:41 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
 <156077921212.433243.11716701611944816815.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e775f307-ce53-f2c1-907d-ca326eec832a@kaod.org>
Date: Mon, 17 Jun 2019 16:19:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156077921212.433243.11716701611944816815.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 11637582913122896704
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeijedgjeehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.48.182
Subject: Re: [Qemu-devel] [PATCH 4/6] xics/kvm: Always use local_err in
 xics_kvm_init()
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

On 17/06/2019 15:46, Greg Kurz wrote:
> Passing both errp and &local_err to functions is a recipe for messing
> things up.
>=20
> Since we must use &local_err for icp_kvm_realize(), use &local_err
> everywhere where rollback must happen and have a single call to
> error_propagate() them all. While here, add errno to the error
> message.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.


> ---
>  hw/intc/xics_kvm.c |   16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 377ff88701c2..c9e25fb051bb 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -353,32 +353,36 @@ int xics_kvm_connect(SpaprMachineState *spapr, Er=
ror **errp)
> =20
>      rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_SET_XIVE, "ibm,set=
-xive");
>      if (rc < 0) {
> -        error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,set-xiv=
e");
> +        error_setg_errno(&local_err, -rc,
> +                         "kvmppc_define_rtas_kernel_token: ibm,set-xiv=
e");
>          goto fail;
>      }
> =20
>      rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_GET_XIVE, "ibm,get=
-xive");
>      if (rc < 0) {
> -        error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,get-xiv=
e");
> +        error_setg_errno(&local_err, -rc,
> +                         "kvmppc_define_rtas_kernel_token: ibm,get-xiv=
e");
>          goto fail;
>      }
> =20
>      rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_INT_ON, "ibm,int-o=
n");
>      if (rc < 0) {
> -        error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,int-on"=
);
> +        error_setg_errno(&local_err, -rc,
> +                         "kvmppc_define_rtas_kernel_token: ibm,int-on"=
);
>          goto fail;
>      }
> =20
>      rc =3D kvmppc_define_rtas_kernel_token(RTAS_IBM_INT_OFF, "ibm,int-=
off");
>      if (rc < 0) {
> -        error_setg(errp, "kvmppc_define_rtas_kernel_token: ibm,int-off=
");
> +        error_setg_errno(&local_err, -rc,
> +                         "kvmppc_define_rtas_kernel_token: ibm,int-off=
");
>          goto fail;
>      }
> =20
>      /* Create the KVM XICS device */
>      rc =3D kvm_create_device(kvm_state, KVM_DEV_TYPE_XICS, false);
>      if (rc < 0) {
> -        error_setg_errno(errp, -rc, "Error on KVM_CREATE_DEVICE for XI=
CS");
> +        error_setg_errno(&local_err, -rc, "Error on KVM_CREATE_DEVICE =
for XICS");
>          goto fail;
>      }
> =20
> @@ -393,7 +397,6 @@ int xics_kvm_connect(SpaprMachineState *spapr, Erro=
r **errp)
> =20
>          icp_kvm_realize(DEVICE(spapr_cpu_state(cpu)->icp), &local_err)=
;
>          if (local_err) {
> -            error_propagate(errp, local_err);
>              goto fail;
>          }
>      }
> @@ -410,6 +413,7 @@ int xics_kvm_connect(SpaprMachineState *spapr, Erro=
r **errp)
>      return 0;
> =20
>  fail:
> +    error_propagate(errp, local_err);
>      kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
>      kvmppc_define_rtas_kernel_token(0, "ibm,get-xive");
>      kvmppc_define_rtas_kernel_token(0, "ibm,int-on");
>=20


