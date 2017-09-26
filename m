Received: from eggs.gnu.org ([2001:4830:134:3::10]:49912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwq5P-0007yV-8Y
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:39:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwq5M-0001mY-4l
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:39:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dwq5L-0001lr-VX
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 09:39:40 -0400
Date: Tue, 26 Sep 2017 15:39:30 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170926153930.65f10c2f.cohuck@redhat.com>
In-Reply-To: <20170925112917.21340-7-dgilbert@redhat.com>
References: <20170925112917.21340-1-dgilbert@redhat.com>
	<20170925112917.21340-7-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 6/6] migration: Route more error paths
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, famz@redhat.com, peter.maydell@linaro.org, rth@twiddle.net

On Mon, 25 Sep 2017 12:29:17 +0100
"Dr. David Alan Gilbert (git)" <dgilbert@redhat.com> wrote:

> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> 
> vmstate_save is called in a few places, and vmstate_save_state is
> called in lots of places.
> 
> Route error returns from the easier cases back up;  there are lots
> of more complex cases where their own error paths need fixing.
> 
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  hw/display/virtio-gpu.c    |  4 +---
>  hw/virtio/virtio.c         | 13 +++++++------
>  include/hw/virtio/virtio.h |  2 +-
>  migration/vmstate-types.c  | 11 ++++++++---
>  tests/test-vmstate.c       |  9 ++++++---
>  5 files changed, 23 insertions(+), 16 deletions(-)

If you fix up the description to only refer to vmstate_save_state:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
