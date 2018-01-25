Received: from eggs.gnu.org ([2001:4830:134:3::10]:36252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eeen0-0004OZ-K7
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:29:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eeemv-0007wg-LJ
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 05:29:50 -0500
Date: Thu, 25 Jan 2018 11:29:38 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180125112938.6d59c7bc.cohuck@redhat.com>
In-Reply-To: <20180117174047.6382-1-david@redhat.com>
References: <20180117174047.6382-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 00/18] s390x: flic rework,
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

On Wed, 17 Jan 2018 18:40:29 +0100
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

Basically, seems good to me. Will play with it a bit more.

I'd also love some reviews/acks.
