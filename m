Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBD3ACA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B783720863
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 22:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B783720863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOUTU-0004qe-OW
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 18:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34016)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iOTw3-0001fn-Ma
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iOTw1-0002sa-3Y
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:49:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iOTw0-0002sP-R3
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 17:49:21 -0400
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3C7D886662
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 21:49:19 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id s3so6347277qkd.6
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 14:49:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lI8lGWQG/oBJpwdI1brm/xDfrvf82St3eNiV4FdDYZI=;
 b=eqOg1sXdlocKhgFu9JQf1QYsryLuyYUyX2uQIVEXekUZ2Cr+z14JNEdx4ZDMUFm1qg
 ThyF5HzlFS5oOn9Q3/ofwcWEYTi4BL3jFK00InsvsJHEGbJokvU6mnxk5UFG8VZSvoA2
 gSEj45w+SAiwtW1K+sFo/EeVvE2LiKVfKv1pfu6LVGgSM/Inv3VuUZ5FhYPsE10fdrdq
 WqBzD4Zh1VsJIi31pgm84bhEfXTUoJGDa3t7zNQWQX76e5QsA8TwewZtxeit76xybEiV
 4cQ2tcTY3NU2dp/uUgLYLQmXFbkbWUwLGrG7WrO1exH+aw1tzRUGEuqyoKTlx89kBZRs
 m2aQ==
X-Gm-Message-State: APjAAAWQF4XxFX+PD2fBJqrYiWJIEVB3SYRps5fzfXW2Ktj/POGYManx
 aRBvmSBqsyH1R6hMEV2+anw6TCnL/a1LnJvWx4631xm6RI//LDfVzXEddBW6AFNp2qHqbxl+k7t
 t9sIlsp8I0EvLQc4=
X-Received: by 2002:a37:6442:: with SMTP id y63mr9311559qkb.31.1572126558398; 
 Sat, 26 Oct 2019 14:49:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz+5frrcScCQG5/uzGSr7A3EYiOqr98XxqMVgPftx8ZADaXQazk+vfzH7lk8wd27jFsyromfw==
X-Received: by 2002:a37:6442:: with SMTP id y63mr9311531qkb.31.1572126558053; 
 Sat, 26 Oct 2019 14:49:18 -0700 (PDT)
Received: from redhat.com (bzq-79-176-10-77.red.bezeqint.net. [79.176.10.77])
 by smtp.gmail.com with ESMTPSA id
 x38sm4548645qtc.64.2019.10.26.14.49.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Oct 2019 14:49:16 -0700 (PDT)
Date: Sat, 26 Oct 2019 17:49:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC 1/3] WIP virtiofsd: import Linux <fuse.h> header file
Message-ID: <20191026174745-mutt-send-email-mst@kernel.org>
References: <20191025100152.6638-1-stefanha@redhat.com>
 <20191025100152.6638-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191025100152.6638-2-stefanha@redhat.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, virtio-fs@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, vgoyal@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 25, 2019 at 12:01:50PM +0200, Stefan Hajnoczi wrote:
> tests/vhost-user-fs-test.c needs fuse.h.  The private copy that
> virtiofsd has can be replaced with a properly imported file using
> update-linux-headers.sh.
> 
> TODO rerun update-linux-headers.sh with upstream kernel tree!
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

OK I would just add this with the virtiofsd patchset.

> ---
>  contrib/virtiofsd/fuse_lowlevel.h                              | 2 +-
>  .../fuse_kernel.h => include/standard-headers/linux/fuse.h     | 0
>  contrib/virtiofsd/fuse_loop_mt.c                               | 2 +-
>  contrib/virtiofsd/fuse_lowlevel.c                              | 2 +-
>  contrib/virtiofsd/fuse_virtio.c                                | 2 +-
>  scripts/update-linux-headers.sh                                | 3 ++-
>  6 files changed, 6 insertions(+), 5 deletions(-)
>  rename contrib/virtiofsd/fuse_kernel.h => include/standard-headers/linux/fuse.h (100%)
> 
> diff --git a/contrib/virtiofsd/fuse_lowlevel.h b/contrib/virtiofsd/fuse_lowlevel.h
> index 79fb30a1c2..a8c92ff7e0 100644
> --- a/contrib/virtiofsd/fuse_lowlevel.h
> +++ b/contrib/virtiofsd/fuse_lowlevel.h
> @@ -23,7 +23,7 @@
>  #endif
>  
>  #include "fuse_common.h"
> -#include "fuse_kernel.h"
> +#include "standard-headers/linux/fuse.h"
>  
>  #include <utime.h>
>  #include <fcntl.h>
> diff --git a/contrib/virtiofsd/fuse_kernel.h b/include/standard-headers/linux/fuse.h
> similarity index 100%
> rename from contrib/virtiofsd/fuse_kernel.h
> rename to include/standard-headers/linux/fuse.h
> diff --git a/contrib/virtiofsd/fuse_loop_mt.c b/contrib/virtiofsd/fuse_loop_mt.c
> index 2000a8902a..af7b501fac 100644
> --- a/contrib/virtiofsd/fuse_loop_mt.c
> +++ b/contrib/virtiofsd/fuse_loop_mt.c
> @@ -11,7 +11,7 @@
>  #include "fuse_i.h"
>  #include "fuse_lowlevel.h"
>  #include "fuse_misc.h"
> -#include "fuse_kernel.h"
> +#include "standard-headers/linux/fuse.h"
>  #include "fuse_virtio.h"
>  
>  #include <stdio.h>
> diff --git a/contrib/virtiofsd/fuse_lowlevel.c b/contrib/virtiofsd/fuse_lowlevel.c
> index 78ccfe3a27..c1a901cb4d 100644
> --- a/contrib/virtiofsd/fuse_lowlevel.c
> +++ b/contrib/virtiofsd/fuse_lowlevel.c
> @@ -10,7 +10,7 @@
>  */
>  
>  #include "fuse_i.h"
> -#include "fuse_kernel.h"
> +#include "standard-headers/linux/fuse.h"
>  #include "fuse_opt.h"
>  #include "fuse_misc.h"
>  #include "fuse_virtio.h"
> diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_virtio.c
> index 533ef24bb7..7a0d0b2603 100644
> --- a/contrib/virtiofsd/fuse_virtio.c
> +++ b/contrib/virtiofsd/fuse_virtio.c
> @@ -15,7 +15,7 @@
>  #include "qapi/error.h"
>  
>  #include "fuse_i.h"
> -#include "fuse_kernel.h"
> +#include "standard-headers/linux/fuse.h"
>  #include "fuse_misc.h"
>  #include "fuse_opt.h"
>  #include "fuse_virtio.h"
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index f76d77363b..1a627ccd73 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -184,7 +184,8 @@ EOF
>  
>  rm -rf "$output/include/standard-headers/linux"
>  mkdir -p "$output/include/standard-headers/linux"
> -for i in "$tmpdir"/include/linux/*virtio*.h \
> +for i in "$tmpdir/include/linux/fuse.h" \
> +         "$tmpdir"/include/linux/*virtio*.h \
>           "$tmpdir/include/linux/qemu_fw_cfg.h" \
>           "$tmpdir/include/linux/input.h" \
>           "$tmpdir/include/linux/input-event-codes.h" \
> -- 
> 2.21.0

