Received: from eggs.gnu.org ([2001:4830:134:3::10]:35748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eYxmr-0007UB-4Z
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:34:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eYxml-00077w-AK
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 12:34:09 -0500
Date: Tue, 9 Jan 2018 18:33:55 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180109183355.008129f3.cohuck@redhat.com>
In-Reply-To: <20171211134740.8235-1-david@redhat.com>
References: <20171211134740.8235-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2-12 00/15] s390x: flic rework,
 tcg flic support and tcg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Thomas Huth <thuth@redhat.com>

On Mon, 11 Dec 2017 14:47:25 +0100
David Hildenbrand <david@redhat.com> wrote:

> This patch series implements floating interrupt support for TCG and fixes
> STSI so we can remove warnings related to s390x SMP and MTTCG.
> 
> KVM code has to be touched in order to factor out the injection routines
> into the flic ("s390x/flic: factor out injection of floating interrupts").
> Basic testing didn't reveal any problems so far.
> 
> With this series I am now able to run fedora 26/27 and Ubuntu 17.10+ with
> 16 VCPUs (MTTCG) on a 8CPU host, doing a make -j16 in the guest. I got
> nasty stalls in the guest beforehand.
> 
> I already sent the patches
>  - "cpus: make pause_all_cpus() play with SMP on single threaded TCG"
>  - "cpu-exec: fix missed CPU kick during interrupt injection"
> separately, but as nobody commented so far (e.g. due to 2.11) I am including
> them here as they are required to make SMP work reliably.
> 
> Based on: https://github.com/cohuck/qemu.git s390x-next
> Available at: https://github.com/davidhildenbrand/qemu.git s390x-queue

Generally, this looks good to me. I have commented on the individual
patches.

Looking forward to a v2 :)
