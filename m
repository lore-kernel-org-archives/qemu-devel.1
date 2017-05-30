Received: from eggs.gnu.org ([2001:4830:134:3::10]:58412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFjmx-0000i6-Ia
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:14:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dFjmu-0001ul-EK
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:14:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54450)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dFjmu-0001uc-6v
	for qemu-devel@nongnu.org; Tue, 30 May 2017 12:14:28 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1495642203-12702-2-git-send-email-felipe@nutanix.com> (Felipe
	Franciosi's message of "Wed, 24 May 2017 17:10:00 +0100")
References: <1495642203-12702-1-git-send-email-felipe@nutanix.com>
	<1495642203-12702-2-git-send-email-felipe@nutanix.com>
Reply-To: quintela@redhat.com
Date: Tue, 30 May 2017 18:14:10 +0200
Message-ID: <87h902e2zx.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/4] migration: keep bytes_xfer_prev init'd
 to zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Felipe Franciosi <felipe@nutanix.com>
Cc: Peter Xu <peterx@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, amit Shah <amit.shah@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Malcolm Crossley <malcolm@nutanix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Felipe Franciosi <felipe@nutanix.com> wrote:
> The first time migration_bitmap_sync() is called, bytes_xfer_prev is set
> to ram_state.bytes_transferred which is, at this point, zero. The next
> time migration_bitmap_sync() is called, an iteration has happened and
> bytes_xfer_prev is set to 'x' bytes. Most likely, more than one second
> has passed, so the auto converge logic will be triggered and
> bytes_xfer_now will also be set to 'x' bytes.
>
> This condition is currently masked by dirty_rate_high_cnt, which will
> wait for a few iterations before throttling. It would otherwise always
> assume zero bytes have been copied and therefore throttle the guest
> (possibly) prematurely.
>
> Given bytes_xfer_prev is only used by the auto convergence logic, it
> makes sense to only set its value after a check has been made against
> bytes_xfer_now.
>
> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>

Reviewed-by: Juan Quintela <quintela@redhat.com>
