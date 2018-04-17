Received: from eggs.gnu.org ([2001:4830:134:3::10]:43464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f8G9I-0000xv-9o
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 22:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1f8G9D-0000ZM-9S
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 22:15:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50556 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1f8G9D-0000X4-3O
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 22:15:07 -0400
References: <20180411072027.5656-1-tiwei.bie@intel.com>
	<20180416074706.GB28904@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b2a5856f-58b5-07c0-85fa-838d4e100d1b@redhat.com>
Date: Tue, 17 Apr 2018 10:14:46 +0800
MIME-Version: 1.0
In-Reply-To: <20180416074706.GB28904@stefanha-x1.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC] vhost-user: introduce F_NEED_ALL_IOTLB
 protocol feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, cunming.liang@intel.com, qemu-devel@nongnu.org, peterx@redhat.com, zhihong.wang@intel.com, dan.daly@intel.com



On 2018=E5=B9=B404=E6=9C=8816=E6=97=A5 15:47, Stefan Hajnoczi wrote:
> On Wed, Apr 11, 2018 at 03:20:27PM +0800, Tiwei Bie wrote:
>> This patch introduces VHOST_USER_PROTOCOL_F_NEED_ALL_IOTLB
> Naming suggestion: "PREFILL_IOTLB" instead of "NEED_ALL_IOTLB".
>
> I wasn't able to guess what "NEED_ALL_IOTLB" does.  "PREFILL_IOTLB"
> communicates that memory translation will be set up in advance.

I agree we need a better name here but it should not have anything like=20
"IOTLB" since it actually try to do page table shadowing on the remote=20
vhost-user backend.

Thanks
