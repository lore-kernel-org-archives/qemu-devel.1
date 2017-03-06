Received: from eggs.gnu.org ([2001:4830:134:3::10]:54773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cksbX-0003Jf-CW
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:23:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1cksbU-0006WW-Js
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:23:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1cksbU-0006W0-Dn
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:23:08 -0500
References: <1488519630-89058-1-git-send-email-wei.w.wang@intel.com>
	<1488519630-89058-6-git-send-email-wei.w.wang@intel.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <d66a8e86-0ead-90fd-b943-f69449e78349@redhat.com>
Date: Mon, 6 Mar 2017 14:23:02 +0100
MIME-Version: 1.0
In-Reply-To: <1488519630-89058-6-git-send-email-wei.w.wang@intel.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 kernel 5/5] This patch contains two
 parts:
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>, virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Cc: Liang Li <liang.z.li@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@techsingularity.net>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Amit Shah <amit.shah@redhat.com>, Dave Hansen <dave.hansen@intel.com>, Andrea Arcangeli <aarcange@redhat.com>, Liang Li <liliang324@gmail.com>

Am 03.03.2017 um 06:40 schrieb Wei Wang:
> From: Liang Li <liang.z.li@intel.com>

I'd prefer to split this into two parts then and to create proper subjects.

If I remember correctly, the general concept was accepted by most reviewers.

> 
> One is to add a new API to mm go get the unused page information.
> The virtio balloon driver will use this new API added to get the
> unused page info and send it to hypervisor(QEMU) to speed up live
> migration. During sending the bitmap, some the pages may be modified
> and are used by the guest, this inaccuracy can be corrected by the
> dirty page logging mechanism.
> 
> One is to add support the request for vm's unused page information,
> QEMU can make use of unused page information and the dirty page
> logging mechanism to skip the transportation of some of these unused
> pages, this is very helpful to reduce the network traffic and speed
> up the live migration process.

-- 
Thanks,

David
