Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C26C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20C202070E
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 13:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v/lJi/2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20C202070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnMm3-0008Lt-Ch
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 09:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnMlG-0007pp-DJ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:45:22 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:43782)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jnMlE-00061d-HJ
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 09:45:22 -0400
Received: by mail-oi1-x232.google.com with SMTP id j189so15608665oih.10
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 06:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XB0nInK5j/O6hKhkHPr6gCSu3qV5U4kiX+665yWmguo=;
 b=v/lJi/2obgId4ybWpz2ASNlk9rTS+MAg22gpUgKPKBpcq9dXGm0zpQX85sjj51Suxl
 3QJlNr2e8HFdQkhFZYXzz6k36U3MOkkrs9/fvc7zQDjCCN5oY9mwmwznVis3l75B23oJ
 snFkws+BM5Z527hdFJQ024sl2CoeuF/BO/3fmog/h7SjGV81w7myx/mNoLp7xUTgSLuz
 HiCC9+xYhZz4rMnsLTBKZsoZ2AF0nSvr6PvnGyi0lm75/wLDyHvcgk5aWhGV+GMGzVt1
 JD3nh9MNLnzEVlZXkFCOI7zOo32C5TTZrx3u2YfuWnAL20ykbgzjuOkeL+095l3R4rZJ
 8Iuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XB0nInK5j/O6hKhkHPr6gCSu3qV5U4kiX+665yWmguo=;
 b=uHqju9wAULTQivpmupaNlKt/8BrfImQW0Bw6f+p6W1+epnecAPJhz0/lvA1S5LEzup
 zpFlkqHhhEaUDUHT0YjFpGVdp96artFSup9Br1TDpkdOIYGMlbuK0u4m1VKZQe1OMK4s
 hf6cmwr/TujLFpYLHkGXF5gXLk3EBYTNbL3YLVHNg0LAeVuTOzi9bgyyrDhq5ZmS89Ya
 5RiXVqlgtih8irdw34jM8u1qV3Ki/ix0DBkkIcBkCeTiKAH+4ZT0bxFKt90+H1Ce2R1V
 rHaX0JJ0EbG3PtmgfCxdRy/kWAq+DjCdmVlH92lG1GCVcgK76SSkjUDd0T6W5sT97pX0
 7+Mw==
X-Gm-Message-State: AOAM530pToZxYBCj6YiyVHGpOwtjjb+RD1X3/GV93nxxwAaRz28xbj4f
 wKkLbqZp1IPRmlB8hloNNmUMU2LSwy6zGdlQ1FLZxHWhfsU=
X-Google-Smtp-Source: ABdhPJwDX850olDba1WUcxJNEYWk8cdPLrr7JqrHFHOQ+lMB5TYLlREPCkRqSaSjmEmxHinOkq33cibk49GkJk4Umpg=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr12467596oia.163.1592833519314; 
 Mon, 22 Jun 2020 06:45:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200619131741.10857-1-kraxel@redhat.com>
In-Reply-To: <20200619131741.10857-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Jun 2020 14:45:08 +0100
Message-ID: <CAFEAcA_ZcGUbhrJdrbGMurv79F2fMFFpMoJdk_YC_RYLWCPKbQ@mail.gmail.com>
Subject: Re: [PULL 0/7] Audio 20200619 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x232.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 19 Jun 2020 at 14:19, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 5c24bce3056ff209a1ecc50ff4b7e65b85ad8e74:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-plugin-160620-2' into staging (2020-06-16 14:57:15 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20200619-pull-request
>
> for you to fetch changes up to 586803455b3fa44d949ecd42cd9c87e5a6287aef:
>
>   hw/audio/gus: Fix registers 32-bit access (2020-06-19 11:20:09 +0200)
>
> ----------------------------------------------------------------
> audio: bugfixes for jack backend and gus emulation.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

