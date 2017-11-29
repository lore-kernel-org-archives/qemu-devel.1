Received: from eggs.gnu.org ([2001:4830:134:3::10]:34630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK4gL-0006oS-Pu
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eK4gG-0004pu-S9
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 10:53:53 -0500
Date: Wed, 29 Nov 2017 16:53:41 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171129165341.3f084d4e.cohuck@redhat.com>
In-Reply-To: <20171128203326.6062-14-david@redhat.com>
References: <20171128203326.6062-1-david@redhat.com>
	<20171128203326.6062-14-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 13/15] s390x/tcg: use
 program_interrupt_ra() in STSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>

On Tue, 28 Nov 2017 21:33:23 +0100
David Hildenbrand <david@redhat.com> wrote:

> STSI needs some more love, but let's do one step at a time.

Out of curiousity: What else do you want to do?

> We can now drop potential_page_fault().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/misc_helper.c | 2 +-
>  target/s390x/translate.c   | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
