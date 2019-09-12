Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1CFC4CEC7
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 17:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7733A20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 17:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7733A20830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8TCI-0004Gs-Pr
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 13:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49153)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8T9v-0002s0-Qa
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8T9t-0006hr-0t
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:45:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33392)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8T9s-0006h0-S5
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 13:45:28 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2394B8AC6FF
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 17:45:28 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E6DB95C22C;
 Thu, 12 Sep 2019 17:45:26 +0000 (UTC)
Date: Thu, 12 Sep 2019 18:45:24 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190912174524.GD2722@work-vm>
References: <20190911190622.7629-1-dgilbert@redhat.com>
 <20190911190622.7629-2-dgilbert@redhat.com>
 <e8802180-3c9a-97b9-dae1-5e07d7843de3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8802180-3c9a-97b9-dae1-5e07d7843de3@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Thu, 12 Sep 2019 17:45:28 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/5] rcu: Add automatically released
 rcu_read_lock variant
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
Cc: quintela@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> On 11/09/19 21:06, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > RCU_READ_LOCK_AUTO takes the rcu_read_lock and then uses glib's
> > g_auto infrastructure (and thus whatever the compiler's hooks are) to
> > release it on all exits of the block.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  include/qemu/rcu.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> > 
> > diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
> > index 22876d1428..8768a7b60a 100644
> > --- a/include/qemu/rcu.h
> > +++ b/include/qemu/rcu.h
> > @@ -154,6 +154,24 @@ extern void call_rcu1(struct rcu_head *head, RCUCBFunc *func);
> >        }),                                                                \
> >        (RCUCBFunc *)g_free);
> >  
> > +typedef void RCUReadAuto;
> > +static inline RCUReadAuto *rcu_read_auto_lock(void)
> > +{
> > +    rcu_read_lock();
> > +    /* Anything non-NULL causes the cleanup function to be called */
> > +    return (void *)0x1;
> 
> Doesn't this cause a warning (should be "(void *)(uintptr_t)1" instead)?

Apparently not, but I'll change it anyway.

> > +}
> > +
> > +static inline void rcu_read_auto_unlock(RCUReadAuto *r)
> > +{
> > +    rcu_read_unlock();
> > +}
> > +
> > +G_DEFINE_AUTOPTR_CLEANUP_FUNC(RCUReadAuto, rcu_read_auto_unlock)
> > +
> > +#define RCU_READ_LOCK_AUTO \
> > +    g_autoptr(RCUReadAuto) _rcu_read_auto = rcu_read_auto_lock()
> > +
> >  #ifdef __cplusplus
> >  }
> >  #endif
> > 
> 
> Is it possible to make this a scope, like
> 
> 	WITH_RCU_READ_LOCK() {
> 	}
> 
> ?  Perhaps something like
> 
> #define WITH_RCU_READ_LOCK()  \
> 	WITH_RCU_READ_LOCK_(_rcu_read_auto##__COUNTER__)
> 
> #define WITH_RCU_READ_LOCK_(var) \
> 	for (g_autoptr(RCUReadAuto) var = rcu_read_auto_lock();
> 	     (var); rcu_read_auto_unlock(), (var) = NULL)
> 
> where the dummy variable doubles as an execute-once guard and the gauto
> cleanup is still used in case of a "break".  I'm not sure if the above
> raises a warning because of the variable declaration inside the for
> loop, though.

Yes, that works - I'm not seeing any warnings.

Do you think it's best to use the block version for all cases
or to use the non-block version by taste?
The block version is quite nice, but that turns most of the patches
into 'indent everything'.

Dave

> Thanks,
> 
> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

