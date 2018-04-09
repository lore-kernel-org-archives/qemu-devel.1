Received: from eggs.gnu.org ([2001:4830:134:3::10]:38612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5VIN-0001Wf-AW
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5VIM-0004Pt-N2
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 07:49:11 -0400
Date: Mon, 9 Apr 2018 13:49:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180409134904.4687e089.cohuck@redhat.com>
In-Reply-To: <b387527b-2851-5cb6-d9a5-65020d8800f6@redhat.com>
References: <20180409113019.14568-1-david@redhat.com>
	<20180409113019.14568-3-david@redhat.com>
	<a82acbd9-3023-8f3a-c5a6-3fb5b5a0832c@de.ibm.com>
	<e6ee002c-373f-d619-a3e4-a3a6f56b2bda@redhat.com>
	<92f20c1c-5510-3e17-d186-be416635d1da@de.ibm.com>
	<b387527b-2851-5cb6-d9a5-65020d8800f6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12 2/2] s390x: load_psw() should
 only exchange the PSW for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On Mon, 9 Apr 2018 13:44:30 +0200
David Hildenbrand <david@redhat.com> wrote:

> Conny, when (and if ;) ) picking this up, can you change the description to
> 
> "Let's simplify it a bit. On some weird circumstances we would have
> tried to recompute watchpoints when running under KVM. load_psw() is
> called from do_restart_interrupt() during a SIGP RESTART if the target
> CPU is STOPPED. Let's touch watchpoints only in the TCG case - where
> they are used for PER emulation."

Will do. Patch looks good to me, but waiting for some review.
