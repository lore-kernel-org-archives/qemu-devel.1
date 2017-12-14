Received: from eggs.gnu.org ([2001:4830:134:3::10]:48490)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePSTY-0005GI-GE
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:18:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ePSTU-0007cM-I6
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 07:18:56 -0500
Date: Thu, 14 Dec 2017 13:18:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171214131845.5d332ac8.cohuck@redhat.com>
In-Reply-To: <20171213132407.5227-1-david@redhat.com>
References: <20171208165529.14124-1-david@redhat.com>
	<20171213132407.5227-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x/cpumodel: make qemu cpu model
 play with "none" machine
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

On Wed, 13 Dec 2017 14:24:07 +0100
David Hildenbrand <david@redhat.com> wrote:

> Make sure "-cpu qemu" works with "-M none".
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> Conny, if this is okay, can you squash with the original patch?
> 
>  hw/s390x/s390-virtio-ccw.c  | 4 ----
>  target/s390x/cpu_models.c   | 7 +++++--
>  target/s390x/gen-features.c | 4 ++--
>  3 files changed, 7 insertions(+), 8 deletions(-)

Squashed into "s390x: change the QEMU cpu model to a stripped down z12".
