Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72BAC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 19:52:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD09820674
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 19:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD09820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2hVc-0001au-Tv
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 15:52:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40433)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i2hTV-0008P4-Kb
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 15:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i2hTU-0001Nd-M5
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 15:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:5603)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i2hTU-0001N7-H3
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 15:49:52 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0E2BE3CA0C;
 Tue, 27 Aug 2019 19:49:51 +0000 (UTC)
Received: from localhost (ovpn-116-73.gru2.redhat.com [10.97.116.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 81EC160933;
 Tue, 27 Aug 2019 19:49:50 +0000 (UTC)
Date: Tue, 27 Aug 2019 16:49:48 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <20190827194948.GB7077@habkost.net>
References: <f056c7e5-fa74-469c-87f8-0f0925301b2d@web.de>
 <90ea3127-5e26-ed2a-4ad7-d30445bcf53a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90ea3127-5e26-ed2a-4ad7-d30445bcf53a@web.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 27 Aug 2019 19:49:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] i386/vmmouse: Properly reset state
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
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 25, 2019 at 04:58:18PM +0200, Jan Kiszka wrote:
> On 21.07.19 10:58, Jan Kiszka wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > 
> > nb_queue was not zeroed so that we no longer delivered events if a
> > previous guest left the device in an overflow state.
> > 
> > The state of absolute does not matter as the next vmmouse_update_handler
> > call will align it again.
> > 
> > Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> > ---
> >   hw/i386/vmmouse.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
> > index 5d2d278be4..e335bd07da 100644
> > --- a/hw/i386/vmmouse.c
> > +++ b/hw/i386/vmmouse.c
> > @@ -257,6 +257,7 @@ static void vmmouse_reset(DeviceState *d)
> >       VMMouseState *s = VMMOUSE(d);
> > 
> >       s->queue_size = VMMOUSE_QUEUE_SIZE;
> > +    s->nb_queue = 0;
> > 
> >       vmmouse_disable(s);
> >   }
> > --
> > 2.16.4
> > 
> > 
> 
> Ping - or who is looking after this?

Despite being in hw/i386, I think we can say vmmouse.c doesn't
have a maintainer.  Last time someone changed vmmouse.c in a
meaningful way (not just adapting to API changes or removing
duplicate code) was in 2012.

But the change makes sense to me, so:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

I'll queue it.

-- 
Eduardo

