Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A40A0C5ACAE
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 18:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 801D020578
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 18:53:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 801D020578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i87kD-0007PK-IG
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 14:53:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51097)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1i87jJ-0006xj-Gy
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 14:52:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1i87jI-0006Vo-HD
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 14:52:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55836)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1i87jI-0006Um-BK
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 14:52:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6CF2110CC1E3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 18:52:35 +0000 (UTC)
Received: from work-vm (ovpn-117-243.ams2.redhat.com [10.36.117.243])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 41DAD1001944;
 Wed, 11 Sep 2019 18:52:34 +0000 (UTC)
Date: Wed, 11 Sep 2019 19:52:31 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190911185231.GO2894@work-vm>
References: <20190911164202.31136-1-dgilbert@redhat.com>
 <20190911164202.31136-2-dgilbert@redhat.com>
 <1a03f787-5cf8-6b8e-7489-3f90c3311032@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a03f787-5cf8-6b8e-7489-3f90c3311032@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Wed, 11 Sep 2019 18:52:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/3] rcu: Add automatically released
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
Cc: pbonzini@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Blake (eblake@redhat.com) wrote:
> On 9/11/19 11:42 AM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > RCU_READ_LOCK_AUTO takes the rcu_read_lock  and then uses glib's
> > g_auto infrastrcture (and thus whatever the compilers hooks are) to
> > release it on all exits of the block.
> > 
> > Note this macro has a variable declaration in, and hence is not in
> > a while loop.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  include/qemu/rcu.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
> > index 22876d1428..6a25b27d28 100644
> > --- a/include/qemu/rcu.h
> > +++ b/include/qemu/rcu.h
> > @@ -154,6 +154,18 @@ extern void call_rcu1(struct rcu_head *head, RCUCBFunc *func);
> >        }),                                                                \
> >        (RCUCBFunc *)g_free);
> >  
> > +typedef char rcu_read_auto_t;
> 
> Declaring new types ending in _t collides with the namespace reserved by
> POSIX.  While I don't think it will bite us, it's still worth
> considering if a different name is better.

Thanks, I've renamed it to 'RCUReadAuto' which is closer to what we
normally use for typedef's (albeit normally of structs)

Dave

> > +static inline void rcu_read_auto_unlock(rcu_read_auto_t *r)
> > +{
> > +  rcu_read_unlock();
> > +}
> > +
> > +G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(rcu_read_auto_t, rcu_read_auto_unlock)
> > +
> > +#define RCU_READ_LOCK_AUTO g_auto(rcu_read_auto_t) \
> > +    _rcu_read_auto = 'x'; \
> 
> I'm a bit lost at where _rcu_read_auto is declared.  (I could understand
> if an earlier macro had created that typedef via concatenating _ with
> rcu_read_auto_t, but making the preprocessor drop _t is not possible. Is
> this a typo, and if so, why did the compiler not complain?)
> 
> > +    rcu_read_lock();
> > +
> >  #ifdef __cplusplus
> >  }
> >  #endif
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

