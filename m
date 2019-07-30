Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A703C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 16:05:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46CF520693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 16:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QosSbjyh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46CF520693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsUdE-0002mk-HO
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 12:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49841)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hsUbc-00083M-Dz
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:04:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hsUbb-0006Pk-AP
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:04:04 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35250)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hsUbb-0006PK-5Z
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:04:03 -0400
Received: by mail-oi1-x242.google.com with SMTP id a127so48263204oii.2
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 09:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p6rUg7JRwuzV5vIRpzkVx7AjYDp1I9ZV/OKO75VF274=;
 b=QosSbjyhYTZO6DgzPpmhlEh8VMyyKQxL5Ll7yki0WV6mS7dkY1QANeeuaucHm485SK
 3o6zv9f//snFvcpzowQKPqUiCqVVSNAimKGgBWAnbQ59DhQA8sIK8u7wjqMJDZO6iK0k
 o3zJgQSgs0OKaf72ePkItXZyNOM+u+Ppcap2dJy/n2H5O6jno2f4wh4oKOoHhi0sNvK1
 bJNM9JpO2VTcuzJHjk4uqLVscZ1bUIun3cmuS25fRshz2An85nmmjjBcI/pnceFH4yh1
 /jD7piyKDmcfTjkCAHh+96gX3iZJ5lgdyHvn2nFrat6p4USDCIbLsR+MNgD9Lnlaloxy
 wWlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p6rUg7JRwuzV5vIRpzkVx7AjYDp1I9ZV/OKO75VF274=;
 b=kJEitR4FEE9YCqFMUUCOdggqz8SDSfJaSUF+qovp6Zow0B3MHnGHxQoeJRe2LpNWkX
 ocJLmgspt86zJuA93KQ40yJ3sFg8LHqIv1tWuUhbB5DtT4ztXdiODv21rL0HNlezPudN
 ZjoupwcGMmKjqNostwRV6ttPuXGUb0018dbe4whbapg3NUis/e2VlmqLhii/LovAglvg
 vaDhFkIpfGuRwdFbxr6jrrWlkkDNU1jKMp7b2a2hnPZLQWlX0pnp9dTJYc7Gv+jv1Hvn
 6jlS7ydzcGkVP7EPYBrtqzh/hAFR/MrqJPDBTiKDfIcrbR/6MdyqP73akntoQ3JcZT+g
 ic0w==
X-Gm-Message-State: APjAAAWUl21bTYUYj4wF2HbXq5M5iQmWrJnLbavyRpP/junGOGuFQq36
 cTTnnZ6uDZ1U3Zp56HKQjvk4/08WWWu75/UccWDdag==
X-Google-Smtp-Source: APXvYqydYz7pPqlWXITgDzOqE5A+NchVbaWlJFh79opdaits/z5ehQyjBdlPobViPNROCCtG50GLrUkKeuUJ/Pqzphg=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr1434932oic.170.1564502642155; 
 Tue, 30 Jul 2019 09:04:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190730153331.24515-1-kwolf@redhat.com>
In-Reply-To: <20190730153331.24515-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jul 2019 17:03:51 +0100
Message-ID: <CAFEAcA-zGqSLbXPEVtcDoE5nCBzns-7ozU_L=_nb-bqRUSeA_g@mail.gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PULL 0/2] fdc: Fix inserting read-only media in
 empty drive
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 at 16:33, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 8517bf84056282ea3e27772d51f76db3a6fa2d26:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-07-30' into staging (2019-07-30 14:23:07 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 68174160144c9263366a4397ef8b417698e2735c:
>
>   iotests/118: Test inserting a read-only medium (2019-07-30 17:32:01 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - fdc: Fix inserting read-only media in empty drive
>
> ----------------------------------------------------------------
> Kevin Wolf (2):
>       fdc: Fix inserting read-only media in empty drive
>       iotests/118: Test inserting a read-only medium


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

