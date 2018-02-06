Received: from eggs.gnu.org ([2001:4830:134:3::10]:39344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ej8SQ-0001aJ-P5
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:59:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ej8SN-00051U-Mn
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 13:59:06 -0500
Date: Tue, 6 Feb 2018 19:58:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180206195859.4cef95eb.cohuck@redhat.com>
In-Reply-To: <20180205102935.14736-1-david@redhat.com>
References: <20180205102935.14736-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] s390x/cpumodel: model PTFF subfunctions
 for Multiple-epoch facility
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

On Mon,  5 Feb 2018 11:29:35 +0100
David Hildenbrand <david@redhat.com> wrote:

> For now, the kernel does not properly indicate configured CPU subfunctions
> to the guest, but simply uses the host values (as support in KVM is still
> missing). That's why we missed to model the PTFF subfunctions that come
> with Multiple-epoch facility.
> 
> Let's properly add these, along with a new feature group.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v1 -> v2:
> - s/MEPOCH/MULTIPLE_EPOCH/ (only internally visible)
> - Add the features to the z14 full model
> - Clear the features if Multiple-epoch facility is not installed
> 
>  target/s390x/cpu_features.c     |  5 +++++
>  target/s390x/cpu_features_def.h |  4 ++++
>  target/s390x/gen-features.c     | 11 +++++++++++
>  target/s390x/kvm.c              |  8 ++++++++
>  4 files changed, 28 insertions(+)

Thanks, applied.
