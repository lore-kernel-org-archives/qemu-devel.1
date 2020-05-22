Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D8AC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 12:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0DC206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 12:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="lz9N0NIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0DC206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jc6uK-0003Nz-01
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 08:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jc6tX-0001wj-KK
 for qemu-devel@nongnu.org; Fri, 22 May 2020 08:35:23 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:49671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1jc6tW-0004p3-DE
 for qemu-devel@nongnu.org; Fri, 22 May 2020 08:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=JlcMcMulq2aImje6LWBEMdbdSP748cBCin6Y2JaLwM0=; b=lz9N0NIUH2x2vAAmTHpk3gyUDc
 Ud1U4z5rPiREc45dnApr+P7FLNuJ03oAuWSh6oILpRdqE+BIppa8WgCf+527Rd6QAewyCzi5LZxgk
 D5HE4dHR1RiFVD467aJcto38m0lHJifsuMQeHMfmpzgPUXvL3htKb7s78MVHuhQuNLoIYmIzlZVAE
 nv2VxdZhW+fCjRJhjwC4EPSfN8SoTNQ8S9+3udl8mK/8tnhZFB884W1zk3w3NUu5/IH5+PGb14Z7r
 9iQ0ndw2nb8D/qCdlw9rfJM1HLNIAXi7+XxZ1RZO5zPvtinu20ex2WxohiICRQCY012M1uuSvAy70
 9Eh76EYNVa/zFi+1xt+4leHHRGkiFIg3i3QQogJdnCkIr27cCNqZNnXlocXSr7vKGKBYpFoyaG8qT
 biXL009ANgws6D3MWJxDO03vjy49q3TdQ64ifBcPhamqtf0oYNw1xsb6lrbQstumvIY+Sud9X75tp
 4WP+KTI77hpWakEwENsZ73lzPAtJds9u/i3cb2sr5tllzFMLinWIXzlKh9JV195/G9FiTHK5S06ne
 oO9b9oQFGAmLQF8NHMz6KyYkLwDjQ+HFebdCrLfgsxNlURPFrAABqWjL6fUT+dIhS0wOujl9ieiv6
 xrvJb8sTEokhmFuAcPbB69dtTXM/ozL2PGxK7bZgg=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, groug@kaod.org, paul@xen.org,
 anthony.perard@citrix.com, Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 1/3] Revert "9p: init_in_iov_from_pdu can truncate the
 size"
Date: Fri, 22 May 2020 14:34:23 +0200
Message-ID: <2043036.LDd4sAjz2a@silver>
In-Reply-To: <20200521192627.15259-1-sstabellini@kernel.org>
References: <alpine.DEB.2.21.2005211225030.27502@sstabellini-ThinkPad-T480s>
 <20200521192627.15259-1-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/22 08:35:18
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Donnerstag, 21. Mai 2020 21:26:25 CEST Stefano Stabellini wrote:
> From: Stefano Stabellini <stefano.stabellini@xilinx.com>
> 
> This reverts commit 16724a173049ac29c7b5ade741da93a0f46edff7.
> It causes https://bugs.launchpad.net/bugs/1877688.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@xilinx.com>
> ---

Actually already reviewed by me; no changes, so just to make it clear:

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

>  hw/9pfs/9p.c               | 33 +++++++++++----------------------
>  hw/9pfs/9p.h               |  2 +-
>  hw/9pfs/virtio-9p-device.c | 11 ++++-------
>  hw/9pfs/xen-9p-backend.c   | 15 ++++++---------
>  4 files changed, 22 insertions(+), 39 deletions(-)
> 
> diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
> index a2a14b5979..d39bfee462 100644
> --- a/hw/9pfs/9p.c
> +++ b/hw/9pfs/9p.c
> @@ -2102,29 +2102,22 @@ out_nofid:
>   * with qemu_iovec_destroy().
>   */
>  static void v9fs_init_qiov_from_pdu(QEMUIOVector *qiov, V9fsPDU *pdu,
> -                                    size_t skip, size_t *size,
> +                                    size_t skip, size_t size,
>                                      bool is_write)
>  {
>      QEMUIOVector elem;
>      struct iovec *iov;
>      unsigned int niov;
> -    size_t alloc_size = *size + skip;
> 
>      if (is_write) {
> -        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov, &niov,
> alloc_size); +        pdu->s->transport->init_out_iov_from_pdu(pdu, &iov,
> &niov, size + skip); } else {
> -        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov,
> &alloc_size); -    }
> -
> -    if (alloc_size < skip) {
> -        *size = 0;
> -    } else {
> -        *size = alloc_size - skip;
> +        pdu->s->transport->init_in_iov_from_pdu(pdu, &iov, &niov, size +
> skip); }
> 
>      qemu_iovec_init_external(&elem, iov, niov);
>      qemu_iovec_init(qiov, niov);
> -    qemu_iovec_concat(qiov, &elem, skip, *size);
> +    qemu_iovec_concat(qiov, &elem, skip, size);
>  }
> 
>  static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu, V9fsFidState *fidp,
> @@ -2132,14 +2125,15 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU
> *pdu, V9fsFidState *fidp, {
>      ssize_t err;
>      size_t offset = 7;
> -    size_t read_count;
> +    uint64_t read_count;
>      QEMUIOVector qiov_full;
> 
>      if (fidp->fs.xattr.len < off) {
>          read_count = 0;
> -    } else if (fidp->fs.xattr.len - off < max_count) {
> -        read_count = fidp->fs.xattr.len - off;
>      } else {
> +        read_count = fidp->fs.xattr.len - off;
> +    }
> +    if (read_count > max_count) {
>          read_count = max_count;
>      }
>      err = pdu_marshal(pdu, offset, "d", read_count);
> @@ -2148,7 +2142,7 @@ static int v9fs_xattr_read(V9fsState *s, V9fsPDU *pdu,
> V9fsFidState *fidp, }
>      offset += err;
> 
> -    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, &read_count, false);
> +    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, read_count, false);
>      err = v9fs_pack(qiov_full.iov, qiov_full.niov, 0,
>                      ((char *)fidp->fs.xattr.value) + off,
>                      read_count);
> @@ -2277,11 +2271,9 @@ static void coroutine_fn v9fs_read(void *opaque)
>          QEMUIOVector qiov_full;
>          QEMUIOVector qiov;
>          int32_t len;
> -        size_t size = max_count;
> 
> -        v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset + 4, &size, false);
> +        v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset + 4, max_count,
> false); qemu_iovec_init(&qiov, qiov_full.niov);
> -        max_count = size;
>          do {
>              qemu_iovec_reset(&qiov);
>              qemu_iovec_concat(&qiov, &qiov_full, count, qiov_full.size -
> count); @@ -2532,7 +2524,6 @@ static void coroutine_fn v9fs_write(void
> *opaque) int32_t len = 0;
>      int32_t total = 0;
>      size_t offset = 7;
> -    size_t size;
>      V9fsFidState *fidp;
>      V9fsPDU *pdu = opaque;
>      V9fsState *s = pdu->s;
> @@ -2545,9 +2536,7 @@ static void coroutine_fn v9fs_write(void *opaque)
>          return;
>      }
>      offset += err;
> -    size = count;
> -    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, &size, true);
> -    count = size;
> +    v9fs_init_qiov_from_pdu(&qiov_full, pdu, offset, count, true);
>      trace_v9fs_write(pdu->tag, pdu->id, fid, off, count, qiov_full.niov);
> 
>      fidp = get_fid(pdu, fid);
> diff --git a/hw/9pfs/9p.h b/hw/9pfs/9p.h
> index dd1c6cb8d2..1b9e110605 100644
> --- a/hw/9pfs/9p.h
> +++ b/hw/9pfs/9p.h
> @@ -436,7 +436,7 @@ struct V9fsTransport {
>      ssize_t     (*pdu_vunmarshal)(V9fsPDU *pdu, size_t offset, const char
> *fmt, va_list ap);
>      void        (*init_in_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
> -                                        unsigned int *pniov, size_t *size);
> +                                        unsigned int *pniov, size_t size);
> void        (*init_out_iov_from_pdu)(V9fsPDU *pdu, struct iovec **piov,
> unsigned int *pniov, size_t size); void        (*push_and_notify)(V9fsPDU
> *pdu);
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index e5b44977c7..36f3aa9352 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -147,22 +147,19 @@ static ssize_t virtio_pdu_vunmarshal(V9fsPDU *pdu,
> size_t offset, }
> 
>  static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
> -                                        unsigned int *pniov, size_t *size)
> +                                        unsigned int *pniov, size_t size)
>  {
>      V9fsState *s = pdu->s;
>      V9fsVirtioState *v = container_of(s, V9fsVirtioState, state);
>      VirtQueueElement *elem = v->elems[pdu->idx];
>      size_t buf_size = iov_size(elem->in_sg, elem->in_num);
> 
> -    if (buf_size < P9_IOHDRSZ) {
> +    if (buf_size < size) {
>          VirtIODevice *vdev = VIRTIO_DEVICE(v);
> 
>          virtio_error(vdev,
> -                     "VirtFS reply type %d needs %zu bytes, buffer has %zu,
> less than minimum", -                     pdu->id + 1, *size, buf_size);
> -    }
> -    if (buf_size < *size) {
> -        *size = buf_size;
> +                     "VirtFS reply type %d needs %zu bytes, buffer has
> %zu", +                     pdu->id + 1, size, buf_size);
>      }
> 
>      *piov = elem->in_sg;
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index f04caabfe5..fc197f6c8a 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -188,7 +188,7 @@ static void xen_9pfs_init_out_iov_from_pdu(V9fsPDU *pdu,
> static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU *pdu,
>                                            struct iovec **piov,
>                                            unsigned int *pniov,
> -                                          size_t *size)
> +                                          size_t size)
>  {
>      Xen9pfsDev *xen_9pfs = container_of(pdu->s, Xen9pfsDev, state);
>      Xen9pfsRing *ring = &xen_9pfs->rings[pdu->tag % xen_9pfs->num_rings];
> @@ -198,19 +198,16 @@ static void xen_9pfs_init_in_iov_from_pdu(V9fsPDU
> *pdu, g_free(ring->sg);
> 
>      ring->sg = g_new0(struct iovec, 2);
> -    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, *size);
> +    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, size);
> 
>      buf_size = iov_size(ring->sg, num);
> -    if (buf_size  < P9_IOHDRSZ) {
> -        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs reply type %d needs "
> -                      "%zu bytes, buffer has %zu, less than minimum\n", - 
>                     pdu->id + 1, *size, buf_size);
> +    if (buf_size  < size) {
> +        xen_pv_printf(&xen_9pfs->xendev, 0, "Xen 9pfs request type %d"
> +                "needs %zu bytes, buffer has %zu\n", pdu->id, size,
> +                buf_size);
>          xen_be_set_state(&xen_9pfs->xendev, XenbusStateClosing);
>          xen_9pfs_disconnect(&xen_9pfs->xendev);
>      }
> -    if (buf_size  < *size) {
> -        *size = buf_size;
> -    }
> 
>      *piov = ring->sg;
>      *pniov = num;

Best regards,
Christian Schoenebeck



