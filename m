Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD02CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 17:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7A5420863
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 17:29:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7A5420863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOPs6-0008TL-2V
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 13:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37238)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1iOPrP-0007Ep-9E
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 13:28:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1iOPrO-0001Gb-6q
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 13:28:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59552)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1iOPrN-0001G6-Sx
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 13:28:18 -0400
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0AEE55AFE3
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 17:28:17 +0000 (UTC)
Received: by mail-ot1-f71.google.com with SMTP id z39so521224ota.7
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 10:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KOHWWzpsRHezucVI6hZGOv9QBOFFxuGAU/AnUycCMgA=;
 b=R7HXTOMlUkYsb5VF1zcEkKNPs433Jb+A6N2MjjT2A4Jbk/egCZRn20CDdyhvNoOLhh
 MpQWcjYmpbL4PjVIZBGWEQ/C0pEaT7rU1wDlapEgQKKWG6D+Wep0Ir/niadcJkadqr7M
 rn+rZxRaqnzskN/pNyLkguVPsqFx+maDSEahHmQeBexVlJh/7OSecIHgWluTCW983Fyb
 +heR1eqvcByXLJd2qkIF5ZYqbVSAKaDv52LGNks/TsYzj68ZSm+wH3OF8J1FBJ5o2iJc
 HaSf+d6h8xZx6PChvdgNWIy/cM/fBdPOtOnpa0LDw3xZpu4V+IlITi7sJ8MqiM5ah29k
 wbew==
X-Gm-Message-State: APjAAAWIqRbs0zZTcYVHsLp4Wp58lxD9rCELvQ7dtf3ojQpQPZeaT+IN
 blQ8OQokUcuJIRcPWD2B8iCJDQIG64DAg9zohUwMI/Ag93DtXcKewRt8HphjpyzCcx9zCS5MmTa
 73CNfMoJu4EmRG+XJOCxCF7iQEHBkIFA=
X-Received: by 2002:aca:d594:: with SMTP id m142mr7611156oig.156.1572110896420; 
 Sat, 26 Oct 2019 10:28:16 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxWth+uZAqzUuxf+ajvBM+Nklwwigve8kbbEQ71FupkylrkUdYUKpXGNKOaz/95MlARaj4+pr6DFIuSR5lcFjw=
X-Received: by 2002:aca:d594:: with SMTP id m142mr7611143oig.156.1572110896031; 
 Sat, 26 Oct 2019 10:28:16 -0700 (PDT)
MIME-Version: 1.0
References: <20191025095849.25283-1-mreitz@redhat.com>
 <20191025095849.25283-4-mreitz@redhat.com>
In-Reply-To: <20191025095849.25283-4-mreitz@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sat, 26 Oct 2019 20:28:00 +0300
Message-ID: <CAMRbyythOST0GXy3XYOfx4oSj1NpVoROw3b2hZ1vnUOfogMwFw@mail.gmail.com>
Subject: Re: [RFC 3/3] block/file-posix: Let post-EOF fallocate serialize
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Krutika Dhananjay <kdhananj@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 25, 2019 at 1:24 PM Max Reitz <mreitz@redhat.com> wrote:
>
> The XFS kernel driver has a bug that may cause data corruption for qcow2
> images as of qemu commit c8bb23cbdbe32f.  We can work around it by
> treating post-EOF fallocates as serializing up until infinity (INT64_MAX
> in practice).
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/file-posix.c | 42 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 5cd54c8bff..1f5a01df70 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -2713,6 +2713,48 @@ raw_do_pwrite_zeroes(BlockDriverState *bs, int64_t offset, int bytes,
>      RawPosixAIOData acb;
>      ThreadPoolFunc *handler;
>
> +#ifdef CONFIG_FALLOCATE
> +    if (s->is_xfs && s->use_linux_aio &&

This limit the fix to local xfs filesystem, but the fix may be needed
to remote filesystem such
as gluster over xfs.

> +        offset + bytes > bs->total_sectors * BDRV_SECTOR_SIZE)
> +    {
> +        BdrvTrackedRequest *req;
> +        uint64_t end;
> +
> +        /*
> +         * The Linux XFS driver has a bug where it will discard writes
> +         * submitted through the AIO interface if they happen beyond a
> +         * concurrently running fallocate() that increases the file
> +         * length (i.e., both the write and the fallocate() happen
> +         * beyond the EOF).
> +         *
> +         * To work around it, we look for the tracked request for this
> +         * zero write, extend it until INT64_MAX (effectively
> +         * infinity), and mark it as serializing.
> +         *
> +         * TODO: Detect whether this has been fixed in the XFS driver.
> +         */
> +
> +        QLIST_FOREACH(req, &bs->tracked_requests, list) {
> +            if (req->co == qemu_coroutine_self() &&
> +                req->type == BDRV_TRACKED_WRITE)
> +            {
> +                break;
> +            }
> +        }
> +
> +        assert(req);
> +        assert(req->offset <= offset);
> +        assert(req->offset + req->bytes >= offset + bytes);
> +
> +        end = INT64_MAX & -(uint64_t)bs->bl.request_alignment;
> +        req->bytes = end - req->offset;
> +        req->overlap_bytes = req->bytes;
> +
> +        bdrv_mark_request_serialising(req, bs->bl.request_alignment);
> +        bdrv_wait_serialising_requests(req);
> +    }
> +#endif
> +
>      acb = (RawPosixAIOData) {
>          .bs             = bs,
>          .aio_fildes     = s->fd,
> --
> 2.21.0
>
>

