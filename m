Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAD8C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 12:06:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 517EA20673
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 12:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 517EA20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFGuq-0000Zo-Cm
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 08:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38511)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iFGt8-0008Hq-Gy
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:04:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iFGt6-0002NY-Aa
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:04:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53898)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iFGt6-0002Me-1y
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 08:04:16 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7B2B92A09DA
 for <qemu-devel@nongnu.org>; Tue,  1 Oct 2019 12:04:14 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id z205so1310150wmb.7
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 05:04:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=4S9GSvtVGVTRXQRmHgyH0l0klwBA4ec1EdhxAPTUlBs=;
 b=LPfOdUWZTxy70o+dX8QCMri5xSiQLMHz1dH0n+B24IOrjHr/QBeTo15ivyqCjluv0i
 hrlNhOm/aX6UGWmwCTnZNAe/Y8g0RfkXjfXSU74M/L+IhHHyG4jQwmEMprrCpg2elXSj
 VhUbNdsQv1ZRFxZC4/wtrx/tOuEqXFcFjFn4N15bU8AE2/8TelR1UC4Z7H2Kp1dudT4Y
 vwhjPyNdmfM6oVtRbMlOMjtKydmfELbISX679mrtgeN6mQdEEbzQ0oeUEtp4QEJvQf/p
 /ZQCeYHoSPzJthNCct4Przrv332ATaTeaSNwKmOHmOYNnL4BnBJjJIWc08xoA0hXm0Lm
 eGgA==
X-Gm-Message-State: APjAAAUv3xRKMRXp7rB9/3gItlYR/uYH5hjG4n8s2nUPZVyMuZIcnCeH
 cf8BYzXfRqL97Pz9Du3wmSDVEjdVbtCoy3RPwazl0FCCRKQunmfCrVyPzAG0IgpiwE9qqSQEC+U
 hZMEiRz65MmcM3aE=
X-Received: by 2002:a5d:430e:: with SMTP id h14mr17017581wrq.18.1569931453185; 
 Tue, 01 Oct 2019 05:04:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw22QpxGa9eME8dcs/1xT5CLiq4lo9gYEw1snK8wBcGR6XzU+vUI36fuW5MEeS/vXNxNnmE8w==
X-Received: by 2002:a5d:430e:: with SMTP id h14mr17017548wrq.18.1569931452886; 
 Tue, 01 Oct 2019 05:04:12 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.200.174])
 by smtp.gmail.com with ESMTPSA id q19sm38966503wra.89.2019.10.01.05.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 05:04:11 -0700 (PDT)
Date: Tue, 1 Oct 2019 14:04:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] qemu-doc: Remove paragraph about requiring a HD image
 with -kernel
Message-ID: <20191001120409.vgxd4tsmx4guhnxc@steredhat>
References: <20191001110111.4870-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001110111.4870-1-thuth@redhat.com>
User-Agent: NeoMutt/20180716
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
Cc: qemu-trivial@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Gerd Hoffmann <kraxel@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 01, 2019 at 01:01:11PM +0200, Thomas Huth wrote:
> The need for specifying "-hda" together with "-kernel" has been removed in
> commit 57a46d057995 ("Convert linux bootrom to external rom and fw_cfg"),
> almost 10 years ago, so let's remove this description from our documentation
> now, too.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  qemu-doc.texi | 4 ----
>  1 file changed, 4 deletions(-)


Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

> 
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 2ba6c90c08..3c5022050f 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -906,10 +906,6 @@ Use @option{-kernel} to provide the Linux kernel image and
>  @option{-append} to give the kernel command line arguments. The
>  @option{-initrd} option can be used to provide an INITRD image.
>  
> -When using the direct Linux boot, a disk image for the first hard disk
> -@file{hda} is required because its boot sector is used to launch the
> -Linux kernel.
> -
>  If you do not need graphical output, you can disable it and redirect
>  the virtual serial port and the QEMU monitor to the console with the
>  @option{-nographic} option. The typical command line is:
> -- 
> 2.18.1
> 
> 

-- 

