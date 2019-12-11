Return-Path: <SRS0=Q6KP=2B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4123BC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:03:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B14621556
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2019 15:03:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTt8lXOo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B14621556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1if3Wj-00089q-4t
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 10:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49182)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1if3Vk-0007gZ-8y
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1if3Vg-0006Jk-NP
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:02:44 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:20066
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1if3Vg-0006IP-JQ
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 10:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576076559;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1xjXhmh3R67SiW1VGxwkHAvmh2R1RUP9h9i289AFgfo=;
 b=hTt8lXOo1Mk0obo5Lk3KrlaIAWBleODOeSpHpgosq+O9EkjnBtEiN2ICwA7xmMWi3qKeOq
 1qySC1pp1e7gXFCCncVionHvur3kkhLHvNgI38twLJ8uUgg1Euw99JITIcZjNP2BqygByg
 nslKndZkeuF+mWPssBDm6zNV7WIfvJ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-377--NEIe-NxPA2nTa1cizHA4A-1; Wed, 11 Dec 2019 10:02:35 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B1CF8E9BE4
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 15:02:34 +0000 (UTC)
Received: from redhat.com (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A817194BB;
 Wed, 11 Dec 2019 15:02:31 +0000 (UTC)
Date: Wed, 11 Dec 2019 15:02:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] ff Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20191211150228.GL955178@redhat.com>
References: <1576075593-50346-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1576075593-50346-1-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: -NEIe-NxPA2nTa1cizHA4A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Missing commit message subject line :-)

On Wed, Dec 11, 2019 at 03:46:33PM +0100, Paolo Bonzini wrote:
> ---
>  hw/ppc/e500.c      | 1 -
>  hw/ppc/spapr_irq.c | 8 --------
>  2 files changed, 9 deletions(-)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 928efaa..12b6a5b 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -793,7 +793,6 @@ static DeviceState *ppce500_init_mpic(PPCE500MachineS=
tate *pms,
>                                        MemoryRegion *ccsr,
>                                        IrqLines *irqs)
>  {
> -    MachineState *machine =3D MACHINE(pms);
>      const PPCE500MachineClass *pmc =3D PPCE500_MACHINE_GET_CLASS(pms);
>      DeviceState *dev =3D NULL;
>      SysBusDevice *s;
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index c3f8870..15c3dd4 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -74,7 +74,6 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptControll=
er *, Error **),
>                         SpaprInterruptController *intc,
>                         Error **errp)
>  {
> -    MachineState *machine =3D MACHINE(qdev_get_machine());
>      Error *local_err =3D NULL;
> =20
>      if (kvm_enabled() && kvm_kernel_irqchip_allowed()) {
> @@ -287,7 +286,6 @@ uint32_t spapr_irq_nr_msis(SpaprMachineState *spapr)
> =20
>  void spapr_irq_init(SpaprMachineState *spapr, Error **errp)
>  {
> -    MachineState *machine =3D MACHINE(spapr);
>      SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> =20
>      if (kvm_enabled() && kvm_kernel_irqchip_split()) {
> @@ -295,12 +293,6 @@ void spapr_irq_init(SpaprMachineState *spapr, Error =
**errp)
>          return;
>      }
> =20
> -    if (!kvm_enabled() && kvm_kernel_irqchip_required()) {
> -        error_setg(errp,
> -                   "kernel_irqchip requested but only available with KVM=
");
> -        return;
> -    }
> -
>      if (spapr_irq_check(spapr, errp) < 0) {
>          return;
>      }
> --=20
> 1.8.3.1
>=20
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange=
 :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com=
 :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange=
 :|


