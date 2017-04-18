Received: from eggs.gnu.org ([2001:4830:134:3::10]:59887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Mjs-0007xo-8G
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 02:35:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d0Mjo-0004Ny-VX
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 02:35:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d0Mjo-0004Nj-Pa
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 02:35:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8428431F3F8
	for <qemu-devel@nongnu.org>; Tue, 18 Apr 2017 06:35:43 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <ba199bb0-8946-e6c7-0f42-67d296c24afc@redhat.com> (Eric Blake's
	message of "Mon, 17 Apr 2017 15:26:50 -0500")
References: <20170417200041.2451-1-quintela@redhat.com>
	<20170417200041.2451-10-quintela@redhat.com>
	<ba199bb0-8946-e6c7-0f42-67d296c24afc@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 18 Apr 2017 08:35:42 +0200
Message-ID: <874lxmjk8x.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 09/19] migration: Create block capabilities
 for shared and enable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Eric Blake <eblake@redhat.com> wrote:
> On 04/17/2017 03:00 PM, Juan Quintela wrote:
>> This two capabilites were added through the command line.  Notice that
>
> s/This/These/
> s/capabilites/capabilities/
>
>> we just created them.  This is just the boilerplate.
>> 
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> ---
>>  include/migration/migration.h |  3 +++
>>  migration/migration.c         | 36 ++++++++++++++++++++++++++++++++++++
>>  qapi-schema.json              |  7 ++++++-
>>  3 files changed, 45 insertions(+), 1 deletion(-)
>
> I think this is a nice cleanup, even if it is exposing the internal
> block migration (the 'migrate -b' stuff) that we really don't like (it
> is one of the things causing grief at the 2.9-rc4 stage), because users
> should be favoring NBD migration over internal block migration these days.

I am 1st in the queue to remove it, but each time that we talk about
removing it, somebody appears to came to fix it :-p

So, if it has to stay, just update it with the times.

> Reviewed-by: Eric Blake <eblake@redhat.com>
