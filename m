Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0D0C433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 22:04:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ED232065F
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 22:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRFunL5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ED232065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCruK-0005U0-FN
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 18:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56336)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kCrtB-0004Sq-79
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 18:02:57 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:44680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kCrt8-0006Ua-5B
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 18:02:55 -0400
Received: by mail-ot1-x341.google.com with SMTP id n23so6731934otq.11
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 15:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9Rbd8DkbZFrex8zTzD4pthrLoMQ9N5hH9oxt06i4s88=;
 b=hRFunL5eKfkpHqPlJ++fTQ7cPylLqUGLv4Q23sjVBMhIztmSsOeIEHojCq25yN16YY
 VEZYWl+QO9YJRRMVe5MybjvUugqiDoaLmM65CvxeCz5mnUGUw+rnObJREnrPpBzIExXr
 1mUFSqXC3QP1IYE8JXtdT4bVdS9oEi3rtUK0fZLvHJIYr4FJX19TcjRzdKS3keO62+Rj
 fw1CajrLFmI8lGtcLQw2E2pAqwUTeM7zXXHng/CuBHNIaLokv/9cItYTH3VYR0fpKxt7
 jPqEA3PXdUNNEAAlnQua1VSIda9lSPT6SYWSvk0euxdHNc0GHltkYlajouR2iEPiAiVX
 bTmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9Rbd8DkbZFrex8zTzD4pthrLoMQ9N5hH9oxt06i4s88=;
 b=RVbeeCA7SNTicv70MNu6HyPWP+eoplYcMBsbXevf5L02BzN4Q9LLAgH3y4adz2rQ8Y
 0HOkz8ZvO0TgUydBOi2/TRNwcHAQytOTG1YQw8RPu3v66/0Dv327IfonDzqampWCZL6z
 a8RFlzZcUakXnypMUS82KDMDahzHaBmByxwiEIb4wCGhMQPnDhDkPJDYTrLXEzmTen4V
 S0n6Q15CcKhEtjfGZO5nG7LvEvXbtk1QMtJEdxSOSrS3vRz0OzT/tt4IaEgAoojCs89X
 e9/bSxQLdFlVOc68fvQr5pTTQellf2ggp4duaIky3dKcYninMYoJd6x0d64P9814ly1Q
 BU3g==
X-Gm-Message-State: AOAM533DnLzujyRzxslwCtgPKnmqEKm3tKiCQwNKMTwqYXzFUE9MhcUf
 yDQCgEekLhJTvzTlVgFgEk2yRHhnpLGF6nbVm68=
X-Google-Smtp-Source: ABdhPJxbnHXc1nUw8n5h16J6Kf5V5muxnGHGqHX0GnkgnZ4RQl1Df+sZESTb4ow6jRSa7eNXw1Y/9g3dSUybYvlBcow=
X-Received: by 2002:a9d:2f04:: with SMTP id h4mr2149829otb.326.1598911372418; 
 Mon, 31 Aug 2020 15:02:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200827210920.111611-1-sw@weilnetz.de>
In-Reply-To: <20200827210920.111611-1-sw@weilnetz.de>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 31 Aug 2020 18:02:41 -0400
Message-ID: <CAFubqFvx2_=Dx6kYXQnipY8JbMbaOLGJK2uCy5WJ+jFVb-Jytw@mail.gmail.com>
Subject: Re: [PATCH] libvhost-user: Add GCC_FMT_ATTR and fix format string
To: Stefan Weil <sw@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-ot1-x341.google.com
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
Cc: QEMU <qemu-devel@nongnu.org>, Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 27, 2020 at 5:09 PM Stefan Weil <sw@weilnetz.de> wrote:
>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  contrib/libvhost-user/libvhost-user.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-user/libvhost-user.c
> index 53f16bdf08..ff7ac876f4 100644
> --- a/contrib/libvhost-user/libvhost-user.c
> +++ b/contrib/libvhost-user/libvhost-user.c
> @@ -151,7 +151,7 @@ vu_request_to_string(unsigned int req)
>      }
>  }
>
> -static void
> +static void GCC_FMT_ATTR(2, 3)
>  vu_panic(VuDev *dev, const char *msg, ...)
>  {
>      char *buf = NULL;
> @@ -643,7 +643,7 @@ generate_faults(VuDev *dev) {
>
>          if (ioctl(dev->postcopy_ufd, UFFDIO_REGISTER, &reg_struct)) {
>              vu_panic(dev, "%s: Failed to userfault region %d "
> -                          "@%p + size:%zx offset: %zx: (ufd=%d)%s\n",
> +                          "@%016"PRIx64" + size:%zx offset: %zx: (ufd=%d)%s\n",
>                       __func__, i,
>                       dev_region->mmap_addr,
>                       dev_region->size, dev_region->mmap_offset,
> --
> 2.28.0
>
>

