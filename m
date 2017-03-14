Received: from eggs.gnu.org ([2001:4830:134:3::10]:47669)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cnhws-0008Np-Ad
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:36:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cnhwn-0004v6-Fl
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:36:54 -0400
Received: from [59.151.112.132] (port=28163 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cnhwn-0004ua-3W
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 04:36:49 -0400
References: <1489460502-6686-1-git-send-email-jasowang@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <deab823a-8fde-6b1e-886c-14b5ec598d4b@cn.fujitsu.com>
Date: Tue, 14 Mar 2017 16:35:59 +0800
MIME-Version: 1.0
In-Reply-To: <1489460502-6686-1-git-send-email-jasowang@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH V3 0/3] Several fixes for virito region
 caches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com, qemu-devel@nongnu.org
Cc: zhangchen.fnst@cn.fujitsu.com



On 03/14/2017 11:01 AM, Jason Wang wrote:
> Hi:
>
> This series contains several fixes for virito region caches, please
> review.

Title and comments typo:

S/virito/virtio

Thanks
Zhang Chen

>
> Thanks.
>
> Jason Wang (3):
>    virtio: guard against NULL pfn
>    virtio: destroy region cache during reset
>    virtio: validate address space cache during init
>
>   hw/virtio/virtio.c | 105 ++++++++++++++++++++++++++++++++++++++++++-----------
>   1 file changed, 83 insertions(+), 22 deletions(-)
>

-- 
Thanks
Zhang Chen
