Received: from eggs.gnu.org ([2001:4830:134:3::10]:46510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffM5Y-0005v3-23
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:16:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ffM5U-0003V8-Uh
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:16:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44254 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ffM5U-0003Uz-OS
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 05:16:04 -0400
Date: Tue, 17 Jul 2018 11:16:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180717111601.53b3c737.cohuck@redhat.com>
In-Reply-To: <20180716173743.133393-5-dgilbert@redhat.com>
References: <20180716173743.133393-1-dgilbert@redhat.com>
	<20180716173743.133393-5-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for 3.1 4/4] virtio:
 qemu_get_virtqueue_element fail rather than assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, mst@redhat.com, famz@redhat.com, amit@kernel.org

On Mon, 16 Jul 2018 18:37:43 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

$SUBJECT reads a bit odd without a 'make', but it is already long...

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> Make it return NULL rather than assert.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/virtio/virtio.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
