Received: from eggs.gnu.org ([209.51.188.92]:40544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3OsS-0007s0-9u
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:38:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1h3OrA-0007Hs-Mi
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 13:36:58 -0400
Date: Mon, 11 Mar 2019 18:36:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190311183647.69361783.cohuck@redhat.com>
In-Reply-To: <1552317693-21979-3-git-send-email-jjherne@linux.ibm.com>
References: <1552317693-21979-1-git-send-email-jjherne@linux.ibm.com>
	<1552317693-21979-3-git-send-email-jjherne@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 02/15] s390-bios: decouple cio setup
 from virtio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Jason J. Herne" <jjherne@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

On Mon, 11 Mar 2019 11:21:20 -0400
"Jason J. Herne" <jjherne@linux.ibm.com> wrote:

> Move channel i/o setup code out to a separate function. This decouples cio
> setup from the virtio code path and allows us to make use of it for booting
> dasd devices.
> 
> Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> Reviewed-by: Collin Walling <walling@linux.ibm.com>
> Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  pc-bios/s390-ccw/main.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

[I could have sworn I already did that...]
