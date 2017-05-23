Received: from eggs.gnu.org ([2001:4830:134:3::10]:33529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDCnN-0006Wh-Px
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:36:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dDCnN-0004Am-1v
	for qemu-devel@nongnu.org; Tue, 23 May 2017 12:36:29 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495548064-10926-2-git-send-email-kwolf@redhat.com> (Kevin
	Wolf's message of "Tue, 23 May 2017 16:01:01 +0200")
References: <1495548064-10926-1-git-send-email-kwolf@redhat.com>
	<1495548064-10926-2-git-send-email-kwolf@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 23 May 2017 18:36:14 +0200
Message-ID: <87zie37cox.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/4] block: Fix anonymous BBs in
 blk_root_inactivate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, dgilbert@redhat.com, stefanha@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Kevin Wolf <kwolf@redhat.com> wrote:
> blk->name isn't an array, but a pointer that can be NULL. Checking for
> an anonymous BB must involve a NULL check first, otherwise we get
> crashes.
>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
