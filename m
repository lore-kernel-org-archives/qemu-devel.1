Received: from eggs.gnu.org ([2001:4830:134:3::10]:58302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6aXM-0002Tx-5N
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6aXH-0006Aq-5o
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:04:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6aXG-0006AV-Vj
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:04:47 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171020090556.18631-7-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 20 Oct 2017 10:05:55 +0100")
References: <20171020090556.18631-1-dgilbert@redhat.com>
	<20171020090556.18631-7-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 23 Oct 2017 13:04:40 +0200
Message-ID: <877evmazw7.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 6/7] migration: allow cancel to unpause
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, jdenemar@redhat.com, wangjie88@huawei.com, peterx@redhat.com, mreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, fuweiwei2@huawei.com

"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> If a migration_cancel is issued during the new paused state,
> kick the pause_sem to get to unpause so it can cancel.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
