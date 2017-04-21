Received: from eggs.gnu.org ([2001:4830:134:3::10]:41242)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1Uvr-0004Fl-Ug
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:32:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1d1Uvr-000696-84
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:32:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53550)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1d1Uvr-000692-2G
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 05:32:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 09F49F810
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 09:32:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1491034725-23968-3-git-send-email-peterx@redhat.com> (Peter Xu's
	message of "Sat, 1 Apr 2017 16:18:43 +0800")
References: <1491034725-23968-1-git-send-email-peterx@redhat.com>
	<1491034725-23968-3-git-send-email-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Fri, 21 Apr 2017 11:32:47 +0200
Message-ID: <87d1c6ds1s.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 2/4] migration: rename max_size to
 threshold_size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "\\ Dr . David Alan Gilbert \\ " <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> In migration codes (especially in migration_thread()), max_size is used
> in many place for the threshold value that we will start to do the final
> flush and jump to the next stage to dump the whole rest things to
> destination. However its name is confusing to first readers. Let's
> rename it to "threshold_size" when proper and add a comment for it. No
> functional change is made.
>
> CC: Juan Quintela <quintela@redhat.com>
> CC: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Reviewed-by: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
