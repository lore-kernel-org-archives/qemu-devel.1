Received: from eggs.gnu.org ([2001:4830:134:3::10]:45752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkiIB-0005dV-HV
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkiI8-0005Ff-FP
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:54:47 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:37644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dkiI8-0005FV-Am
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 22:54:44 -0400
Received: by mail-qt0-x244.google.com with SMTP id h24so1174262qth.4
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 19:54:44 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170823162004.27337-1-marcandre.lureau@redhat.com>
	<20170823162004.27337-7-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9c963f8d-2fae-75bd-14de-c9c245229119@amsat.org>
Date: Wed, 23 Aug 2017 23:54:39 -0300
MIME-Version: 1.0
In-Reply-To: <20170823162004.27337-7-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/27] vhost-user-scsi: code style fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: changpeng.liu@intel.com, felipe@nutanix.com

On 08/23/2017 01:19 PM, Marc-André Lureau wrote:
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   contrib/vhost-user-scsi/vhost-user-scsi.c | 20 ++++++++++++--------
>   1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index cddaaf8995..8d6ff18cc4 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -305,7 +305,8 @@ fail:
>   }
>   
>   static struct scsi_task *scsi_task_new(int cdb_len, uint8_t *cdb, int dir,
> -                                       int xfer_len) {
> +                                       int xfer_len)
> +{
>       struct scsi_task *task;
>   
>       assert(cdb_len > 0);
> @@ -344,7 +345,8 @@ static int handle_cmd_sync(struct iscsi_context *ctx,
>                              VirtIOSCSICmdReq *req,
>                              struct iovec *out, unsigned int out_len,
>                              VirtIOSCSICmdResp *rsp,
> -                           struct iovec *in, unsigned int in_len) {
> +                           struct iovec *in, unsigned int in_len)
> +{
>       struct scsi_task *task;
>       uint32_t dir;
>       uint32_t len;
> @@ -454,7 +456,8 @@ static void vus_panic_cb(VuDev *vu_dev, const char *buf)
>   }
>   
>   static void vus_add_watch_cb(VuDev *vu_dev, int fd, int vu_evt, vu_watch_cb cb,
> -                             void *pvt) {
> +                             void *pvt)
> +{
>       vhost_scsi_dev_t *vdev_scsi;
>       guint id;
>   
> @@ -529,7 +532,7 @@ static void vus_proc_req(VuDev *vu_dev, int idx)
>           return;
>       }
>   
> -    if ((idx < 0) || (idx >= VHOST_MAX_NR_VIRTQUEUE)) {
> +    if (idx < 0 || idx >= VHOST_MAX_NR_VIRTQUEUE) {
>           PERR("VQ Index out of range: %d", idx);
>           vus_panic_cb(vu_dev, NULL);
>           return;
> @@ -556,8 +559,8 @@ static void vus_proc_req(VuDev *vu_dev, int idx)
>           }
>           PDBG("Popped elem@%p", elem);
>   
> -        assert(!((elem->out_num > 1) && (elem->in_num > 1)));
> -        assert((elem->out_num > 0) && (elem->in_num > 0));
> +        assert(!(elem->out_num > 1 && elem->in_num > 1));
> +        assert(elem->out_num > 0 && elem->in_num > 0);
>   
>           if (elem->out_sg[0].iov_len < sizeof(VirtIOSCSICmdReq)) {
>               PERR("Invalid virtio-scsi req header");
> @@ -593,7 +596,7 @@ static void vus_queue_set_started(VuDev *vu_dev, int idx, bool started)
>   
>       assert(vu_dev);
>   
> -    if ((idx < 0) || (idx >= VHOST_MAX_NR_VIRTQUEUE)) {
> +    if (idx < 0 || idx >= VHOST_MAX_NR_VIRTQUEUE) {
>           PERR("VQ Index out of range: %d", idx);
>           vus_panic_cb(vu_dev, NULL);
>           return;
> @@ -750,7 +753,8 @@ err:
>   }
>   
>   static int vdev_scsi_add_iscsi_lun(vhost_scsi_dev_t *vdev_scsi,
> -                                   char *iscsi_uri, uint32_t lun) {
> +                                   char *iscsi_uri, uint32_t lun)
> +{
>       assert(vdev_scsi);
>       assert(iscsi_uri);
>       assert(lun < VUS_MAX_LUNS);
> 
