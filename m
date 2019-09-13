Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD945C4CEC9
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 18:46:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D0C920830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 18:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D0C920830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8qaM-00043F-Ns
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 14:46:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53603)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i8qZD-0003Ym-HO
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i8qZC-0002Qm-87
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:45:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52248)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i8qZB-0002QZ-Vx
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 14:45:10 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 47E7E3086202
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2019 18:45:09 +0000 (UTC)
Received: from work-vm (unknown [10.36.118.12])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1899760925;
 Fri, 13 Sep 2019 18:45:07 +0000 (UTC)
Date: Fri, 13 Sep 2019 19:45:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190913184505.GG2682@work-vm>
References: <20190913102538.24167-1-dgilbert@redhat.com>
 <20190913102538.24167-2-dgilbert@redhat.com>
 <db74dc28-361e-a3a6-218d-0cedb83ee21d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db74dc28-361e-a3a6-218d-0cedb83ee21d@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 13 Sep 2019 18:45:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 1/5] rcu: Add automatically released
 rcu_read_lock variants
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
> On 13/09/19 12:25, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > RCU_READ_LOCK_GUARD() takes the rcu_read_lock and then uses glib's
> > g_auto infrastructure (and thus whatever the compiler's hooks are) to
> > release it on all exits of the block.
> > 
> > WITH_RCU_READ_LOCK_GUARD() is similar but is used as a wrapper for the
> > lock, i.e.:
> > 
> >    WITH_RCU_READ_LOCK_GUARD() {
> >        stuff under lock
> >    }
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  docs/devel/rcu.txt | 16 ++++++++++++++++
> >  include/qemu/rcu.h | 25 +++++++++++++++++++++++++
> >  2 files changed, 41 insertions(+)
> > 
> > diff --git a/docs/devel/rcu.txt b/docs/devel/rcu.txt
> > index c84e7f42b2..d83fed2f79 100644
> > --- a/docs/devel/rcu.txt
> > +++ b/docs/devel/rcu.txt
> > @@ -187,6 +187,22 @@ The following APIs must be used before RCU is used in a thread:
> >  Note that these APIs are relatively heavyweight, and should _not_ be
> >  nested.
> >  
> > +Convenience macros
> > +==================
> > +
> > +Two macros are provided that automatically release the read lock at the
> > +end of the scope.
> > +
> > +      RCU_READ_LOCK_GUARD()
> > +
> > +         Takes the lock and will release it at the end of the block it's
> > +         used in.
> > +
> > +      WITH_RCU_READ_LOCK_GUARD()  { code }
> > +
> > +         Is used at the head of a block to protect the code within the block.
> > +
> > +Note that 'goto'ing out of the guarded block will also drop the lock.
> >  
> >  DIFFERENCES WITH LINUX
> >  ======================
> > diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
> > index 22876d1428..3a8d4cf28b 100644
> > --- a/include/qemu/rcu.h
> > +++ b/include/qemu/rcu.h
> > @@ -154,6 +154,31 @@ extern void call_rcu1(struct rcu_head *head, RCUCBFunc *func);
> >        }),                                                                \
> >        (RCUCBFunc *)g_free);
> >  
> > +typedef void RCUReadAuto;
> > +static inline RCUReadAuto *rcu_read_auto_lock(void)
> > +{
> > +    rcu_read_lock();
> > +    /* Anything non-NULL causes the cleanup function to be called */
> > +    return (void *)(uintptr_t)0x1;
> > +}
> > +
> > +static inline void rcu_read_auto_unlock(RCUReadAuto *r)
> > +{
> > +    rcu_read_unlock();
> > +}
> > +
> > +G_DEFINE_AUTOPTR_CLEANUP_FUNC(RCUReadAuto, rcu_read_auto_unlock)
> > +
> > +#define WITH_RCU_READ_LOCK_GUARD() \
> > +    WITH_RCU_READ_LOCK_GUARD_(_rcu_read_auto##__COUNTER__)
> > +
> > +#define WITH_RCU_READ_LOCK_GUARD_(var) \
> > +    for (g_autoptr(RCUReadAuto) var = rcu_read_auto_lock(); \
> > +        (var); rcu_read_auto_unlock(var), (var) = NULL)
> > +
> > +#define RCU_READ_LOCK_GUARD() \
> > +    g_autoptr(RCUReadAuto) _rcu_read_auto = rcu_read_auto_lock()
> > +
> >  #ifdef __cplusplus
> >  }
> >  #endif
> > 
> 
> Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Can you look at the other bits of this series and tell me if they're OK?
If they are, do you want to take them (since it's RCU based)?

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

