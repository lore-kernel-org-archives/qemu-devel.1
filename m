Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2C01C7618F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:56:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB513205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 15:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awkQqvBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB513205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn3LM-00082q-02
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 11:56:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54589)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hn3LA-0007Lw-WC
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hn3L9-00028F-SJ
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:56:36 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:38606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hn3L9-00027h-Li
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 11:56:35 -0400
Received: by mail-oi1-x243.google.com with SMTP id v186so13035447oie.5
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 08:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qE1l7HK/XZzEyn/G0YQDymltaZQMckPbIXRw32OkiHY=;
 b=awkQqvBvqgmAC/rVAmUDcA8+o8f9zsw8zhxZmTaONxZ4skYHR0k3axfZkBdvA3vgO3
 EzJdbUy1yiy9sehRdkwgEr08oMemZ47A3Mfe5Gx4diq33TdeTyaFqGA8Tp5rwQY97TJb
 qQ6oLstJw5iBxdb0+eTh7wE1lQsjOcmirMpb6exhBlzh70hEGLIYplLpG6BZFzQIEJC6
 /5Qn9NTKKX+WOduLmD4hhBDlQ6qRDw3EgCWQywYiP9yN9rr9qgNyS9PSDzxI8VZhVoeW
 E+tGmCnCPRMofVxw+dqJkNxPp95lVN3DKFx8rG9AfonA5B4r17k/kmN/nG6MraqeqGCa
 xEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qE1l7HK/XZzEyn/G0YQDymltaZQMckPbIXRw32OkiHY=;
 b=EIcnOMC41iYa2rIWmdv3Ta2JZNT21Jc0aIS5kSNUi5K+eD4e26ogm7VENeEAtph/q/
 n5I6rwJQYDe5ui+gNpa8iKIQfOemytmkXrbfEVvycde0MATYP18Jtzw7bwZlHQTG46Q1
 8Ozm2RE8vXd2yXA3cZQBojt++o5z/6hDcrTf9qdEZlnc5Es26fxAOEw9cuppni1mXUqh
 jUQfuUjpWLnVclSTIkr6//SImxxbNMQmq1Goi4u3nspgfsy3u9yfapNIWdLYqV+/UoH8
 AAW2eP6oyTUxrrOnm/o0DIJv2OlURHdCHbUm03TNLUoM70deACPzC36RIabDvUZnqUFK
 6OrQ==
X-Gm-Message-State: APjAAAXx4tE6KuecFd5RHdo17aZbiOs2JqYHaIllo8iTKqoY7h/C5LeR
 XATVHyYU02sGqAF0jzec4Sk0JxXRM/iTv/TwFzarWQ==
X-Google-Smtp-Source: APXvYqylphpogqoqXu7u/oOKDB9erZnozrUSNWo2Ds4fO/1w+Rpj+hPum5tTJb44xDpJba15W/4+rG2R1bPQle24OFs=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr13141568oij.98.1563206194518; 
 Mon, 15 Jul 2019 08:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190715142905.9078-1-mreitz@redhat.com>
In-Reply-To: <20190715142905.9078-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jul 2019 16:56:23 +0100
Message-ID: <CAFEAcA_Fxv-EOzcdYh-tZUontKy82_TzRys71tZ3FpU8fthCLg@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PULL 00/11] Block patches for rc1
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 15 Jul 2019 at 15:29, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit b9404bf592e7ba74180e1a54ed7a266ec6ee67f2:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20190715' into staging (2019-07-15 12:22:07 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-07-15
>
> for you to fetch changes up to 0b1847bbc2b4f50e7497cb05c4540bf7b016c9c6:
>
>   gluster: fix .bdrv_reopen_prepare when backing file is a JSON object (2019-07-15 15:48:41 +0200)
>
> ----------------------------------------------------------------
> Block patches for 4.1-rc1:
> - Fixes for the NVMe block driver, the gluster block driver, and for
>   running multiple block jobs concurrently on a single chain
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

