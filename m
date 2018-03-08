Received: from eggs.gnu.org ([2001:4830:134:3::10]:43592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ettkl-0005UL-Md
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:30:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1ettkk-0007Od-QI
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:30:31 -0500
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <1520507908-16743-4-git-send-email-pl@kamp.de> (Peter Lieven's
	message of "Thu, 8 Mar 2018 12:18:26 +0100")
References: <1520507908-16743-1-git-send-email-pl@kamp.de>
	<1520507908-16743-4-git-send-email-pl@kamp.de>
Reply-To: quintela@redhat.com
Date: Thu, 08 Mar 2018 12:31:01 +0100
Message-ID: <87a7vierd6.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 3/5] migration/block: rename
 MAX_INFLIGHT_IO to MAX_IO_BUFFERS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, dgilbert@redhat.com, famz@redhat.com, stefanha@redhat.com, jjherne@linux.vnet.ibm.com

Peter Lieven <pl@kamp.de> wrote:
> this actually limits (as the original commit mesage suggests) the
> number of I/O buffers that can be allocated and not the number
> of parallel (inflight) I/O requests.
>
> Signed-off-by: Peter Lieven <pl@kamp.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>
