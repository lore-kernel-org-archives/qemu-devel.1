Received: from eggs.gnu.org ([2001:4830:134:3::10]:48738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gJdGS-0002a8-MY
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:41:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gJdGN-0006uc-O4
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 06:41:52 -0500
References: <1541139396-4727-1-git-send-email-dongli.zhang@oracle.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <e06eeaf1-0042-2a68-904f-d625357c714d@vivier.eu>
Date: Mon, 5 Nov 2018 12:41:08 +0100
MIME-Version: 1.0
In-Reply-To: <1541139396-4727-1-git-send-email-dongli.zhang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 1/1] virtio: pass argument
 by value for virtqueue_map_iovec()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dongli Zhang <dongli.zhang@oracle.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, mst@redhat.com

On 02/11/2018 07:16, Dongli Zhang wrote:
> Pass num_sg by value instead of by pointer, as num_sg is never modified in
> virtqueue_map_iovec().
> 
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> ---
>  hw/virtio/virtio.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 

Applied to my branch trivial-patches.

Thanks,
Laurent
