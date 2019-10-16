Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41C09C4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 07:08:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149BC2082C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 07:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149BC2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKdQC-0003A7-43
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 03:08:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34576)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jfreimann@redhat.com>) id 1iKdPL-0002i1-4D
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 03:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jfreimann@redhat.com>) id 1iKdPK-0000jI-2W
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 03:07:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42022)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jfreimann@redhat.com>)
 id 1iKdPJ-0000hO-QU
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 03:07:42 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB99C85360;
 Wed, 16 Oct 2019 07:07:40 +0000 (UTC)
Received: from localhost (dhcp-192-238.str.redhat.com [10.33.192.238])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACED619D70;
 Wed, 16 Oct 2019 07:07:32 +0000 (UTC)
Date: Wed, 16 Oct 2019 09:07:31 +0200
From: Jens Freimann <jfreimann@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v3 07/10] migration: add new migration state wait-unplug
Message-ID: <20191016070731.vi2svfs2er5fmefr@jenstp.localdomain>
References: <20191011112015.11785-1-jfreimann@redhat.com>
 <20191011112015.11785-8-jfreimann@redhat.com>
 <20191011171133.GU3354@work-vm>
 <20191015094525.zqq4534ghe3l2ngr@jenstp.localdomain>
 <20191015105008.GE3073@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20191015105008.GE3073@work-vm>
User-Agent: NeoMutt/20180716-1376-5d6ed1
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 16 Oct 2019 07:07:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: ehabkost@redhat.com, mst@redhat.com, aadam@redhat.com,
 qemu-devel@nongnu.org, alex.williamson@redhat.com, laine@redhat.com,
 ailan@redhat.com, parav@mellanox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 15, 2019 at 11:50:08AM +0100, Dr. David Alan Gilbert wrote:
>* Jens Freimann (jfreimann@redhat.com) wrote:
>> On Fri, Oct 11, 2019 at 06:11:33PM +0100, Dr. David Alan Gilbert wrote:
>> > * Jens Freimann (jfreimann@redhat.com) wrote:
>> > > This patch adds a new migration state called wait-unplug.  It is entered
>> > > after the SETUP state and will transition into ACTIVE once all devices
>> > > were succesfully unplugged from the guest.
>> > >
>> > > So if a guest doesn't respond or takes long to honor the unplug request
>> > > the user will see the migration state 'wait-unplug'.
>> > >
>> > > In the migration thread we query failover devices if they're are still
>> > > pending the guest unplug. When all are unplugged the migration
>> > > continues. We give it a defined number of iterations including small
>> > > waiting periods before we proceed.
>> > >
>> > > Signed-off-by: Jens Freimann <jfreimann@redhat.com>
>> [..]
>> > > +    while (i < FAILOVER_UNPLUG_RETRIES &&
>> > > +           s->state == MIGRATION_STATUS_WAIT_UNPLUG) {
>> > > +        i++;
>> > > +        qemu_sem_timedwait(&s->wait_unplug_sem, FAILOVER_GUEST_UNPLUG_WAIT);
>> > > +        all_unplugged = qemu_savevm_state_guest_unplug_pending();
>> > > +        if (all_unplugged) {
>> > > +            break;
>> > > +        }
>> > > +    }
>> > > +
>> > > +    if (all_unplugged) {
>> > > +        migrate_set_state(&s->state, MIGRATION_STATUS_WAIT_UNPLUG,
>> > > +                MIGRATION_STATUS_ACTIVE);
>> > > +    } else {
>> > > +        migrate_set_state(&s->state, MIGRATION_STATUS_WAIT_UNPLUG,
>> > > +                          MIGRATION_STATUS_CANCELLING);
>> > > +    }
>> >
>> > I think you can get rid of both the timeout and the count and just make
>> > sure that migrate_cancel works at this point.
>>
>> I see, I need to add the new state to migration_is_setup_or_active() or
>> a cancel won't work.
>
>You probably need to do that anyway given all the other places
>is_setup_or_active is called.

Yes, done.

>> > This pushes the problem up a layer, which I think is fine.
>>
>> Seems good to me. To be clear, you're saying I should just poll on
>> the device unplugged state? Like
>>
>>         while (s->state == MIGRATION_STATUS_WAIT_UNPLUG &&
>>                !qemu_savevm_state_guest_unplug_pending()) {
>> _            /* This block intentionally left blank */
>>         }
>
>I'd keep the qemu_sem_timedwait in there, but with a short time out
>(e.g. 250ms say); that way it doesn't eat cpu, but also the cancel still
>happens quickly.

Yes, that's what I do now and it works fine.

Thanks!

regards,
Jens 

