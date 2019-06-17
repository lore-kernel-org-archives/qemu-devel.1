Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5791C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:51:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC1A20657
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:51:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC1A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50622 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvnB-0006ho-CR
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49701)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hcvlB-0005de-D9
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:49:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hcvlA-0006uL-9T
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:49:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39902)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hcvlA-0006s9-2D
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 13:49:36 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9440330F1BB3;
 Mon, 17 Jun 2019 17:49:24 +0000 (UTC)
Received: from localhost (ovpn-116-100.phx2.redhat.com [10.3.116.100])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EAB09F62;
 Mon, 17 Jun 2019 17:49:20 +0000 (UTC)
Date: Mon, 17 Jun 2019 14:49:17 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Roman Kagan <rkagan@virtuozzo.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Vadim Rozenfeld <vrozenfe@redhat.com>
Message-ID: <20190617174917.GE19178@habkost.net>
References: <20190615200505.31348-1-ehabkost@redhat.com>
 <20190617134856.GF32624@rkaganb.sw.ru>
 <20190617142301.GA19178@habkost.net>
 <20190617173210.GG32624@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190617173210.GG32624@rkaganb.sw.ru>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 17 Jun 2019 17:49:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] i386: Fix signedness of
 hyperv_spinlock_attempts
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 17, 2019 at 05:32:13PM +0000, Roman Kagan wrote:
> On Mon, Jun 17, 2019 at 11:23:01AM -0300, Eduardo Habkost wrote:
> > On Mon, Jun 17, 2019 at 01:48:59PM +0000, Roman Kagan wrote:
> > > On Sat, Jun 15, 2019 at 05:05:05PM -0300, Eduardo Habkost wrote:
> > > > The current default value for hv-spinlocks is 0xFFFFFFFF (meaning
> > > > "never retry").  However, the value is stored as a signed
> > > > integer, making the getter of the hv-spinlocks QOM property
> > > > return -1 instead of 0xFFFFFFFF.
> > > > 
> > > > Fix this by changing the type of X86CPU::hyperv_spinlock_attempts
> > > > to uint32_t.  This has no visible effect to guest operating
> > > > systems, affecting just the behavior of the QOM getter.
> > > > 
> > > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > > > ---
> > > >  target/i386/cpu.h | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
> > > 
> > > That said, it's tempting to just nuke qdev_prop_spinlocks and make
> > > hv-spinlocks a regular DEFINE_PROP_UINT32...
> > 
> > Agreed.  The only difference is that we would validate the
> > property at realize time instead of object_property_set().
> 
> Right.  But currently it's validated to be no less than 0xfff and no
> bigger than 0xffffffff.  The latter check would become unnecessary, and
> I'm unable to find any reason to do the former (neither spec references
> nor the log messages of the commits that introduced it).

The 0xFFF lower limit was originally introduced by commit
28f52cc04d34 ("hyper-v: introduce Hyper-V support infrastructure").

Vadim, do you know where the 0xFFF limit comes from?

-- 
Eduardo

