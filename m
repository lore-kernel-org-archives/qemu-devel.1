Received: from eggs.gnu.org ([2001:4830:134:3::10]:43971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXIu2-00033Z-HC
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:10:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dXItz-0007J8-Ap
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:10:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dXItz-0007Im-4E
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 23:10:23 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D844C356E4
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 03:10:21 +0000 (UTC)
Date: Tue, 18 Jul 2017 11:10:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170718031021.GC27284@pxdev.xzpeter.org>
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
	<1500279971-13875-11-git-send-email-peterx@redhat.com>
	<87vamryohn.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87vamryohn.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH v2 10/11] migration: provide
 migrate_cap_add()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jul 17, 2017 at 07:14:44PM +0200, Juan Quintela wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > Abstracted from migrate_set_block_enabled() to allocate
> > MigrationCapabilityStatusList properly.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> 
> 
> Nitpick
> 
> > -void migrate_set_block_enabled(bool value, Error **errp)
> > +static MigrationCapabilityStatusList *migrate_cap_add(
> > +    MigrationCapabilityStatusList *head,
> 
> We have a parameter called head
> 
> > +    MigrationCapability index,
> > +    bool state)
> >  {
> >      MigrationCapabilityStatusList *cap;
> >  
> >      cap = g_new0(MigrationCapabilityStatusList, 1);
> >      cap->value = g_new0(MigrationCapabilityStatus, 1);
> > -    cap->value->capability = MIGRATION_CAPABILITY_BLOCK;
> > -    cap->value->state = value;
> > +    cap->value->capability = index;
> > +    cap->value->state = state;
> > +    cap->next = head;
> > +
> > +    return cap;
> 
> 
> But we don't do the *head = cap?
> 
> Pelhaps is better to call it "next" or "list"?

It's the (old) head, but sure. :)

Thanks,

-- 
Peter Xu
