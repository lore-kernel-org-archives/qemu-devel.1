Received: from eggs.gnu.org ([2001:4830:134:3::10]:44889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dZaRc-0005y2-LD
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dZaRY-0004Io-NC
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:18:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:1603)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dZaRY-0004HX-Gu
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 06:18:28 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 814467F408
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 10:18:24 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170720084755.GB21566@redhat.com> (Daniel P. Berrange's message
	of "Thu, 20 Jul 2017 09:47:55 +0100")
References: <20170717134238.1966-1-quintela@redhat.com>
	<20170717134238.1966-2-quintela@redhat.com>
	<20170719150109.GN2103@work-vm>
	<20170720070023.GA23385@pxdev.xzpeter.org>
	<20170720084755.GB21566@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 24 Jul 2017 12:18:21 +0200
Message-ID: <87bmoa87f6.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v5 01/17] migrate: Add gboolean return type
 to migrate_channel_process_incoming
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com

"Daniel P. Berrange" <berrange@redhat.com> wrote:
> On Thu, Jul 20, 2017 at 03:00:23PM +0800, Peter Xu wrote:
>> On Wed, Jul 19, 2017 at 04:01:10PM +0100, Dr. David Alan Gilbert wrote:
>> > * Juan Quintela (quintela@redhat.com) wrote:
>> > >  
>> > > -void migration_channel_process_incoming(QIOChannel *ioc);
>> > > +gboolean migration_channel_process_incoming(QIOChannel *ioc);
>> > 
>> > Can you add a comment here that says what the return value means.

Added comment for the two functions (in the .c file through)

>> 
>> And, looks like we have G_SOURCE_CONTINUE and G_SOURCE_REMOVE:

Used this ones, thanks.

>> https://developer.gnome.org/glib/stable/glib-The-Main-Event-Loop.html#G-SOURCE-CONTINUE:CAPS
>> 
>> Maybe we can use them as well?
>
> Those are newer than our min required glib version, though we could
> add compat defines for them

Added the compatibility macros.

Thanks to all of you, Juan.
