Received: from eggs.gnu.org ([2001:4830:134:3::10]:40876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e5EA2-0004QD-Ny
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:59:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1e5E9y-000314-Op
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 12:59:10 -0400
References: <cover.1508390588.git.alistair.francis@xilinx.com>
	<3a47068b0561596283383c38e6e1188b1d6e7d2f.1508390588.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <9b967d33-397f-3602-35d8-67fdd9a81949@redhat.com>
Date: Thu, 19 Oct 2017 18:58:59 +0200
MIME-Version: 1.0
In-Reply-To: <3a47068b0561596283383c38e6e1188b1d6e7d2f.1508390588.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 32/46] hw/s390x: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com, qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>

On 19.10.2017 18:17, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
[...]
> Some lines where then manually tweaked to pass checkpatch.
> 
> One fprintf(stderr, was manually converted to a
> qemu_log_mask(LOG_GUEST_ERROR,
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> V3:
>  - Use a qemu_log_mask(LOG_GUEST_ERROR,
> V2:
>  - Split hw patch into individual directories
> 
>  hw/s390x/virtio-ccw.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/s390x/virtio-ccw.c b/hw/s390x/virtio-ccw.c
> index 085f17f871..1c6ea916b8 100644
> --- a/hw/s390x/virtio-ccw.c
> +++ b/hw/s390x/virtio-ccw.c
> @@ -426,8 +426,9 @@ static int virtio_ccw_cb(SubchDev *sch, CCW1 ccw)
>                   * passes us zeroes for those we don't support.
>                   */
>                  if (features.features) {
> -                    fprintf(stderr, "Guest bug: features[%i]=%x (expected 0)\n",
> -                            features.index, features.features);
> +                    qemu_log_mask(LOG_GUEST_ERROR,
> +                                  "Guest bug: features[%i]=%x (expected 0)",
> +                                  features.index, features.features);
>                      /* XXX: do a unit check here? */
>                  }
>              }
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
