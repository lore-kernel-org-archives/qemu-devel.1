Received: from eggs.gnu.org ([2001:4830:134:3::10]:39217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fhtW4-00013C-52
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fhtVx-0007d8-QV
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:22:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44314 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fhtVx-0007d4-MW
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 05:21:53 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39CBF81A4EA7
	for <qemu-devel@nongnu.org>; Tue, 24 Jul 2018 09:21:53 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180723123305.24792-3-peterx@redhat.com> (Peter Xu's message of
	"Mon, 23 Jul 2018 20:33:03 +0800")
References: <20180723123305.24792-1-peterx@redhat.com>
	<20180723123305.24792-3-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 24 Jul 2018 11:21:47 +0200
Message-ID: <877ellgf9w.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH for-3.0 2/4] migration: disallow recovery
 for release-ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> Postcopy recovery won't work well with release-ram capability since
> release-ram will drop the page buffer as long as the page is put into
> the send buffer.  So if there is a network failure happened, any page
> buffers that have not yet reached the destination VM but have already
> been sent from the source VM will be lost forever.  Let's refuse the
> client from resuming such a postcopy migration.  Luckily release-ram was
> designed to only be used when src and destination VMs are on the same
> host, so it should be fine.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>

I wonder if we should have a FAQ somewhere and point an URL to there.
