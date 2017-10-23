Received: from eggs.gnu.org ([2001:4830:134:3::10]:57925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6aVY-0001Ev-OZ
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:03:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1e6aVS-0005Qq-KA
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:02:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1e6aVS-0005QR-EX
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 07:02:54 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20171020090556.18631-4-dgilbert@redhat.com> (David Alan
	Gilbert's message of "Fri, 20 Oct 2017 10:05:52 +0100")
References: <20171020090556.18631-1-dgilbert@redhat.com>
	<20171020090556.18631-4-dgilbert@redhat.com>
Reply-To: quintela@redhat.com
Date: Mon, 23 Oct 2017 13:02:48 +0200
Message-ID: <87k1zmazzb.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v4 3/7] migration: Wait for semaphore
 before completing migration
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
> Wait for a semaphore before completing the migration,
> if the previously added capability was enabled.
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>


> +    while (qemu_sem_timedwait(&s->pause_sem, 1) == 0) {

wait

> +        /* This block intentionally left blank */
> +    }
> +

> +    qemu_sem_wait(&s->pause_sem);


wait

and no posts on the whole patchset.

I agree that we only wait if we enable the feature, but still O:-)
