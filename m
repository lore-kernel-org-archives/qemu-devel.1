Return-Path: <SRS0=glhp=WN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33213C3A59B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 21:33:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0278E2173B
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Aug 2019 21:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0278E2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hz6KQ-00056u-T0
	for qemu-devel@archiver.kernel.org; Sat, 17 Aug 2019 17:33:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39331)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1hz6Iu-0004Om-1f
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 17:32:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1hz6Ir-0001hB-G0
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 17:32:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33996)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1hz6Ir-0001gS-7w
 for qemu-devel@nongnu.org; Sat, 17 Aug 2019 17:32:01 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BD04F7EBBD
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2019 21:31:59 +0000 (UTC)
Received: by mail-ot1-f70.google.com with SMTP id x31so1435607ota.4
 for <qemu-devel@nongnu.org>; Sat, 17 Aug 2019 14:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=13OJiW/fiI38hsN6qscgOvSYFZmx17aJBLxbi/I8T0g=;
 b=QmWNtFs/LAFrsZZajeX694jxLAOJY0ZBeUxFM4CCI5AjAUKgaK9ynvOTg5G04lPlb4
 Ash/84qn17mLqAOsxZwp7l/6U009iBqKPKAs+lxieX6a9t+EINj1KsBl/z7d8wHdG+wh
 yU0ZDMM4FRQlbt70slKdb5zxA66lTkLONjUHtJjMdIomlUc925J8dnm/SUYO9ZDR1p0D
 b5iK18Ft2fz6LxI0c4hCDGv/VWzIEOL35I5zeC9GC45MA+z7vQrHYqqcao04vleGjLYI
 GvcA5pWniY2WT4tXR1QnVOTpGfG1YhcUz8+CjHa3xJNP7aYHc4dJv6Y99zyKlBvLSlxs
 5AvA==
X-Gm-Message-State: APjAAAXPn/fyZsPam9/dFjUEyfNXn6TGORYGIky6VXKHcp7k6ISqXP5N
 XtsTb2oSVIcK9gkLTbHhsgLjrpU1QVsBytDMNCTsJTfZz/7aNcuXNsnlcKbNsTv2W5poH13Pj0O
 1YpWe3UkgjxbkEmYHlKOOkPxOXqQvfec=
X-Received: by 2002:a54:4610:: with SMTP id p16mr9545880oip.56.1566077519114; 
 Sat, 17 Aug 2019 14:31:59 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyNDCoq8gmIL5hUUEIyT9FXTaojZxe2qyCNv0cQYITEFwIfch5pRWW/c4pP7mxsiPTD+vZoTpQt0HPAffN7+P4=
X-Received: by 2002:a54:4610:: with SMTP id p16mr9545865oip.56.1566077518781; 
 Sat, 17 Aug 2019 14:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190817212111.13265-1-nsoffer@redhat.com>
In-Reply-To: <20190817212111.13265-1-nsoffer@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sun, 18 Aug 2019 00:31:47 +0300
Message-ID: <CAMRbyyv2FnyPVirbSRZNqgvoqp=0_cYPgQZfprf51gUgCgHO9g@mail.gmail.com>
To: Nir Soffer <nirsof@gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] block: gluster: Probe alignment limits
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
Cc: Kevin Wolf <kwolf@redhat.com>, integration@gluster.org,
 qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Niels de Vos <ndevos@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 18, 2019 at 12:21 AM Nir Soffer <nirsof@gmail.com> wrote:

> Implement alignment probing similar to file-posix, by reading from the
> first 4k of the image.
>
> Before this change, provisioning a VM on storage with sector size of
> 4096 bytes would fail when the installer try to create filesystems. Here
> is an example command that reproduces this issue:
>
>     $ qemu-system-x86_64 -accel kvm -m 2048 -smp 2 \
>         -drive
> file=gluster://gluster1/gv0/fedora29.raw,format=raw,cache=none \
>         -cdrom Fedora-Server-dvd-x86_64-29-1.2.iso
>
> The installer fails in few seconds when trying to create filesystem on
> /dev/mapper/fedora-root. In error report we can see that it failed with
> EINVAL (I could not extract the error from guest).
>
> Copying disk fails with EINVAL:
>
>     $ qemu-img convert -p -f raw -O raw -t none -T none \
>         gluster://gluster1/gv0/fedora29.raw \
>         gluster://gluster1/gv0/fedora29-clone.raw
>     qemu-img: error while writing sector 4190208: Invalid argument
>
> This is a fix to same issue fixed in commit a6b257a08e3d (file-posix:
> Handle undetectable alignment) for gluster:// images.
>
> This fix has the same limit, that the first block of the image should be
> allocated, otherwise we cannot detect the alignment and fallback to a
> safe value (4096) even when using storage with sector size of 512 bytes.
>
> Signed-off-by: Nir Soffer <nsoffer@redhat.com>
> ---
>  block/gluster.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/block/gluster.c b/block/gluster.c
> index f64dc5b01e..d936240b72 100644
> --- a/block/gluster.c
> +++ b/block/gluster.c
> @@ -52,6 +52,9 @@
>
>  #define GERR_INDEX_HINT "hint: check in 'server' array index '%d'\n"
>
> +/* The value is known only on the server side. */
> +#define MAX_ALIGN 4096
> +
>  typedef struct GlusterAIOCB {
>      int64_t size;
>      int ret;
> @@ -902,8 +905,52 @@ out:
>      return ret;
>  }
>
> +/*
> + * Check if read is allowed with given memory buffer and length.
> + *
> + * This function is used to check O_DIRECT request alignment.
> + */
> +static bool gluster_is_io_aligned(struct glfs_fd *fd, void *buf, size_t
> len)
> +{
> +    ssize_t ret = glfs_pread(fd, buf, len, 0, 0, NULL);
> +    return ret >= 0 || errno != EINVAL;
> +}
> +
> +static void gluster_probe_alignment(BlockDriverState *bs, struct glfs_fd
> *fd,
> +                                    Error **errp)
> +{
> +    char *buf;
> +    size_t alignments[] = {1, 512, 1024, 2048, 4096};
> +    size_t align;
> +    int i;
> +
> +    buf = qemu_memalign(MAX_ALIGN, MAX_ALIGN);
> +
> +    for (i = 0; i < ARRAY_SIZE(alignments); i++) {
> +        align = alignments[i];
> +        if (gluster_is_io_aligned(fd, buf, align)) {
> +            /* Fallback to safe value. */
> +            bs->bl.request_alignment = (align != 1) ? align : MAX_ALIGN;
> +            break;
> +        }
> +    }
> +
> +    qemu_vfree(buf);
> +
> +    if (!bs->bl.request_alignment) {
> +        error_setg(errp, "Could not find working O_DIRECT alignment");
> +        error_append_hint(errp, "Try cache.direct=off\n");
> +    }
> +}
> +
>  static void qemu_gluster_refresh_limits(BlockDriverState *bs, Error
> **errp)
>  {
> +    BDRVGlusterState *s = bs->opaque;
> +
> +    gluster_probe_alignment(bs, s->fd, errp);
> +
> +    bs->bl.min_mem_alignment = bs->bl.request_alignment;
> +    bs->bl.opt_mem_alignment = MAX(bs->bl.request_alignment, MAX_ALIGN);
>      bs->bl.max_transfer = GLUSTER_MAX_TRANSFER;
>  }
>
> --
> 2.20.1
>
>
To debug this I added this temporary patch:

diff --git a/block/gluster.c b/block/gluster.c
index d2d187490b..790ef4251b 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -912,6 +912,7 @@ out:
 static bool gluster_is_io_aligned(struct glfs_fd *fd, void *buf, size_t
len)
 {
     ssize_t ret = glfs_pread(fd, buf, len, 0, 0, NULL);
+    printf("gluster_is_io_aligned len=%ld ret=%ld errno=%d\n", len, ret,
errno);
     return ret >= 0 || errno != EINVAL;
 }

@@ -940,6 +941,9 @@ static void gluster_probe_alignment(BlockDriverState
*bs, struct glfs_fd *fd,
         error_setg(errp, "Could not find working O_DIRECT alignment");
         error_append_hint(errp, "Try cache.direct=off\n");
     }
+
+    printf("Probed aligment for %s request_alignment=%d\n",
+           bs->filename, bs->bl.request_alignment);
 }

 static void qemu_gluster_refresh_limits(BlockDriverState *bs, Error **errp)

Here is example run with volume with sector size of 512 bytes:

$ sudo mount -t glusterfs gluster1:/gv1 /tmp/gv1
$ dd if=/dev/zero bs=1M count=100 | tr "\0" "x" > /tmp/gv1/src.raw
$ truncate -s 100m /tmp/gv1/dst.raw
$ dd if=/dev/zero bs=1 count=1 of=/tmp/gv1/dst.raw conv=notrunc

$ ./qemu-img convert -n -f raw -O raw -t none -T none
gluster://gluster1/gv1/src.raw gluster://gluster1/gv1/dst.raw
gluster_is_io_aligned len=1 ret=-1 errno=22
gluster_is_io_aligned len=512 ret=512 errno=0
Probed aligment for gluster://gluster1/gv1/src.raw request_alignment=512
gluster_is_io_aligned len=1 ret=-1 errno=22
gluster_is_io_aligned len=512 ret=512 errno=0
Probed aligment for gluster://gluster1/gv1/dst.raw request_alignment=512

And with volume with sector size of 4096 bytes:

$ sudo mount -t glusterfs gluster1:/gv0 /tmp/gv0
$ dd if=/dev/zero bs=1M count=100 | tr "\0" "x" > /tmp/gv0/src.raw
$ truncate -s 100m /tmp/gv0/dst.raw
$ dd if=/dev/zero bs=1 count=1 of=/tmp/gv0/dst.raw conv=notrunc

$ ./qemu-img convert -n -f raw -O raw -t none -T none
gluster://gluster1/gv0/src.raw gluster://gluster1/gv0/dst.raw
gluster_is_io_aligned len=1 ret=-1 errno=22
gluster_is_io_aligned len=512 ret=-1 errno=22
gluster_is_io_aligned len=1024 ret=-1 errno=22
gluster_is_io_aligned len=2048 ret=-1 errno=22
gluster_is_io_aligned len=4096 ret=4096 errno=0
Probed aligment for gluster://gluster1/gv0/src.raw request_alignment=4096
gluster_is_io_aligned len=1 ret=-1 errno=22
gluster_is_io_aligned len=512 ret=-1 errno=22
gluster_is_io_aligned len=1024 ret=-1 errno=22
gluster_is_io_aligned len=2048 ret=-1 errno=22
gluster_is_io_aligned len=4096 ret=4096 errno=0
Probed aligment for gluster://gluster1/gv0/dst.raw request_alignment=4096
