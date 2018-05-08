Received: from eggs.gnu.org ([2001:4830:134:3::10]:42862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fG3hD-0000Ag-Ik
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:34:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fG3hA-0007q4-HD
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:34:27 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44238 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fG3hA-0007pf-D8
	for qemu-devel@nongnu.org; Tue, 08 May 2018 10:34:24 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180502104740.12123-2-peterx@redhat.com> (Peter Xu's message of
	"Wed, 2 May 2018 18:47:17 +0800")
References: <20180502104740.12123-1-peterx@redhat.com>
	<20180502104740.12123-2-peterx@redhat.com>
Reply-To: quintela@redhat.com
Date: Tue, 08 May 2018 16:36:26 +0200
Message-ID: <87y3gu6wph.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 01/24] migration: let incoming side use
 thread context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> wrote:
> The old incoming migration is running in main thread and default
> gcontext.  With the new qio_channel_add_watch_full() we can now let it
> run in the thread's own gcontext (if there is one).
>
> Currently this patch does nothing alone.  But when any of the incoming
> migration is run in another iothread (e.g., the upcoming migrate-recover
> command), this patch will bind the incoming logic to the iothread
> instead of the main thread (which may already get page faulted and
> hanged).
>
> RDMA is not considered for now since it's not even using the QIO watch
> framework at all.
>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
