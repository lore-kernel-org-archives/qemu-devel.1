Received: from eggs.gnu.org ([2001:4830:134:3::10]:58007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6aWD-0001YH-Sp
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:03:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6aW8-0005gG-En
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:03:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6aW8-0005g2-90
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:03:36 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171020090556.18631-5-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 20 Oct 2017 10:05:53 +0100")
References: <20171020090556.18631-1-dgilbert@redhat.com>
	<20171020090556.18631-5-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 23 Oct 2017 13:03:32 +0200
Message-ID: <87fuaaazy3.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 4/7] migration: migrate-continue
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
> A new qmp command allows the caller to continue from a given
> paused state.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
> +    qemu_sem_post(&s->pause_sem);


one of the missing posts
