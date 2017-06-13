Received: from eggs.gnu.org ([2001:4830:134:3::10]:39142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dKcpG-0002gR-LS
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 23:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dKcpD-0000EM-KB
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 23:49:06 -0400
Received: from mga02.intel.com ([134.134.136.20]:57639)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dKcpD-0000CS-Ad
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 23:49:03 -0400
Message-ID: <593F6133.9050804@intel.com>
Date: Tue, 13 Jun 2017 11:51:15 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1496653049-44530-1-git-send-email-wei.w.wang@intel.com>
	<20170605182514-mutt-send-email-mst@kernel.org>
	<5937511D.5070205@intel.com>
	<20170608220006-mutt-send-email-mst@kernel.org>
	<593A0F47.5080806@intel.com> <593E5F46.5080704@intel.com>
	<20170612234035-mutt-send-email-mst@kernel.org>
	<593F57C0.9080701@intel.com>
	<4639c51b-32a6-3528-2ed6-c5f6296b6300@redhat.com>
In-Reply-To: <4639c51b-32a6-3528-2ed6-c5f6296b6300@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v1] virtio-net: enable
 configurable tx queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: stefanha@gmail.com, marcandre.lureau@gmail.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, jan.scheurich@ericsson.com, eblake@redhat.com, armbru@redhat.com

On 06/13/2017 11:19 AM, Jason Wang wrote:
>
>
> On 2017年06月13日 11:10, Wei Wang wrote:
>> On 06/13/2017 04:43 AM, Michael S. Tsirkin wrote:
>>> On Mon, Jun 12, 2017 at 05:30:46PM +0800, Wei Wang wrote:
>>>> Ping for comments, thanks.
>>> This was only posted a week ago, might be a bit too short for some
>>> people.
>> OK, sorry for the push.
>>> A couple of weeks is more reasonable before you ping.  Also, I
>>> sent a bunch of comments on Thu, 8 Jun 2017.  You should probably
>>> address these.
>>>
>> I responded to the comments. The main question is that I'm not sure
>> why we need the vhost backend to support VIRTIO_F_MAX_CHAIN_SIZE.
>> IMHO, that should be a feature proposed to solve the possible issue
>> caused by the QEMU implemented backend.
>
> The issue is what if there's a mismatch of max #sgs between qemu and 
> vhost?
>

When the vhost backend is used, QEMU is not involved in the data path. 
The vhost backend
directly gets what is offered by the guest from the vq. Why would there 
be a mismatch of
max #sgs between QEMU and vhost, and what is the QEMU side max #sgs used 
for? Thanks.

Best,
Wei
