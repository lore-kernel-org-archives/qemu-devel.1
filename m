Received: from eggs.gnu.org ([2001:4830:134:3::10]:47792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e5Hzv-00040F-Fr
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 17:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1e5Hzs-0005YL-Sm
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 17:04:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1e5Hzs-0005Y9-MV
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 17:04:56 -0400
References: <1508390650-19115-1-git-send-email-changpeng.liu@intel.com>
	<1508390650-19115-2-git-send-email-changpeng.liu@intel.com>
	<20171019183638-mutt-send-email-mst@kernel.org>
	<42aa8736-bc23-d66d-27de-dbaf83ea2f99@redhat.com>
	<20171019204305-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e2c13ada-aa4b-1bbd-b2ba-3dcf247b6f57@redhat.com>
Date: Thu, 19 Oct 2017 23:04:48 +0200
MIME-Version: 1.0
In-Reply-To: <20171019204305-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 1/4] vhost-user: add new vhost user
 messages to support virtio config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Changpeng Liu <changpeng.liu@intel.com>, qemu-devel@nongnu.org, stefanha@gmail.com, marcandre.lureau@redhat.com, felipe@nutanix.com, james.r.harris@intel.com

On 19/10/2017 19:43, Michael S. Tsirkin wrote:
> On Thu, Oct 19, 2017 at 05:43:18PM +0200, Paolo Bonzini wrote:
>> On 19/10/2017 17:39, Michael S. Tsirkin wrote:
>>>> Add VHOST_USER_GET_CONFIG/VHOST_USER_SET_CONFIG messages which can be
>>>> used for live migration of vhost user devices, also vhost user devices
>>>> can benefit from the messages to get/set virtio config space from/to the
>>>> I/O target. For the purpose to support virtio config space change,
>>>> VHOST_USER_SET_CONFIG_FD message is added as the event notifier
>>>> in case virtio config space change in the I/O target.
>>>>
>>>> Signed-off-by: Changpeng Liu <changpeng.liu@intel.com>
>>> I don't much like it that config is getting passed through.
>>>
>>> IMO this makes managing things harder not easier.
>>>
>>> How about specific messages about specific parts of
>>> config space that you want to get from the backend?
>>
>> In the case of virtio-blk that would be all of it.  Do you have a case
>> in mind where some part of the configuration space is owned by QEMU?
>>
>> Paolo
> 
> Yes. seg_max

The seg_max limit is established by whoever reads buffers from the vring
and passes them down to the lower layer.  For vhost-blk that's the
device server, not QEMU.

Paolo
