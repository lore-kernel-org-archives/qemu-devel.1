Received: from eggs.gnu.org ([2001:4830:134:3::10]:56901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1gA8vg-0006Dk-KW
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 03:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1gA8vb-0004xV-HJ
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 03:29:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47580)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1gA8va-0004ws-Qh
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 03:29:07 -0400
References: <CGME20181008160317eucas1p12156552c6876786bd3087d3922d49399@eucas1p1.samsung.com>
	<20181008160536.6332-1-i.maximets@samsung.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <d33b389d-34ac-bd32-4915-a94cc239d7cc@redhat.com>
Date: Wed, 10 Oct 2018 09:28:57 +0200
MIME-Version: 1.0
In-Reply-To: <20181008160536.6332-1-i.maximets@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/2] vhost+postcopy fixes
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



On 10/08/2018 06:05 PM, Ilya Maximets wrote:
> Sending as RFC because it's not fully tested yet.
> 
> Ilya Maximets (2):
>    migration: Stop postcopy fault thread before notifying
>    vhost-user: Fix userfaultfd leak
> 
>   hw/virtio/vhost-user.c   |  7 +++++++
>   migration/postcopy-ram.c | 11 ++++++-----
>   2 files changed, 13 insertions(+), 5 deletions(-)
> 

For the series:
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>

Thanks,
Maxime
