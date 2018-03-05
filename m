Received: from eggs.gnu.org ([2001:4830:134:3::10]:38334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eso24-0006fO-Nd
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:11:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eso21-0003kn-Hy
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 06:11:52 -0500
Date: Mon, 5 Mar 2018 12:11:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180305121145.3fb2f1a0.cohuck@redhat.com>
In-Reply-To: <1520227018-4061-1-git-send-email-thuth@redhat.com>
References: <1520227018-4061-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] target/s390x: Remove leading underscores
 from #defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-s390x@nongnu.org

On Mon,  5 Mar 2018 06:16:58 +0100
Thomas Huth <thuth@redhat.com> wrote:

> We should not use leading underscores followed by a capital letter
> in #defines since such identifiers are reserved by the C standard.
> 
> For ASCE_ORIGIN, REGION_ENTRY_ORIGIN and SEGMENT_ENTRY_ORIGIN I also
> added parentheses around the value to silence an error message from
> checkpatch.pl.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  target/s390x/cpu.h        | 66 +++++++++++++++++++++++------------------------
>  target/s390x/mem_helper.c | 20 +++++++-------
>  target/s390x/mmu_helper.c | 54 +++++++++++++++++++-------------------
>  3 files changed, 70 insertions(+), 70 deletions(-)

Thanks, applied.
