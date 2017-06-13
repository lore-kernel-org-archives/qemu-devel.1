Received: from eggs.gnu.org ([2001:4830:134:3::10]:58824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dKcCG-00006p-0j
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 23:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dKcCB-0001yU-3F
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 23:08:48 -0400
Received: from mga03.intel.com ([134.134.136.65]:57988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dKcCA-0001xF-QV
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 23:08:43 -0400
Message-ID: <593F57C0.9080701@intel.com>
Date: Tue, 13 Jun 2017 11:10:56 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1496653049-44530-1-git-send-email-wei.w.wang@intel.com>
	<20170605182514-mutt-send-email-mst@kernel.org>
	<5937511D.5070205@intel.com>
	<20170608220006-mutt-send-email-mst@kernel.org>
	<593A0F47.5080806@intel.com> <593E5F46.5080704@intel.com>
	<20170612234035-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170612234035-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, stefanha@gmail.com, marcandre.lureau@gmail.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, jan.scheurich@ericsson.com, eblake@redhat.com, armbru@redhat.com

On 06/13/2017 04:43 AM, Michael S. Tsirkin wrote:
> On Mon, Jun 12, 2017 at 05:30:46PM +0800, Wei Wang wrote:
>> Ping for comments, thanks.
> This was only posted a week ago, might be a bit too short for some
> people.
OK, sorry for the push.
> A couple of weeks is more reasonable before you ping.  Also, I
> sent a bunch of comments on Thu, 8 Jun 2017.  You should probably
> address these.
>
I responded to the comments. The main question is that I'm not sure
why we need the vhost backend to support VIRTIO_F_MAX_CHAIN_SIZE.
IMHO, that should be a feature proposed to solve the possible issue
caused by the QEMU implemented backend.

Best,
Wei
