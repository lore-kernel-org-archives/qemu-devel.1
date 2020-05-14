Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA70DC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4F2720643
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:22:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOnnuBmG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4F2720643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJRK-0008O6-AH
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57758)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jZJOI-00046a-E5
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:19:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40072)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sstabellini@kernel.org>)
 id 1jZJOG-0006u0-OB
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:19:34 -0400
Received: from localhost (c-67-164-102-47.hsd1.ca.comcast.net [67.164.102.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3971220675;
 Thu, 14 May 2020 19:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589483971;
 bh=kYeCBG5fCIh5Nhv5V9vc+cg3mRAQ2NDoWh6I0xC6Rtg=;
 h=Date:From:To:cc:Subject:In-Reply-To:References:From;
 b=gOnnuBmG+QLIs+qk3fZuu25R3PKx5t8WNs2WYNsaOyB+kZMhO03/T+zih2++xZgL/
 G51CKi7vLLfRFBJMYOg4gM55QKNDGPVexE1BFFHt1lfT2R/UuRE0MQ/QXiFk5TOWT4
 XVXTNgLyYuvCa/W7/6RveX30gBhEY7nZf6oTD8IY=
Date: Thu, 14 May 2020 12:19:30 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@sstabellini-ThinkPad-T480s
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 1/1] virtio-9pfs: don't truncate response
In-Reply-To: <2cc8d6c4ae9fa8210c48c349b207dfb68cb15290.1589481482.git.qemu_oss@crudebyte.com>
Message-ID: <alpine.DEB.2.21.2005141219170.26167@sstabellini-ThinkPad-T480s>
References: <cover.1589481482.git.qemu_oss@crudebyte.com>
 <2cc8d6c4ae9fa8210c48c349b207dfb68cb15290.1589481482.git.qemu_oss@crudebyte.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=198.145.29.99;
 envelope-from=sstabellini@kernel.org; helo=mail.kernel.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 15:19:31
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -70
X-Spam_score: -7.1
X-Spam_bar: -------
X-Spam_report: (-7.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_HI=-5, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 14 May 2020, Christian Schoenebeck wrote:
> Commit SHA-1 16724a173049ac29c7b5ade741da93a0f46edff7 introduced
> truncating the response to the currently available transport buffer size,
> which was supposed to fix an 9pfs error on Xen boot where transport buffer
> might still be smaller than required for response.
> 
> Unfortunately this change broke small reads (with less than 12 bytes).
> 
> To fix this introduced bug for virtio at least, let's revert this change
> for the virtio transport. Unlike with Xen, we should never come into
> this situation with virtio that the available transport buffer would be
> too small for delivering any response to client. So truncating the buffer
> is not necessary with virtio in the first place.
> 
> This bug still needs to be addressed for Xen appropriately though.
> 
> Fixes: 16724a173049ac29c7b5ade741da93a0f46edff7 (for virtio only)
> Fixes: https://bugs.launchpad.net/bugs/1877688 (for virtio only)
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  hw/9pfs/virtio-9p-device.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/9pfs/virtio-9p-device.c b/hw/9pfs/virtio-9p-device.c
> index 536447a355..bb6154945a 100644
> --- a/hw/9pfs/virtio-9p-device.c
> +++ b/hw/9pfs/virtio-9p-device.c
> @@ -154,16 +154,13 @@ static void virtio_init_in_iov_from_pdu(V9fsPDU *pdu, struct iovec **piov,
>      VirtQueueElement *elem = v->elems[pdu->idx];
>      size_t buf_size = iov_size(elem->in_sg, elem->in_num);
>  
> -    if (buf_size < P9_IOHDRSZ) {
> +    if (buf_size < *size) {
>          VirtIODevice *vdev = VIRTIO_DEVICE(v);
>  
>          virtio_error(vdev,
> -                     "VirtFS reply type %d needs %zu bytes, buffer has %zu, less than minimum",
> +                     "VirtFS reply type %d needs %zu bytes, buffer has %zu",
>                       pdu->id + 1, *size, buf_size);
>      }
> -    if (buf_size < *size) {
> -        *size = buf_size;
> -    }
>  
>      *piov = elem->in_sg;
>      *pniov = elem->in_num;
> -- 
> 2.20.1
> 

