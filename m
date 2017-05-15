Received: from eggs.gnu.org ([2001:4830:134:3::10]:60018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dAKnl-0004Dh-Ty
	for qemu-devel@nongnu.org; Mon, 15 May 2017 14:33:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dAKni-0001eM-LJ
	for qemu-devel@nongnu.org; Mon, 15 May 2017 14:33:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dAKni-0001dq-F8
	for qemu-devel@nongnu.org; Mon, 15 May 2017 14:32:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 23FDB80C17
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 18:32:57 +0000 (UTC)
Date: Mon, 15 May 2017 19:32:51 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170515183251.GJ2089@work-vm>
References: <5bab598f-30eb-fcf6-9d06-8f683b466414@redhat.com>
	<87lgpyfo28.fsf@secure.mitica> <87k25iqf4m.fsf@dusky.pond.sub.org>
	<87efvqdqqj.fsf@secure.mitica> <20170515163841.GB2324@work-vm>
	<87a86edpot.fsf@secure.mitica> <20170515172736.GA26717@work-vm>
	<871srqdnvw.fsf@secure.mitica> <20170515173834.GI2089@work-vm>
	<87wp9ic8ts.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wp9ic8ts.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH 2/3] migration: Remove use of old
 MigrationParams
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, lvivier@redhat.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

* Juan Quintela (quintela@redhat.com) wrote:
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> 
> >> Forget -b/-i.
> >> 
> >> migration_set_parameter compression_threads 8
> >> 
> >> migrate <foo>
> >> 
> >> We don't use compression_threads at all
> >> 
> >> migrate_set_capability compress
> >> 
> >> migrate <foo>
> >> 
> >> Now, we use compression threads.
> >> 
> >> So, compression_threads parameter is a parameter that is only used when
> >> compress capability is enabled.
> >> 
> >> Same for block migration.  Block_incremental parameter is used only when
> >> block migration capability is setup.  No dependency check needed at all.
> >> 
> >> Or I am losing something obvious here?
> >
> > Ah, you've made up a new rule
> 
> Oops, I thought that was a rule on how things worked O:-)
> 
> >- I don't think it's a bad rule
> > but is it true? Do we always enable a capability before we use a
> > parameter? I don't think so - I think the tls parameters don't have
> > a capability.
> 
> To use tls paramater, we need to use an url with tls, no?
> 
> > My previous rule was just that if it was a bool it was a capability
> > and you can have whatever dependencies you like there - or none.
> 
> Dunno.
> 
> If you think that we can document it (one way or another), I am for it.
> 
> It is really weird that we both thought (reading) the interface that the
> rules are different O:-)

Well I think that's because no one ever defined any rules!  We just
created parameters because we needed something that could take
non-boolean values, but I don't think there's anything more
about the structure of their use that's actually defined.
Similarly, I don't think there's anything defined about the
structure of capabilities.

Dave

> Later, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
