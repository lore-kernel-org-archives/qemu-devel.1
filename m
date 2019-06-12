Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_HK_NAME_DR,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7D9C31E47
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5737221734
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 15:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5737221734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33162 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb5J9-0005E0-Gu
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 11:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36968)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hb5FF-0002zY-Gf
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:33:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hb5FC-0002Hb-QR
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:33:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46954)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hb5FB-0002FU-JP
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 11:32:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 214C630872E6
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 15:32:49 +0000 (UTC)
Received: from work-vm (ovpn-117-119.ams2.redhat.com [10.36.117.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CF094647C;
 Wed, 12 Jun 2019 15:32:42 +0000 (UTC)
Date: Wed, 12 Jun 2019 16:32:40 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190612153239.GE2691@work-vm>
References: <20190610184402.7090-1-dgilbert@redhat.com>
 <20190610184402.7090-4-dgilbert@redhat.com>
 <e602e259-f5db-c73a-7a4e-f63a2d48e85c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e602e259-f5db-c73a-7a4e-f63a2d48e85c@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Wed, 12 Jun 2019 15:32:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 3/4] net/announce: Add optional ID
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
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, laine@redhat.com,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Eric Blake (eblake@redhat.com) wrote:
> On 6/10/19 1:44 PM, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Previously there was a single instance of the timer used by
> > monitor triggered announces, that's OK, but when combined with the
> > previous change that lets you have announces for subsets of interfaces
> > it's a bit restrictive if you want to do different things to different
> > interfaces.
> > 
> > Add an 'id' field to the announce, and maintain a list of the
> > timers based on id.
> > 
> > This allows you to for example:
> >     a) Start an announce going on interface eth0 for a long time
> >     b) Start an announce going on interface eth1 for a long time
> >     c) Kill the announce on eth0 while leaving eth1 going.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> 
> > +++ b/include/net/announce.h
> > @@ -23,8 +23,12 @@ struct AnnounceTimer {
> >  /* Returns: update the timer to the next time point */
> >  int64_t qemu_announce_timer_step(AnnounceTimer *timer);
> >  
> > -/* Delete the underlying timer and other data */
> > -void qemu_announce_timer_del(AnnounceTimer *timer);
> > +/*
> > + * Delete the underlying timer and other datas
> 
> 'data' is already plural, 'datas' is not a word.

oops yes, fixed.

> > + * If 'free_named' true and the timer is a named timer, then remove
> > + * it from the list of named timers and free the AnnounceTimer itself.
> > + */
> > +void qemu_announce_timer_del(AnnounceTimer *timer, bool free_named);
> >  
> 
> > +++ b/qapi/net.json
> > @@ -702,6 +702,10 @@
> >  # @interfaces: An optional list of interface names, which restrict the
> >  #        announcment to the listed interfaces. (Since 4.1)
> >  #
> > +# @id: A name to be used to identify an instance of announce-timers
> > +#        and to allow it to modified later.  Not for use as
> > +#        part of the migration paramters. (Since 4.1)
> 
> parameters

Fixed.

> > +#
> >  # Since: 4.0
> >  ##
> >  
> > @@ -710,7 +714,8 @@
> >              'max': 'int',
> >              'rounds': 'int',
> >              'step': 'int',
> > -            '*interfaces': ['str'] } }
> > +            '*interfaces': ['str'],
> > +            '*id' : 'str' } }
> >  
> >  ##
> >  # @announce-self:
> > @@ -725,7 +730,7 @@
> >  # -> { "execute": "announce-self",
> >  #      "arguments": {
> >  #          "initial": 50, "max": 550, "rounds": 10, "step": 50,
> > -#          "interfaces": ["vn2","vn3"] } }
> > +#          "interfaces": ["vn2","vn3"], "id": "bob" } }
> >  # <- { "return": {} }
> >  #
> 
> Worth an example of deleting a timer by id?
> 

The syntax is actually the same - the only thing you need to do
to cancel is set 'rounds' to 0 for the named id.

> >  # Since: 4.0
> > diff --git a/tests/virtio-net-test.c b/tests/virtio-net-test.c
> > index 163126cf07..7184e2bff4 100644
> > --- a/tests/virtio-net-test.c
> > +++ b/tests/virtio-net-test.c
> > @@ -186,7 +186,7 @@ static void announce_self(void *obj, void *data, QGuestAllocator *t_alloc)
> >      rsp = qmp("{ 'execute' : 'announce-self', "
> >                    " 'arguments': {"
> >                        " 'initial': 50, 'max': 550,"
> > -                      " 'rounds': 10, 'step': 50 } }");
> > +                      " 'rounds': 10, 'step': 50, 'id': 'bob' } }");
> 
> And here, is it worth testing that you can delete by id, rather than
> just create with an id?

OK, I'll have a look at how painful that is.

Dave

> >      assert(!qdict_haskey(rsp, "error"));
> >      qobject_unref(rsp);
> >  
> > 
> 
> -- 
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
> 



--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

