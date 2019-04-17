Received: from eggs.gnu.org ([209.51.188.92]:46344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hGjhw-0006df-Eh
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:30:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hGjhv-0001mo-Jp
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 08:30:32 -0400
MIME-Version: 1.0
References: <20190417115343.30527-1-pbonzini@redhat.com>
In-Reply-To: <20190417115343.30527-1-pbonzini@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 17 Apr 2019 13:30:18 +0100
Message-ID: <CAJSP0QWtW3L54SC2FuWwc_Eu9DQnHw0eWWM1bUtGRrwwbFTyiQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] scsi-generic: prevent guest
 from exceeding SG_IO limits
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-stable <qemu-stable@nongnu.org>, qemu block <qemu-block@nongnu.org>

On Wed, Apr 17, 2019 at 12:54 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
> Linux places a limit of UIO_MAXIOV pages on SG_IO ioctls (and if the limit
> is exceeded, a confusing ENOMEM error is returned[1]).  Prevent the guest
> from exceeding these limits, by capping the maximum transfer length to
> that value in the block limits VPD page.
>
> [1] Oh well, at least it was easier to follow the kernel source knowing
>     it had to end as ENOMEM...
>
> Cc: qemu-stable@nongnu.org
> Cc: qemu-block@nongnu.org
> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/scsi-generic.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
