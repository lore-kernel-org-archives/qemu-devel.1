Received: from eggs.gnu.org ([2001:4830:134:3::10]:60276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dKcN1-0002Oo-7k
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 23:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dKcMy-0006Ak-4f
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 23:19:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dKcMx-0006AA-Ua
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 23:19:52 -0400
References: <1496653049-44530-1-git-send-email-wei.w.wang@intel.com>
	<20170605182514-mutt-send-email-mst@kernel.org>
	<5937511D.5070205@intel.com>
	<20170608220006-mutt-send-email-mst@kernel.org>
	<593A0F47.5080806@intel.com> <593E5F46.5080704@intel.com>
	<20170612234035-mutt-send-email-mst@kernel.org>
	<593F57C0.9080701@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <4639c51b-32a6-3528-2ed6-c5f6296b6300@redhat.com>
Date: Tue, 13 Jun 2017 11:19:32 +0800
MIME-Version: 1.0
In-Reply-To: <593F57C0.9080701@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Wei Wang <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: stefanha@gmail.com, marcandre.lureau@gmail.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, jan.scheurich@ericsson.com, eblake@redhat.com, armbru@redhat.com



On 2017=E5=B9=B406=E6=9C=8813=E6=97=A5 11:10, Wei Wang wrote:
> On 06/13/2017 04:43 AM, Michael S. Tsirkin wrote:
>> On Mon, Jun 12, 2017 at 05:30:46PM +0800, Wei Wang wrote:
>>> Ping for comments, thanks.
>> This was only posted a week ago, might be a bit too short for some
>> people.
> OK, sorry for the push.
>> A couple of weeks is more reasonable before you ping.  Also, I
>> sent a bunch of comments on Thu, 8 Jun 2017.  You should probably
>> address these.
>>
> I responded to the comments. The main question is that I'm not sure
> why we need the vhost backend to support VIRTIO_F_MAX_CHAIN_SIZE.
> IMHO, that should be a feature proposed to solve the possible issue
> caused by the QEMU implemented backend.

The issue is what if there's a mismatch of max #sgs between qemu and vhos=
t?

Thanks

>
> Best,
> Wei
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
