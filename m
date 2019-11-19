Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5221BC432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:18:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21358222DC
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CE0EYjj5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21358222DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWzef-0004Jd-7V
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 04:18:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58149)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWzdM-0003MZ-Va
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:17:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWzdL-0005lj-Kw
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:17:16 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:36637)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWzdL-0005lH-Ey
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:17:15 -0500
Received: by mail-oi1-x232.google.com with SMTP id j7so18245709oib.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 01:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZgaiqwXa6HoNimWbMAtk1SyieQdtG6pQaO2eeZee/gE=;
 b=CE0EYjj5OVgvxKO8X7nusfGfR15z2L93+gwK6eWlzxTHqWmtcr4RnxiUzykDzKxjQZ
 BU2ECy50xQmSLBfiMsqDebVcs1uRKpv0WiMba7ZQZAu8hClCM5gAiSejVrhCPFTcoMd4
 BxDLsptQrCu0NcHJRAHMIVTl2M2tLTj/O6cer+JgT39jjXoreqqajjP5vMBrp/7E3ryF
 UD13xLCtIAgVKp2tX+hMJYVJNe+M5VqpMBGKAvXKtqm/S4Bppq64O04QM69BlGeqYeXd
 L0FvE0B/vUYoKbfRBB3CMWAFKMX7L0Oy+eAF43fBcVZNdhEe/wEuqJenW9KUJG+cQ8ZO
 v79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZgaiqwXa6HoNimWbMAtk1SyieQdtG6pQaO2eeZee/gE=;
 b=ejdDlRBsMo59BmGscOI8hLBo42FPBhjXykKEB1O5NC8Ijd00htDnfdIt+IIE5MlCBh
 pGJsbobZqR9Jq7f3qzyzzFW8Ogczmq8WSGxPIem6KxEtB9WkPOhq3u3rMhi8rN3skGEh
 Z1B9KGXTiKUMi2GbZ22u9JN0GQN/zYPq3hIIIhzQQa5cYGp0s6HBt1AQpPaKGcvqIRxE
 7gheXybT7mceXWOvCZi1a+Z48sjW+8gXSuHWDO329ZqyoKRdUoZah3kKcUzeljrQHZhj
 XOeXWzpU6vK3kin/KwENpC85bmPDxACKeVJN6VgOzXcOQwRDO5JkCIImVZuEVLhetRHH
 aUJg==
X-Gm-Message-State: APjAAAWx1y5SVnvl4iXHipMdIq/VmlWcpeIod4Q/P4Cz52vy15vpMuyD
 ePpyfhz7OJWkjZgAxQo3VDcTJkNYt4079H6Fei1OTw==
X-Google-Smtp-Source: APXvYqz69tonrELsexo0dhmUhtaAn4Z6tQ45+AEPbXDUyiBpCxtCG+pRWszLcuJPM9qlDLnFzoOBXpAluXN1+hOw5MY=
X-Received: by 2002:aca:451:: with SMTP id 78mr3237753oie.170.1574155034540;
 Tue, 19 Nov 2019 01:17:14 -0800 (PST)
MIME-Version: 1.0
References: <157410270703.24655.9333886493163056872.stgit@gimli.home>
In-Reply-To: <157410270703.24655.9333886493163056872.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 19 Nov 2019 09:17:03 +0000
Message-ID: <CAFEAcA_9k3=3jWXdtFvK9qZqTEPUt-Zre=ZxvC1Ftf_MShamCg@mail.gmail.com>
Subject: Re: [PULL 0/3] VFIO fixes 2019-11-18
To: Alex Williamson <alex.williamson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::232
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 Nov 2019 at 18:48, Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> The following changes since commit 1bd0f1c9c149c2fb738f381099cec7ad0ee224a9:
>
>   Merge remote-tracking branch
> 'remotes/kraxel/tags/seabios-20191118-pull-request' into staging (2019-11-18
> 14:30:24 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-fixes-20191118.0
>
> for you to fetch changes up to 29b95c992a569818294478b4616e44b45c67d34e:
>
>   vfio: vfio-pci requires EDID (2019-11-18 10:41:49 -0700)
>
> ----------------------------------------------------------------
> VFIO fixes 2019-11-18
>
>  - Fix migration blocker double free (Michal Privoznik)
>
>  - Use migration_add_blocker() return value (Jens Freimann)
>
>  - Depend on EDID for display support (Paolo Bonzini)
>
> ----------------------------------------------------------------

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

