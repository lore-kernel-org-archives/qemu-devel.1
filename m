Return-Path: <SRS0=M8fn=UR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77183C31E51
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:19:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F7A420679
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2019 07:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F7A420679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54336 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd8Ob-0003cg-Hx
	for qemu-devel@archiver.kernel.org; Tue, 18 Jun 2019 03:19:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51395)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <clg@kaod.org>) id 1hd8Nt-000381-Tb
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:18:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <clg@kaod.org>) id 1hd8Ns-0007LA-Qt
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:18:25 -0400
Received: from 1.mo177.mail-out.ovh.net ([178.33.107.143]:38116)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <clg@kaod.org>) id 1hd8Ns-0007KQ-JT
 for qemu-devel@nongnu.org; Tue, 18 Jun 2019 03:18:24 -0400
Received: from player778.ha.ovh.net (unknown [10.108.54.230])
 by mo177.mail-out.ovh.net (Postfix) with ESMTP id 2AAEEFE787
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2019 09:18:21 +0200 (CEST)
Received: from kaod.org (lfbn-1-10649-41.w90-89.abo.wanadoo.fr [90.89.235.41])
 (Authenticated sender: clg@kaod.org)
 by player778.ha.ovh.net (Postfix) with ESMTPSA id 20E556E2C69A;
 Tue, 18 Jun 2019 07:18:18 +0000 (UTC)
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
References: <156077918969.433243.1416211899441569578.stgit@bahia.lan>
 <156077922319.433243.609897156640506891.stgit@bahia.lan>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <4f1aa2c2-6083-7233-c0dc-9434fd7e1fe5@kaod.org>
Date: Tue, 18 Jun 2019 09:18:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156077922319.433243.609897156640506891.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Ovh-Tracer-Id: 10393463515695975232
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrudeikedguddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.107.143
Subject: Re: [Qemu-devel] [PATCH 6/6] xics/kvm: Add proper rollback to
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

On 17/06/2019 15:47, Greg Kurz wrote:
> Make xics_kvm_disconnect() able to undo the changes of a partial execut=
ion
> of xics_kvm_connect() and use it to perform rollback.
>=20
> Note that kvmppc_define_rtas_kernel_token(0) never fails, no matter the
> RTAS call has been defined or not.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/intc/xics_kvm.c |   11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>=20
> diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
> index 4bfbe1a84092..51433b19b076 100644
> --- a/hw/intc/xics_kvm.c
> +++ b/hw/intc/xics_kvm.c
> @@ -421,10 +421,7 @@ int xics_kvm_connect(SpaprMachineState *spapr, Err=
or **errp)
> =20
>  fail:
>      error_propagate(errp, local_err);
> -    kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
> -    kvmppc_define_rtas_kernel_token(0, "ibm,get-xive");
> -    kvmppc_define_rtas_kernel_token(0, "ibm,int-on");
> -    kvmppc_define_rtas_kernel_token(0, "ibm,int-off");
> +    xics_kvm_disconnect(spapr, NULL);
>      return -1;
>  }
> =20
> @@ -448,8 +445,10 @@ void xics_kvm_disconnect(SpaprMachineState *spapr,=
 Error **errp)
>       * removed from the list of devices of the VM. The VCPU presenters
>       * are also detached from the device.
>       */
> -    close(kernel_xics_fd);
> -    kernel_xics_fd =3D -1;
> +    if (kernel_xics_fd !=3D -1) {
> +        close(kernel_xics_fd);
> +        kernel_xics_fd =3D -1;
> +    }
> =20
>      kvmppc_define_rtas_kernel_token(0, "ibm,set-xive");
>      kvmppc_define_rtas_kernel_token(0, "ibm,get-xive");
>=20


