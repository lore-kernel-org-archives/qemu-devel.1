Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_LOCAL_NOVOWEL,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9C6EC43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 05:15:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2BCF2077B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 05:15:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L98NYnN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2BCF2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39489 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJtCi-0007Tb-Eh
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 01:15:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hJtBz-00078X-OT
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 01:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1hJtBy-0001ib-SK
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 01:14:35 -0400
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:45032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1hJtBy-0001df-Nx
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 01:14:34 -0400
Received: by mail-yb1-xb44.google.com with SMTP id u187so831834ybg.11
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 22:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=gYhEzSdcVu+JPSE5gzO8ECdnSJypZliLiJaeaHvxaN4=;
	b=L98NYnN3PPMX5ERfqp/8zSivVZRh17jj1OQHhf6moYgK6W+I1lvgUTT4pexAETRF0e
	JZZvF3NVspvi/xT8A0w0ECqmWnO2KIJqljE+d+hSU26MjMwBG2Pms33SIjK+MYjMd1Dz
	Rb5HWP5MIrBXlV4JXXcw7T/SxW0kegSDUY2EmaA8w6yMd2OkyJwLj6M30a7+fQtnyXe6
	RhUp1tQGVbIwJ42Xnz2AdlwX4Nt0AZMPYHhARc8MB3xgPZmsgIQ0yngXMUe+4tKlr/yO
	BFY5Ydj4Bq7+CAoyX7aZVuoO/g/2eMj4MzM5wkAydJl8BxUk8+6SDmPnlz0w2Ehexq/9
	jVBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=gYhEzSdcVu+JPSE5gzO8ECdnSJypZliLiJaeaHvxaN4=;
	b=mYfQAReuB+o89MtxEJ4DBGFkMqx062glDMgh4KJMTaJJ33s6kij7OlX7wAtn0+ZvtC
	9t1c15M1TneHSsoj7hlG+rCHliYxGzn3fqW3JkVvVD3oNEs2Wpy7LX+mq96MbUoNu2VF
	l/eTvB3JyAZnfhn6CjN6O8tuMNTsZ5Xpz3MZP/XkCp4snJS8VPJ0w0OIKtkmGYoFcNho
	ER9ZCdCdiojNYhROEN7zjSdf5TJye1tnW/1BoQqJDdHCcvLMoluTcyNmCmmi5oFYcRqT
	BQqYQ/JclFxDQAOt0mZhu/JUoOOwrtsEBnBP1kLiOPYVcdmy2eVlSq6bqCUyi/zK0u3A
	OHTw==
X-Gm-Message-State: APjAAAWwp+yGfncMztrzO4/XXY4g49nIbVZW20trYMlD8R0ntScCGwKV
	LwilxT2ohfrO0z693XVLpRgu3uokeRMA6SNwkLd6ag==
X-Google-Smtp-Source: APXvYqyUEJMefpDQKZbEHjTTD71Zf4QWTJ0ujHQXI8FE9zgQLWkdZu339P4AbgG2cVlecbaRx9EgIA294zPHMAVLsLk=
X-Received: by 2002:a25:ef01:: with SMTP id g1mr37636110ybd.399.1556255673914; 
	Thu, 25 Apr 2019 22:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <1556110623-655-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1556110623-655-3-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1556110623-655-3-git-send-email-aleksandar.markovic@rt-rk.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 25 Apr 2019 22:14:23 -0700
Message-ID:
 <CAMo8BfKTHd5Ycz-E=_nbX7JQmhU_kiOc7ZMSauae7GsRr9QpFA@mail.gmail.com>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::b44
Subject: Re: [Qemu-devel] [PATCH v2 2/5] linux-user: Add support for the
 SIOCSPGRP ioctl
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	qemu-devel <qemu-devel@nongnu.org>, daniel.santos@pobox.com,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426051423.7eUOvete24cosLFnYbY51d-46OWi5Cf4JuW0AXtd71s@z>

On Wed, Apr 24, 2019 at 5:58 AM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Add support for setting the process (or process group) to receive SIGIO
> or SIGURG signals when I/O becomes possible or urgent data is available,
> using SIOCSPGRP ioctl.
>
> The ioctl numeric values for SIOCSPGRP are platform-dependent and are
> determined by following files in Linux kernel source tree:
>
> arch/ia64/include/uapi/asm/sockios.h:#define SIOCSPGRP    0x8902
> arch/mips/include/uapi/asm/sockios.h:#define SIOCSPGRP    _IOW('s', 8, pid_t)
> arch/parisc/include/uapi/asm/sockios.h:#define SIOCSPGRP  0x8902
> arch/sh/include/uapi/asm/sockios.h:#define SIOCSPGRP      _IOW('s', 8, pid_t)
> arch/xtensa/include/uapi/asm/sockios.h:#define SIOCSPGRP  _IOW('s', 8, pid_t)
> arch/alpha/include/uapi/asm/sockios.h:#define SIOCSPGRP   _IOW('s', 8, pid_t)
> arch/sparc/include/uapi/asm/sockios.h:#define SIOCSPGRP   0x8902
> include/uapi/asm-generic/sockios.h:#define SIOCSPGRP      0x8902
>
> Hence the different definition for alpha, mips, sh4, and extensa.

Typo: xtensa.

> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/ioctls.h       | 1 +
>  linux-user/syscall_defs.h | 3 +++
>  2 files changed, 4 insertions(+)

Reviewed-by: Max Filippov <jcmvbkbc@gmail.com>

-- 
Thanks.
-- Max

