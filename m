Received: from eggs.gnu.org ([2001:4830:134:3::10]:59679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehEut-0004rc-Lx
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehEup-0000Kd-CQ
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 08:28:39 -0500
Date: Thu, 1 Feb 2018 14:28:28 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180201142828.05db0228.cohuck@redhat.com>
In-Reply-To: <20180129125623.21729-1-david@redhat.com>
References: <20180129125623.21729-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 00/18] s390x: flic rework,
 tcg flic support and STSI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>

On Mon, 29 Jan 2018 13:56:05 +0100
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
> Now also included: More flic related caching to avoid recurring
> conversions.
> 
> Available at: https://github.com/davidhildenbrand/qemu.git s390x-queue

Also survives some hot(un)plugging of devices (with and without load).

Thanks, applied.

(I'll happily apply further r-bs until I prepare a pull request.)
