Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EEFC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 08:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94A252067D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 08:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94A252067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huYS5-0004rv-Ps
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 04:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51433)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1huYRL-0004Rz-My
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 04:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1huYRK-000840-Ne
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 04:33:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34646)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1huYRK-00083L-I2
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 04:33:58 -0400
Received: by mail-wm1-f68.google.com with SMTP id w9so6124521wmd.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 01:33:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=pRnUSOfz8SWzXIiJrmEa+E2ID++aDMlnZMSNCIX3Dmk=;
 b=S16SuYlSH/lqaJcqTLk04BOjFtB6W7W2Eg60H8073Rhh9kf1ZcgOwoqXG6QB8/D3FF
 of1Xbdd/DW2JWfZSb2ki/netQHWMHqvYvBucZH2qExwIyVzfly5tODc5pvZ6Cy01nYbS
 1AmtfZhJbUpwzHV/k0yvjfYjlQd/xZNr37Kp0nKQTeX1AI0VW5wl/Q3q49mAtAnf8MBV
 DnghqGd+So0OMpAr8TadUHnMRj0+REwjf2pOd3gZmCButaTAddGQeJqh3ynhR89CZlB/
 BspEEo0pCORwV5WjdF/GcLCjL/04tDVa0s9P/ls80jz0lQHeOKgh4b1tdS+bC9DaPXhC
 POfw==
X-Gm-Message-State: APjAAAVRM0hWOiXSi6UGUBEJf6s3iJ3442U5KIuLPZBUgY58cn+Yr6N4
 OhdYat1EXTmzUTiXFUIC4+PMJw==
X-Google-Smtp-Source: APXvYqw+2aSyXSk3J5uaZf3V2Pw1UlcNv/ecWkiL4KkySpfPKx7QZ2YbMyK+4KUggXM7Cx3B7lQLyw==
X-Received: by 2002:a1c:3883:: with SMTP id f125mr16745600wma.18.1564994035987; 
 Mon, 05 Aug 2019 01:33:55 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id k124sm143880373wmk.47.2019.08.05.01.33.55
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 05 Aug 2019 01:33:55 -0700 (PDT)
Date: Mon, 5 Aug 2019 10:33:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jan Kiszka <jan.kiszka@web.de>
Message-ID: <20190805083352.mtu7pwoekwstmzp2@steredhat>
References: <99c1a7bd-1876-66a2-4b8e-d5bc86116fe7@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99c1a7bd-1876-66a2-4b8e-d5bc86116fe7@web.de>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2] ivshmem-server: Terminate also on SIGINT
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
Cc: qemu-devel <qemu-devel@nongnu.org>, Claudio Fontana <cfontana@suse.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Aug 03, 2019 at 03:22:04PM +0200, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Allows to shutdown a foreground session via ctrl-c.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
> 
> Changes in v2:
>  - adjust error message
> 
>  contrib/ivshmem-server/main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/contrib/ivshmem-server/main.c b/contrib/ivshmem-server/main.c
> index 197c79c57e..e4cd35f74c 100644
> --- a/contrib/ivshmem-server/main.c
> +++ b/contrib/ivshmem-server/main.c
> @@ -223,8 +223,9 @@ main(int argc, char *argv[])
>      sa_quit.sa_handler = ivshmem_server_quit_cb;
>      sa_quit.sa_flags = 0;
>      if (sigemptyset(&sa_quit.sa_mask) == -1 ||
> -        sigaction(SIGTERM, &sa_quit, 0) == -1) {
> -        perror("failed to add SIGTERM handler; sigaction");
> +        sigaction(SIGTERM, &sa_quit, 0) == -1 ||
> +        sigaction(SIGINT, &sa_quit, 0) == -1) {
> +        perror("failed to add signal handler; sigaction");
>          goto err;
>      }

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Not related with this patch, but since I was looking at the code,
I noticed the 'ivshmem_server_quit' variable, set in the signal handler,
is not volatile.
Should we define it volatile to avoid possible compiler optimizations?

Thanks,
Stefano

