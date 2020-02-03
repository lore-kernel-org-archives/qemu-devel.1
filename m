Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB552C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 844DC2166E
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dvNHNgEi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 844DC2166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybQW-0006F3-OY
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iybPO-0005Ia-BI
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:04:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iybPN-00008h-0J
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:04:58 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:41336)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iybPM-00005x-P0
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:04:56 -0500
Received: by mail-ot1-x331.google.com with SMTP id r27so13505032otc.8
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 05:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=3QGsJLoaXVXv6ynoE5sg0XS3xC5QTb6jVWtFtIolL2Q=;
 b=dvNHNgEimT7ErKKp4Sq0EgY/bIbmPHO1v3V1T1V8oaVL1/EX9M4AvCPJSkawd/aMzj
 DMMby6+LjqmuJmP7DqIS/aP5sTHnwZv0nIYspYhJ7pXbIxZ/KY9hfGw1Bq9nNAS9CE7b
 xKKxehSlxQJ3TkNZM23XCBBro0kOZbwFNEN0RnxjyOZxzGw9GDfyUpb1UmVxMMe8D0kN
 D6/k8ZdhGwK6RJyt9uDCfFK4b3DA+iH4paFkvU7tyHpc1xttESyBPpqHi9i3IzDEanSk
 Wn3SQXCA1dQudzJOXQ1xzOqAu+XR6EGCS4GvQg6EFRlg/ClbV3tCgNIc0vTLbJJ6hj3s
 99OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=3QGsJLoaXVXv6ynoE5sg0XS3xC5QTb6jVWtFtIolL2Q=;
 b=s/w6e1yKeL8rCoGi2ewm3K8IXZQ192lI+jW8fQwAw1aEQbfYUBhOKk8TB5U2qhizYl
 Sk59IjNyF4m2OL3rxlwrST/qlRLNquf5umldycHAx3p2JQvZHCtHb5IDVwe98GczFdUY
 bnobOwYCTewmRZ7tMZhrDavNTFNzOlFSTsd7h64GaxmdkhDFy7ExCzeBOE6LigoOWtiY
 fks9lsckoBTYbDdizwg0/bsPPSD03Lts7YHTmvUBxgZ3GL9yI5JZ3FWK2HoykRnPA5tY
 KCkE837ia5dDqinsYZnDMPyQH2B1+xhpDiECiRLlZbhT0OUmqI3mCR9ldfCR9FG/+5w+
 seZw==
X-Gm-Message-State: APjAAAUoeqM3kX16xa0Pcwk7kTYL8bQ3aEzyoqEdcGHwcKtORcTVmYSd
 MuzwFMpHQILxmiZSCm75D5he6xASOIujit3miG4M51KB
X-Google-Smtp-Source: APXvYqzKjTKx0x9criUfqAdeYDFqsvmby7io73nbGsgBL+7cZdqm5f0pOUkdVRHAo731glISPVVScuTNTa/zZpxWSxY=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr17775885otq.135.1580735095678; 
 Mon, 03 Feb 2020 05:04:55 -0800 (PST)
MIME-Version: 1.0
References: <20200203111318.23378-1-peter.maydell@linaro.org>
In-Reply-To: <20200203111318.23378-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 13:04:44 +0000
Message-ID: <CAFEAcA_GPDhVNAZpCqZVc_xN8cViK2GYU=NkiFRBgHVnF=wR5g@mail.gmail.com>
Subject: Re: [PULL 0/8] docs queue
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 11:13, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This 'docs' pullrequest is just my 8-patch series
> which adds hxtool doc fragment support for rST and
> converts qemu-img/qemu-trace-stap/virtfs-proxy-helper.
>
> It has small fixes squashed in to account for commit
> cdd267749a3ab78 (which adds a new option to the qemu-img
> docs) now being in master.
>
> thanks
> -- PMM
>
> The following changes since commit 035b21977ce1791a630c5cbf46e482e54552e05b:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.0-20200203' into staging (2020-02-03 09:52:43 +0000)
>
> are available in the Git repository at:
>
>   https://git.linaro.org/people/pmaydell/qemu-arm.git tags/pull-docs-20200203
>
> for you to fetch changes up to 78813586b04e89639754cfdcef23802dc9f54ff4:
>
>   virtfs-proxy-helper: Convert documentation to rST (2020-02-03 11:02:23 +0000)
>
> ----------------------------------------------------------------
> docs:
>  * Fix Makefile concurrency bug where we could run Sphinx twice
>    in parallel on the same manual (which makes it crash)
>  * Support handling hxtool doc fragments for rST manuals
>  * Convert qemu-img docs to rST
>  * Convert qemu-trace-stap docs to rST
>  * Convert virtfs-proxy-helper docs to rST
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

