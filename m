Received: from eggs.gnu.org ([2001:4830:134:3::10]:45399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBIgG-0007Pb-77
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:29:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBIgE-00032P-Te
	for qemu-devel@nongnu.org; Thu, 18 May 2017 06:29:16 -0400
References: <20170518102808.30046-1-famz@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4d509dff-56f9-0474-237a-6c4beeacb75f@redhat.com>
Date: Thu, 18 May 2017 12:29:06 +0200
MIME-Version: 1.0
In-Reply-To: <20170518102808.30046-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] virtio-scsi: Unset hotplug handler when
 unrealize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>



On 18/05/2017 12:28, Fam Zheng wrote:
> Like suggested by Paolo, it seems to make sense to do this clean up in
> bus_unparent, but given how confused I got when working on this bug, I'm
> not confident in my reasoning about the ref count balance in other
> callers.

Queued this for now.

Paolo
