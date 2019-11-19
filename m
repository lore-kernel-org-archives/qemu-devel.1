Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA1CFC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:57:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81378222C7
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 11:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZbZQalNh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81378222C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX28Y-0006ZR-MI
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 06:57:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iX27i-00067r-OO
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iX27g-0003yT-PG
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:56:45 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34748
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iX27g-0003y0-Ll
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 06:56:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574164603;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ypHso67iWlVy2Fk4lycI8fWvnSmRJ5HfFhSddcp1xhM=;
 b=ZbZQalNhnWeGkKdsqdkbTWMu7fRxb52znoFMoa8rF+G6P47SJ1hwA13QgHxLVV9lTOG6Go
 sxa+icA3zt7pL9OnBNv8APNjn/2+x64SRHltB3iO4FJpI19Y/EP3yOMCeKFWXqUkECvdzl
 wQL59I1aHtUnpYHCTpxRvTc21RhUs2s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-wMgtxqzTNzGMWPwf7okh5w-1; Tue, 19 Nov 2019 06:56:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A059B1005509
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 11:56:41 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6FB9691A8;
 Tue, 19 Nov 2019 11:56:40 +0000 (UTC)
Subject: Re: [PATCH 15/16] kvm: introduce kvm_kernel_irqchip_* functions
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-16-git-send-email-pbonzini@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <cfa98de2-3bb6-8eef-1edc-6c396e9af121@redhat.com>
Date: Tue, 19 Nov 2019 12:56:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1573655945-14912-16-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: wMgtxqzTNzGMWPwf7okh5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 13/11/2019 15.39, Paolo Bonzini wrote:
> The KVMState struct is opaque, so provide accessors for the fields
> that will be moved from current_machine to the accelerator.  For now
> they just forward to the machine object, but this will change.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  accel/kvm/kvm-all.c  | 23 +++++++++++++++++++----
>  hw/ppc/e500.c        |  4 ++--
>  hw/ppc/spapr_irq.c   | 10 +++++-----
>  include/sysemu/kvm.h |  7 +++++--
>  target/arm/kvm.c     |  8 ++++----
>  target/i386/kvm.c    |  4 ++--
>  target/mips/kvm.c    |  2 +-
>  target/ppc/kvm.c     |  2 +-
>  target/s390x/kvm.c   |  2 +-
>  9 files changed, 40 insertions(+), 22 deletions(-)
[...]
> diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
> index b941608..8b66eb9 100644
> --- a/hw/ppc/spapr_irq.c
> +++ b/hw/ppc/spapr_irq.c
> @@ -77,9 +77,9 @@ int spapr_irq_init_kvm(int (*fn)(SpaprInterruptControll=
er *, Error **),
>      MachineState *machine =3D MACHINE(qdev_get_machine());
>      Error *local_err =3D NULL;
> =20
> -    if (kvm_enabled() && machine_kernel_irqchip_allowed(machine)) {
> +    if (kvm_enabled() && kvm_kernel_irqchip_allowed()) {
>          if (fn(intc, &local_err) < 0) {
> -            if (machine_kernel_irqchip_required(machine)) {
> +            if (kvm_kernel_irqchip_required()) {
>                  error_prepend(&local_err,
>                                "kernel_irqchip requested but unavailable:=
 ");
>                  error_propagate(errp, local_err);
> @@ -184,7 +184,7 @@ static int spapr_irq_check(SpaprMachineState *spapr, =
Error **errp)
>       */
>      if (kvm_enabled() &&
>          spapr->irq =3D=3D &spapr_irq_dual &&
> -        machine_kernel_irqchip_required(machine) &&
> +        kvm_kernel_irqchip_required() &&
>          xics_kvm_has_broken_disconnect(spapr)) {
>          error_setg(errp, "KVM is too old to support ic-mode=3Ddual,kerne=
l-irqchip=3Don");
>          return -1;
> @@ -276,12 +276,12 @@ void spapr_irq_init(SpaprMachineState *spapr, Error=
 **errp)
>      MachineState *machine =3D MACHINE(spapr);
>      SpaprMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
> =20
> -    if (machine_kernel_irqchip_split(machine)) {
> +    if (kvm_enabled() && kvm_kernel_irqchip_split()) {
>          error_setg(errp, "kernel_irqchip split mode not supported on pse=
ries");
>          return;
>      }

Any reason for the additional kvm_enabled() here? I think it should also
be ok without that?

Apart from that question, patch looks fine to me.

 Thomas


