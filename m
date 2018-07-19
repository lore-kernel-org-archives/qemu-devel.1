Received: from eggs.gnu.org ([2001:4830:134:3::10]:42791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fg6m2-0001sI-5S
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 07:07:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fg6lx-00023b-4o
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 07:07:06 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40694 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fg6lw-00023G-Vw
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 07:07:01 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BACE4401EF02
	for <qemu-devel@nongnu.org>; Thu, 19 Jul 2018 11:06:59 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180719092257.12703-1-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Thu, 19 Jul 2018 10:22:57 +0100")
References: <20180719092257.12703-1-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Thu, 19 Jul 2018 13:06:54 +0200
Message-ID: <87va9bwkkx.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] migrate: Fix cancelling state warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> We've been getting the warning:
>
> migration_iteration_finish: Unknown ending state 2
>
> on a cancel.
>
> I think that's originally due to 39b9e17905c;  although
> I've only seen the warning, I think that in some cases
> that we could find the VM stays paused after a cancel where
> it should restart.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
