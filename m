Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDEE4C072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:34:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A871F2175B
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 18:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKp4zpF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A871F2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58553 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUF1D-0006X8-VJ
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 14:34:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hUExN-000485-8n
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:30:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1hUEtu-00021l-Dg
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:26:43 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:35490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hUEtt-0001zg-6F
	for qemu-devel@nongnu.org; Fri, 24 May 2019 14:26:41 -0400
Received: by mail-wr1-x431.google.com with SMTP id m3so10937455wrv.2
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 11:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=hvXDmrw3GEQly7aZZR69fJtYhJFiM0yXn8JwBkn1fUo=;
	b=oKp4zpF0OFbie4FIGQOgAXqch76+wF5wwTD1vGmd0oTvedjWQgmaCarkspNImEA7cg
	njp8nCaRdhCAokKCrSwasra1RUDAbUAbBJFbOzDwHJ6HpMpyMXVDMy6FMTHGHCbnWS3v
	eKGCrfXoIXzPhw/4QiH+0Uc8sFajw89hEpdnRw7AlzamILAXBINSwWnEBWPri6u6KBbY
	M6LH5DW4YqV3M1vqD/azrA204h8QJ+KkxMV+GXr6fsjJuWthAHyAGuzVkSxMkH6V3Fnk
	IEFh3ZjgK+kObAU2GUyLuK19M0tA11ImedOpYVnWLL+2opdeScHMr3QXlZ5AZVEMjW4p
	lZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=hvXDmrw3GEQly7aZZR69fJtYhJFiM0yXn8JwBkn1fUo=;
	b=itFOp3fexhl+1Y9dvRsVLST2aZfBxm71hZvqS87IFhHO6T5vCveBpgdNWxUPCY/RxF
	vsHU34ljofIHsg9R+8gxUxxOTWV0goWcaBcmT7MBN45Vh2wAaN72KHXhiCXrxZQlZshw
	ysG5aq67COuQJpu9RYZODt3OA2qymsNF553aeV1gkl8k02kCddC65fXP9hQl5MlRFUgm
	o96/kiqWdJ8GebbDy1vr7SBMscwCJf2/jJy/bxoA3+R82yKGO2/B38rjCU8bh/+Um1e8
	jqduz1QIRFUe0MW4Oq+/HtRXv2gp5wApnscULDt4L7QTAJ3JnEzLqLoPHQG/hnlFaEL0
	le0Q==
X-Gm-Message-State: APjAAAU883ylhgGmASj/md8mvg4DEqE4Qc0nJX7CM2mP8+rJaae4rBYI
	sV4UONEpJM6xGriIRzzLA+lF3Pz67w4U3r/hDZ8=
X-Google-Smtp-Source: APXvYqyu6u/Wz14PBii2wxMrLThWaoFsA/FqgX9p/UVWL5TLq/SJA3gy7TzQ7Ww4c7GS2Q1o6ZdFgOQvX13qrbI881g=
X-Received: by 2002:adf:f988:: with SMTP id f8mr3688396wrr.254.1558722398220; 
	Fri, 24 May 2019 11:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190523134409.18673-1-stefanha@redhat.com>
	<20190523134409.18673-2-stefanha@redhat.com>
In-Reply-To: <20190523134409.18673-2-stefanha@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Fri, 24 May 2019 19:26:26 +0100
Message-ID: <CAJSP0QU8nLHhvWUAPjDrUR8BvqGnDBvAPdi49sAH39ytp-H_-g@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::431
Subject: Re: [Qemu-devel] [RFC v2 1/3] virtio: add vdc->vmchange_state()
 callback
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
Cc: Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	Fam Zheng <fam@euphon.net>, qemu-devel <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 23, 2019 at 2:55 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> @@ -2253,10 +2254,18 @@ static void virtio_vmstate_change(void *opaque, int running, RunState state)
>          virtio_set_status(vdev, vdev->status);
>      }
>
> +    if (!backend_run && k->vmstate_change) {
> +        vdc->vmstate_change(vdev, backend_run);
> +    }
> +
>      if (k->vmstate_change) {
>          k->vmstate_change(qbus->parent, backend_run);
>      }
>
> +    if (backend_run && k->vmstate_change) {
> +        vdc->vmstate_change(vdev, backend_run);
> +    }

Oops, k->vmstate_change should be vdc->vmstate_change.  I'll send a
new revision.

Stefan

