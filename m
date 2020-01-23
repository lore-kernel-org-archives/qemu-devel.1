Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E36C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33C6E2077C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EsNx8DkQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33C6E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuh2D-0005wk-SS
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:16:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iueHh-00026p-HM
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iueHg-0004lQ-Dt
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:20:41 -0500
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:42034)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iueHg-0004lB-7m
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:20:40 -0500
Received: by mail-oi1-x236.google.com with SMTP id 18so3196543oin.9
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 07:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E2IwaD1b6hdWWR9vufp/riiOvY31nSO/JhEKz88GNEc=;
 b=EsNx8DkQDIDTP4FSSYAh1I/ADb7ZgewoO7aQ1ParvxAhpiRwco19UOENnxfsPhk/lv
 d9FY7tmIC6tK7gZN1UB5PgIGt4s3II0o1N6H3K9YvpYuwNNUVl/PUcH8fMlatpCLcN9z
 a/lU2PCcZqbAPCF3yWK+9qdv7u3Q0joT2W/YZWJ2y9MnolMAtkgbYPtzrwd8EkY3Het+
 zvjTVnnV3VNy9jzOnxIEBr32AoFk3eiO2WE8CTLCKuY+G7n2lXYv3ZLktt4nkx6Kl91Q
 YVAlp5lxZG3zHGdTDibPTN0TBrV91nIyp6bk9W6bEwKh81qbDpre/uaRLIKhjCvp5Zcc
 lwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E2IwaD1b6hdWWR9vufp/riiOvY31nSO/JhEKz88GNEc=;
 b=A7kFP+QCFV19v2Qo1eYDT25h342piC+wY90qryJI8JupcWRGEe2kqfRiE95t+FwRww
 wPhghfAk7NQB8POTUZ/lqcTiSZ9LW1TLnjbrjiEYJEvC/+625JNBwFJkjEZrkV4jH6Vn
 AmTSeE4qumBpydh2y2MkMwe2tZbAE81iIWoAnQ9z2tLglBN85NDX+kbvPHu1O5rJuR/c
 2olitCd5Bw/5NJFi+MHNVEYjPnnotA2ZvLhXDBu+NZpUu/ZW8pEL9caOPkgwoMryvQfZ
 5aD+aI5hEA9H2/3IR0nd4AeDSlkrvceM6wSzAagylK3kyRGBwWSq/CBbFnXGBF/AHZ0p
 QGpg==
X-Gm-Message-State: APjAAAUFFhgfRm09lrY2iWvE2c+mZwxJZkehQnpwZEZwPXMnEMndE7Mg
 rP82vMg964LQFa0ccoKR/fmJSOTwL5jjnLnI2f0+y042yK0=
X-Google-Smtp-Source: APXvYqwwYbVvpAddc+K+1Xn4AlhfcdQ1PmBVU2eXd3DG+uCrKu7wRwKQyHLVkIRSPtarAjJvoZ8f4kcsr1b0Dydssuo=
X-Received: by 2002:aca:d78b:: with SMTP id
 o133mr11025185oig.163.1579792839332; 
 Thu, 23 Jan 2020 07:20:39 -0800 (PST)
MIME-Version: 1.0
References: <20200123115841.138849-1-dgilbert@redhat.com>
In-Reply-To: <20200123115841.138849-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jan 2020 15:20:28 +0000
Message-ID: <CAFEAcA_7T2Yu8fXv7XycSSN=8xoi8aciR5NMh76o8LQxNU6rDw@mail.gmail.com>
Subject: Re: [PULL 000/111] virtiofs queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 at 12:54, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0dd40:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-20200121' into staging (2020-01-21 15:29:25 +0000)
>
> are available in the Git repository at:
>
>   git@gitlab.com:dagrh/qemu.git tags/pull-virtiofs-20200123
>
> for you to fetch changes up to 87509325f70c78a28683f9460699915ea3300091:
>
>   virtiofsd: add some options to the help message (2020-01-23 10:54:49 +0000)
>
> ----------------------------------------------------------------
> virtiofsd first pull
>
> Import our virtiofsd.
> This pulls in the daemon to drive a file system connected to the
> existing qemu virtiofsd device.
> It's derived from upstream libfuse with lots of changes (and a lot
> trimmed out).
> The daemon lives in the newly created qemu/tools/virtiofsd
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


>  docs/tools/conf.py                        |   16 +
>  docs/tools/index.rst                      |   14 +
>  docs/tools/virtiofsd-security.rst         |  118 ++

Do we really want a new top-level manual? This isn't
in the plan: https://wiki.qemu.org/Features/Documentation

What defines what goes in docs/tools rather than
docs/interop (like qemu-nbd and qemu-img do) ?

thanks
-- PMM

