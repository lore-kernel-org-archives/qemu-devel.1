Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56548C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 16:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895CC21481
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 16:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pylDyyzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895CC21481
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYB1b-0003NP-EC
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 12:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kYAzz-0002In-R1; Thu, 29 Oct 2020 12:42:03 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43258)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kYAzx-0007I6-Ew; Thu, 29 Oct 2020 12:42:03 -0400
Received: by mail-ot1-x343.google.com with SMTP id a6so2894336otp.10;
 Thu, 29 Oct 2020 09:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6IPaBIQVWrpxrg8zLG4HtnydJbP3ZNQy8OL8nvM/4/A=;
 b=pylDyyzOnZ5WC4Y4HzGpSoVyrsogelFAnYCZX9bRsQVn0OPexQJXEKntzswbienjAo
 8cSz9jgZAs3hn7spWvveiWLxc4yuhxj70ZHkYDZ/OkSdRmrmDBOYrw1EtGzRIuNbUdYT
 KSpKbJK37x0U86OJkpmlZ8HvZJ+PW14zUk7hDCTCp5Fcyx3I6q8eXOdz32wYGjTR9SWE
 zT+X4NP20wHyOSPRMegRtfbqnx9rds2GVvsr8pjyAlx37FhSQPoMTdWJ0guwCs+mpHdh
 VwXY57EBUHnDthGw2bIFWpNuLd/rewVwxlxQULgNHue/bTuF444fVPPiMRONvFLV9fLO
 N0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6IPaBIQVWrpxrg8zLG4HtnydJbP3ZNQy8OL8nvM/4/A=;
 b=ovgmQewxSKYW8/l9+NJ9OhgP9aIDaPAofHjF9BLfxOM1iAo3LTBP4gO0ZSKXrgIj3E
 4BB1F+mntAVv+tqybuMS6mos2nHXJydsHD0JUtsNRE6afyIq5Py+X7bemkfCqw2L5fFt
 lD3tDQG+2tuRJsNrUODQaPPDh5lclfUtzfYAHobJLqdfWy/rCMo/wgQe2bKjgL3wyCjf
 OV2OczaCUTsTRCbZIkkxvNGBP9VsojAldF85AJyfiyAN+Xswrf+FrfxSW4+fazStcLUa
 ajq8NBKf8Cgak7h7lOdVjFHxYbms701pK6k3hVdI9q890o2f79dLfRqjZ0R6tPqmpjS7
 pvTw==
X-Gm-Message-State: AOAM531b9YapvukmWqlHKi3AMJ3Dvj9NfzVDSX4sSqPN0ehtK7iSOhE1
 lfqe8yaMS3x379BjMh7rsGzVAdNBNHoW+Vt42LE=
X-Google-Smtp-Source: ABdhPJwwvz2WJwb/qfo8x7Qy0TGETK+e4QrMyJ5OMmCmHgGHGg9+3wism68U+mqPRB1rMx5DxRjZST3UZCmIfJNy0iQ=
X-Received: by 2002:a9d:57c3:: with SMTP id q3mr3669316oti.326.1603989719708; 
 Thu, 29 Oct 2020 09:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <5F997B84.9040900@huawei.com> <5F9A5B48.9030509@huawei.com>
In-Reply-To: <5F9A5B48.9030509@huawei.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 29 Oct 2020 12:41:48 -0400
Message-ID: <CAFubqFsRFh0rV3j8DS7bym-P_JHZdkuH5dyGJskKFLgQUbGABA@mail.gmail.com>
Subject: Re: [PATCH V2] vhost-user-blk/scsi: Fix broken error handling for
 socket call
To: AlexChen <alex.chen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-trivial@nongnu.org, QEMU <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 29, 2020 at 2:04 AM AlexChen <alex.chen@huawei.com> wrote:
>
> When socket() fails, it returns -1, 0 is the normal return value and should not return error.
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: AlexChen <alex.chen@huawei.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>


> ---
>  contrib/vhost-user-blk/vhost-user-blk.c   | 2 +-
>  contrib/vhost-user-scsi/vhost-user-scsi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
> index 25eccd02b5..40a2dfc544 100644
> --- a/contrib/vhost-user-blk/vhost-user-blk.c
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -474,7 +474,7 @@ static int unix_sock_new(char *unix_fn)
>      assert(unix_fn);
>
>      sock = socket(AF_UNIX, SOCK_STREAM, 0);
> -    if (sock <= 0) {
> +    if (sock < 0) {
>          perror("socket");
>          return -1;
>      }
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index 3c912384e9..0f9ba4b2a2 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -320,7 +320,7 @@ static int unix_sock_new(char *unix_fn)
>      assert(unix_fn);
>
>      sock = socket(AF_UNIX, SOCK_STREAM, 0);
> -    if (sock <= 0) {
> +    if (sock < 0) {
>          perror("socket");
>          return -1;
>      }
> --
> 2.19.1
>

