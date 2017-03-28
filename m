Received: from eggs.gnu.org ([2001:4830:134:3::10]:45241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1csonP-00015q-Fb
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:56:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1csonK-0005J8-HY
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:56:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1csonK-0005IZ-CF
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 06:56:10 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5176A61D13
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 10:56:09 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20170327073407.GB11497@pxdev.xzpeter.org> (Peter Xu's message of
	"Mon, 27 Mar 2017 15:34:07 +0800")
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-6-quintela@redhat.com>
	<20170327073407.GB11497@pxdev.xzpeter.org>
Reply-To: quintela@redhat.com
Date: Tue, 28 Mar 2017 12:56:06 +0200
Message-ID: <87wpb9r7p5.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 05/51] ram: Move bitmap_sync_count into
 RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com

Peter Xu <peterx@redhat.com> wrote:
> On Thu, Mar 23, 2017 at 09:44:58PM +0100, Juan Quintela wrote:
>> Signed-off-by: Juan Quintela <quintela@redhat.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
>
> (I see that we have MigrationStats.dirty_pages_rate which looks
>  similar to this one. Maybe one day we can merge these two?)

no, this one is how many times we have synchronized the dirty bitmap
with kvm/rest of qemu.
dirty_pages_rame is the pages we have dirtied in some <period>.

Period is not clear, it tries to be around one second, but that part is
not specially well done.

Later, Juan.
