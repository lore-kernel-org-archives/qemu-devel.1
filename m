Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70489C43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3783120719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 09:28:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SSIufcEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3783120719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48388 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHOoQ-0000f3-C1
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 05:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45714)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jHOnr-0000EH-Ql
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:27:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jHOnq-00017T-87
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:27:55 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235]:40295)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jHOnq-00016r-1v
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 05:27:54 -0400
Received: by mail-oi1-x235.google.com with SMTP id y71so4872181oia.7
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2020 02:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x8gFQ0emhdm9GaInZj5zBCQZRuQb+HOJMiySes9+p10=;
 b=SSIufcEcCBGL70fIcHX5L4IuC12Pe5WFAS3GJHuGI5SRFWUu7gWwTYe5HHhtf6i7hC
 MZD9vxYMLwhf/ORNMnm4STSMQAa5jPYOmCrVE6QUqc8AVvTMUWx5qS8Xnk/g1MEqDXuS
 t9rmSkN1J6nKJoKj9j6WF/Fnz6zaWxImAYT08xyRgtkX4fFRJzqQpfPDiCXWZ78ctR0E
 26VYgVYH3dqPUv41tUpQuE3rEbiKvC1xdZ01H9WDSQBSXdCFGjeJEewsvO4iPq9jXGhD
 wwlOlADXgB7LMx3VzhJyOBMKX02gDGPqfa7ASZZUkzH2HKnsG3UR5FSuYr7wU20JHFit
 CHig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x8gFQ0emhdm9GaInZj5zBCQZRuQb+HOJMiySes9+p10=;
 b=d+6IquAo6ggt9I+TWCJ9o9Yc0S9wKSo0USVfzViP7UmnBGgBInNk8Rak1ikj2wAY8a
 jV0qVzZx38ry5TeAc3hv7LToK1QJRiL1eyxMp+pYJ5vy0K0izuMUhK2oDtaypHguHkv9
 RgbFi3j1ZE1NEVVOtHVsZ8j3jmnFKboOZenN2JA74+JOJQ/Qm6Q8W7rkIW0RJH8iUpCq
 EsSH8tOra7um/IgGV1BWxkgS+UwbgeT4XwjB3AT/6+xHR3gJuUBOBRzyF3pnNTd7FVwm
 29h1XEjDPYGFwjUZ/t37brnhdUhXGpTIvl/VbP1AXUe3ncrB2pB2kNRPVVDB9KeWZyIt
 Ipmw==
X-Gm-Message-State: ANhLgQ1j5ixd0E9dyeynDTv6CNPtLvfWJ24vp9eFpSoCi3nap3ZwKo2Z
 EJl0QC+EGmGN1Kq24Y3Gj/T5s9aowA3JBZuBV9PxTw==
X-Google-Smtp-Source: ADFU+vs19HzMMnYgyX6mFfUswnQKGf+jrJUXMQcvZY2L47xnVjo3E7bgwK5CYZ2a+vRRM2PC1IarAlZxxu+Y2gR1zbM=
X-Received: by 2002:a05:6808:8cb:: with SMTP id
 k11mr117096oij.48.1585214873151; 
 Thu, 26 Mar 2020 02:27:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200325105843.17387-1-kraxel@redhat.com>
In-Reply-To: <20200325105843.17387-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 26 Mar 2020 09:27:41 +0000
Message-ID: <CAFEAcA-w3d+0kWk6tOcPV-Lmg8dUDoMyCzypW-tcvPVqgN6KyQ@mail.gmail.com>
Subject: Re: [PULL 0/2] Fixes 20200325 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::235
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

On Wed, 25 Mar 2020 at 11:05, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 736cf607e40674776d752acc201f565723e86045:
>
>   Update version for v5.0.0-rc0 release (2020-03-24 17:50:00 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/fixes-20200325-pull-request
>
> for you to fetch changes up to 95fad99cb28e9970944b01fd7af452f6f9f37484:
>
>   hw/audio/fmopl: fix segmentation fault (2020-03-25 09:55:40 +0100)
>
> ----------------------------------------------------------------
> fixes: input error handling & audio segfault
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

