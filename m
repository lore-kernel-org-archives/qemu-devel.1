Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E73C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:41:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2DAB21E6C
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 15:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cx3Lsco8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2DAB21E6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvO4L-0002pg-Ug
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 11:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57203)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hvO3Z-0002Cf-Gr
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:40:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hvO3X-0002sp-Jc
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:40:53 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43834)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hvO3X-0002qy-6H
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 11:40:51 -0400
Received: by mail-wr1-x444.google.com with SMTP id p13so17269170wru.10
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 08:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=iyuv91Faapk1moEifRNVgWiPwIf+MwfRJvPFtEEyKEg=;
 b=cx3Lsco8cxRP/EZdmhWpOSZw18Kjnxfl4PqCLYm1H9Idk5IZhGEzJLIBYalnIN9ZSB
 okCLyRTRxdXST1rYFyla7QOrIHYlzsFDiwmcYiOs3JfM6mtWwENAqHgoCw2o1l6Cyxxp
 tzsCWK63Zxu2+nw4ZgRS59r7QvMAHnOOW53fIebXnzsHRdG/E/1/bfDE7YNumNq2SiMa
 ywgNaBV5wIE5rfAaydmh+tayNAT7kxJJ6TbExq527duEvkAPt2qNBm2VmfYmo2bGguSW
 /lIIMKCdAvnueTZMVHtI0lGF1XkxlNcF4CvxBN4zcfYyCW/H7GX5htgzQeysVgWTVaIr
 Ynng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=iyuv91Faapk1moEifRNVgWiPwIf+MwfRJvPFtEEyKEg=;
 b=pYy0DD2KHIs0sMZR3OhptQWn8T1zuopkolDkx7ixJnCOuXKMCFLEKjQix1++8Cf69L
 2tQHCOMIpHpAs5WnQYgYuHzbTFr40DkbXUaI9lAmbFmQNYkBkBmpwbeGjK875IYJ2Y5P
 E6t/+GxZkOTZYFu9kqBqxk7C6Ig3n4lF5uVs/UZ9eXMuCtvBhWAIlwLloC4KX20Rg8XK
 E/zqGeBmDPPudxaXpsaEgu4OKrUr88c/eGaC+10/Q9ZnBIjeDGuA7nLv7RDpGhDuawi6
 W4M+dsPkBtgcP5LOGnrwTYxl5+IDfAJqF4GAAzbGcWCOJIREG3ptrmBDsY4qa8ufrqiZ
 N6cw==
X-Gm-Message-State: APjAAAVlxXTorYxO94E2ss7zC9mZRRS3ymuMotrIgN/ZycdRxOPmambD
 9a/e7aG7IuXUvqr9pk6IDSMXcZezvZc=
X-Google-Smtp-Source: APXvYqzwwB7LxommAva35mH3qLZVGv2g3ziVBnOC0rRgrbXIHm3/fQ37bp8L2aqV/HsNMOerBFOiwQ==
X-Received: by 2002:a05:6000:1148:: with SMTP id
 d8mr10696714wrx.354.1565192449140; 
 Wed, 07 Aug 2019 08:40:49 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id x6sm98393533wrt.63.2019.08.07.08.40.48
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 07 Aug 2019 08:40:48 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DE3B51FF87;
 Wed,  7 Aug 2019 16:40:47 +0100 (BST)
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-6-armbru@redhat.com>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190806151435.10740-6-armbru@redhat.com>
Date: Wed, 07 Aug 2019 16:40:47 +0100
Message-ID: <87ftmdhtkw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v2 05/29] queue: Drop superfluous #include
 qemu/atomic.h
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
Cc: Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Markus Armbruster <armbru@redhat.com> writes:

> When commit 5f7d05ecfda added QLIST_INSERT_HEAD_RCU() to qemu/queue.h,
> it had to include qemu/atomic.h.  Commit 341774fe6cc removed
> QLIST_INSERT_HEAD_RCU() again, but neglected to remove the #include.
> Do that now.
>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  include/qemu/queue.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/qemu/queue.h b/include/qemu/queue.h
> index 0379bd8fdb..73bf4a984d 100644
> --- a/include/qemu/queue.h
> +++ b/include/qemu/queue.h
> @@ -78,8 +78,6 @@
>   * For details on the use of these macros, see the queue(3) manual page.
>   */
>
> -#include "qemu/atomic.h" /* for smp_wmb() */
> -
>  /*
>   * List definitions.
>   */


--
Alex Benn=C3=A9e

