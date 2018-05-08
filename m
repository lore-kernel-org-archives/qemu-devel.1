Received: from eggs.gnu.org ([2001:4830:134:3::10]:60691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fFzLV-0003Br-6r
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:55:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fFzLS-0002C6-3W
	for qemu-devel@nongnu.org; Tue, 08 May 2018 05:55:45 -0400
Date: Tue, 8 May 2018 11:55:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180508115521.0ef49d72.cohuck@redhat.com>
In-Reply-To: <20180504131605.22816-1-cohuck@redhat.com>
References: <20180504131605.22816-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] s390x/css: disabled subchannels cannot be
 status pending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>
Cc: Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Fri,  4 May 2018 15:16:05 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> The 3270 code will try to post an attention interrupt when the
> 3270 emulator (e.g. x3270) attaches. If the guest has not yet
> enabled the subchannel for the 3270 device, we will give it a
> spurious status during msch when it does so later.
> 
> To fix this, just don't do anything in css_conditional_io_interrupt()
> if the subchannel is not enabled. The 3270 code will work fine with
> that, and the other user of this function (virtio-ccw) never
> attempts to post an interrupt for a disabled device to begin with.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  hw/s390x/css.c | 8 ++++++++
>  1 file changed, 8 insertions(+)

Queued to s390-next (with commit message tweaked and cc:stable added).
