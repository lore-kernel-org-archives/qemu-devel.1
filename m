Return-Path: <SRS0=xsRN=VS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B797C76188
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 10:05:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 341DA2084C
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jul 2019 10:05:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 341DA2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55262 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hp8iG-0002pj-8L
	for qemu-devel@archiver.kernel.org; Sun, 21 Jul 2019 06:05:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51895)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hp8i6-0002RQ-DG
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 06:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hp8i5-0005RU-A0
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 06:04:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hp8i5-0005Qm-4x
 for qemu-devel@nongnu.org; Sun, 21 Jul 2019 06:04:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5A8AE356E7;
 Sun, 21 Jul 2019 10:04:51 +0000 (UTC)
Received: from redhat.com (ovpn-120-23.rdu2.redhat.com [10.10.120.23])
 by smtp.corp.redhat.com (Postfix) with SMTP id 91FEE600C6;
 Sun, 21 Jul 2019 10:04:47 +0000 (UTC)
Date: Sun, 21 Jul 2019 06:04:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <20190721060409-mutt-send-email-mst@kernel.org>
References: <a84b7e03-f9a8-b577-be27-4d93d1caa1c9@siemens.com>
 <20190602174041-mutt-send-email-mst@kernel.org>
 <2d735fe7-d451-207d-eca9-2796cad7e778@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d735fe7-d451-207d-eca9-2796cad7e778@web.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Sun, 21 Jul 2019 10:04:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] ioapic: kvm: Skip route updates for masked
 pins
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Jul 21, 2019 at 10:58:42AM +0200, Jan Kiszka wrote:
> On 03.06.19 02:36, Michael S. Tsirkin wrote:
> > On Sun, Jun 02, 2019 at 01:42:13PM +0200, Jan Kiszka wrote:
> >> From: Jan Kiszka <jan.kiszka@siemens.com>
> >>
> >> Masked entries will not generate interrupt messages, thus do no need to
> >> be routed by KVM. This is a cosmetic cleanup, just avoiding warnings of
> >> the kind
> >>
> >> qemu-system-x86_64: vtd_irte_get: detected non-present IRTE (index=0, high=0xff00, low=0x100)
> >>
> >> if the masked entry happens to reference a non-present IRTE.
> >>
> >> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> >
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >
> >> ---
> >>  hw/intc/ioapic.c | 8 +++++---
> >>  1 file changed, 5 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
> >> index 7074489fdf..2fb288a22d 100644
> >> --- a/hw/intc/ioapic.c
> >> +++ b/hw/intc/ioapic.c
> >> @@ -197,9 +197,11 @@ static void ioapic_update_kvm_routes(IOAPICCommonState *s)
> >>              MSIMessage msg;
> >>              struct ioapic_entry_info info;
> >>              ioapic_entry_parse(s->ioredtbl[i], &info);
> >> -            msg.address = info.addr;
> >> -            msg.data = info.data;
> >> -            kvm_irqchip_update_msi_route(kvm_state, i, msg, NULL);
> >> +            if (!info.masked) {
> >> +                msg.address = info.addr;
> >> +                msg.data = info.data;
> >> +                kvm_irqchip_update_msi_route(kvm_state, i, msg, NULL);
> >> +            }
> >>          }
> >>          kvm_irqchip_commit_routes(kvm_state);
> >>      }
> >> --
> >> 2.16.4
> >
> >
> 
> Ping. Or is this queued for 4.2?
> 
> Jan

Paolo was queueing ioapic things recently. I can take this if
he doesn't respond until I pack up my next pull req.

-- 
MST

