Received: from eggs.gnu.org ([2001:4830:134:3::10]:41904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1g7Q1b-0008LZ-MO
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 15:08:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1g7Q1Y-0008Ab-Kg
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 15:08:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1g7Q1Y-00089R-Dw
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 15:08:00 -0400
References: <CGME20181002140746eucas1p14d822ee1600d78687a73d6bf9a44e36b@eucas1p1.samsung.com>
	<20181002140947.4107-1-i.maximets@samsung.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <cda10fda-8543-7200-adf5-de1671ea988e@redhat.com>
Date: Tue, 2 Oct 2018 21:07:41 +0200
MIME-Version: 1.0
In-Reply-To: <20181002140947.4107-1-i.maximets@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost-user: Don't ask for reply on
 postcopy mem table set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ilya Maximets <i.maximets@samsung.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>



On 10/02/2018 04:09 PM, Ilya Maximets wrote:
> According to documentation, NEED_REPLY_MASK should not be set
> for VHOST_USER_SET_MEM_TABLE request in postcopy mode.
> This restriction was mistakenly applied to 'reply_supported'
> variable, which is local and used only for non-postcopy case.
> 
> CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Fixes: 9bb38019942c ("vhost+postcopy: Send address back to qemu")
> Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
> ---
>   hw/virtio/vhost-user.c | 13 +------------
>   1 file changed, 1 insertion(+), 12 deletions(-)
> 

Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime
