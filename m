Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEBEC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:37:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0CB92184B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 12:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0CB92184B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48239 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEYxE-0006es-JM
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 08:37:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1hEYvw-0005vV-2z
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jdillama@redhat.com>) id 1hEYvu-0003ay-SJ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:36:00 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1hEYvu-0003Zu-I3
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 08:35:58 -0400
Received: by mail-ed1-f65.google.com with SMTP id f53so3488206ede.4
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 05:35:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
	:from:date:message-id:subject:to:cc;
	bh=sQEKtJpAg1ao+cV3sTYKGW+u02crCojtPLUEThmIvkY=;
	b=RdmKpg//lqSbUCd/kTv272ugm0R5XGy1Zc7fmAliF/5oWHSNjxaNnOfBHzIIawSo1P
	Lx0l8k3zHAZrN7DU1z6GWpJe4zHtMmg/WUx1gydMRwCrGnAk4otdg6fkTzKxli+8lrpF
	EcH7pD7p2NtfXHc9e0iVxrigrTz6lbp/EriFo30NCjYc5GLYPc/I6Y4F2UYmT09wecZk
	uWQqV1oNgmH0iL48kvX7dVniw/Cb+ckBNDMOfwoZvm1Z+u97x4aWRMXihWksiJ/Vpn7Q
	gRBOg3uaXQejMepCZ9r0Q/qkw+a0GJdLkHVwPzEe0N4K25gDGR+CPEyuybu4d4oOewWL
	S5gQ==
X-Gm-Message-State: APjAAAUq/ytd/jZ6tREv9Unffd2f6Ku4DUsy/Ix+K5SkEaH6qeNRokZ5
	35v9RHXNWplv7kp/gxUxzrH7lyzOFZLSgMyADIBAAg==
X-Google-Smtp-Source: APXvYqyNJMlR2fOoBm9IWcuHm/3Fq83t5VZou6aMcB0kt8zvoto+9Bj6CeXRLRz6AQ+acZ8UyS7k569kJKosghB5eG0=
X-Received: by 2002:a17:906:f0cd:: with SMTP id
	dk13mr26365757ejb.87.1554986155852; 
	Thu, 11 Apr 2019 05:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190411105025.97397-1-sgarzare@redhat.com>
	<20190411105025.97397-2-sgarzare@redhat.com>
In-Reply-To: <20190411105025.97397-2-sgarzare@redhat.com>
From: Jason Dillaman <jdillama@redhat.com>
Date: Thu, 11 Apr 2019 08:35:44 -0400
Message-ID:
 <CA+aFP1AMzNjWtMeGy4MpWBa26qxShgciYkcEZ8mkSmDrtCvfqA@mail.gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.208.65
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] block/rbd: increase dynamically
 the image size
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: dillaman@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
	qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190411123544.pv2JLNTzSftcZeE4av-xpUjQvioqEYqLJ7dSMMjX_L0@z>

On Thu, Apr 11, 2019 at 7:00 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> RBD APIs don't allow us to write more than the size set with rbd_create()
> or rbd_resize().
> In order to support growing images (eg. qcow2), we resize the image
> before RW operations that exceed the current size.

What's the use-case for storing qcow2 images within a RBD image? RBD
images are already thinly provisioned, they support snapshots, they
can form a parent/child linked image hierarchy.

> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1171007
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  block/rbd.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/block/rbd.c b/block/rbd.c
> index 0c549c9935..228658e20a 100644
> --- a/block/rbd.c
> +++ b/block/rbd.c
> @@ -102,6 +102,7 @@ typedef struct BDRVRBDState {
>      rbd_image_t image;
>      char *image_name;
>      char *snap;
> +    uint64_t image_size;
>  } BDRVRBDState;
>
>  static int qemu_rbd_connect(rados_t *cluster, rados_ioctx_t *io_ctx,
> @@ -777,6 +778,14 @@ static int qemu_rbd_open(BlockDriverState *bs, QDict *options, int flags,
>          goto failed_open;
>      }
>
> +    r = rbd_get_size(s->image, &s->image_size);
> +    if (r < 0) {
> +        error_setg_errno(errp, -r, "error reading image size from %s",
> +                         s->image_name);
> +        rbd_close(s->image);
> +        goto failed_open;
> +    }
> +
>      /* If we are using an rbd snapshot, we must be r/o, otherwise
>       * leave as-is */
>      if (s->snap != NULL) {
> @@ -921,6 +930,20 @@ static BlockAIOCB *rbd_start_aio(BlockDriverState *bs,
>          rcb->buf = acb->bounce;
>      }
>
> +    /*
> +     * RBD APIs don't allow us to write more than actual size, so in order
> +     * to support growing images, we resize the image before RW operations
> +     * that exceed the current size.
> +     */
> +    if (s->image_size < off + size) {
> +        r = rbd_resize(s->image, off + size);
> +        if (r < 0) {
> +            goto failed;
> +        }
> +
> +        s->image_size = off + size;
> +    }
> +
>      acb->ret = 0;
>      acb->error = 0;
>      acb->s = s;
> @@ -1066,6 +1089,8 @@ static int coroutine_fn qemu_rbd_co_truncate(BlockDriverState *bs,
>          return r;
>      }
>
> +    s->image_size = offset;
> +
>      return 0;
>  }
>
> --
> 2.20.1
>
>


-- 
Jason

