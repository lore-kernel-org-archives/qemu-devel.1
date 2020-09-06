Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54BE5C43461
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 18:01:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DC72078E
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 18:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TvCf3f8f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DC72078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEyyX-0003Pj-Li
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 14:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEyxq-0002nn-AQ
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 14:00:30 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f]:41236)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEyxo-000125-DG
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 14:00:29 -0400
Received: by mail-ej1-x62f.google.com with SMTP id lo4so14969027ejb.8
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 11:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KOpwxO4MLF6R6dzJAxSpCfCaFW5+aO96Bu7Cv7bP7n4=;
 b=TvCf3f8f+lzOf28HWG+DZ2Hhmsa4gULdJZoFdKeFDHz41dxb7DVRByvGlrUqmR0OvW
 6H6c7e98KSdBA3aIxKpzi7wfyZbqTuu8xuZAdJ1G9wBNHQiSlLWytGJ7CWZ6p32JfoBh
 J+oVQrWohbsB7u2rSz+FkGlq99gi17kY31IaUmoOXUQeZG9CYUXhL5ejfeFbDzD1QsYG
 wNPA+Vsr+sGjF2F+jH+TUWu8QJGsuQiPTzdntmIEmoBpcV29J6/ymG1YiV/OTAKcfeot
 uyMtWVx44COQAGJH5/LIZXpyFeRL+INE/jEmXQ/okZfFV61D+R4f+eE0Ru/ndUk3ZCQ1
 lrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KOpwxO4MLF6R6dzJAxSpCfCaFW5+aO96Bu7Cv7bP7n4=;
 b=I3NBYim0OkFtQPdv4M7c2cVrKITiL4BTkas4ZX3HVPz5LJ6K9fjWFEeYij3qxfrLpx
 IehEOYypIEoXSKhqH0vybj82J8YcI3W5msU1lAeZqC277KTdoOjeHmlBJdleCLoRwrNY
 1o+/cRb4YLFe85RW1yYvXjRMsROl8TI1nJU9do6ZX9MfPezLBYqGddNFF7a4y5eXYaDu
 ZsT7GgscgwruCvYuEYYLxL2MXJDx17FWgZmV32n37veBPYjVY1FdoadRaGM22PRwqsjc
 YPJFRJOLcNq/U4uDfZLy6L2zk49KNcQmOnm3ti2n3hmdgiCoBrmU/XOVZDNKMjx7xCMb
 jHvA==
X-Gm-Message-State: AOAM5311mQDgv3gds2YRj4xRjvFc+FMInzY9ytMFP5reI5W0hAJYP+O6
 Dj+LxCP3arbx3wGkG6aKq1XKQHJgtDJiu22dTdCnJg==
X-Google-Smtp-Source: ABdhPJxoKyuGZgl9q7BPruwr/J0AZHq56m8TXAKBpAanGqTwLM3ZhhiK2cgkU4z4APTXmghVtCqKUVbZ/0HJY2UzGXw=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr17238928ejr.482.1599415226707; 
 Sun, 06 Sep 2020 11:00:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200904070112.7315-1-kraxel@redhat.com>
In-Reply-To: <20200904070112.7315-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 6 Sep 2020 19:00:15 +0100
Message-ID: <CAFEAcA8jSnLRcmT+_2xN70nzrGa_Z+kzdqBRjeHqXcfV4go4uA@mail.gmail.com>
Subject: Re: [PULL 0/4] Ui 20200904 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Sep 2020 at 08:04, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 67a7bfe560a1bba59efab085cb3430f45176d382:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-09=
> -03' into staging (2020-09-03 16:58:25 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20200904-pull-request
>
> for you to fetch changes up to dc26435edb469ebdadf298dc3945b95d08f743d4:
>
>   ui/gtk: Update refresh interval after widget is realized (2020-09-04 07:32:=
> 28 +0200)
>
> ----------------------------------------------------------------
> ui: memleak fixes.
> gtk: refresh interval fix.
> spice: add mouse buttons.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

