Received: from eggs.gnu.org ([2001:4830:134:3::10]:58496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOoZP-0006IG-42
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:42:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eOoZO-0001sq-A4
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 12:42:19 -0500
References: <1513091808-24541-1-git-send-email-den@openvz.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <887466d1-08fd-d10a-a675-634ba005371e@redhat.com>
Date: Tue, 12 Dec 2017 18:42:05 +0100
MIME-Version: 1.0
In-Reply-To: <1513091808-24541-1-git-send-email-den@openvz.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 1/1] virtio: fix IO request length in virtio
 SCSI/block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

On 12/12/2017 16:16, Denis V. Lunev wrote:
> The dark side of this patch is that we are tweaking guest visible
> parameter, though this should be relatively safe as above transport
> layer support is present in QEMU/host Linux for a very long time.
> The patch adds configurable property for VirtIO SCSI with a new default
> and hardcode option for VirtBlock which does not provide good
> configurable framework.

The dark side is fine, but you still need to do backwards-compatibility
properties and also use a property in virtio-blk.

Thanks,

Paolo
