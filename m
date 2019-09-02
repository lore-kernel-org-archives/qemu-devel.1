Return-Path: <SRS0=OFvx=W5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C4DC3A59E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 16:55:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B989A2173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Sep 2019 16:55:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B989A2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i4pbw-0004ck-SJ
	for qemu-devel@archiver.kernel.org; Mon, 02 Sep 2019 12:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mtosatti@redhat.com>) id 1i4pb7-0004Bf-FC
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 12:54:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mtosatti@redhat.com>) id 1i4pb4-0000Wo-SE
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 12:54:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41144)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mtosatti@redhat.com>) id 1i4pb4-0000Ul-M4
 for qemu-devel@nongnu.org; Mon, 02 Sep 2019 12:54:30 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3A9638665D;
 Mon,  2 Sep 2019 16:54:29 +0000 (UTC)
Received: from amt.cnet (ovpn-112-6.gru2.redhat.com [10.97.112.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 683E35D9C3;
 Mon,  2 Sep 2019 16:54:26 +0000 (UTC)
Received: from amt.cnet (localhost [127.0.0.1])
 by amt.cnet (Postfix) with ESMTP id F0D5B10514C;
 Mon,  2 Sep 2019 13:54:02 -0300 (BRT)
Received: (from marcelo@localhost)
 by amt.cnet (8.14.7/8.14.7/Submit) id x82Grwvk028142;
 Mon, 2 Sep 2019 13:53:58 -0300
Date: Mon, 2 Sep 2019 13:53:58 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190902165354.GA27729@amt.cnet>
References: <20190829210711.6570-1-maxiwell@linux.ibm.com>
 <20190829211842.GC3694@habkost.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190829211842.GC3694@habkost.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 02 Sep 2019 16:54:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migration: Do not re-read the clock on
 pre_save in case of paused guest
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
Cc: mst@redhat.com, qemu-devel@nongnu.org,
 "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Looks good.

Reviewed-by: Marcelo Tosatti <mtosatti@redhat.com>

On Thu, Aug 29, 2019 at 06:18:42PM -0300, Eduardo Habkost wrote:
> CCing Marcelo, who wrote kvm_update_clock() and
> kvmclock_pre_save().
> 
> On Thu, Aug 29, 2019 at 06:07:11PM -0300, Maxiwell S. Garcia wrote:
> > The clock move makes the guest knows about the paused time between the
> > 'stop' and 'migrate' commands. This is an issue in an already-paused
> > VM because some side effects, like process stalls, could happen
> > after migration.
> > 
> > So, this patch checks the runstate of guest in the pre_save handler and
> > do not re-reads the clock in case of paused state (cold migration).
> > 
> > Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
> > ---
> >  hw/i386/kvm/clock.c | 15 +++++++++++----
> >  1 file changed, 11 insertions(+), 4 deletions(-)
> > 
> > diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
> > index 80c133a724..2c59b6894b 100644
> > --- a/hw/i386/kvm/clock.c
> > +++ b/hw/i386/kvm/clock.c
> > @@ -41,6 +41,9 @@ typedef struct KVMClockState {
> >      uint64_t clock;
> >      bool clock_valid;
> >  
> > +    /* whether the 'clock' value was obtained in the 'paused' state */
> > +    bool runstate_paused;
> > +
> >      /* whether machine type supports reliable KVM_GET_CLOCK */
> >      bool mach_use_reliable_get_clock;
> >  
> > @@ -202,6 +205,8 @@ static void kvmclock_vm_state_change(void *opaque, int running,
> >              return;
> >          }
> >  
> > +        s->runstate_paused = runstate_check(RUN_STATE_PAUSED);
> > +
> >          kvm_synchronize_all_tsc();
> >  
> >          kvm_update_clock(s);
> > @@ -260,9 +265,9 @@ static int kvmclock_pre_load(void *opaque)
> >  }
> >  
> >  /*
> > - * When migrating, read the clock just before migration,
> > - * so that the guest clock counts during the events
> > - * between:
> > + * When migrating a running guest, read the clock just
> > + * before migration, so that the guest clock counts
> > + * during the events between:
> >   *
> >   *  * vm_stop()
> >   *  *
> > @@ -277,7 +282,9 @@ static int kvmclock_pre_save(void *opaque)
> >  {
> >      KVMClockState *s = opaque;
> >  
> > -    kvm_update_clock(s);
> > +    if (!s->runstate_paused) {
> > +        kvm_update_clock(s);
> > +    }
> >  
> >      return 0;
> >  }
> > -- 
> > 2.20.1
> > 
> 
> -- 
> Eduardo

