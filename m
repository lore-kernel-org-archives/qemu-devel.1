Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF9C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:42:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 739C920861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 739C920861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47020 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqxo-0004oA-MZ
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42132)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hcqp4-000754-6m
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hcqp2-0001D3-Si
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:33:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40462)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hcqp0-00019f-B8; Mon, 17 Jun 2019 08:33:14 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5A56D30BBE97;
 Mon, 17 Jun 2019 12:33:10 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1D8B21017E2E;
 Mon, 17 Jun 2019 12:33:02 +0000 (UTC)
Message-ID: <86a8e88792be3df0b16277ac762865abb411f490.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>, qemu-devel@nongnu.org
Date: Mon, 17 Jun 2019 15:33:01 +0300
In-Reply-To: <20190610134905.22294-6-mehta.aaru20@gmail.com>
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190610134905.22294-6-mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Mon, 17 Jun 2019 12:33:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 05/12] stubs: add stubs for io_uring
 interface
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-06-10 at 19:18 +0530, Aarushi Mehta wrote:
> Signed-off-by: Aarushi Mehta <mehta.aaru20@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS         |  1 +
>  stubs/Makefile.objs |  1 +
>  stubs/io_uring.c    | 32 ++++++++++++++++++++++++++++++++
>  3 files changed, 34 insertions(+)
>  create mode 100644 stubs/io_uring.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 49f896796e..bc38175124 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2522,6 +2522,7 @@ R: Stefan Hajnoczi <stefan@redhat.com>
>  L: qemu-block@nongnu.org
>  S: Maintained
>  F: block/io_uring.c
> +F: stubs/io_uring.c
>  
>  qcow2
>  M: Kevin Wolf <kwolf@redhat.com>
> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
> index 9c7393b08c..5cf160a9c8 100644
> --- a/stubs/Makefile.objs
> +++ b/stubs/Makefile.objs
> @@ -13,6 +13,7 @@ stub-obj-y += iothread.o
>  stub-obj-y += iothread-lock.o
>  stub-obj-y += is-daemonized.o
>  stub-obj-$(CONFIG_LINUX_AIO) += linux-aio.o
> +stub-obj-$(CONFIG_LINUX_IO_URING) += io_uring.o
>  stub-obj-y += machine-init-done.o
>  stub-obj-y += migr-blocker.o
>  stub-obj-y += change-state-handler.o
> diff --git a/stubs/io_uring.c b/stubs/io_uring.c
> new file mode 100644
> index 0000000000..622d1e4648
> --- /dev/null
> +++ b/stubs/io_uring.c
> @@ -0,0 +1,32 @@
> +/*
> + * Linux io_uring support.
> + *
> + * Copyright (C) 2009 IBM, Corp.
> + * Copyright (C) 2009 Red Hat, Inc.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +#include "qemu/osdep.h"
> +#include "block/aio.h"
> +#include "block/raw-aio.h"
> +
> +void luring_detach_aio_context(LuringState *s, AioContext *old_context)
> +{
> +    abort();
> +}
> +
> +void luring_attach_aio_context(LuringState *s, AioContext *new_context)
> +{
> +    abort();
> +}
> +
> +LuringState *luring_init(Error **errp)
> +{
> +    abort();
> +}
> +
> +void luring_cleanup(LuringState *s)
> +{
> +    abort();
> +}

I do wonder if there is any value in these stubs (and linux aio stubs as well) since any attempt to use this
will abort the test, even basic aio initialization.

I am not yet familiar with qemu unit tests, so I won't yet put ack on this patch.

Best regards,
	Maxim Levitsky


