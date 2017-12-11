Received: from eggs.gnu.org ([2001:4830:134:3::10]:34717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eOL62-0001r9-52
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 05:14:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eOL5x-0003l5-7T
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 05:14:02 -0500
Date: Mon, 11 Dec 2017 11:13:45 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171211111345.4b2edabf.cohuck@redhat.com>
In-Reply-To: <20171208160207.26494-1-david@redhat.com>
References: <20171208160207.26494-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 for-2.12 00/14] s390x/tcg: CCW hotplug,
 facilities, instructions
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

On Fri,  8 Dec 2017 17:01:53 +0100
David Hildenbrand <david@redhat.com> wrote:

> Both series in one piece as (most probably) most reviewing is done.
> 
> Wire up some io instructions and implement new facilitites. Make sure
> to take care of MTTCG when it comes to atomic operations. Make CCW
> hotplug work.
> 
> As we are now able to install/boot a Fedora 26/27 as well as an upstream
> kernel compiled for z12, let's bump up the QEMU cpu model to a very
> stripped down version of a z12 (with missing base features). Take care
> of backwards compatibility (as we defined the QEMU model as
> migration-safe).

Thanks, queued to s390-next (with v4 of patch 14).
