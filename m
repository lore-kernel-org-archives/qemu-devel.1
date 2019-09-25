Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70B19C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:39:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463152146E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463152146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD7WG-0005hS-DT
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 09:39:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34082)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iD7Fd-00036S-F9
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:22:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iD7Fc-0007in-1q
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:22:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49450)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iD7Fb-0007iK-RB
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:22:35 -0400
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CEC635859E
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 13:22:34 +0000 (UTC)
Received: by mail-qt1-f198.google.com with SMTP id m6so5806615qtk.23
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 06:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pnlJfRUOHFXJHHXYrwkBIidYQJoyhof5/8LiUPs5BtI=;
 b=DuXpSkN9Gg6XcjYOADq4LnNWW+kPcf5kosf8eCZuv/tws7094xYUcXvLJQqEhfNL68
 AAwRmISDSWUgv2PPFEZ1r5OY8+X5WAEm9W0oKtE7OBj3ya5Cpa52qFLy9UIGBg1Cin11
 +uFr30MF4YDaLO4ciWIMUlqJmwtfjNre+v4CDlhHTXAu7WKV/Is6mBnyyEmIcvYgyWRL
 l3SOJeUKsJ4dPS0Qcn/Rp33/yIGgr5cB1xuYhG/2aeMqW5u55uaR9XIZ/PKprIoj6I8w
 aKydl4eFGvhgqdGdw6THTVIts8Hl5i+kY4Jjsf+SoJmWU24raZTYWggr0P3X24CG1FWy
 MesQ==
X-Gm-Message-State: APjAAAWNWzRQVIbhh5WYRU0fM/eXazDGK6W0xrZRS0hzAl/xts+l4tPY
 7ss7+2cqeADQ776lJET0n9pJ5JT1VUBR/9EzMrRs43156YldQ1yTUg6pr4dKzU0n9KLeMebIQZ1
 Y1lfDlHU+0o+H9nA=
X-Received: by 2002:a0c:8003:: with SMTP id 3mr7066284qva.161.1569417754150;
 Wed, 25 Sep 2019 06:22:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxfvhI9uAiac2Etlkr4MuWFkGKXWJ7+RXgO/YMAue1KzBwN4rmcYi6Uo7Zh4UcPnnSKElkZvg==
X-Received: by 2002:a0c:8003:: with SMTP id 3mr7066259qva.161.1569417753925;
 Wed, 25 Sep 2019 06:22:33 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id 200sm3004999qkf.65.2019.09.25.06.22.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Sep 2019 06:22:33 -0700 (PDT)
Date: Wed, 25 Sep 2019 09:22:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] hw/core/loader: Fix possible crash in rom_copy()
Message-ID: <20190925092212-mutt-send-email-mst@kernel.org>
References: <20190925130331.27825-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925130331.27825-1-thuth@redhat.com>
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
Cc: mdroth@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 25, 2019 at 03:03:31PM +0200, Thomas Huth wrote:
> Both, "rom->addr" and "addr" are derived from the binary image
> that can be loaded with the "-kernel" paramer. The code in
> rom_copy() then calculates:
> 
>     d = dest + (rom->addr - addr);
> 
> and uses "d" as destination in a memcpy() some lines later. Now with
> bad kernel images, it is possible that rom->addr is smaller than addr,
> thus "rom->addr - addr" gets negative and the memcpy() then tries to
> copy contents from the image to a bad memory location. In the best case,
> this just crashes QEMU, in the worst case, this could maybe be used to
> inject code from the kernel image into the QEMU binary, so we better fix
> it with an additional sanity check here.
> 
> Cc: qemu-stable@nongnu.org
> Reported-by: Guangming Liu
> Buglink: https://bugs.launchpad.net/qemu/+bug/1844635
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/core/loader.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 0d60219364..5099f27dc8 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1281,7 +1281,7 @@ int rom_copy(uint8_t *dest, hwaddr addr, size_t size)
>          if (rom->addr + rom->romsize < addr) {
>              continue;
>          }
> -        if (rom->addr > end) {
> +        if (rom->addr > end || rom->addr < addr) {
>              break;
>          }
>  
> -- 
> 2.18.1

